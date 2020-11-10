Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14513C388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC2E207BB
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 14:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ywPGPlbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgKJOwE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgKJOwD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 09:52:03 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3CC0613CF
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 06:52:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s2so360284plr.9
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nx5eqeg7MJ0UkBhGNYYgQ24vfp/tLZx9Fz8eX2aHPnY=;
        b=ywPGPlbJdBOQzWn6iQh0Idu6yvaCg5rAQTUlc8yYGeIxRLEpKkTNnJ4aFDE5OgheCH
         KI5GueOkTiH8l5Hv9kiebgvgR7ogK42aO4yT3hRDNStP9GQcZ5NfKJXtWGBlvnw7aUx4
         RtbxwIMDGQx6TG6HaL1VGozVFENftJ14Ra2vWpG9Rjaew4/mGk8NK323CQNXwWSgq96C
         JHJwLPDsY5gpgl0MZey/hj74GqNIf/mVAwMj9k6eWfbLcOmFySUNWuh7WeoLxnC8B0An
         fwM0emsLs4RPM3SqkEokVAyfWifv/zcCvSXYPi/Suelt/TGoMaz4F3qptMnC6DjSNI4a
         wFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nx5eqeg7MJ0UkBhGNYYgQ24vfp/tLZx9Fz8eX2aHPnY=;
        b=Fiaun/tGE/3srjhLpv2DT7GH94gGCH9lASFoSzWHiwHIje7/yzZaNSy+0vF5Fp0bTF
         txFH5eUAPAWBdE2s+6QPM1rzFI6EyG4gJvxzYLWuNCHqj8jrVlBg/CUfWKQKJo/VLczb
         gnGBsO+gkfStiJmBqcsg0afGvCTDjA+WlhjbRn2dWVELH8qSVe5D36P3GvbtI5To7poM
         SfGAVHWP/0th2Ds+BOwvwZoedLvTs9Sbp9+qhrDc31kLLl1yxS9qGFS2PEsmS75fjiFd
         byWADBsU3JXxFNCWTuaRqMCX8d0yd3pgf6zOfqXeQ66MA8embc04aqXS545tWWg/w21m
         P0Rg==
X-Gm-Message-State: AOAM532yhjX7YqKc7/CylazsRBbsYEeWOAZMtISWSO5ijOrkrbQnHV27
        kMmC2RUD59S9FnYSvEhN5ph/EQ==
X-Google-Smtp-Source: ABdhPJz8owAJX/3JnVR3TXfApRDf00SEj/s77BfhN2Re2xq5WfDDk+IDxMy2OQ6OJTA68rCpMVsrHw==
X-Received: by 2002:a17:902:7088:b029:d6:8072:9ce1 with SMTP id z8-20020a1709027088b02900d680729ce1mr17503444plk.11.1605019922138;
        Tue, 10 Nov 2020 06:52:02 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id cm20sm3812618pjb.18.2020.11.10.06.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:52:01 -0800 (PST)
Subject: Re: [GIT PULL] nvme fix for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201110103620.GA3200092@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cf10be5-301e-ab08-a83a-6d55a58ddc6e@kernel.dk>
Date:   Tue, 10 Nov 2020 07:51:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110103620.GA3200092@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/10/20 3:36 AM, Christoph Hellwig wrote:
> The following changes since commit e1777d099728a76a8f8090f89649aac961e7e530:
> 
>   null_blk: Fix scheduling in atomic with zoned mode (2020-11-06 09:36:42 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-10

Pulled, thanks.

-- 
Jens Axboe

