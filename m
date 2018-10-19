Return-Path: <dennisszhou@gmail.com>
Return-Path: <dennisszhou@gmail.com>
Date: Fri, 19 Oct 2018 18:21:00 -0400
From: Dennis Zhou <dennis@kernel.org>
To: valdis.kletnieks@vt.edu
Cc: Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181019222100.GA20900@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
 <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
 <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
 <14614.1539964356@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14614.1539964356@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 19, 2018 at 11:52:36AM -0400, valdis.kletnieks@vt.edu wrote:
> On Wed, 17 Oct 2018 17:20:29 -0400, Dennis Zhou said:
> >
> > I apologize, but I'm having a hard time reproducing this myself. I am
> > not able to hit this issue in my qemu instance with linux-next built
> > with your config. I have been running 'rpm -Hvh --force fio.rpm' several
> > times and haven't seen the issue.
> 
> I wouldn't be surprised if there's something oddball in my system config
> that changes the situation.
> 

Do you by chance run any encryption or anything on top of your hard
drive or ssd?

> > Would it be possible for you to create a minimal qemu image that
> > reproduces the issue as I'm having issues reproducing it with my setup?
> 
> Hmm.. I'd first have to figure out how to build a qemu image at all..
> 
> > Additionally, I've added some more debug text in the diff below. If you
> > could apply that and send me the full dmesg that would be great. Lastly,
> > can you just confirm for me that the commit before, f0fcb3ec89f3
> > "blkcg: remove additional reference to the css", isn't seeing this
> > issue?
> 
> Full dmesg attached.  Had to piece it together from a 'dmesg' and what
> got saved in pstore when it crashed.  I was surprised that the printk_once
> popped during very early boot (2.88 seconds in), and then only 2 lines of output
> right before the crash:
> 
> [  106.465848] audit: type=1130 audit(1539957798.984:101): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:syst
> em_r:init_t:s0-s15:c0.c1023 msg='unit=run-r93ac4731e4724fd6a3670e7d0c417522 comm="systemd" exe="/usr/lib/systemd/systemd
> " hostname=? addr=? terminal=? res=success'
> [  106.564711] dennis: q ffff9e3c57152000 != rl->q ffff9e3a8fe48040
> [  106.564713] dennis: bio: ffff9e3a8fcf5400, root: ffffffffbbdd89e0
> [  106.564761] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [  106.568786] PGD 0 P4D 0
> [  106.570761] Oops: 0000 [#1] PREEMPT SMP PTI
> [  106.573115] CPU: 2 PID: 1205 Comm: sh Tainted: G                T 4.19.0-rc8-next-20181016-dirty #639
> 
> I'll cook up a kernel checked out at that commit and test later today...

I thought of another issue that may explain what's going on. It has to
do with how a bio can go through make_request() several times. However,
I do association on the first entry, but subsequent requests may go to
separate queues. Therefore association and the blk_get_rl() returns the
wrong request_list. It may be that a particular blkg doesn't have a
fully initialized request_list.

I've currently only been testing on a drive directly, but my try with md
still worked.. So I am still trying other ways to reproduce it.

Thanks for being patient with me. Would you be able to try the following
on Jens' for-4.20/block branch? His tree is available here:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

Thanks,
Dennis

---
 block/bio.c         | 20 ++++++++++++++++++++
 block/blk-core.c    |  1 +
 include/linux/bio.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 17a8b0aa7050..bbfeb4ee2892 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2083,6 +2083,26 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 	return ret;
 }
 
+/**
+ * bio_reassociate_blkg - reassociate a bio with a blkg from q
+ * @q: request_queue where bio is going
+ * @bio: target bio
+ *
+ * When submitting a bio, multiple recursive calls to make_request() may occur.
+ * This causes the initial associate done in blkcg_bio_issue_check() to be
+ * incorrect and reference the prior request_queue.  This performs reassociation
+ * when this situation happens.
+ */
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+
+	return bio_associate_create_blkg(q, bio);
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..3ed60723e242 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2433,6 +2433,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			if (q)
 				blk_queue_exit(q);
 			q = bio->bi_disk->queue;
+			bio_reassociate_blkg(q, bio);
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f447b0ebb288..b47c7f716731 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -514,6 +514,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css);
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
@@ -522,6 +523,8 @@ static inline int bio_associate_blkg_from_css(struct bio *bio,
 { return 0; }
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
+static inline int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{ return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
-- 
2.17.1
