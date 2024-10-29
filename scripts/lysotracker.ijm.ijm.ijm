// Ask for the folder containing the images
dir = getDirectory("Choose a Directory");

// Get list of all image files in the folder
list = getFileList(dir);

// Create a Results table to store the results for all images
resultTable = newArray();

// Loop through all the images in the folder
for (i = 0; i < list.length; i++) {
    
    // Open each image
    open(dir + list[i]);

    // Convert the image to 8-bit grayscale (if it's not already)
    run("8-bit");

    // Exclude the scale bar
    // (You can define the area where the scale bar is located, e.g., bottom-right corner, and remove that region)
    makeRectangle(0, 0, getWidth(), getHeight() - 200);  // Example: Adjust '50' to the height of your scale bar
    run("Clear Outside");

	run("Set Measurements...", "area mean min integrated median limit display redirect=None decimal=3");

    // Apply a threshold (adjust as necessary)
   setAutoThreshold("Default dark no-reset");
   setThreshold(52, 255, "raw");
   run("Threshold...");
    

    // Create a mask to identify the region of interest (excluding the scale bar)
    run("Create Mask");

    // Analyze particles (i.e., the zebrafish), and summarize the results
    run("Select None");
    mask = getTitle();
    selectWindow(list[i]); // Switch back to the original image
    run("Measure");	

     // Close the image and result windows for the next iteration
    close("*");
    // run("Clear Results");
}

// Save the final results to a CSV file in the same directory
saveAs("Results", dir + "Total_Intensity_Results.csv");

// Print a completion message
print("Batch processing complete. Results saved to: " + dir + "Total_Intensity_Results.csv");
