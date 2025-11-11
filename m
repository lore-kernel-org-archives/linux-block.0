Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C6254B18
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885064; cv=none; b=SOcDjCrmKwj4FtZjAOZ6+BMZC4XQU28Vdz7O5Oy+ygGB7yT1X0yqGHeB4MZ+q+RSZ2k5fdSHQglIgKkLOjbAy1yE/E5o4uO7Vd2gDyP9Gw/X4RuZAZkiuyZt3pX2plvRH/joaHlvefLeNIPCAKX7EgkoglwJriswkwj0Nhg/50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885064; c=relaxed/simple;
	bh=nWZjS1nPdDEksgCppyW9mX/eKsKMjiUzAXESrhSoCIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1jvF1TTVmP6M1BOLR2ecMCZTHlh8nDaCmvSQuwmznmG+uGB/iSi8UkhsCeygm4WziA7GfxHce3l8VpZOLD7KWGNSD7Y9CwIZI6gyoAXLL/ZoYUTEl1LpKzVzEEC/aFVZH/f+8rhHQwB44a6swUO1J73Xtk6SvePhKcFT8jwEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO2xGP7i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO2xGP7i"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2955623e6faso37700465ad.1
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 10:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762885061; x=1763489861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhKk2jKEQU8yPrG2We87A9Z8l3xrC7QpPaIa0eL0+sM=;
        b=hO2xGP7i0svP4LhKnfzUBgNDtwADC5ZSge1ZH3ind7rpxmAMYKmOt2Gb2DQ77ta2Mk
         e+8BoYBmzhTtKDCIPWj4Y/Vehd6hZlzCFQNamCTqAU7HzATM9nNpNUSVBFTZPpw3ue/u
         byorRVdyUBkwQyGQZdfbnqSwArMRHWYAkcnItapy1e4+bkxEtFrWg9FoFsApL/CFb5KF
         2oMh8nhJV/u6e9nShVhp03ZqbdqQMjE/jnftxPo71rrhLEC1QnJpFDyLwb0GiUQ6sUUX
         xoQ56qtkzEA1LYhIvdZfORcZRQnu4rO5lvcDKOgLjBse0Q32QwaJccaFZkEsb4FY4uRP
         M3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885061; x=1763489861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhKk2jKEQU8yPrG2We87A9Z8l3xrC7QpPaIa0eL0+sM=;
        b=vTj2Ro9yEDyiHiYFWf9jvtRhNLaalelJxmZ8+Jp1rh0xCmP1PQA0Ss/1KINexeG6aH
         Hie9ggdBB5wBk02CIvZul5ZkVBe5AlppcGYKo9t/ba/KSPcvfDzWy7omH+k6F9b6ZAba
         bJLBvczEYUABDYVtelUeVZgKlwNo1I9V7XgNYs2lLfiAJxMfXr7o9qu9WVWMbtafwevn
         LcJeNHhwqEhPgK55DO9/a2Y652xsXdRvfrbv5HOnloXojOadkUbUfoQwbD/VrzQuGtWt
         mUpl64DTotDj6BfNveQVtUiI3wqktahid4rygaafneYF+UF5jDAjg2TmjTqqtIYOzVrp
         at4w==
X-Gm-Message-State: AOJu0YzAalhK/HlInqKra8yiy+j1TtAfUQ9yiOd+cVTI+fTkwmJd4yi2
	gg37hpywJqt0K5spg00S/dVahzmJLIxIQSowTEt8eLDQ2MZvFrNLaa5rffS9tw==
X-Gm-Gg: ASbGncuHs9+ZQCkv9ww4V4E6BrxxyNaN1xagbBMr7pCmqIZnLyum2YOTW4L3KeCoylh
	QKUYmq5vXyk/PEF4MI5GhVFx9IvoNFqI24Si54R0VEVE96ic022ihB7c+2EBm/bYIhPpR/U0rwZ
	JeG79wHT0PRLrhkjExeOQcGUqkqOG9QlFbEqaX8+BaHhbpogOJ1tORmowjHpOIC02mL69cxDAom
	oUQw7Vp6GYKXmpZ804RVKTETA3IyzQjX588Bu8XVPv5MTMiH/K+ATkSK4o4cHK+dGHbQwaZc1wm
	Itch0iupZm8/K247t9dbqIiULNhBFQgDOKAUxbH+1elg7A+Zcklc2XpBuIo1WD+XQFsIqs541GD
	mn2BLVk+b1yvJRvFWEyPzDr29X0GPNPPhOvhTAPFfoX0yQu7I5oe1+FAHr01z9gQe6RiehB6LxT
	yQlsEhz6DOyF55mBKcbT0fPcysaKPSrsbg7kW7fRJ+HU8WKMA=
X-Google-Smtp-Source: AGHT+IFAZqc4VShDpIxXXiIsKTLKOJdTK6+aEeJSOxcl9Zh3L9O2DlIpPj/+UZJODJ9pWEyN2VSwxQ==
X-Received: by 2002:a17:903:b0b:b0:295:8dbb:b3cd with SMTP id d9443c01a7336-2984eda4092mr2749115ad.27.1762885060586;
        Tue, 11 Nov 2025 10:17:40 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd4b2asm3721375ad.94.2025.11.11.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:17:40 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	kch@nvidia.com,
	dlemoal@kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] blk-mq: add blk_rq_nr_bvec() helper
