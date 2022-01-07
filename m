Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F2C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 07:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiAGHft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiAGHfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 02:35:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8314CC061245
        for <linux-block@vger.kernel.org>; Thu,  6 Jan 2022 23:35:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so5724569pjp.0
        for <linux-block@vger.kernel.org>; Thu, 06 Jan 2022 23:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=OrVJJzEMfeYJe1B6yksirCyj/h68cq46UpN21Eljn4I=;
        b=PKo3FcXii3nvE7TpAoKr+lkOb55F54Xg9j0YLDq0hKY19YoCXV7Ja1noqvBTgHkrCt
         bUVAXtQFHainIDgt66R1Qizr8ZNYmc5Wp0Ze8iWDjT57QR6WLSfVH3la3y7kFhgqAQzk
         ENzn+b6yszJZaro6wrRgfeFMVbiRdq4r+BGTaXINqcbk/05xWPsq/ta5H77AcEJ+qhLj
         zd7vUFy072P7YDIJFJ5mA5eHt4BRGokeY8i8sGuaLR/KU2+Lz8QOD/B6cXcoHlszht08
         dE4mip5Nqb56yLbYsn/yhCnRm9Jzz2n2lUo5cTo9Llf0KomQGqjM2jqHcyOHUf/qecee
         Liqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=OrVJJzEMfeYJe1B6yksirCyj/h68cq46UpN21Eljn4I=;
        b=aXRYyl8Za6d/nkeZQ80K1WTc/RczaRek0fTnZ2X5XnRzh2cKWOJMvoKKLtAxG038VK
         joj3xwDwXsQixRFo1XEfI+KCdgftJ1q2YbvwCcFJ5CHWExk8BmQEyHV3uwNw5W/1vaBc
         A2Ivj6J8NqjGRdhspKcwDYTzXxLxms+dVNfgb1vg39vidboGpRa3Po3ABceta0KvIBbT
         JgtIimdFGNoPjRYkfutz7cVPrQA35qmQvrVsqOX2xilLaekzn09vyqOmFraWVmDnFolN
         wtIqiFSj2TgJBPalht/C8AmkGsHuA3SUA9SNua6kh1sqILXG8zyvFatb2er0HNwu0zhP
         Tyow==
X-Gm-Message-State: AOAM533q1uRN0FIIo3IZEMAQg8kd80iOwEjz7U21jq4AN7smgjq8BGwQ
        mvJzGqR2tlkY95+j7mqHWR4=
X-Google-Smtp-Source: ABdhPJxICYyKek0hktt50sgqCJcDXrYdS/eKJIEcx575n06c4VCsQaYvs37/2195tJpN9Eb4AYrvxw==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr14275155pjb.160.1641540948086;
        Thu, 06 Jan 2022 23:35:48 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.112])
        by smtp.gmail.com with ESMTPSA id y13sm3496486pgi.53.2022.01.06.23.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 23:35:47 -0800 (PST)
Message-ID: <c91dddbe-101b-1416-6292-cc66104e5df1@gmail.com>
Date:   Fri, 7 Jan 2022 15:35:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] block: throttle: charge io re-submission for iops limit
Content-Language: en-US
From:   brookxu <brookxu.cn@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        lining2020x@163.com, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
References: <20211230034513.131619-1-ming.lei@redhat.com>
 <6eac325f-3d37-92b9-ca4a-f419a17345a1@gmail.com> <Yde5EK12LoBq1wHw@T590>
 <4fc7ac4a-5945-a3c4-c3fd-2ad10673e906@gmail.com>
In-Reply-To: <4fc7ac4a-5945-a3c4-c3fd-2ad10673e906@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



brookxu wrote on 2022/1/7 14:50:
> 
> 
> Ming Lei wrote on 2022/1/7 11:52:
>> On Thu, Jan 06, 2022 at 03:46:54PM +0800, brookxu wrote:
>>> Hi Ming:
>>>
>>> I think it may be due to other reasons, I test this patch seems work fine,
>>> Can you verify it in your environment?
>>
>> Your patch can't cover the issue Ning Li reported.
>>
>>>
>>>
>>> From 2c7305042e71d0f53ca50a8a3f2eebe6a2dcdb86 Mon Sep 17 00:00:00 2001
>>> From: Chunguang Xu <brookxu@tencent.com>
>>> Date: Thu, 6 Jan 2022 15:18:50 +0800
>>> Subject: [PATCH] blk-throtl: avoid double charge of bio IOPS due to split
>>>
>>> After commit 900e08075202("block: move queue enter logic into
>>> blk_mq_submit_bio()"), submit_bio_checks() is moved from the
>>> entrance of the IO stack to the specific submit_bio() entrance.
>>> Therefore, the IO may be splited before entering blk-throtl, so
>>> we need to check whether the BIO is throttled, and only need
>>> to update the io_split_cnt for the throttled bio to avoid
>>> double charge.
>>
>> Actually since commit 900e08075202, your commit 4f1e9630afe6
>> ("blk-throtl: optimize IOPS throttle for large IO scenarios") doesn't
>> need any more, because split bio is always sent to submit_bio_checks().

> This patch should still be necessary for those devices whose IO needs to go
> through __submit_bio_fops(). If the IO is split after submit_bio_checks(), 
> the cloned IO will be marked with BIO_THROTTLED and will not be charged again
> when resubmitted.


Excuse me. Think deeply, we should sitll need to add the following judgment? 
This maybe more reliable, because we only need to add the IOPS count for
THROTTLED IO that was missed due to split. It can also avoid double charge
problems in the future. Any comments is required.

@@ -2049,6 +2049,9 @@ void blk_throtl_charge_bio_split(struct bio *bio)
 	struct throtl_service_queue *parent_sq;
 	bool rw = bio_data_dir(bio);
 
+	if (!bio_flagged(bio, BIO_THROTTLED))
+		return;
+
 	do {
 		if (!parent->has_rules[rw])
 			break;

>> But I don't think that way is reasonable, especially precise driver tag
>> and request is consumed by each throttling, so the following patch is posted:
> 
> Right.
> 
>>
>> https://lore.kernel.org/linux-block/20220104134223.590803-1-ming.lei@redhat.com/T/#u
>>
>>
>> Thanks,
>> Ming
>>
