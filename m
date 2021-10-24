Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3224AC433F5
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1888E60FD7
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhJXPMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhJXPMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 11:12:19 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF2C061745
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 08:09:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so11285618otr.7
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m2hawqcUMKqmKebMPSmZdslMx7kgaCtRmPNkD8dALrg=;
        b=S9q6G2I/hN7089yxciUAWfLxcxX/I8VXbgWFlCAqPH+c0HxMO00AnZC3e3DMO4IGy4
         MrJJWAy9iOKT1KylsPe8D0PFtISgCOSCzsaugLd3Kpo0NLdrsjHH/JnWOq7hLmxvFZZN
         7831MZ4g2WbpBUtcv01642y+dZcaVpZaNbwglXwgiv/L/543QHMqIfl53kvx0yKLLyVa
         h6Dr3d3JFF+ktnfrZ6p8kHLVsDD+w+CXrcIxy5Y1XVB/MyKbm4NyP9J+mAiai1EH3jWf
         PsWdu2slN/i6vnThKNKSHJR6EQyaXnM0izTTw/DOyzbx+Yzz6WFQMxrwr3+zqgFEAahE
         ViBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m2hawqcUMKqmKebMPSmZdslMx7kgaCtRmPNkD8dALrg=;
        b=lpYFRq0HzOIqXEhQozLP0dBviWzjH2xZRvhHf6fgtjZrTiJdErE1k70b9kq7aB9sAq
         sITnD1NshXUcPAJXM8JDSpSFlcq28H7Tc8/PFFxLypHUlCecxTKNk89HsjpQH0+urX1r
         XjeeTA127fo4QYka0PE5v7DI6ycW9+KnVo78WdUDlyvGln8daoZzV+PE1K0R4NhCsYJj
         Xa/BJtu6adLUW774naFCVjBrU80yWLIMFJVEuk5SJ2Fz5SQ8RLk5UHAxt+u8w23grKJn
         i8CxibouM7E13GD5HRh7eNNZUUozZ61jGOtqOIB/tBtK3Ayb5N582Eg/IdwMsp+c5/7B
         GTSg==
X-Gm-Message-State: AOAM533zFpldSOHY+fcNR2t6uAw1EsA+YNFpEqTWyOau6NyhX43hjYHa
        pktgIc6UPohkTpeCKmwWvVCz0A==
X-Google-Smtp-Source: ABdhPJw746tGwvAYoRZVMfmrW+j3Iurr9P08fFp1dFAZzzzaIeaIowOBFVtrmNZ7SlzngIF7WmFJTg==
X-Received: by 2002:a9d:725e:: with SMTP id a30mr9504251otk.62.1635088198026;
        Sun, 24 Oct 2021 08:09:58 -0700 (PDT)
Received: from ?IPv6:2600:380:602f:3f82:6d35:8f05:e174:d6a5? ([2600:380:602f:3f82:6d35:8f05:e174:d6a5])
        by smtp.gmail.com with ESMTPSA id a15sm2952588otp.73.2021.10.24.08.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 08:09:57 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
 <9200437d-d5b7-fca2-b8e3-32a01603b281@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fb75a75-c06b-1ede-3989-69cf7e7e69bc@kernel.dk>
Date:   Sun, 24 Oct 2021 09:09:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9200437d-d5b7-fca2-b8e3-32a01603b281@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/21 10:46 AM, Pavel Begunkov wrote:
> On 10/23/21 17:21, Pavel Begunkov wrote:
>> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
>> serves only multio-bio I/O, which we don't poll. Now we can remove
>> anything related to I/O polling from it.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   block/fops.c | 20 +++-----------------
>>   1 file changed, 3 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 8800b0ad5c29..997904963a9d 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -190,7 +190,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>   	struct blk_plug plug;
>>   	struct blkdev_dio *dio;
>>   	struct bio *bio;
>> -	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
>>   	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>>   	loff_t pos = iocb->ki_pos;
>>   	int ret = 0;
>> @@ -216,12 +215,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>   	if (is_read && iter_is_iovec(iter))
>>   		dio->flags |= DIO_SHOULD_DIRTY;
>>   
>> -	/*
>> -	 * Don't plug for HIPRI/polled IO, as those should go straight
>> -	 * to issue
>> -	 */
>> -	if (!(iocb->ki_flags & IOCB_HIPRI))
>> -		blk_start_plug(&plug);
> 
> I'm not sure, do we want to leave it conditional here?

For async polled there's only one user and that user plug already...

-- 
Jens Axboe

