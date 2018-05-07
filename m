Return-Path: <tytso@thunk.org>
Date: Mon, 7 May 2018 09:10:07 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: axboe@kernel.dk, syzkaller-bugs@googlegroups.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: add recursion validation to LOOP_CHANGE_FD
Message-ID: <20180507131007.GZ29205@thunk.org>
References: <20180504021717.9246-1-tytso@mit.edu>
 <201805072016.GAC48495.VSJQFtFHLFMOOO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201805072016.GAC48495.VSJQFtFHLFMOOO@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 07, 2018 at 08:16:58PM +0900, Tetsuo Handa wrote:
> Oh, your message did not arrive at news.gmane.org and I didn't notice that you
> already wrote this patch. But please update yours or review mine shown below.
> 
> > @@ -673,14 +703,13 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
> >  	if (!file)
> >  		goto out;
> >  
> > +	error = loop_validate_file(file, bdev);
> > +	if (error)
> > +		goto out_putf;
> > +
> >  	inode = file->f_mapping->host;
> >  	old_file = lo->lo_backing_file;
> >  
> > -	error = -EINVAL;
> > -
> > -	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> > -		goto out_putf;
> > -
> >  	/* size of the new backing store needs to be the same */
> >  	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
> >  		goto out_putf;
> 
> error == 0 upon "goto out_putf" is wrong.

I don't understand your concern; where are we going to out_putf when
error == 0?

The relevant code that was added is:

	error = loop_validate_file(file, bdev);
	if (error)
		goto out_putf;


						- Ted
