Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73618C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B44A218FF
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hxyyP+pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCUOV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:21:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32880 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfCUOV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 10:21:58 -0400
Received: by mail-it1-f193.google.com with SMTP id v8so2598908itf.0
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XgDhbctfX3Arv5rZxySt6y8AH4YckqBWEj3wTbF9LLI=;
        b=hxyyP+pSce1pi6B/SWx1E/81Qs359gimqlFRDaEwzdgQ7oXeKWeBavUJ9WB6ZN411S
         WGAA7IBOs9/3fKyS9EVd+AG5zgI/oPl3J6M6b7twKBQn29jZSkpe9cVRsQgOq//nENbk
         CYyqorm8TKFNJ6tpWHezsiwXs1Tz4i4rkuh1XiWJJCkpsopKn6x3xPuy4aiQHfvBbb0g
         /xI/n0qhZlTpQUQ41pl8mB0LqnoL3tTZ8fa19UgNaACtlqdFQ7DYECLBoxYsTLgJOst4
         I9Tygoq54ANSV6bwL54G1NQ7o/FgUgDjWOvOey8gXaMQ6C7y/G4cMi3Pd2+TYvj3tMIX
         igLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XgDhbctfX3Arv5rZxySt6y8AH4YckqBWEj3wTbF9LLI=;
        b=WiJutsjXewjuibvS8JQ5dcKRoJ0Z+cdelRTQwtEWQ5yazcbEU+lidlVkPZKE7nXM0k
         2gFv3/yVy79D5om2hffqQBigyJ+z/ctzqitnMvZ8MZWXnw0CNW10sMr+EOR5W1qexIle
         TVzQMF2jTUPwkKcCLikFQfvRjpULWBF14UdhQoxsNkLvUMKlFl1xPQ2VoO7zVQS00GC2
         ZgzBkfG5Xp1Q8rhoAIcRZzvuljzM9oS99bPbzcrYnFIoUnpFG/C0uaHPJdPicnJzy0Kr
         ItTQSddie9y+tp/bgcXn1pMWox7QmervyjUxWzTQGaGVY1DMgHYmbyfr78yYdmbRgsj2
         PHtA==
X-Gm-Message-State: APjAAAXVT1Y4z1Q5mhnlRF9zKI+ZJw2r70+6Jjsk/pVFViI5YyV5Qcr9
        meUJ/ajowGuutYdNvRxvcN0vhg==
X-Google-Smtp-Source: APXvYqwnYLYSPIIkfnqlzWgi79+mGsKpLokjfu0tFyX837vTrSmx4RZNsFgYnk22snHG6i7s85N+WA==
X-Received: by 2002:a05:660c:a18:: with SMTP id e24mr2783545itk.129.1553178117386;
        Thu, 21 Mar 2019 07:21:57 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n4sm347424ioh.52.2019.03.21.07.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:21:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: bio: ensure newly added bio flags don't
 override BVEC_POOL_IDX
From:   Jens Axboe <axboe@kernel.dk>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
References: <20190321123045.32396-1-jthumshirn@suse.de>
 <20190321123045.32396-2-jthumshirn@suse.de>
 <78cf685f-2bb4-c494-4677-afa513b47339@fb.com>
Message-ID: <17f1ef65-5fcf-0cba-4d37-a43d5e5038b0@kernel.dk>
Date:   Thu, 21 Mar 2019 08:21:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <78cf685f-2bb4-c494-4677-afa513b47339@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 8:15 AM, Jens Axboe wrote:
> You also haven't solved the issue of now having an extra bit, 2/2 uses
> the last bit which the other patch already took...

Here's one way - kill BIO_SEG_VALID. We should just use
->bi_phys_segments to tell if it's valid or not. This patch uses -1 to
signify it's not.

Totally untested...

diff --git a/block/bio.c b/block/bio.c
index 71a78d9fb8b7..4bc165e7ca43 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -280,6 +280,7 @@ void bio_init(struct bio *bio, struct bio_vec *table,
 	      unsigned short max_vecs)
 {
 	memset(bio, 0, sizeof(*bio));
+	bio->bi_phys_segments = -1;
 	atomic_set(&bio->__bi_remaining, 1);
 	atomic_set(&bio->__bi_cnt, 1);
 
@@ -305,6 +306,7 @@ void bio_reset(struct bio *bio)
 	bio_uninit(bio);
 
 	memset(bio, 0, BIO_RESET_BYTES);
+	bio->bi_phys_segments = -1;
 	bio->bi_flags = flags;
 	atomic_set(&bio->__bi_remaining, 1);
 }
