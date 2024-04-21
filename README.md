# Duo Assignment 2 SCART




# How to use

- Simply attach your phone to your MacBook
- Check if you have to disable simulators
- Click on build
- Open the images in the assets folder seperately
- Point Your phone at an image and VOILA! 

# Demo

https://www.youtube.com/shorts/41-WzEq91mY - Demo

# Want to edit?

- Replace the images in the assets folder with yours
- Set size on the right ( Units: Meters)
- In order to get your images working, you need to replace the names in cases with the names of your images, same goes to the videos which you have to put in Moving Image folder. 
`switch imgName
            {

            case "Flower":
                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Flower", ofType: "mp4")!)

            case "milkmaid":
                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "AnimatedPainting", ofType: "mp4")!)

            case "Starry Night":
                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Starry Night", ofType: "mp4")!)

            case "walkingwoman":

                videoURL = URL(fileURLWithPath: Bundle.main.path(forResource: "walkingwomanp", ofType: "mp4")!)`
- If you dont want the videos to loop, simply remove line 79 to 83 from ViewController.
- If you want to add another image and video, simply add another case.
