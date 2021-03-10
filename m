Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AEFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3B564FCD
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhCJUWN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 15:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhCJUVx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 15:21:53 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F09C061574
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 12:21:53 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id d5so16818131iln.6
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=16SMPeE21CushitzJ7QMJXGi9ZvpBG0rD0GsXsI6hkU=;
        b=spJ0UNdk80g6IuuuMgwcY1AR/MlQcbuEaGPdCTXj/1jApxV2p8lLCbpw2FXeZARvWw
         y/3ktMyTJ21jResBV0RdchCy0MqpQWNv6dER4WFlnhzYk11bwv9aqcm+KgHMLqKIFAg9
         wF9GAaMI7rlW6A9bWBqHeVNEog/S6909mlwkSYh4TiTs7CPTx7DyMRuCfR5rgcfLGNPw
         7niYk993aUFxdD50MZMH/zMHbKSz3aFLl/hTPoGJ9DZoAjDfDnhpA9Yejl0H8WuBPrrr
         mEbiTH3WB8Tk5vq0oyUEyB0M7QqkyfIHA/kpU0TP4QB2m7ME4eNl4B6QEjUSfovzkZcb
         hE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=16SMPeE21CushitzJ7QMJXGi9ZvpBG0rD0GsXsI6hkU=;
        b=DlRwd1h2s9HfE9QGRGbVaPNXMJ0zEDty0QvWpk34isZ5/Dkw9qC07E3BpYSQ2rxgGy
         SsNp0u2hWxDgVtOY5G5emJx0570KiCv6D1xTUsmy/TJkRPFsjYOIKO9SpZxvbOEI+JKb
         QVcp5ereeGOOnoxmwrgCF/FfQCxRDLwCMmbvhZQV2ey4QJ1EuDSYbwiQQNTcZHjyFsDg
         BlfFyl2c+m49sWWaoKDLswvIOy/M0w9Duwi7dIs9MIsbLFwg+g81jDZDmEogYYa6xR+X
         LI5jKVJL/UAc4fCEpO6mfPiby05Y+3j3vuDehDGdCkoTVUbSKd3oMlKnIJgaVUdm9SrG
         3gcg==
X-Gm-Message-State: AOAM533WXgcU9sm3hHgfRntOdVLw2HUTDsmC0yz15PrEYqpYc+MojwvF
        aG+W/dzXZ/uiiRFlH7YTPpuwO8agZjY00Q==
X-Google-Smtp-Source: ABdhPJzg7g/La5YMg5wKnM0/F2ii9+d2ML0g09VHJPp0z1r9WLx+9Fj1ToRDzy/DzFD7axi1WAT7xQ==
X-Received: by 2002:a92:1312:: with SMTP id 18mr3843559ilt.92.1615407713037;
        Wed, 10 Mar 2021 12:21:53 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h15sm199377ils.73.2021.03.10.12.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 12:21:52 -0800 (PST)
Subject: Re: -Walign-mismatch in block/blk-mq.c
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
Date:   Wed, 10 Mar 2021 13:21:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/21 11:23 AM, Nathan Chancellor wrote:
> Hi Jens,
> 
> There is a new clang warning added in the development branch,
> -Walign-mismatch, which shows an instance in block/blk-mq.c:
> 
> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
> result in an unaligned pointer access [-Walign-mismatch]
>                 smp_call_function_single_async(cpu, &rq->csd);
>                                                     ^
> 1 warning generated.
> 
> There appears to be some history here as I can see that this member was
> purposefully unaligned in commit 4ccafe032005 ("block: unalign
> call_single_data in struct request"). However, I later see a change in
> commit 7c3fb70f0341 ("block: rearrange a few request fields for better
> cache layout") that seems somewhat related. Is it possible to get back
> the alignment by rearranging the structure again? This seems to be the
> only solution for the warning aside from just outright disabling it,
> which would be a shame since it seems like it could be useful for
> architectures that cannot handle unaligned accesses well, unless I am
> missing something obvious :)

It should not be hard to ensure that alignment without re-introducing
the bloat. Is there some background on why 32-byte alignment is
required?

-- 
Jens Axboe

