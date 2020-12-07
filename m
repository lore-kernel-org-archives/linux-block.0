Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B8C4361B
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3713F236F9
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 15:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLGPC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLGPCy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 10:02:54 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7815CC06179C
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 07:02:08 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id q1so12425844ilt.6
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VybQWwbL6UvzcbCL3NCZaMBiwuEmrkek/VawgkB7ZD8=;
        b=fPRjo0rViiLpzlSV/cYvxL+aParhvHQFHBvf5Ms3odbYIyCLW1RU9uljM8UzNMUyn/
         x6qXvusS8124Z2GpGuWhfIO+2klnLhPWelPuwPKWJznvscHoRenj4/q71YtGqVLgbuLM
         0lnVmK8inWjBUft0GC3f/UeHUL6GdtjaBogfs4ZbfmoKupcCvVkytR3VRPhgjs5RaekK
         +he9AhiRM5ztashvnDeacL9gBGNU2OSaj3fHir83R5i70H+uv+b5iM8LP+j0l/ZROsny
         Gc0Tg2b8hu1fT+TxgaDNCpv0SC/SqvuUv9zjdSYb6cYxiKmAcWz7PEqymqp9kndjzkYO
         imrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VybQWwbL6UvzcbCL3NCZaMBiwuEmrkek/VawgkB7ZD8=;
        b=YICftjXd4J9hg5Wl1oNLJ0SCrLCxi9pSBACTko0qpvl/vZM/giuszDJ8ACs3jltthi
         fSrTlvF0BFK8sC+dcp2XGG0vkz0Evv1zOJyRUBxHzTl/DpB1UZIcc3xtzjhJj//AVjBd
         A8/4aOJ+qot3DaRAo7LLA363EDkZXntDdwK0YkeZCkwFrFWW1aiw0Ana0a78RbA2p2dc
         jTWCN2gdsjbmjoIYwcxDAmn/qf8LNDVia8sFybxDwkSKjwyICQrNKfbyz71ufqnrGJW9
         MS9uYABwwIahRiBcwGjKUmtGN2xm0c2fiSDYtxeMESI5/u4pMbupuinzoQGZrlaGVrhc
         MzeA==
X-Gm-Message-State: AOAM532270vhiWVP/rDNx+WKD1Oak7mh0r7kTy/+EwWes8F9VrqSe7d+
        IZSr98rSnKc8p1kLGmUu+w8tlw==
X-Google-Smtp-Source: ABdhPJwXyg25mmVigE/vD8BUXZ8meCAbl38W8aCMhaVRVxosrXA78kTdChRbv2nSuTpfbnQKgdP5Pw==
X-Received: by 2002:a92:2801:: with SMTP id l1mr21564464ilf.124.1607353327887;
        Mon, 07 Dec 2020 07:02:07 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l4sm6247280ilo.29.2020.12.07.07.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:02:07 -0800 (PST)
Subject: Re: [PATCH v2 0/5] Some cleanups and improvements for blk-iocost
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2aad8cc-2fb4-015a-30b2-ff8f2b5e6ad6@kernel.dk>
Date:   Mon, 7 Dec 2020 08:02:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 1:16 AM, Baolin Wang wrote:
> Hi,
> 
> This patch set did some cleanups and improvements for blk-iocost, and
> no big functional changes. Please help to review. Thanks.
> 
> Changes from v1:
>  - Add acked-by tag from Tejun.
>  - Drop 2 unnecessary patches.
>  - Move the related variable declarations inside the block together
>  with the code in patch 3.
>  - Move the commit_weights() into ioc_check_iocgs().
>  - Move more related logics of adjusting base vrate into the
>  ioc_adjust_base_vrate().
>  - Rename the new functions.
> 
> Baolin Wang (5):
>   blk-iocost: Fix some typos in comments
>   blk-iocost: Remove unnecessary advance declaration
>   blk-iocost: Move the usage ratio calculation to the correct place
>   blk-iocost: Factor out the active iocgs' state check into a separate
>     function
>   blk-iocost: Factor out the base vrate change into a separate function
> 
>  block/blk-iocost.c | 251 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 137 insertions(+), 114 deletions(-)

Applied, thanks.

-- 
Jens Axboe

