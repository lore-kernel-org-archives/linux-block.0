Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BAC00140
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiHESVq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiHESVp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 14:21:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91076E03B
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 11:21:44 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r6so1721830ilc.12
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rXJR+3kRg10GWju8AY2VY5RepJsm3stSFMxKfTc+Mdw=;
        b=ylx2a39t5J/xEYFPe9U2YFYkUC0vB2kEd6CZ0AM3jHmuWnlWGVzvucZOIbxVceg+5f
         SHItuRP4ZHyrlM5gqKBA+f8EeAFZj7weuhI0B8efhbEhNcay66sSc+mMPE/1snGyd5GN
         ZiqTjR28ByPPcqkuCLa2GpQkdwkfiad3LU4kQBrlM4qM+ef9wFfO/ZpDpNJEU3jOPE2k
         tGQcKdbgx2pPqSBZmyXKm8G7+Z4NxpBJFBpVpO5ghdho8/O/2BtxZ79dh9Ul8emCSast
         b2/R0ZYL9dnMbbOqHWfwFcX7BBvqZ6ROf5vYBNzRkkJugiJuEcl7mVlFonciUqZco+jl
         lkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rXJR+3kRg10GWju8AY2VY5RepJsm3stSFMxKfTc+Mdw=;
        b=Yy30Bjoo0+HZ0Cgx3R8UhrCRgy/t7mZt5fXLK0OAbRqqNIOGluCIj8GzAQY7S8yyBF
         JH5dt4qIS/UAAfkTCcHxYtyQP7yvRpg7XYQCyDPN9CkSzoAkHHl8g5KVpgAC4rk2+USI
         c/JDIqsDCC1pvSiczUg5xjmWrU4B48QGjvVdmtXyC5/41Njbu3lnu6qnm+Lnjc3lPYh4
         DBsCFGNqQ1wVEOxwuGpY6ivxdTq0uEmsPxADuMht7gC4KKBJ3kQ+CTNVemrL3ingagJ6
         Eb9ERkWHUXSQXKuLcdP/pL8zOyBJNToqTvEc0lOg6SgxjYgkHS4NViQYwbfCoaE3E3Cr
         MyuA==
X-Gm-Message-State: ACgBeo2MAd7hlT82D5esm3kS4nFpKpyHeaOSpGXUcG3OoaLOU/+Ab+UN
        rql7AN8S1Jn4FzuINyaGLmTlEg==
X-Google-Smtp-Source: AA6agR54l3gROd8fc8d/9Drphu+8qZXHk3NQjHgNOoLVQ9RkgmLa8ddQo4OjUqO7+DrtWHvs27S+bA==
X-Received: by 2002:a05:6e02:15c9:b0:2da:c33e:49c7 with SMTP id q9-20020a056e0215c900b002dac33e49c7mr3543295ilu.26.1659723703886;
        Fri, 05 Aug 2022 11:21:43 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p5-20020a02c805000000b0033ec45fb044sm1927776jao.47.2022.08.05.11.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:21:43 -0700 (PDT)
Message-ID: <e7aef1f3-b616-8a6e-ee1f-e5ed5998b0db@kernel.dk>
Date:   Fri, 5 Aug 2022 12:21:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com,
        joshiiitr@gmail.com, gost.dev@samsung.com,
        Keith Busch <kbusch@kernel.org>
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
 <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
 <a2a5184d-f3ab-0941-6cc4-87cf231d5333@kernel.dk>
In-Reply-To: <a2a5184d-f3ab-0941-6cc4-87cf231d5333@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/22 11:18 AM, Jens Axboe wrote:
> On 8/5/22 11:04 AM, Jens Axboe wrote:
>> On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>>> Hi,
>>>
>>> Series enables async polling on io_uring command, and nvme passthrough
>>> (for io-commands) is wired up to leverage that.
>>>
>>> 512b randread performance (KIOP) below:
>>>
>>> QD_batch    block    passthru    passthru-poll   block-poll
>>> 1_1          80        81          158            157
>>> 8_2         406       470          680            700
>>> 16_4        620       656          931            920
>>> 128_32      879       1056        1120            1132
>>
>> Curious on why passthru is slower than block-poll? Are we missing
>> something here?
> 
> I took a quick peek, running it here. List of items making it slower:
> 
> - No fixedbufs support for passthru, each each request will go through
>   get_user_pages() and put_pages() on completion. This is about a 10%
>   change for me, by itself.
> 
> - nvme_uring_cmd_io() -> nvme_alloc_user_request() -> blk_rq_map_user()
>   -> blk_rq_map_user_iov() -> memset() is another ~4% for me.
> 
> - The kmalloc+kfree per command is roughly 9% extra slowdown.
> 
> There are other little things, but the above are the main ones. Even if
> I disable fixedbufs for non-passthru, passthru is about ~24% slower
> here using a single device and a single core, which is mostly the above
> mentioned items.
> 
> This isn't specific to the iopoll support, that's obviously faster than
> IRQ driven for this test case. This is just comparing passthru with
> the regular block path for doing random 512b reads.

