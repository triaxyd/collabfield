// Close modal when clicking the close button
document.addEventListener('turbo:load', function() {
    // Ensure the event listener is bound after each Turbo load
    $("body").on("click", ".single-post-card", function() {
        //console.log('Post clicked!'); // Add a log to check if the click is working
        var posted_by = $(this).find('.post-content .posted-by').html();
        var post_heading = $(this).find('.post-content h3').html();
        var post_content = $(this).find('.post-content p').html();
        var interested = $(this).find('.post-content .interested').attr('href');
        $('.modal-header .posted-by').text(posted_by);
        $('.loaded-data h3').text(post_heading);
        $('.loaded-data p').text(post_content);
        $('.loaded-data .interested a').attr('href', interested);
        $('.myModal').modal('show');
    });
});
$(document).on('click', '.close', function() {
    $('.myModal').modal('hide');
});