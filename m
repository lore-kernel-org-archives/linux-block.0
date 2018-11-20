Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B8C41536
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E186206BA
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WCJ4NVOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E186206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKUEFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:05:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36338 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeKUEFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 23:05:46 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so4808538itj.1
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/sK6Fncbe+irKkeRXtqblRPzKPhkvavXtyL18HcWvXk=;
        b=WCJ4NVOJM+aQ73j04Fo4PbWgMBr2v6bVknSI2WFdwJZ8e9Ozvgtco5/jpX4OvUGpDV
         /u0Bk/bgLq4zhHQ2KVx5oi3ufxoJaXOd3YvJEyamlKo9V3dEmkcTMMml6rAbio3+9Yif
         eE30duXlhctzkW6Un82XBlL2QzJFbKPkq/PsbneYFi9oFABmBBAyYZsHx4vLsnLdbI8Y
         aEg6tI8DTM/TkwYRlpv5mCTa7kwJoP2jQUgsvvFT5r+Ym/KtlOMyLKjKeoo4lwD1YLX3
         QxpFfBwYURyErffhou8rGlUMv2L6bZ8KHxz70onMuN00/nv9pGniJx1x7qrrxdujLqtx
         5Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/sK6Fncbe+irKkeRXtqblRPzKPhkvavXtyL18HcWvXk=;
        b=ZLQ+vMkv0+1xrO0zmgg5uQfDqjrTAI5C9znHo1tAPUgHpErXJ7AXJ70orSu96dfJ/V
         W18Kz2VnwWxQkbypGBTXEcRcUms0irBF6cXKnfeRt8IftKayJXQ/sMt5B1RDOHWR7BgD
         60+GdCDwqD+Ww03ndP33PwNyqQQbKaRrJJTReIB5iHWkfuznVW2LISfgsjtlO2OKMJIL
         S42FSWcDyWXyF4+paqHutTj7q5U7yy5HEV7shhV8d48NmcgherucTvQQM3sizMvIQLPc
         lIhk67lIS+nJqHNZ/IcUghYyqh3oobymVtGT2jTGZGa5Anihp5tnZ82ItSg1ldwGKI68
         t7NA==
X-Gm-Message-State: AGRZ1gKdm4CIGFKaaYB3NZMAQtwd6Tf7amXHX9m1PvFPGUdiGw8rx0Cr
        H54MmmTnD0QBIfsuxEF+CMb07QOKQ2Q=
X-Google-Smtp-Source: AFSGD/Vh3eadKpElW/xiCJiQ8BN/eYMKTkGX+EQYBhVShLEcdl84wMnqtm5ijRyIQITTCiMaGhQTQg==
X-Received: by 2002:a05:660c:850:: with SMTP id f16mr3186105itl.111.1542735328348;
        Tue, 20 Nov 2018 09:35:28 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i77-v6sm20963049itb.22.2018.11.20.09.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:35:27 -0800 (PST)
Subject: Re: [PATCH 4.21 V3] blk-mq: not embed .mq_kobj and ctx->kobj into
 queue instance
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org
References: <20181120014435.3339-1-ming.lei@redhat.com>
 <20181120075150.GF15276@kroah.com> <20181120164509.GA32433@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e6ce1db-3d24-6d01-22a9-4f37719bdccc@kernel.dk>
Date:   Tue, 20 Nov 2018 10:35:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120164509.GA32433@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/18 9:45 AM, Guenter Roeck wrote:
> On Tue, Nov 20, 2018 at 08:51:50AM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Nov 20, 2018 at 09:44:35AM +0800, Ming Lei wrote:
>>> Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
>>> from block layer's view, actually they don't because userspace may
>>> grab one kobject anytime via sysfs.
>>>
>>> This patch fixes the issue by the following approach:
>>>
>>> 1) introduce 'struct blk_mq_ctxs' for holding .mq_kobj and managing
>>> all ctxs
>>>
>>> 2) free all allocated ctxs and the 'blk_mq_ctxs' instance in release
>>> handler of .mq_kobj
>>>
>>> 3) grab one ref of .mq_kobj before initializing each ctx->kobj, so that
>>> .mq_kobj is always released after all ctxs are freed.
>>>
>>> This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
>>> is enabled.
>>>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>> V3:
>>> 	- keep to allocate q->queue_ctx via percpu allocator, so one extra
>>> 	  pointer reference can be saved for getting ctx
>>> V2:
>>> 	- allocate 'blk_mq_ctx' inside blk_mq_init_allocated_queue()
>>> 	- allocate q->mq_kobj directly 
>>
>> Not tested, but seems sane from a kobject point-of-view:
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> with v4.14.y and v4.19.y.
> 
> The patch is marked for v4.21. I would kindly suggest to not wait for v4.21
> but apply it to v4.20. This would let us enable DEBUG_KOBJECT_RELEASE
> with syzbot on upstream and stable kernels.

I'd very much like to put this into 4.21, and not 4.20, as that's much
less risky. This isn't a new regression anyway, so there's no rush to
put it into 4.20 as far as I'm concerned.

-- 
Jens Axboe

