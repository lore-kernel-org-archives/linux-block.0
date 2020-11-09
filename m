Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E7C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913A520665
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 18:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nSvFzbiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgKISCg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbgKISCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 13:02:35 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDCC0613CF
        for <linux-block@vger.kernel.org>; Mon,  9 Nov 2020 10:02:34 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so8779119qkb.7
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4+wJvodj8QGA3+lx46g9VLVUXUE4sXqbQye56BRZMT4=;
        b=nSvFzbiJKVhU09cCGGVNSYHbbmTJkjuubXVygWLThsMfy/tc+I2j/FbKAFmSC0EIZ7
         f5TGaTgQKeRqbTnJajqJsqJtdlpCbME1Vpys9kTJ47XAGP9mgoMM62qWhSUyhuFX6WI7
         5PTVI6M9t82MpAa2fKaynglPY2MY+yUTIHI3u5F3A9qwme4bnyDvSJLMnRspqf31Z0Mi
         rJRHAJKajfZOdEGp+M16BxoczhboCyhTxBq07DlDtXj4zkG4d43jHMuvQOVk+O2YvUox
         5ZnnZ2JGkPMeej/FEEZZz8qN2SdupTHAR0iagSqlSpwEe/1RtHzYBa8ipLn/BaHTJvci
         4oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4+wJvodj8QGA3+lx46g9VLVUXUE4sXqbQye56BRZMT4=;
        b=XHeXSetZSaRkKP18SzE3fPkh0ND945Ue1DfdidVbDt7Z9I0QeAuo73W/UIGkFrjJIh
         UBcb5ITBDDVT/9BoH6xOjgv3MGjS69VB+Ne+CORLhvZtBTIk1udIGoQGmmsHaIuck5V8
         +9BMQGOqhZ8HHmmxjrWeeVDPXZKE97mzDx0RkQPhhWmdSmNogYv91xa8jzllyNM7bh9L
         ePBJbqzlDkQeD+W0Z4XgWOU3AWGx0DqgS/wxr09fsqeyHE+1k+rbQvEWimHAixchgYNH
         0HaxincVDufY/DSEIYGVylyn4+fW143rHNxr8/B5zlQTEX15eTwy9FMXVf3kSS0gwgkq
         wXDA==
X-Gm-Message-State: AOAM530GKY8ia0n6ezht5MbXUxpsQMbu5xJgVMmebbllED4F703iXOMv
        Ye8jtkFWTMfOXZ1kUhkHoZ736Q==
X-Google-Smtp-Source: ABdhPJzbVHuDdC2HNtZXp5HDnyFsLFdjIfYuZlbtcZBEn3OetSCdeOgcEoq0mosskMTCZPW1/Lj/KA==
X-Received: by 2002:a37:de17:: with SMTP id h23mr14834955qkj.267.1604944953998;
        Mon, 09 Nov 2020 10:02:33 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm6270879qtl.69.2020.11.09.10.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:02:33 -0800 (PST)
Subject: Re: [PATCH] nbd: fix a block_device refcount leak in nbd_release
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20201109173059.2500429-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <00a2ebc2-95f2-eeb0-cbf8-cb4a5a198996@toxicpanda.com>
Date:   Mon, 9 Nov 2020 13:02:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109173059.2500429-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/20 12:30 PM, Christoph Hellwig wrote:
> bdget_disk needs to be paired with bdput to not leak a reference
> on the block device inode.
> 
> Fixes: 08ba91ee6e2c ("nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