@@ -573,7 +575,7 @@ EXPORT_SYMBOL(bio_put);
 
 int bio_phys_segments(struct request_queue *q, struct bio *bio)
 {
-	if (unlikely(!bio_flagged(bio, BIO_SEG_VALID)))
+	if (unlikely(bio->bi_phys_segments == -1))
 		blk_recount_segments(q, bio);
 
 	return bio->bi_phys_segments;
@@ -731,7 +733,7 @@ int bio_add_pc_page(struct request_queue *q, struct bio *bio, struct page
 
 	/* If we may be able to merge these biovecs, force a recount */
 	if (bio->bi_vcnt > 1 && biovec_phys_mergeable(q, bvec - 1, bvec))
-		bio_clear_flag(bio, BIO_SEG_VALID);
+		bio->bi_phys_segments = -1;
 
  done:
 	return len;
@@ -1913,10 +1915,8 @@ void bio_trim(struct bio *bio, int offset, int size)
 	if (offset == 0 && size == bio->bi_iter.bi_size)
 		return;
 
-	bio_clear_flag(bio, BIO_SEG_VALID);
-
+	bio->bi_phys_segments = -1;
 	bio_advance(bio, offset << 9);
-
 	bio->bi_iter.bi_size = size;
 
 	if (bio_integrity(bio))
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1c9d4f0f96ea..57cea2782a76 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -343,7 +343,6 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 	/* physical segments can be figured out during splitting */
 	res = split ? split : *bio;
 	res->bi_phys_segments = nsegs;
-	bio_set_flag(res, BIO_SEG_VALID);
 
 	if (split) {
 		/* there isn't chance to merge the splitted bio */
@@ -440,8 +439,6 @@ void blk_recount_segments(struct request_queue *q, struct bio *bio)
 	bio->bi_next = NULL;
 	bio->bi_phys_segments = __blk_recalc_rq_segments(q, bio);
 	bio->bi_next = nxt;
-
-	bio_set_flag(bio, BIO_SEG_VALID);
 }
 
 static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
@@ -651,9 +648,9 @@ int ll_back_merge_fn(struct request_queue *q, struct request *req,
 		req_set_nomerge(q, req);
 		return 0;
 	}
-	if (!bio_flagged(req->biotail, BIO_SEG_VALID))
+	if (req->biotail->bi_phys_segments == -1)
 		blk_recount_segments(q, req->biotail);
-	if (!bio_flagged(bio, BIO_SEG_VALID))
+	if (bio->bi_phys_segments == -1)
 		blk_recount_segments(q, bio);
 
 	return ll_new_hw_segment(q, req, bio);
@@ -673,9 +670,9 @@ int ll_front_merge_fn(struct request_queue *q, struct request *req,
 		req_set_nomerge(q, req);
 		return 0;
 	}
-	if (!bio_flagged(bio, BIO_SEG_VALID))
+	if (bio->bi_phys_segments == -1)
 		blk_recount_segments(q, bio);
-	if (!bio_flagged(req->bio, BIO_SEG_VALID))
+	if (req->bio->bi_phys_segments == -1)
 		blk_recount_segments(q, req->bio);
 
 	return ll_new_hw_segment(q, req, bio);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c033bfcb209e..79eb54dcf0f9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5247,7 +5247,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 		rcu_read_unlock();
 		raid_bio->bi_next = (void*)rdev;
 		bio_set_dev(align_bi, rdev->bdev);
-		bio_clear_flag(align_bi, BIO_SEG_VALID);
+		align_bi->bi_phys_segments = -1;
 
 		if (is_badblock(rdev, align_bi->bi_iter.bi_sector,
 				bio_sectors(align_bi),
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d66bf5f32610..472059e92071 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -215,7 +215,6 @@ struct bio {
 /*
  * bio flags
  */
-#define BIO_SEG_VALID	1	/* bi_phys_segments valid */
 #define BIO_CLONED	2	/* doesn't own data */
 #define BIO_BOUNCED	3	/* bio is a bounce bio */
 #define BIO_USER_MAPPED 4	/* contains user pages */

-- 
Jens Axboe

