Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E98231827
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764734294; cv=none; b=dcu4ceiTkrJqHGvhjvxa8zYMu3LOmxPpnWfW7HP8CHVi1NZ9X6+X4Q+9Uf0/sLM1++/BQSygu7MG7R3v4+jdTIi7/ntdIjE72EzPIWGRfti4iJYqNABhIxhV6xzGsIfY1V5+cissDz9h13bK8Z5oZ3OomHmOoa6xcMr/0OTPuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764734294; c=relaxed/simple;
	bh=jA7ppoL2btYpLD56UmAahdXqlhGBlNes4HeuDdKQUaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+nkXEFHxcvRS6ah5MBHiDD1yXY6ZL5prcrbfHE6XuE9xYuTryiHMhveeAxFa/R65Ijow9mfPQEXmrxrv++Eyj2XWT9aHaPXt0Ak+pUkRQBVXRlrQoaIfUuh/sIBDbGFdBwMp56igb4KVdRmck+FAVp34xzM59gOlYTKdw5zvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpEzhEnq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpEzhEnq"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b996c8db896so7304892a12.3
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 19:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764734292; x=1765339092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wtT80laZZr2EVLtVh+9yjeQK2HScm71Gn/qBdsOPts=;
        b=lpEzhEnq+ku8EgcXmg+yaNB3kNBmIAPKHPPBjOfE5LRhVnQF32VVQ4oTyIIjpFmXv/
         y0JedtMjqA4NfK4m0/0VGZTwZsRGNKx6kRVr0+10NQy15M0qE1L7F6nfygX5FblAjH5g
         K0IK8wayl6V0O9sdnLhV8dudxOIuvR/kt8Q9FVNSeBK0UtoWiXwaihrSzrBctZtaOAfJ
         SNcL+zHxbB41lSf0H5zgS7fdu/iApG3T8yzaOxckWiSQap5jsyVLtBtR14Jx/4gU9Dm9
         l2EahPtT9akVRYsiK8V/zviKmZNQvtJXcc6Rw4mofmVd41vje0CejdntOTos9LzRjRGR
         3uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764734292; x=1765339092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wtT80laZZr2EVLtVh+9yjeQK2HScm71Gn/qBdsOPts=;
        b=I6EZF+zhSWwpqfhp7AQcPnvlBUfgGXtygmgTfnR83V2/MLU/l7IwvtSTUBuWWbyOwX
         3bq7e7Q6YprbLhnd3pjaQ+3aEIN/AyOQNYRaQpa3EtzlhU6mFEqgJ0YxLjQWwALmkAy/
         lpe/NLNEWLvY2wc/2CduInpX2T8e2rxwUr+/aFnA1wNp7YgOPSyJP9XpjGocFunz6DFP
         3v9WpVdRnps1hDwGOOX/2BGeppKUaQUAJMqRLoLV7t1JFaeQOKS4CNHnIMZWhsAIlDx6
         6ItpA0hwtQzwOGwsPPhnGtR+jfhrbhShlccDaoVyFIOMjN9eOw1ueUTHsrohGQcQq8hQ
         iBmQ==
X-Gm-Message-State: AOJu0YwOBXebCe3TdHfR2buVTvvbXeTyySeWkOzhW6CcOrI/zRMkFczO
	Eq5nkH/zLkQsC1AyIdSjNi/vgxkJ85rNGWKiWdQ5rPGu/m5V68zvapqX
