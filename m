Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D0C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2F22241
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k0w5KgsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgDPP1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391156AbgDPP1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 11:27:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4D4C061A0C
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 08:27:15 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so5879566ilp.1
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J+iM4IV/bLEyrF9kw46DZpxuO4x2QaA2JmBIMEiwT5M=;
        b=k0w5KgsQW7J5bI3TlEYBfxGM81pCvY0fB9a4hzWcaD3hTWXEUa4NOh3fyBwV14FPZa
         I99cQhbp/5Vc5WzgFRSmdQo4Gn68RVa3Z+BndxfAYykQz3Yagrp2TMLzBkmyZvHbCWgH
         UdsDfP/84bkpwxejAVeeFvmYzZzPo0pBzbRZRIAlK8KC6+b6yRwQb65juf2rwZHesF+K
         roCv09PQHLX/CJKnJriR69mdDqeWURCvcfZUOAId0VmMrAi+opR//HRS5RZV1q8SWdxt
         MUEie0Mz2ukiUybilfMOY6+j+lbBfOIyA4uSu0p8U1qEwPSa2AkIQg8yiESOuzFJe260
         REDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+iM4IV/bLEyrF9kw46DZpxuO4x2QaA2JmBIMEiwT5M=;
        b=qx9MGh4Pa7mPchh/pXoDU53TJpWCLtMP1N3sSAh9j1/JWKhaZAwHTkpKSiA35Nq/UP
         X1DqdBOLakunQkdsPS1wKIoi7OQJLE3eU+4HaZLUlHqS4jtgVhXTWebikuNRjth3uri6
         31DljoHwG82UiDt/PfGOHa1tY8JrFYnd3i+Zbmo0H8PoleJ0tPnkbGCUcFXq4T85VAEZ
         2oMPcw43XHdd3kU+Tof4CuBftgoTqnR5zpJSYfNeLr3bsApGGMWwC9ECYPRM4aKKKSMo
         3DgCrmXrrFrVo11kAmkqWyZvxbRDanJgc37K+rUrYjn2ma7MeBX9DMTJJyZVAyIX209O
         cnBw==
X-Gm-Message-State: AGi0PuYwphwFSEpVOMep/KG8pilzhwLtaBBMjjsyGinG6fqNI111kud4
        LphSSoJ4n2CG+LVH2tBTXKaFew==
X-Google-Smtp-Source: APiQypKGzPUmvE3dAyPFh4OXyM106ao8Cz1IgSwgan5zQMMBUxtvn113Cs4tk1fq/vwlKFqen4OYmQ==
X-Received: by 2002:a92:606:: with SMTP id x6mr10385653ilg.92.1587050834482;
        Thu, 16 Apr 2020 08:27:14 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 10sm7234116ilb.45.2020.04.16.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:27:13 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when
 no budget
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
References: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b247811-7ce5-7a2c-66f4-1a45235f622c@kernel.dk>
Date:   Thu, 16 Apr 2020 09:27:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/20 5:18 AM, John Garry wrote:
> If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
> dispatch loop, but the request may keep the driver tag, evaulated
> in 'nxt' in the previous loop iteration.
> 
> Fix by putting the driver tag for that request.

Applied, thanks.

-- 
Jens Axboe

