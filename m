Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D326FC4332B
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C4B64EF6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 14:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhCJOqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCJOqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 09:46:09 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7530C061760
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 06:46:09 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id b5so15745846ilq.10
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ejwljHWOZOpY8X8W8PQ/BRVgYFMW2dQgBvsiU42iNog=;
        b=mhUI0b1wL2k2YyTeoUGP86uQW82uH9IJjaOpsgPPSnz956HnGyd/Tx5u9/MBGEzpxz
         QM7B/UCYKICoQSFCigxEZToeIpZ6XqWuJweJtxU5AQxkibDNwhicsVbX2yCNHiBRF6JX
         9VhWtgYDZEsKenBe6glmrx5VlPveLrXMPVbdirY7ipHdvCop8vF7TfYO4VEyyTaA7atJ
         Bu4IzgehtLt/6ZW5ozGw5gc0OETlJXAP7f74/U7WBnaPcUo0zsuJ1jkFm+tMRToibyPL
         q87v9Xtj1uR1jnSPS/FyxrRUSnLlqLs02aPAliMDbEJwB9hCoTnPnUUEtu8xxJ2KuQ7+
         hcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejwljHWOZOpY8X8W8PQ/BRVgYFMW2dQgBvsiU42iNog=;
        b=jYdHQXOD62BOYAm7b5XqPcYhQ/9o2yNPRCVXU0FCFZagFeXeMnMotCCOyNFDHk4m2L
         3HIYoeLqQkR3sr0QfQvzpnNT2wKRxNdJWNftq5RUnb4BwTB0LRcI9OpBmJ/qZg5BywJk
         19N6EJ0DIxngUFWlrOqMOeGGv6fwj4QIOkF4IKai4fBy37y7keRMHn8UOusKnWVT2Fu9
         Bhp+TmMGrxQIn/yFTKHqu+WZ91NYRw5+uTD5Nb7dMQnl0Pfgek5rZcOaD3jvcoTn2eeE
         NbDxqdCcmnQULj2AdbCkJvMHa++uLbeHqDwNrKQ7TfJlFVyjs2zKVBAaN7TnV0ZEtdIm
         futA==
X-Gm-Message-State: AOAM530lamhJo17IBQH0nC1vwUOkulO9hppLM015qfpB5i/WPqmKwbWC
        cfm7yz/Oe8hS4Ya6535709dyawWN8fOcGA==
X-Google-Smtp-Source: ABdhPJxWMTLmlT7nOVDYVPo593fDhkVTSq6s54/z8wgLyaMe1xSneTwiTBXqGQTe5J1cIPuWu4Gwkg==
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr2751130ilu.183.1615387569122;
        Wed, 10 Mar 2021 06:46:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h13sm8925390ioe.40.2021.03.10.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 06:46:08 -0800 (PST)
Subject: Re: [PATCH] block: Fix REQ_OP_ZONE_RESET_ALL handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20210310090919.123511-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa03c00e-3651-e82c-0058-d27c4620981e@kernel.dk>
Date:   Wed, 10 Mar 2021 07:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310090919.123511-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/21 2:09 AM, Damien Le Moal wrote:
> Similarly to a single zone reset operation (REQ_OP_ZONE_RESET), execute
> REQ_OP_ZONE_RESET_ALL operations with REQ_SYNC set.

Applied, thanks.

-- 
Jens Axboe