X-Gm-Gg: ASbGnctFCrrIq5w8oopC4jEpAxBIofoOJ/dwzB7QXtZ1FUm/EvDaDclcSrwRKNaKzQF
	kK9yfO1RFnVbG6zQZDgEBhYKoorQt6OwHpWTndshOrGmEw5Ql7d1Ngju/8gIM3iQqW+P0KyJ3GB
	fw6ObNuXbQT/mHo/lFz0oL5zSbiTT5eyL9p/FsAvpm2EUHS6dC6oSw1qkA7pJ9CCTpASYuVmNgP
	To+gi5iNLd6WVxj2fQAX4DeSn7no4lrcs4UqB2NtvUvtYhffMRhyRItQrwYmpBi6nzp7m1LenaQ
	42M9ttuz/mKG3WJQod8ylDgjgleUCIBmBgkZn15RoC5pNVaDTpRii13xc/mJSniNi4hgQJ95rvK
	2bvUgUEVQPQ92o2KmzdmhghgyfW/o+G+NXeN3dfxkzpJ5ME2WiHL+dEE4fD28AkPCAJqCOSLnUW
	7TQSssbC8VGq2QuUsjgoDLuZ2x
X-Google-Smtp-Source: AGHT+IEOgV2/DUMz8fOTczj8KB7JctvBHrGTDKjtmIFIh7aboBfyER5OaL/OMoztpNMtKRnzNYRCeQ==
X-Received: by 2002:a05:693c:2d81:b0:2a4:3592:cf71 with SMTP id 5a478bee46e88-2ab92e23131mr699686eec.21.1764734292149;
        Tue, 02 Dec 2025 19:58:12 -0800 (PST)
Received: from localhost ([165.85.49.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm63705317eec.6.2025.12.02.19.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:58:11 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	dlemoal@kernel.org
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH V3] blk-mq: add blk_rq_nr_bvec() helper
Date: Tue,  2 Dec 2025 19:58:09 -0800
Message-Id: <20251203035809.30610-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper function blk_rq_nr_bvec() that returns the number of
bvecs in a request. This count represents the number of iterations
rq_for_each_bvec() would perform on a request.

Drivers need to pre-allocate bvec arrays before iterating through
a request's bvecs. Currently, they manually count bvecs using
rq_for_each_bvec() in a loop, which is repetitive. The new helper
centralizes this logic.

This pattern exists in loop and zloop drivers, where multi-bio requests
require copying bvecs into a contiguous array before creating
an iov_iter for file operations.

Update loop and zloop drivers to use the new helper, eliminating
duplicate code.

This patch also provides a clear API to avoid any potential misuse of
blk_nr_phys_segments() for calculating the bvecs since, one bvec can
have more than one segments and use of blk_nr_phys_segments() can
lead to extra memory allocation :-

[ 6155.673749] nullb_bio: 128K bio as ONE bvec: sector=0, size=131072
[ 6155.673846] null_blk: #### null_handle_data_transfer:1375
[ 6155.673850] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=2
[ 6155.674263] null_blk: #### null_handle_data_transfer:1375
[ 6155.674267] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=1

Reviewed-by: Niklas Cassel<cassel@kernel.org>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

V3:-
1. Rebased and Added Reviewed-by tag. (Niklas)

Hi,

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
        return (len > 0);
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
 include/linux/blk-mq.h | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ebe751f39742..272bc608e528 100644
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
index 3f50321aa4a7..77bd6081b244 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -394,7 +394,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	struct bio_vec tmp;
 	unsigned long flags;
 	sector_t zone_end;
-	int nr_bvec = 0;
+	unsigned int nr_bvec;
 	int ret;
 
 	atomic_set(&cmd->ref, 2);
@@ -487,8 +487,7 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		spin_unlock_irqrestore(&zone->wp_lock, flags);
 	}
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
+	nr_bvec = blk_rq_nr_bvec(rq);
 
 	if (rq->bio != rq->biotail) {
 		struct bio_vec *bvec;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index eb7254b3dddd..cae9e857aea4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1213,6 +1213,24 @@ static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
 	return max_t(unsigned short, rq->nr_phys_segments, 1);
 }
 
+/**
+ * blk_rq_nr_bvec - return number of bvecs in a request
+ * @rq: request to calculate bvecs for
+ *
+ * Returns the number of bvecs.
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

