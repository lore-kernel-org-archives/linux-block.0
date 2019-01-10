Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C2C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656F214C6
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BWeUz19l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfAJQF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:05:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33876 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfAJQF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 11:05:26 -0500
Received: by mail-io1-f65.google.com with SMTP id b16so9366820ior.1
        for <linux-block@vger.kernel.org>; Thu, 10 Jan 2019 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGZRRg/XQME9zVWTx4BFpLvvTae7/ugtnBZ/uVbwmvk=;
        b=BWeUz19lVXyDeQgGycJ+FPqMU/w0owO5CAygVx3ULnd1/E1G9ZG5+Fml9mw1ptGcn0
         tw2BroruMK8YHcx4jeWcTUxTI0IQ9QYVUqjK7JNhdFjIZ7buR7/5CT97SqGrUtWLMzyI
         Th3jUhQzEqfJkA1lSJnph+3aPBG4qOvily5DK4HzYbLLxifZxT/9zUUCY3Gtv3b5rbiZ
         BGXW8lgMh0etPmDvu5LFkbQcq7RXIwgxpN4Cgno8dXts+F9xlnI+iSGlSZzw3M0XMLlc
         E6G4pILw4rYbl7K99iTGx3bofMU8FGyd7NfRGopj+hu/kZc2P2D9QGe/UPMKdc9GZHJJ
         zQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGZRRg/XQME9zVWTx4BFpLvvTae7/ugtnBZ/uVbwmvk=;
        b=gP38oFyWqvt42SH/xxqORPU4IGEEvKS6LPMPNLjcdoDIuhUyUysaRBnzBc2JYYvheh
         Nm31pr4GYUGRSgfFKdtEHMXxln3rJtuV8JdevLB7u+ATZwHAbaaCMUh2cDwKDARzf0Xc
         GtKA0jpL4G/CpBwq2rfsBBTq4zjBFMn911/r6jeFbNVKJAMAHIKjdbUoQyzu5KzW/39w
         J/QRZihtfPzoF66YWrGAwVzKdFLXxLtDPDlJxRHBOWaKYUo4otrq/CfXZWE7POju0554
         kuFTn5HdHFIAIl1zSukJ7YdbOn31Ar7T86DCu8E+IxnMLML5qwx7ca7PpTbVJqW3hrVJ
         kqfA==
X-Gm-Message-State: AJcUukdv68Jy6wZgumL3JGkTR90S2SesQrHXHEWO7Lq9/kGLvaE/J69L
        gxs0Bs+VMBv2cAczjpxbwVAAmA==
X-Google-Smtp-Source: ALg8bN6zzv2BAk/c4vlc6hZQVOYeBFlysRpC15KFuV5XM2aDhBlWsfIse+ynGsiigyui7dcSHnCoWg==
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr6842369iof.172.1547136325586;
        Thu, 10 Jan 2019 08:05:25 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f10sm9745279itf.41.2019.01.10.08.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 08:05:24 -0800 (PST)
Subject: Re: [PATCH 03/16] block: add bio_set_polled() helper
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-4-axboe@kernel.dk> <20190110094355.GA13512@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1a6ae88-1436-e947-1124-41e10b3ea9bc@kernel.dk>
Date:   Thu, 10 Jan 2019 09:05:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110094355.GA13512@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/19 2:43 AM, Ming Lei wrote:
> On Tue, Jan 08, 2019 at 09:56:32AM -0700, Jens Axboe wrote:
>> For the upcoming async polled IO, we can't sleep allocating requests.
>> If we do, then we introduce a deadlock where the submitter already
>> has async polled IO in-flight, but can't wait for them to complete
>> since polled requests must be active found and reaped.
>>
>> Utilize the helper in the blockdev DIRECT_IO code.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c      |  4 ++--
>>  include/linux/bio.h | 14 ++++++++++++++
>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 5415579f3e14..2ebd2a0d7789 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -233,7 +233,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  		task_io_account_write(ret);
>>  	}
>>  	if (iocb->ki_flags & IOCB_HIPRI)
>> -		bio.bi_opf |= REQ_HIPRI;
>> +		bio_set_polled(&bio, iocb);
>>  
>>  	qc = submit_bio(&bio);
>>  	for (;;) {
>> @@ -401,7 +401,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>>  		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>>  		if (!nr_pages) {
>>  			if (iocb->ki_flags & IOCB_HIPRI)
>> -				bio->bi_opf |= REQ_HIPRI;
>> +				bio_set_polled(bio, iocb);
>>  
>>  			qc = submit_bio(bio);
>>  			WRITE_ONCE(iocb->ki_cookie, qc);
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 7380b094dcca..f6f0a2b3cbc8 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
>>  
>>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>>  
>> +/*
>> + * Mark a bio as polled. Note that for async polled IO, the caller must
>> + * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
>> + * We cannot block waiting for requests on polled IO, as those completions
>> + * must be found by the caller. This is different than IRQ driven IO, where
>> + * it's safe to wait for IO to complete.
>> + */
>> +static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>> +{
>> +	bio->bi_opf |= REQ_HIPRI;
>> +	if (!is_sync_kiocb(kiocb))
>> +		bio->bi_opf |= REQ_NOWAIT;
>> +}
>> +
> 
> REQ_NOWAIT doesn't cover allocating split bio, is that a issue?

Yes, that might be an issue. I'll look into what we should do about that,
for now it's not a huge problem.

> BTW, could you explain a bit about the deadlock in case of sleep from
> request allocation?

It's more a live lock I guess, but the issue is that with polled IO, we don't
get an IRQ. For normal IO, if you run out, you can just sleep and wait for
an IRQ to come in, trigger a completion (or multiple), which will then wake
you up. For polled IO, you have to find those completions. Hence if you just
go to sleep, nobody is going to find those completions for you. You'll then
be waiting forever for an event, that will never trigger.

-- 
Jens Axboe

