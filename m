Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382C33F6
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903379; cv=none; b=HFYS/HzIxd3R3npXs29wFL6wJ5iVN8AdsrttvyHIoPj3WGKNE14jO/EyFh6og6wTImzXRy7TqPV7oCpghNHRifirNYEu0/F37YClSK0tDI7e6HKbxGNqBkYuYMYiGxyvyEpNZmQUdMosLqFbxo0XzeDEQ1UFVOV2SNc/0kh35/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903379; c=relaxed/simple;
	bh=RVYav7d5qdxfKCgb3Zsk7tQNluzxNvGsvBkF6LDPMAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktPdmEaCaRWNB86gD2ZCWlosEPXI1VcdJHu7NF23sMZ4Z5ikI56EmcpkXTnh2jq4Bf+pNF88Zbi9Iu5vZwYhAIYTEONmj1n+Vd1SxysuA0ysB3oDfJYLEZ0QXJRSYY4Olt3E1/P/Dh4QnmbK6d5oaOEGCyd2vRezbLEhWiEgS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoKZAcEM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoKZAcEM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso280282b3a.1
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762903377; x=1763508177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYoo8lboixDlRScjwLZoiK/+QAvNuFcUagm6YGdzh28=;
        b=VoKZAcEMUoWkv5n4CQaotTcAAe515RrcyFv/B+ea24R8l/GZZapFsLrYSwdBegBUFx
         4qtFUryhkfft5XZnCp8NBiIkFr5swo51+glnuWYUbqDn8hOeLb2Ekfh0x9bL9tt9TnSi
         r6R0b3LkWsf9smo6FJhuZH1BdxpWf9iMM6kJLCJtlukRvH7W07OCCsOsog/P6bM/X6hL
         BvGc8Y6DXFVBX5WtS9ik0AAgoFCH8b5/XQe/LCkZknuiXNuzJbdedOqrUhchhlj2cBee
         /aPBMRDA2U8z9ws6ZySe6GwYssX0b6xUJ4OSRJwyWe6gLRkvu/XvQjf1HchOT0EYejYE
         mZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903377; x=1763508177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYoo8lboixDlRScjwLZoiK/+QAvNuFcUagm6YGdzh28=;
        b=cs1gkNuE0kMd2nSV4AZWLGWevuDJxpEunCHy8ULqYo3Fu+H+HWN8VW7BjeD6uMPyc9
         HifHoNDGQsDV/7LvfI9TNKDIgMlFf8bzX9Z6jUrkXzdLI3dChf2Z0Y7HtwGk9VcJWxHw
         DYK7BKer0Pvxl/9XbEsTgo7+u0S1bn7olsB3EM82nHFN0uCqIvwTfE2sq+NS+9Oq69tX
         RwqbtDy7lQJopiUE44MVEHXEtdjE4QuNMJJm3w0mMzyk51/JZFo6gpVCg2+ga2j6nFWM
         bW5GlPuCbp/z+1q4cNlyQss48il4aT48GC3ue0wCU4OrCU6t/9RxcrRZu8kczXRr+rrp
         NDRw==
X-Gm-Message-State: AOJu0YxF5u6eObF1CS7x+rKkRCvE9teYAeLBOfQ+QJKiL+JpjM+5D4gv
	WkDhJA7jNlSAZpiGD0rk+ZTwwOJpY6TD3T5/Ip3ZOqKRL5DcwGslGkK23THM2Q==
X-Gm-Gg: ASbGncvZCJxFZUz1LF3Pzrhq3UzcVghKw5xR6beiVrm/Sg3G9Y6dzU/D0iMi96S+I8f
	KeD4osetLiFKP9wnOwL95d/mmzQTTUExmILdbt8DKS4I5X5onzVY69+g+UQkZzPuzXRs51kBA7h
	bkLLpoZ6onqjExIv9CwWygTXPGu/e7oUZdaG7Q5CphiZOz+idGabAjmjBuDvjGRJ8etJhMCz6Df
	bXeyfxolrdrCnHLXvvu0QnF/bqmeq8qeDegqvJhR7NFkBzquph/W6Jckhx08jrm8H/TspZ6pKdD
	LWi2mzfwU2ONs+YRhKmVu1lMyMpibjPz5MYuwl3ThCQEa20wSTNl9vsZg2e7D5bYdY1Rng96ElE
	K7/+mcLLJA0nJYDmYaZttnySto51OSJDIAK8qJBhi2JK2rvnZ3l70ZQNGQmSyt6fXVB0G/eFFpE
	52NKQfmwtmTmC8fyd2DQ5meWu65QvYbW8oSmjZ
X-Google-Smtp-Source: AGHT+IG61v28vLZJxYvJZ6i+xzDcTNdOFUgVk0K/CgTHjiw7GBIayLoHapGlhEVZSSLgaiwHqrJSfA==
X-Received: by 2002:a05:6a00:94c7:b0:7ab:6fdb:1d3a with SMTP id d2e1a72fcca58-7b7a46ffb4bmr792330b3a.16.1762903376972;
        Tue, 11 Nov 2025 15:22:56 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9f01821sm16626927b3a.26.2025.11.11.15.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:22:56 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	kch@nvidia.com,
	dlemoal@kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Date: Tue, 11 Nov 2025 15:22:52 -0800
Message-Id: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
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

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---

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
 include/linux/blk-mq.h | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

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
index b25d12545f46..7cedc0eba561 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1185,6 +1185,24 @@ static inline unsigned short blk_rq_nr_discard_segments(struct request *rq)
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

