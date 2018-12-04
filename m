Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30543C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED89B20834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED89B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeLDSg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:36:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42196 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeLDSgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:17 -0500
Received: by mail-yw1-f65.google.com with SMTP id x2so7389242ywc.9;
        Tue, 04 Dec 2018 10:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GpKKsX6cKhxXuFDSCK8CzHfLCYdBqcCVVk9oe3i81ZI=;
        b=WajcnQyNXdCosDSZVWr9Q9npgIAfcw90vWD3BIEuXEkOi9Va4zauZbC9aicLCG/c9I
         5IqS+QGzd0NRr5xVJDs1LPpJ4ceK9pui9dPHOOQHm3DVHfLYcje9rYD8JeQjdGsf5YmC
         FnngW8AvJRwkX/taXjXUaX0trn9YM0MBHuWmHaimj5UiU70Y68BdCqk5zr9Z/inIPgIb
         sDo+CMNidlD68p3r1Ouol0HYwcpKVaLodFAqTIbYnUbOywKtuJp5yP7BmwQePAe1E3U8
         PxErZUUNqy8VhINZhK/qCQg2dXNaAmE97MTj+PIOa73Q1FjmerNUu7WuOLupBlCM8wG8
         62eA==
X-Gm-Message-State: AA+aEWYNEgPcZLGxUdQ53fk/477MBvGM8b14/5GoY6I3RBSnKqcC4mhA
        r27ahM2Bb2NejnaCkT+3j9E=
X-Google-Smtp-Source: AFSGD/WqS/IJaNCIO7rR3vEw1K1Wn1pCmVl5YoD4U8Xn2D4mljKrGLdmexZVz1xYg7kwIkPTN6m/kA==
X-Received: by 2002:a81:3683:: with SMTP id d125mr21319530ywa.263.1543948576082;
        Tue, 04 Dec 2018 10:36:16 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:15 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 09/14] blkcg: associate writeback bios with a blkg
Date:   Tue,  4 Dec 2018 13:35:55 -0500
Message-Id: <20181204183600.99746-10-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the goals of this series is to remove a separate reference to
the css of the bio. This can and should be accessed via bio_blkcg(). In
this patch, wbc_init_bio() now requires a bio to have a device
associated with it.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 +++++---
 block/bio.c                             | 18 ++++++++++++++++++
 fs/buffer.c                             | 10 +++++-----
 fs/ext4/page-io.c                       |  2 +-
 include/linux/bio.h                     |  5 +++++
 include/linux/writeback.h               |  5 +++--
 6 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 476722b7b636..baf19bf28385 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1879,8 +1879,10 @@ following two functions.
 
   wbc_init_bio(@wbc, @bio)
 	Should be called for each bio carrying writeback data and
-	associates the bio with the inode's owner cgroup.  Can be
-	called anytime between bio allocation and submission.
+	associates the bio with the inode's owner cgroup and the
+	corresponding request queue.  This must be called after
+	a queue (device) has been associated with the bio and
+	before submission.
 
   wbc_account_io(@wbc, @page, @bytes)
 	Should be called for each data segment being written out.
@@ -1899,7 +1901,7 @@ the configuration, the bio may be executed at a lower priority and if
 the writeback session is holding shared resources, e.g. a journal
 entry, may lead to priority inversion.  There is no one easy solution
 for the problem.  Filesystems can try to work around specific problem
-cases by skipping wbc_init_bio() or using bio_associate_blkcg()
+cases by skipping wbc_init_bio() and using bio_associate_blkg()
 directly.
 
 
diff --git a/block/bio.c b/block/bio.c
index f0f069c1823c..b42477b6a225 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2034,6 +2034,24 @@ static void __bio_associate_blkg_from_css(struct bio *bio,
 	rcu_read_unlock();
 }
 
+/**
+ * bio_associate_blkg_from_css - associate a bio with a specified css
+ * @bio: target bio
+ * @css: target css
+ *
+ * Associate @bio with the blkg found by combining the css's blkg and the
+ * request_queue of the @bio.  This takes a reference on the css that will
+ * be put upon freeing of @bio.
+ */
+void bio_associate_blkg_from_css(struct bio *bio,
+				 struct cgroup_subsys_state *css)
+{
+	css_get(css);
+	bio->bi_css = css;
+	__bio_associate_blkg_from_css(bio, css);
+}
+EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
+
 #ifdef CONFIG_MEMCG
 /**
  * bio_associate_blkg_from_page - associate a bio with the page's blkg
diff --git a/fs/buffer.c b/fs/buffer.c
index 1286c2b95498..d60d61e8ed7d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3060,11 +3060,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
-	if (wbc) {
-		wbc_init_bio(wbc, bio);
-		wbc_account_io(wbc, bh->b_page, bh->b_size);
-	}
-
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
@@ -3084,6 +3079,11 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 		op_flags |= REQ_PRIO;
 	bio_set_op_attrs(bio, op, op_flags);
 
+	if (wbc) {
+		wbc_init_bio(wbc, bio);
+		wbc_account_io(wbc, bh->b_page, bh->b_size);
+	}
+
 	submit_bio(bio);
 	return 0;
 }
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index db7590178dfc..2aa62d58d8dd 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -374,13 +374,13 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 	if (!bio)
 		return -ENOMEM;
-	wbc_init_bio(io->io_wbc, bio);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
+	wbc_init_bio(io->io_wbc, bio);
 	return 0;
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f13572c254a7..f0438061a5a3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -515,6 +515,8 @@ static inline void bio_associate_blkg_from_page(struct bio *bio,
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 void bio_disassociate_blkg(struct bio *bio);
 void bio_associate_blkg(struct bio *bio);
+void bio_associate_blkg_from_css(struct bio *bio,
+				 struct cgroup_subsys_state *css);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
@@ -522,6 +524,9 @@ static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline void bio_disassociate_blkg(struct bio *bio) { }
 static inline void bio_associate_blkg(struct bio *bio) { }
+static inline void bio_associate_blkg_from_css(struct bio *bio,
+					       struct cgroup_subsys_state *css)
+{ }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkcg_association(struct bio *dst,
 			struct bio *src) { }
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fdfd04e348f6..738a0c24874f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -246,7 +246,8 @@ static inline void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
  *
  * @bio is a part of the writeback in progress controlled by @wbc.  Perform
  * writeback specific initialization.  This is used to apply the cgroup
- * writeback context.
+ * writeback context.  Must be called after the bio has been associated with
+ * a device.
  */
 static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 {
@@ -257,7 +258,7 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 	 * regular writeback instead of writing things out itself.
 	 */
 	if (wbc->wb)
-		bio_associate_blkcg(bio, wbc->wb->blkcg_css);
+		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css);
 }
 
 #else	/* CONFIG_CGROUP_WRITEBACK */
-- 
2.17.1

