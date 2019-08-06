Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B8C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 19:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0085214C6
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 19:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F7zVWf1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHFTxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:53:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35648 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfHFTxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 15:53:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so42098680pfn.2
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sd/1agLFaSxCntc3I/Xp9gIxaShOfDT2bKvwtDeZcCc=;
        b=F7zVWf1mJ/t745zt4nkTkWJwIAveQh7izpy+44fKBkynP8EOHvgsHyBVFBydI7ncRV
         ZiOcIY3ME3bN7vFCGeLIpmIvnnlmkyjZ0wrXqPO+xIpQpVb1S8KuGe4T8JpHbG/Gr3nu
         g56NZwDP0CObCzPP9v0Kmp+l6AHBvfy6DT5ZLKIWp6/V8tdDc5b2NbYKKhsBCFFiOSIb
         YFvVMXSENvo5iMSwYt0FThJl5qvQntu7cun71lFlaf9KT2zSHNg7eRv0m8XnB1/8YdFI
         kEbPuBQitizbpUOoJ9lqOzqbenrxcMABZm7CbPhSUHuu4mfICq/RIa9u+sxUWhadw8gY
         YHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sd/1agLFaSxCntc3I/Xp9gIxaShOfDT2bKvwtDeZcCc=;
        b=OjCKf9go6hHX5xJHkNH5eSslOugIZ2H8BXfIKI/t74aB0JvGJ5UcYPaD669nApTNOA
         P+NcR5eSZzfMND72zEApII70p9ZgHkSUs3XlarGMmpH8iFOeskfmM06WvqHLhyR7xvOp
         6Pp9nQoXxwK1BfcvUoaeNEBUOSVvPxDd44iqLA0IqX2ieAdrveGJ2UJWUQooZpUnNIuo
         u2yTHuTT7od4i/hIciCPV76VkFxnwkWJK54wP2kQhL3A0Y3oMbKE2GjOLngy0LXiv+lf
         G+k81il01r7mVJgw2QzU0T8pi8hNZBrOUNSFGghU+K68vkQXcFhqWxeODPxkN24ZRS3+
         eckA==
X-Gm-Message-State: APjAAAUcZDgFhcWXajc2r/BBAn1F02obDIRlaf1dyWVB1OnwJMG0XrGK
        wDGJXiXukejnKxmX/1vE/Y0nzA==
X-Google-Smtp-Source: APXvYqwbc/D2ZoqkxyvBcOW6/0E0UNynlB54ywpz5k2QtJjj3acahsbi2lVL0vwwmsB8Gii4CzRZ6Q==
X-Received: by 2002:a65:6406:: with SMTP id a6mr4351792pgv.393.1565121227436;
        Tue, 06 Aug 2019 12:53:47 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:610b:6bed:b84e:83c0? ([2605:e000:100e:83a1:610b:6bed:b84e:83c0])
        by smtp.gmail.com with ESMTPSA id b16sm143579988pfo.54.2019.08.06.12.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 12:53:45 -0700 (PDT)
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
 <8d6bb95a-3bf5-4bee-90ca-1b0110e39ff1@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b739a9f-9dc3-ea1f-82e4-d42c756bf9b7@kernel.dk>
Date:   Tue, 6 Aug 2019 12:53:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8d6bb95a-3bf5-4bee-90ca-1b0110e39ff1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/19 10:11 AM, Bart Van Assche wrote:
> On 8/1/19 3:21 AM, Damien Le Moal wrote:
>> The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO
>> (patch 6a43074e2f46) introduced two problems with BIO fragment handling
>> for direct IOs:
>> 1) The dio size processed is claculated by incrementing the ret variable
>> by the size of the bio fragment issued for the dio. However, this size
>> is obtained directly from bio->bi_iter.bi_size AFTER the bio submission
>> which may result in referencing the bi_size value after the bio
>> completed, resulting in an incorrect value use.
>> 2) The ret variable is not incremented by the size of the last bio
>> fragment issued for the bio, leading to an invalid IO size being
>> returned to the user.
>>
>> Fix both problem by using dio->size (which is incremented before the bio
>> submission) to update the value of ret after bio submissions, including
>> for the last bio fragment issued.
>>
>> Fixes: 6a43074e2f46 ("block: properly handle IOCB_NOWAIT for async O_DIRECT IO")
>> Reported-by: Masato Suzuki <masato.suzuki@wdc.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>    fs/block_dev.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index c2a85b587922..75cc7f424b3a 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -439,6 +439,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>    					ret = -EAGAIN;
>>    				goto error;
>>    			}
>> +			ret = dio->size;
>>    
>>    			if (polled)
>>    				WRITE_ONCE(iocb->ki_cookie, qc);
>> @@ -465,7 +466,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>    				ret = -EAGAIN;
>>    			goto error;
>>    		}
>> -		ret += bio->bi_iter.bi_size;
>> +		ret = dio->size;
>>    
>>    		bio = bio_alloc(gfp, nr_pages);
>>    		if (!bio) {
> 
> Hi Damien,
> 
> Had you verified this patch with blktests and KASAN enabled? I think the
> above patch introduced the following KASAN complaint:

I posted this in another thread, can you try?


diff --git a/fs/block_dev.c b/fs/block_dev.c
index a6f7c892cb4a..131e2e0582a6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
 	gfp_t gfp;
-	ssize_t ret;
+	int ret;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -386,8 +386,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	ret = 0;
 	for (;;) {
-		int err;
-
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_write_hint = iocb->ki_hint;
@@ -395,10 +393,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
 
-		err = bio_iov_iter_get_pages(bio, iter);
-		if (unlikely(err)) {
-			if (!ret)
-				ret = err;
+		ret = bio_iov_iter_get_pages(bio, iter);
+		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
 			break;
@@ -421,7 +417,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		if (nowait)
 			bio->bi_opf |= (REQ_NOWAIT | REQ_NOWAIT_INLINE);
 
-		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
@@ -433,13 +428,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				polled = true;
 			}
 
+			dio->size += bio->bi_iter.bi_size;
 			qc = submit_bio(bio);
 			if (qc == BLK_QC_T_EAGAIN) {
-				if (!ret)
-					ret = -EAGAIN;
+				dio->size -= bio->bi_iter.bi_size;
+				ret = -EAGAIN;
 				goto error;
 			}
-			ret = dio->size;
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -460,18 +455,17 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			atomic_inc(&dio->ref);
 		}
 
+		dio->size += bio->bi_iter.bi_size;
 		qc = submit_bio(bio);
 		if (qc == BLK_QC_T_EAGAIN) {
-			if (!ret)
-				ret = -EAGAIN;
+			dio->size -= bio->bi_iter.bi_size;
+			ret = -EAGAIN;
 			goto error;
 		}
-		ret = dio->size;
 
 		bio = bio_alloc(gfp, nr_pages);
 		if (!bio) {
-			if (!ret)
-				ret = -EAGAIN;
+			ret = -EAGAIN;
 			goto error;
 		}
 	}
@@ -496,6 +490,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 out:
 	if (!ret)
 		ret = blk_status_to_errno(dio->bio.bi_status);
+	if (likely(!ret))
+		ret = dio->size;
 
 	bio_put(&dio->bio);
 	return ret;

-- 
Jens Axboe

