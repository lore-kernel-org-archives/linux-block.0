Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E4C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3052B2082B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MiiuNZKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3052B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLFWVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:21:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51237 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFWVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 17:21:16 -0500
Received: by mail-it1-f193.google.com with SMTP id x19so4022225itl.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lHun5gCktYjpgIwZaPYNjnEPtqGg5jEicxN/ly1ym0g=;
        b=MiiuNZKsYKuxj2YgCLrzyz4ZV0uaJf1m3TyIPLeSUPOYYD4UDGaqsOWTebACBgDStn
         mMVSEF19gvlpdbKKK2+SQ8opMwMoj/DrdsBDHd7pZ6z0XAMS1oRt/J9+3Biz5QXdtEsz
         Lu+hYyD1gMBG+vGwzRtk2RYBaASO6k91U8nSZPf6tAEFXuM04TdorJFHPUTtZvDG0fCo
         Di8x1EfJKpCp/z6jDQhdyix67F10FVgu/2ZEqo5GtAt5LepL6dPrp0/1Sp6Zb7ikghBg
         ubqCJl92Rob11Pc4HHRF1DgvbuV5JoQqFpMQMsdianXa7LliXPky2jEE4KNE4XGg66lB
         rVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lHun5gCktYjpgIwZaPYNjnEPtqGg5jEicxN/ly1ym0g=;
        b=polgGqh6pEcab1PjtsFiuEm9Zrm2920FoPVFxR1KOYqjp2PLmshmIOx6Z8F9ZvsmrE
         twJgXnQIfrqTmrYuQ2XtDN8vTjvfS9mYv2yanqTkqHGFgiVMWknuHllk04izsIeeKsgs
         B6ZLmEHUaUUojQR37TyQtj368nLNAUHSpFsc/IwWvZSWyktxlQg7x6vUyZizrUWpueUu
         B3VFscOqMpVe2UqoOmKoGU9qL28yFIBVhDLPFVHgDoxVemlZSUyLBeB/ZFo0Hyybcde4
         hYvHB0OUVrquljXd4jcMBxsN4i0v8wNT3s+Z2Fx2LjrdCynzXbcaVrzZj8LT7mlxaZbz
         Kwug==
X-Gm-Message-State: AA+aEWbHR6jViHJ+gzsNffeLKtbEHNn/RrjGfvzEUiIhz5YAdSKln6a9
        vaqADjJ76KGc/CR98j8e/l9GfRSGHRA=
X-Google-Smtp-Source: AFSGD/V84T6qgF31n6FOKPBiLecoYiBxa48hKh/+j5AuVhxIcwXBU7ci1/M80zu8KphlUm/y+I+ffw==
X-Received: by 2002:a24:a141:: with SMTP id n1mr148092iti.31.1544134875805;
        Thu, 06 Dec 2018 14:21:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n198sm815720iod.76.2018.12.06.14.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:21:14 -0800 (PST)
Subject: Re: [PATCH] block: fix direct dispatch issue failure for clones
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
Message-ID: <0448060e-4bba-4f53-008e-520b5b7436e9@kernel.dk>
Date:   Thu, 6 Dec 2018 15:21:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 3:20 PM, Jens Axboe wrote:
> After the direct dispatch corruption fix, we permanently disallow direct
> dispatch of non read/write requests. This works fine off the normal IO
> path, as they will be retried like any other failed direct dispatch
> request. But for the blk_insert_cloned_request() that only DM uses to
> bypass the bottom level scheduler, we always first attempt direct
> dispatch. For some types of requests, that's now a permanent failure,
> and no amount of retrying will make that succeed.
> 
> Don't use direct dispatch off the cloned insert path, always just use
> bypass inserts. This still bypasses the bottom level scheduler, which is
> what DM wants.
> 
> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Bart, I'll add your reported-by here of course, and also a stable CC
since the original patch went into stable.

-- 
Jens Axboe

