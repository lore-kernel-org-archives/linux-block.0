Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F249C64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 18:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADBD207F7
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 18:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X79HjfLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgK3SLB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgK3SLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 13:11:01 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED5EC0613CF
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 10:10:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 131so10914704pfb.9
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 10:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JfjXD662manSUYpiP1JHUSzxo/pxTsLkc9sAPIYNsuI=;
        b=X79HjfLzljA+0Z27ZuzPIdUYlvtzP24/jRs07S1yBlgCMuvo49QylUAckwZg1pPtIj
         bY2LIMf6iYBYSllo2QqRE/KKFwuSB+JiJh1SnpMk7sWk2ztcpxvwcuf+OUjUW/ZoNEjt
         0TzmvLsz4TD0325LPk9LQNHKfcgbPoewgdSgeVQtSFoWckP6AO1FPT/ZDGpXekg6muAN
         galyM2iZi8IniMmKe0L8FEm3hG/e2y7c4qNLyWboSA6vnBpWRUbV0Rb/jsNML8l4ORrp
         jCI/Mz/nTieD0slwqHCSyWVrYl1GORYnZByamdTE1VHf2jmnCqsTVXHFPjwfAMP2u/tr
         W3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JfjXD662manSUYpiP1JHUSzxo/pxTsLkc9sAPIYNsuI=;
        b=b9Zz8SjRG3UBzDA69lwARiP2dtYW1EH/3Cao9i0HoeWIKgpkJyunlvxxOhRF8fxHod
         okwyXmpq6EF/Pw4mZ/DaUbQSZ/ycHbGqnLij/IaZQcTIDsLincXr59ZwvQTUsdMuXq0n
         q1vaO+2P0/oQ47UGoo61ej91ymoXLAFepFS38QJH1cOp72FiaLv9fKDGKgYO9eyEdscx
         wIbC3KQA2w++JRnXdrnzJGhwEWtGeS7i8pc4pWi5U9h8ukHjEPLLe0D349Y5FH/zuveQ
         /HpZHeVOvVwIsAR6MYQuxqvY6uvoFPt4htIY2KC09PIgAG8tUKuN0XRW/Uytnt1PIyFd
         6utA==
X-Gm-Message-State: AOAM531CERLihZsA6edulwH7pCbcLssy5unipDollf3/C2en2tKi6nzV
        VBpVxvyRRI1TiHK8U/1o5jE7Sg==
X-Google-Smtp-Source: ABdhPJxh3Uowu7JH4UdkTNftlk54k603Bv/jaftSe1FU3Lsss96e05qjowDMM/Ug6HmqnFOsblmqKA==
X-Received: by 2002:a62:2ac2:0:b029:18c:25ff:d68 with SMTP id q185-20020a622ac20000b029018c25ff0d68mr20455201pfq.64.1606759815084;
        Mon, 30 Nov 2020 10:10:15 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 184sm17681065pfc.28.2020.11.30.10.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:10:14 -0800 (PST)
Subject: Re: [PATCH] block: wbt: Remove unnecessary invoking of
 wbt_update_limits in wbt_init
To:     chenlei0x@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
References: <1606702852-14157-1-git-send-email-lennychen@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5cbc949d-5703-90e2-fe0b-809b1b76bb08@kernel.dk>
Date:   Mon, 30 Nov 2020 11:10:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606702852-14157-1-git-send-email-lennychen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/20 7:20 PM, chenlei0x@gmail.com wrote:
> From: Lei Chen <lennychen@tencent.com>
> 
> It's unnecessary to call wbt_update_limits explicitly within wbt_init,
> because it will be called in the following function wbt_queue_depth_changed.

Applied, thanks.

-- 
Jens Axboe

