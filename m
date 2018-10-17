Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Wed, 17 Oct 2018 17:20:29 -0400
From: Dennis Zhou <dennis@kernel.org>
To: valdis.kletnieks@vt.edu
Cc: Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
 <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
 <13448.1539791255@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13448.1539791255@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 17, 2018 at 11:47:35AM -0400, valdis.kletnieks@vt.edu wrote:
> On Tue, 16 Oct 2018 14:25:13 -0400, Dennis Zhou said:
> 
> > > >  grep execve /root/rpm-exec-strace
> > > > execve("/usr/bin/rpm", ["rpm", "-Uvh", "--force", "dracut-049-4.git20181010.fc30.x8"...], 0x7ffc9d967d80 /* 33 vars */) = 0
> 
> > > Thanks for testing and reporting this! Do you mind sending me your
> > > reproducer?
> 
> See above. An 'rpm' command blows it up....
> 
> > I've spent some time thinking about this, and this is my guess at what
> > is happening without seeing your reproducer. The system is under memory
> > pressure and a new cgroup is being created. The cgroup allocation fails
> > causing the request_list code to fallback and walk up the blkg tree.
> > There is special handling for the root cgroup, but I missed that case
> > and it fails there I believe.
> 
> Hmm... I boot to single-user, do a cd, and run 'rpm -Uvh --force' on an RPM
> that was already installed. (I originally hit this with 'dnf', but running 'dnf
> update' wouldn't trigger a crash if the system was up to date.  To make a
> bisect workable, I ended up using RPM to re-install an already installed
> package or 3 triggered it as well.
> 
> That's a consistent reproducer for me.  rpm does an execve() (actually,
> it does 5), and one of them goes kablam.  I've also managed to hit it
> once doing an 'rm'.
> 
> And my laptop has 16G of ram.  Shouldn't be any memory pressure at all in
> single-user mode.  So it looks like you fixed a bug, but not the one I was hitting.
> 
> > In addition to sending me the reproducer and your config, can you please
> > try the patch below?
> 
> Tried the patch, didn't make a difference. So there's at least one more bug
> out there to find. :)
> 
> Config attached.

I apologize, but I'm having a hard time reproducing this myself. I am
not able to hit this issue in my qemu instance with linux-next built
with your config. I have been running 'rpm -Hvh --force fio.rpm' several
times and haven't seen the issue.

Would it be possible for you to create a minimal qemu image that
reproduces the issue as I'm having issues reproducing it with my setup?
Additionally, I've added some more debug text in the diff below. If you
could apply that and send me the full dmesg that would be great. Lastly,
can you just confirm for me that the commit before, f0fcb3ec89f3
"blkcg: remove additional reference to the css", isn't seeing this
issue?

Thanks,
Dennis
---
diff --git a/block/blk-core.c b/block/blk-core.c
index 4dbc93f43b38..1b56cec40301 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1538,6 +1538,19 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
+	printk_once(KERN_INFO "dennis zhou");
+	if (q != rl->q) {
+		printk(KERN_INFO "dennis: q %px != rl->q %px", q, rl->q);
+		if (bio && bio->bi_blkg)
+			printk(KERN_INFO "dennis: bio: %px, root: %px",
+			       bio->bi_blkg->blkcg, &blkcg_root);
+	}
+	if (!q)
+		printk(KERN_INFO "dennis: q is null!");
+	if (!rl)
+		printk(KERN_INFO "dennis: rl is null!");
+	if (!rl->q)
+		printk(KERN_INFO "dennis: rl->q is null!");
 	rq = __get_request(rl, op, bio, flags, gfp);
 	if (!IS_ERR(rq))
 		return rq;
