Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A3FC433DF
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5272311A
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VjidcVnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgHFRPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgHFRFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 13:05:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16681C034622
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 06:30:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so8717181pgb.2
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=etlr2pAwqifxloZFaoi/LuDdf2axD/mLzq9HJ5tYhoY=;
        b=VjidcVnuYLVBIh0MoujQmGLzohzZtYhYjmmvWBMtFzBlBIC7rLQHsZlPRuKxecmme1
         MNnY6rzLh0AZBBK2J26c/7HjYB6pSVWe6uCUzVVzMQjHUDbSFCdcYxMoa30K6gZjCLJq
         N2z6oZ0xoQACLYjgUrWHsm1CzyTBenzDEj9ceAcC2AHI7ola856eMdC//2LWHcm87o9q
         +xe8GmSwh91FqSxH0bCzBuB6lKfAsyFD3WnJVOyszn0qkVuqIyqr7A/Z5RZRIGPUFZRU
         6idzUagup96uSjkwJX3s1//oo4YyyplTLaM1PwZbWBRqPIYkwTj9xPktSw2LRxRoRfLj
         bT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=etlr2pAwqifxloZFaoi/LuDdf2axD/mLzq9HJ5tYhoY=;
        b=GWthRc+IKSB4ONMF+3s0D17q1EwI/xepYYNXag5VmTTQmBooLhoqzsjKKeYsSYR/Tb
         r7nRRSvCO+7RtYQ5NITSXOOAjJJkhlJqu+5vmmr/QdBiJkKUbIJbjA2KxeZt51sewamG
         2KJMbvhXzt5YdJRPc+8C6SngjkkwhM+Ll/xJSWSqw21sIxjnHFCLf8NddNuu8RBKl13K
         MC38oITh/G6AL3oYNwqHd6v5nbCkqw7uzpBPEEtb74aaR/wL8+Xj8JY6FtZHAMiUfvby
         yTnVo3vdN7dMq7Y81+DtfKJ4W2L8qQZUg/AOulxzoKI3RamlTmY0+zX1ysD7SADpbzlS
         Chgg==
X-Gm-Message-State: AOAM532RE8+EqvriHRkqoXZPtXH6pxauiUJDWGu/Hd+2Nf+fPuPNdGlb
        xbB1jpgRViHzl7APWWk/ZuhFwsIaPds=
X-Google-Smtp-Source: ABdhPJzWeSTGoVe9NvljgqV7Dprzr+BwtUgNmywsHV9rsRqp8nDtL6i5BRfmtPiI8JD3Z5cpaohNEw==
X-Received: by 2002:aa7:960f:: with SMTP id q15mr8780018pfg.79.1596720619130;
        Thu, 06 Aug 2020 06:30:19 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ml18sm7006244pjb.43.2020.08.06.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 06:30:18 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] Two patches for rnbd
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org
References: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92b8c91d-1bfa-e06e-0346-26398e265a52@kernel.dk>
Date:   Thu, 6 Aug 2020 07:30:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/20 3:13 AM, Guoqing Jiang wrote:
> V2:
> * add Acked-by tag from Danil and Jack.
> 
> Hi Jens,
> 
> Could you take a look at this patchset?
> 
> Thanks,
> Guoqing
> 
> Guoqing Jiang (2):
>   rnbd: remove rnbd_dev_submit_io
>   rnbd: no need to set bi_end_io in rnbd_bio_map_kern
> 
>  drivers/block/rnbd/rnbd-srv-dev.c | 37 +++----------------------------
>  drivers/block/rnbd/rnbd-srv-dev.h | 19 +++++-----------
>  drivers/block/rnbd/rnbd-srv.c     | 32 ++++++++++++++++++--------
>  3 files changed, 31 insertions(+), 57 deletions(-)

Applied, thanks.

-- 
Jens Axboe

