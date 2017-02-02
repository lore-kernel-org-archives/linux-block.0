Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35666 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdBBRCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2017 12:02:16 -0500
Received: by mail-pg0-f51.google.com with SMTP id 194so7137858pgd.2
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2017 09:02:16 -0800 (PST)
Date: Thu, 2 Feb 2017 09:01:45 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: fix blk-mq debugfs vs. blktrace
Message-ID: <20170202170145.GA31613@vader>
References: <cover.1485902856.git.osandov@fb.com>
 <20170201081608.GB18278@kroah.com>
 <20170201083115.GA16278@vader>
 <20170202105853.GA27128@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170202105853.GA27128@kroah.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02, 2017 at 11:58:53AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 01, 2017 at 12:31:15AM -0800, Omar Sandoval wrote:
> > On Wed, Feb 01, 2017 at 09:16:08AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 31, 2017 at 02:53:16PM -0800, Omar Sandoval wrote:
> > > > From: Omar Sandoval <osandov@fb.com>
> > > > 
> > > > When I moved the blk-mq debugging information to debugfs, I didn't
> > > > realize that blktrace also created directories in debugfs that
> > > > conflicted with the blk-mq directories. This series fixes that.
> > > > 
> > > > Patch 1 adds a new debugfs helper needed for patch 6. Greg, could I get
> > > > an ack on that if it makes sense? Jens and I went back and forth on this
> > > > for a little while, but patch 6 has more of the rationale on why we
> > > > decided that this approach was the cleanest.
> > > 
> > > I can't find patch 6, you only cc:ed me on the first patch :(
> > > 
> > > Care to bounce them all to me?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Gah, I forgot --cc-cover to git-send-email. The series is all here:
> > http://marc.info/?l=linux-block&r=1&b=201701&w=2. I can also send the
> > patches directly to you if you prefer that.
> 
> I don't understand the problem here.  How do you not know if you have
> created the debugfs file or not?  You have the structure, with the
> correct name, how could it have been created?  Can't you save the dentry
> to the debugfs file in the structure that has the name?
> 
> thanks,
> 
> greg k-h

Hey, Greg,

So here's the alternative to doing the lookup:

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 38052f625a0f..79ef6b9d1f96 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -470,12 +470,15 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!blk_debugfs_root)
 		goto err;
 
-	dir = debugfs_create_dir(buts->name, blk_debugfs_root);
-
+#ifdef CONFIG_BLK_DEBUG_FS
+	if (q->mq_ops && !bdev->bd_part.partno)
+		dir = q->debugfs_dir;
+#endif
+	if (!dir)
+		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 	if (!dir)
 		goto err;
 
-	bt->dir = dir;
 	bt->dev = dev;
 	atomic_set(&bt->dropped, 0);
 	INIT_LIST_HEAD(&bt->running_list);


So we could figure out if it exists, but it's very special-cased and
fragile. And then there's this further up:


	/*
	 * some device names have larger paths - convert the slashes
	 * to underscores for this to work as expected
	 */
	strreplace(buts->name, '/', '_');


which I'm not sure applies anymore but would also break this. Doing the
lookup is just more foolproof.

Thanks,
Omar
