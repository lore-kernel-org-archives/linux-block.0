Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093F5C433EF
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 06:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiAGGvF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jan 2022 01:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAGGvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jan 2022 01:51:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F50C061245
        for <linux-block@vger.kernel.org>; Thu,  6 Jan 2022 22:51:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l15so4213437pls.7
        for <linux-block@vger.kernel.org>; Thu, 06 Jan 2022 22:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VWc2i6goL46GNhJDuSYoralTAUy7NR8mN3RlSGd/tvo=;
        b=JTJ71XDStQwuiyv+4qYiK4Quh+O1kPWeXvZvEq/WDSTppEnwj+cXYybEVEz7lD7Q0b
         MtxMgCVdT6UdcrrGLvR9zzox1LV+atz2N4sb4xVgWU6MvU8crF7r21Lv8ByZAfN5ywZ3
         THQFv2qCA0B1xRxOF2kDv7IiJZwLA2sIf8PllZbSNs+7uH+42aHcqAOOgIWBzfn+O2Vv
         4EesrTfifsFmf5APgpML6NALnyvReWFzYWwdZTWvzO/b2AVN7aYJF9VZ+M3me+rEVewW
         KAIHBiD4hqimJLJFCvSYa3iaT1LSGZpYky0N06CbVYRMRpRAfDoLZoWRTDT2XehdlKBc
         9wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VWc2i6goL46GNhJDuSYoralTAUy7NR8mN3RlSGd/tvo=;
        b=eKAUHSgEQdFwp9p+x1nxGcECnFPEJw2WfyzDC/ag37dORuqWgyr1hYISEIpI8HmT07
         jxrTzLGiaWYu3LTox5dsOR6Xx7qwh2SDkiTbjH8QRI+vn7+7AwUoxgz1J6IubwzO1ceI
         u9BcYkvpE8s6kxTxQ8Yl9m0Ho066tylKWvOJQl5bIVt4BjoAlFNoSq2oL2g1f6q6LNJO
         LFbtK8drEsMmk3D/yPurStkWM4sYt3iWkt1GG3lXBZthRyM5h33JhDEdx4AKmtXiGOYs
         rIfc3kXHIXU6ibhPu7yVSmLMuQ+uitmhVfYU4CXLboXfF+YI8RdETDQDmbdDzCwZc9RT
         ILgA==
X-Gm-Message-State: AOAM5323JFSoDaMQ+xfWUSgk0Si6847QpTwjedC1TbuXJeQd0z6F2DpR
        R8dH+YIeKEUtfAS0unXcEQU=
X-Google-Smtp-Source: ABdhPJzma5HBDaJEHjEo5ZYhWhfQ0nUN1SdwgSm3H6hv4C9INshloX8Wwco5k+p8pD8OJpsZP12pvQ==
X-Received: by 2002:a17:90b:1651:: with SMTP id il17mr14331302pjb.10.1641538263926;
        Thu, 06 Jan 2022 22:51:03 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.112])
        by smtp.gmail.com with ESMTPSA id p24sm4175443pfn.33.2022.01.06.22.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 22:51:03 -0800 (PST)
Message-ID: <4fc7ac4a-5945-a3c4-c3fd-2ad10673e906@gmail.com>
Date:   Fri, 7 Jan 2022 14:50:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] block: throttle: charge io re-submission for iops limit
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        lining2020x@163.com, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
References: <20211230034513.131619-1-ming.lei@redhat.com>
 <6eac325f-3d37-92b9-ca4a-f419a17345a1@gmail.com> <Yde5EK12LoBq1wHw@T590>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <Yde5EK12LoBq1wHw@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



Ming Lei wrote on 2022/1/7 11:52:
> On Thu, Jan 06, 2022 at 03:46:54PM +0800, brookxu wrote:
>> Hi Ming:
>>
>> I think it may be due to other reasons, I test this patch seems work fine,
>> Can you verify it in your environment?
> 
> Your patch can't cover the issue Ning Li reported.
> 
>>
>>
>> From 2c7305042e71d0f53ca50a8a3f2eebe6a2dcdb86 Mon Sep 17 00:00:00 2001
>> From: Chunguang Xu <brookxu@tencent.com>
>> Date: Thu, 6 Jan 2022 15:18:50 +0800
>> Subject: [PATCH] blk-throtl: avoid double charge of bio IOPS due to split
>>
>> After commit 900e08075202("block: move queue enter logic into
>> blk_mq_submit_bio()"), submit_bio_checks() is moved from the
>> entrance of the IO stack to the specific submit_bio() entrance.
>> Therefore, the IO may be splited before entering blk-throtl, so
>> we need to check whether the BIO is throttled, and only need
>> to update the io_split_cnt for the throttled bio to avoid
>> double charge.
> 
> Actually since commit 900e08075202, your commit 4f1e9630afe6
> ("blk-throtl: optimize IOPS throttle for large IO scenarios") doesn't
> need any more, because split bio is always sent to submit_bio_checks().

This patch should still be necessary for those devices whose IO needs to go
through __submit_bio_fops(). If the IO is split after submit_bio_checks(), 
the cloned IO will be marked with BIO_THROTTLED and will not be charged again
when resubmitted.
> But I don't think that way is reasonable, especially precise driver tag
> and request is consumed by each throttling, so the following patch is posted:

Right.

> 
> https://lore.kernel.org/linux-block/20220104134223.590803-1-ming.lei@redhat.com/T/#u
> 
> 
> Thanks,
> Ming
> 