Here's a hack that gets rid of the page array alloc+free for smaller vec
ranges, and uses the bio cache for polled IO too.

This reclaims about 14% of the 24% compared to block-iopoll, in
particular for this run it brings IOPS from ~1815K to 2110K for
passthru-polled.

We also don't seem to be taking advantage of request completion
batching, and tag batch allocations. Outside of that, looks like just
some generic block bits that need fixing up (and the attached patch that
needs some cleanup gets us most of the way there), so nothing we can't
get sorted out.

Keith, the memset() seems to be tied to the allocations fixed in this
patch, it's gone now as well.

diff --git a/block/blk-map.c b/block/blk-map.c
index df8b066cd548..8861b89e15a8 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -157,10 +157,8 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 		goto out_bmd;
 	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, req_op(rq));
 
-	if (map_data) {
-		nr_pages = 1 << map_data->page_order;
+	if (map_data)
 		i = map_data->offset / PAGE_SIZE;
-	}
 	while (len) {
 		unsigned int bytes = PAGE_SIZE;
 
@@ -232,7 +230,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 }
 
 static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
-		gfp_t gfp_mask)
+			    gfp_t gfp_mask)
 {
 	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
@@ -243,18 +241,34 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (!iov_iter_count(iter))
 		return -EINVAL;
 
-	bio = bio_kmalloc(nr_vecs, gfp_mask);
-	if (!bio)
-		return -ENOMEM;
-	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
+	if (rq->cmd_flags & REQ_POLLED) {
+		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
+
+		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
+					&fs_bio_set);
+		if (!bio)
+			return -ENOMEM;
+	} else {
+		bio = bio_kmalloc(nr_vecs, gfp_mask);
+		if (!bio)
+			return -ENOMEM;
+		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
+	}
 
 	while (iov_iter_count(iter)) {
-		struct page **pages;
+		struct page **pages, *stack_pages[8];
 		ssize_t bytes;
 		size_t offs, added = 0;
 		int npages;
 
-		bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
+		if (nr_vecs < ARRAY_SIZE(stack_pages)) {
+			pages = stack_pages;
+			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
+							nr_vecs, &offs);
+		} else {
+			bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX,
+							&offs);
+		}
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -291,7 +305,8 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 */
 		while (j < npages)
 			put_page(pages[j++]);
-		kvfree(pages);
+		if (pages != stack_pages)
+			kvfree(pages);
 		/* couldn't stuff something into bio? */
 		if (bytes)
 			break;
@@ -304,8 +319,12 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
  out_unmap:
 	bio_release_pages(bio, false);
-	bio_uninit(bio);
-	kfree(bio);
+	if (bio->bi_opf & REQ_ALLOC_CACHE) {
+		bio_put(bio);
+	} else {
+		bio_uninit(bio);
+		kfree(bio);
+	}
 	return ret;
 }
 
@@ -325,8 +344,12 @@ static void bio_invalidate_vmalloc_pages(struct bio *bio)
 static void bio_map_kern_endio(struct bio *bio)
 {
 	bio_invalidate_vmalloc_pages(bio);
-	bio_uninit(bio);
-	kfree(bio);
+	if (bio->bi_opf & REQ_ALLOC_CACHE) {
+		bio_put(bio);
+	} else {
+		bio_uninit(bio);
+		kfree(bio);
+	}
 }
 
 /**
@@ -610,8 +633,12 @@ int blk_rq_unmap_user(struct bio *bio)
 
 		next_bio = bio;
 		bio = bio->bi_next;
-		bio_uninit(next_bio);
-		kfree(next_bio);
+		if (next_bio->bi_opf & REQ_ALLOC_CACHE) {
+			bio_put(next_bio);
+		} else {
+			bio_uninit(next_bio);
+			kfree(next_bio);
+		}
 	}
 
 	return ret;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8f841caaa4cb..ce2f4b8dc0d9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -964,11 +964,10 @@ blk_status_t blk_insert_cloned_request(struct request *rq);
 
 struct rq_map_data {
 	struct page **pages;
-	int page_order;
 	int nr_entries;
 	unsigned long offset;
-	int null_mapped;
-	int from_user;
+	bool null_mapped;
+	bool from_user;
 };
 
 int blk_rq_map_user(struct request_queue *, struct request *,

-- 
Jens Axboe

