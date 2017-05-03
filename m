Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34505 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdECXWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 19:22:17 -0400
Received: by mail-pf0-f169.google.com with SMTP id e64so1943604pfd.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 16:22:17 -0700 (PDT)
Date: Wed, 3 May 2017 16:22:15 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/9] blk-mq-debugfs: get rid of a bunch of boilerplate
Message-ID: <20170503232215.GA29984@vader>
References: <cover.1493839103.git.osandov@fb.com>
 <6cac60b55b78044dd26226706f1bb5cd00f59d4b.1493839103.git.osandov@fb.com>
 <1493844669.3901.38.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493844669.3901.38.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 03, 2017 at 08:51:11PM +0000, Bart Van Assche wrote:
> On Wed, 2017-05-03 at 12:18 -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > A large part of blk-mq-debugfs.c is file_operations and seq_file
> > boilerplate. This sucks as is but will suck even more when schedulers
> > can define their own debugfs entries. Factor it all out into a single
> > blk_mq_debugfs_fops which multiplexes as needed. We store the
> > request_queue, blk_mq_hw_ctx, or blk_mq_ctx in the parent directory
> > dentry, which is kind of hacky, but it works.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  block/blk-mq-debugfs.c | 469 +++++++++++++++----------------------------------
> >  1 file changed, 138 insertions(+), 331 deletions(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index f58a116d6cca..00cc89c34590 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -26,23 +26,12 @@
> >  struct blk_mq_debugfs_attr {
> >  	const char *name;
> >  	umode_t mode;
> > -	const struct file_operations *fops;
> > +	int (*show)(void *, struct seq_file *);
> 
> Hello Omar,
> 
> The current show functions have the seq_file pointer as first argument
> but for .show() it is the second argument. Please consider to keep that
> pointer as the first argument.

The current show functions aren't the same thing, though. The void *
argument to those is meaningless, and the data is in m->private instead
of being passed in. I don't want to conflate the two calling
conventions.

Really what I wanted were strongly-typed show/write functions, i.e., one of

	int (*show)(struct request_queue *, struct seq_file *);
	int (*show)(struct blk_mq_hw_ctx *, struct seq_file *);
	int (*show)(struct blk_mq_ctx *, struct seq_file *);

But I couldn't come up with a nice way to do that.

> > +static ssize_t queue_state_write(void *data, const char __user *buf,
> > +				 size_t count, loff_t *ppos)
> >  {
> > -	struct request_queue *q = file_inode(file)->i_private;
> > +	struct request_queue *q = data;
> >  	char op[16] = { }, *s;
> >  
> > -	len = min(len, sizeof(op) - 1);
> > -	if (copy_from_user(op, ubuf, len))
> > +	if (copy_from_user(op, buf, min(count, sizeof(op) - 1)))
> >  		return -EFAULT;
> >  	s = op;
> >  	strsep(&s, " \t\n"); /* strip trailing whitespace */
> > @@ -127,22 +115,9 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
> >  		       __func__, op);
> >  		return -EINVAL;
> >  	}
> > -	return len;
> > -}
> > -
> > -static int blk_queue_flags_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, blk_queue_flags_show, inode->i_private);
> > +	return count;
> >  }
> 
> Please move the return value changes of queue_state_write() into a separate
> patch since these are a bug fix and not related to the removal of the
> boilerplate code.

Sure, I'll do that.

Thanks for the review.
