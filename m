Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0FAC433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7D92089E
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 15:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mTAFSuZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436646AbfHIPwl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:52:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34619 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436626AbfHIPwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 11:52:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so46274924pfo.1
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2019 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GS97JCAT7H99adgGHVNCstZcWlgcctLP7T3y2zoZm1w=;
        b=mTAFSuZ+zOJsslRtm11Tv98UPfGxe4bzXBxlAlwtFcLaO+VoQ0KvIb2IBLT1FlVQCJ
         TwqI6VY8uptgZj0ZgFCpUIMWQTwImsXq4qIw5AlDku9sWuuPkWjEYAUMvoqhWg5V564U
         6kOpRV+VH3kfE86pW8lDRtu9jWcrzAabuX1z2DkKoUuZGY4pn3sMLPzvuHSRDAdrFTQU
         m9+6wYFApyp/KPogmrTpU5+OSAVYFrXffCy5FabOR/G7TogVD5jsRU+oTZ4ka7Hx0E6Y
         wZOP0yoUYn5xKQp9/COKpZ9Z3Weelcj/quRzLUOktfAcczMSX9EVBvKipp9lvGvjDtIV
         S0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GS97JCAT7H99adgGHVNCstZcWlgcctLP7T3y2zoZm1w=;
        b=PXX36qnaa47nHzX220PTan73ew2E9yfkzTcSYQphrZPMx47tZWXVTdOhKJ4OUNwYwM
         0QItu+d+b+yvviQzBnGYcSfhFfUUEwTKUY23Kv5MYX1WG9fN77AgmJC3VOR9D6qyCUTo
         3an6gg1yz5/KWQR+Agcfqb9eDUf1YHm3EP8ARjVeB9bqxE2FCs9KZ01wTr8wIbWhiLFv
         /XXeuGd+J2MHV8FvyjrYzslquKZ9DtWVGklzpA9tqwN6DlYG1DldoqlCZWw28pqgtgoE
         9p8JUNM9QtUcS/Jr92jZKOyYvuMlFAVkI7T5/1N0M8rJrPk+kZn8Stx/sMuYbkG0g99G
         Upmw==
X-Gm-Message-State: APjAAAWjy9KAPGl+V7SZNq261KD3DTMXv91IxuA3Cb9Rzso6BL1x8YEX
        ZNNK6KjDgxx7rb82u1p4k9TP2Q==
X-Google-Smtp-Source: APXvYqz0ciLi75+pv4FjRXIjHsEgYsAOnJ2Zg2Rgz8+jyiBtXV7NAQJZR9XnmRiy7zcYe4StfkmCNA==
X-Received: by 2002:a65:65c5:: with SMTP id y5mr17902684pgv.342.1565365959834;
        Fri, 09 Aug 2019 08:52:39 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:8460:a1eb:bc6a:7081? ([2605:e000:100e:83a1:8460:a1eb:bc6a:7081])
        by smtp.gmail.com with ESMTPSA id g18sm146559015pgm.9.2019.08.09.08.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:52:38 -0700 (PDT)
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
 <8d6bb95a-3bf5-4bee-90ca-1b0110e39ff1@acm.org>
 <5b739a9f-9dc3-ea1f-82e4-d42c756bf9b7@kernel.dk>
 <BYAPR04MB5816CA21355412EA7DAEA4A3E7D60@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <269da72d-9e09-fd2d-601a-19acc5575944@kernel.dk>
Date:   Fri, 9 Aug 2019 08:52:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816CA21355412EA7DAEA4A3E7D60@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/19 6:01 AM, Damien Le Moal wrote:
> On 2019/08/07 4:53, Jens Axboe wrote:
>>> Hi Damien,
>>>
>>> Had you verified this patch with blktests and KASAN enabled? I think the
>>> above patch introduced the following KASAN complaint:
>>
>> I posted this in another thread, can you try?
>>
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index a6f7c892cb4a..131e2e0582a6 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   	loff_t pos = iocb->ki_pos;
>>   	blk_qc_t qc = BLK_QC_T_NONE;
>>   	gfp_t gfp;
>> -	ssize_t ret;
>> +	int ret;
>>   
>>   	if ((pos | iov_iter_alignment(iter)) &
>>   	    (bdev_logical_block_size(bdev) - 1))
>> @@ -386,8 +386,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   
>>   	ret = 0;
>>   	for (;;) {
>> -		int err;
>> -
>>   		bio_set_dev(bio, bdev);
>>   		bio->bi_iter.bi_sector = pos >> 9;
>>   		bio->bi_write_hint = iocb->ki_hint;
>> @@ -395,10 +393,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   		bio->bi_end_io = blkdev_bio_end_io;
>>   		bio->bi_ioprio = iocb->ki_ioprio;
>>   
>> -		err = bio_iov_iter_get_pages(bio, iter);
>> -		if (unlikely(err)) {
>> -			if (!ret)
>> -				ret = err;
>> +		ret = bio_iov_iter_get_pages(bio, iter);
>> +		if (unlikely(ret)) {
>>   			bio->bi_status = BLK_STS_IOERR;
>>   			bio_endio(bio);
>>   			break;
>> @@ -421,7 +417,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   		if (nowait)
>>   			bio->bi_opf |= (REQ_NOWAIT | REQ_NOWAIT_INLINE);
>>   
>> -		dio->size += bio->bi_iter.bi_size;
>>   		pos += bio->bi_iter.bi_size;
>>   
>>   		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>> @@ -433,13 +428,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   				polled = true;
>>   			}
>>   
>> +			dio->size += bio->bi_iter.bi_size;
>>   			qc = submit_bio(bio);
>>   			if (qc == BLK_QC_T_EAGAIN) {
>> -				if (!ret)
>> -					ret = -EAGAIN;
>> +				dio->size -= bio->bi_iter.bi_size;
>> +				ret = -EAGAIN;
>>   				goto error;
>>   			}
>> -			ret = dio->size;
>>   
>>   			if (polled)
>>   				WRITE_ONCE(iocb->ki_cookie, qc);
>> @@ -460,18 +455,17 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   			atomic_inc(&dio->ref);
>>   		}
>>   
>> +		dio->size += bio->bi_iter.bi_size;
>>   		qc = submit_bio(bio);
>>   		if (qc == BLK_QC_T_EAGAIN) {
>> -			if (!ret)
>> -				ret = -EAGAIN;
>> +			dio->size -= bio->bi_iter.bi_size;
>> +			ret = -EAGAIN;
>>   			goto error;
>>   		}
>> -		ret = dio->size;
>>   
>>   		bio = bio_alloc(gfp, nr_pages);
>>   		if (!bio) {
>> -			if (!ret)
>> -				ret = -EAGAIN;
>> +			ret = -EAGAIN;
>>   			goto error;
>>   		}
>>   	}
>> @@ -496,6 +490,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>   out:
>>   	if (!ret)
>>   		ret = blk_status_to_errno(dio->bio.bi_status);
>> +	if (likely(!ret))
>> +		ret = dio->size;
>>   
>>   	bio_put(&dio->bio);
>>   	return ret;
>>
> 
> Jens,
> 
> I tested a slightly modified version of your patch. I think it is 100%
> equivalent, but a little cleaner in my opinion.

[snip]

I already queued up the other one days ago, don't think there's much
difference between them. In any case, I've read your full email and I'll
take a look at the NOWAIT + sync case. I'm currently out though, so it
won't be until Monday. Because of that, I'll ship what I have today as
it fixes the most common case, then go over the sync+nowait on Monday to
see what's up there.

-- 
Jens Axboe

