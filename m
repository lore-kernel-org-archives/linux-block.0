Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3515C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF59221871
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xHPV3FO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLRQSw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:18:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40997 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeLRQSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 11:18:51 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so13184967ioc.8
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=47ZXmGSfmkxZJVMfFnDdw0DSqj0OFBQ+x4NhYPxThzM=;
        b=xHPV3FO3+R9qHrpytYeg62eRuumHXA1/OI+cC207dV8aVjMuSmd4sOv07eNA1USTEQ
         woe7zv842N3oVViq3tQC6a1s3v5W+wyxDcFWqJCAYAJdCS2hHemiD7xXciZEQtZd4WuF
         Yh8U0AEMXaQvhm9ItFpnUiMeCkbf04mN8ei1DrplC6W78dMYyO+Bhkua0DHDi17g8E0Q
         HqAQ6QCYKWoEbCwZ9xfzvncXMbIUhyd1FGbzWI9/EJ67g0+yozOjovMxzc3XweXsMMPp
         tse4SHv2qkAV+ppJmcvHjAT3ck8CDLp5tARMWRupQFc5msJyGG/Nw1VYv7dGYr8lI8lc
         VGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=47ZXmGSfmkxZJVMfFnDdw0DSqj0OFBQ+x4NhYPxThzM=;
        b=dKVTyjpy4rjhBvGLayT4vIN84mEEsyuUL6h3s7S3cTpPvVKXOguBBwgq/japOo4faX
         t2STomQ4GcKFDhBCgzQ580rnGlEen1r90kqO2g1oLIxHgO3i7Ojon9DSzprsJ0PZ5i5s
         qDuqeonUW2iPK/zqeBQEyjDhlB/jAgc+YVyfwM42dNXpk0wMSb/LlYLoyD//y6PC7i9u
         k+BeIjM2bDAEHu4GPv4TYh91odV41lF5LZThYPdntE+SVMNhNI5lWWepV8aNBQHyLfyo
         Lt5/abhgZuiN2MIvI/MAVyIfV7Std3gN4tHGE5N/pvnXJ+EJMzAjiXT28RXGnFX0uKoL
         DTFw==
X-Gm-Message-State: AA+aEWbegXrXKwEr+1pKxxMSMmwM3zfPk5Tkrdn/miKevHab3Rb2CCvg
        8+EUpZKjwdH3ptcY11IdCCD25g==
X-Google-Smtp-Source: AFSGD/WE1CTSqsDCXrzFzfGoH9rzvMua7aNbCKKfPbEeTkKr8XlDk6XNbQfFoyCz/1Du3d6uRn1KJw==
X-Received: by 2002:a6b:5012:: with SMTP id e18mr10619150iob.73.1545149930422;
        Tue, 18 Dec 2018 08:18:50 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b24sm6514417ioj.57.2018.12.18.08.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 08:18:49 -0800 (PST)
Subject: Re: [PATCH V2] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
To:     Bart Van Assche <bvanassche@acm.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
Date:   Tue, 18 Dec 2018 09:18:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545149754.185366.449.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 9:15 AM, Bart Van Assche wrote:
> On Tue, 2018-12-18 at 12:38 +0530, Kashyap Desai wrote:
>> V1 -> V2
>> Added fix in __blk_mq_finish_request around blk_mq_put_tag() for
>> non-internal tags
>>
>> Problem statement :
>> Whenever try to get outstanding request via scsi_host_find_tag,
>> block layer will return stale entries instead of actual outstanding
>> request. Kernel panic if stale entry is inaccessible or memory is reused.
>> Fix :
>> Undo request mapping in blk_mq_put_driver_tag  nce request is return.
>>
>> More detail :
>> Whenever each SDEV entry is created, block layer allocate separate tags
>> and static requestis.Those requests are not valid after SDEV is deleted
>> from the system. On the fly, block layer maps static rqs to rqs as below
>> from blk_mq_get_driver_tag()
>>
>> data.hctx->tags->rqs[rq->tag] = rq;
>>
>> Above mapping is active in-used requests and it is the same mapping which
>> is referred in function scsi_host_find_tag().
>> After running some IOs, “data.hctx->tags->rqs[rq->tag]” will have some
>> entries which will never be reset in block layer.
>>
>> There would be a kernel panic, If request pointing to
>> “data.hctx->tags->rqs[rq->tag]” is part of “sdev” which is removed
>> and as part of that all the memory allocation of request associated with
>> that sdev might be reused or inaccessible to the driver.
>> Kernel panic snippet -
>>
>> BUG: unable to handle kernel paging request at ffffff8000000010
>> IP: [<ffffffffc048306c>] mpt3sas_scsih_scsi_lookup_get+0x6c/0xc0 [mpt3sas]
>> PGD aa4414067 PUD 0
>> Oops: 0000 [#1] SMP
>> Call Trace:
>>  [<ffffffffc046f72f>] mpt3sas_get_st_from_smid+0x1f/0x60 [mpt3sas]
>>  [<ffffffffc047e125>] scsih_shutdown+0x55/0x100 [mpt3sas]
> 
> Other block drivers (e.g. ib_srp, skd) do not need this to work reliably.
> It has been explained to you that the bug that you reported can be fixed
> by modifying the mpt3sas driver. So why to fix this by modifying the block
> layer? Additionally, what prevents that a race condition occurs between
> the block layer clearing hctx->tags->rqs[rq->tag] and scsi_host_find_tag()
> reading that same array element? I'm afraid that this is an attempt to
> paper over a real problem instead of fixing the root cause.

I have to agree with Bart here, I just don't see how the mpt3sas use case
is special. The change will paper over the issue in any case.

-- 
Jens Axboe