Date: Tue, 11 Nov 2025 10:17:36 -0800
Message-Id: <20251111181736.54852-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper function blk_rq_nr_bvec() that returns the number of 
bvec segments in a request. This count represents the number of iterations
rq_for_each_bvec() would perform.

Drivers need to pre-allocate bvec arrays before iterating through
a request's bvecs. Currently, they manually count segments using
rq_for_each_bvec() in a loop, which is repetitive. The new helper
centralizes this logic.

This pattern exists in loop and zloop drivers, where multi-bio requests
require copying bvecs into a contiguous array before creating
an iov_iter for file operations.

Update loop and zloop drivers to use the new helper, eliminating
duplicate code.

This patch also provides a clear API to avoid any potential misuse of
blk_nr_phys_segments() for calculating the bvecs since, one bvec can
have more than one segments :-

[ 6155.673749] nullb_bio: 128K bio as ONE bvec: sector=0, size=131072
[ 6155.673846] null_blk: #### null_handle_data_transfer:1375
[ 6155.673850] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=2
[ 6155.674263] null_blk: #### null_handle_data_transfer:1375
[ 6155.674267] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=1

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
Hi,

This patch also provides a clear API to avoid any potential misuse of
blk_nr_phys_segments() for calculating the bvecs in drivers since :-

During bio submission, the block layer may split a single bvec into
multiple physical segments based on device limits:
    submit_bio()
      -> submit_bio_noacct()
        -> __submit_bio_noacct()
          -> __submit_bio()
            -> blk_mq_submit_bio()
              -> __bio_split_to_limits()
                -> bio_split_rw()
                  -> bio_split_rw_at()
                    -> bio_split_io_at()
                      -> bio_for_each_bvec()
                        -> [Fast path] nsegs++ (1 bvec = 1 segment)
                        -> [Slow path] bvec_split_segs()

The bvec_split_segs() function handles the case where a single bvec must 
be split into multiple segments:

    /**
     * bvec_split_segs - verify whether or not a bvec should be split in the
     *                   middle
     * ...
     * When splitting a bio, it can happen that a bvec is encountered that is
     * too big to fit in a single segment and hence that it has to be split in
     * the middle.
     */
    static bool bvec_split_segs(...)
    {
        while (len && *nsegs < max_segs) {
            seg_size = get_max_segment_size(...);
            (*nsegs)++;
            total_len += seg_size;
            len -= seg_size;
        }
        *bytes += total_len;
        return (len > 0);  // True if bvec was split
    }

Splitting occurs when a bvec exceeds:
- max_segment_size
- segment_boundary_mask (DMA boundary constraints)
- max_segments limit

Result after bio_split_io_at():
- nr_bvec (what rq_for_each_bvec iterates): **1**
- rq->nr_phys_segments: 2

*[ 6155.673749] nullb_bio: 128K bio as ONE bvec: sector=0, size=131072
*[ 6155.673846] null_blk: #### null_handle_data_transfer:1375*
*[ 6155.673850] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=2*
*[ 6155.674263] null_blk: #### null_handle_data_transfer:1375*
*[ 6155.674267] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=1*

-ck
---
 drivers/block/loop.c   |  5 ++---
 drivers/block/zloop.c  |  5 ++---
 include/linux/blk-mq.h | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13ce229d450c..7b716d759168 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -348,11 +348,10 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
 	unsigned int offset;
-	int nr_bvec = 0;
+	unsigned int nr_bvec;
 	int ret;
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
+	nr_bvec = blk_rq_nr_bvec(rq);
 
 	if (rq->bio != rq->biotail) {
 
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..857a8de61088 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -370,7 +370,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	struct iov_iter iter;
 	struct bio_vec tmp;
 	sector_t zone_end;
-	int nr_bvec = 0;
+	unsigned int nr_bvec;
 	int ret;
 
 	atomic_set(&cmd->ref, 2);
@@ -437,8 +437,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 			zone->cond = BLK_ZONE_COND_FULL;
 	}
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
+	nr_bvec = blk_rq_nr_bvec(rq);
 
 	if (rq->bio != rq->biotail) {
 		struct bio_vec *bvec;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b25d12545f46..ef1a80d41e15 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1185,6 +1185,25 @@ static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
 	return max_t(unsigned short, rq->nr_phys_segments, 1);
 }
 
+/**
+ * blk_rq_nr_bvec - return number of bvec segments in a request
+ * @rq: request to calculate bvvecs for
+ *
+ * Returns the number of bvec segments that would be iterated by
+ * rq_for_each_bvec().
+ */
+static inline unsigned int blk_rq_nr_bvec(struct request *rq)
+{
+	struct req_iterator rq_iter;
+	struct bio_vec bv;
+	unsigned int nr_bvec = 0;
+
+	rq_for_each_bvec(bv, rq, rq_iter)
+		nr_bvec++;
+
+	return nr_bvec;
+}
+
 int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 		struct scatterlist **last_sg);
 static inline int blk_rq_map_sg(struct request *rq, struct scatterlist *sglist)
-- 
2.40.0

