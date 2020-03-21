Return-Path: <SRS0=o1BL=5G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FFEC4332B
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 20:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF092072C
	for <linux-block@archiver.kernel.org>; Sat, 21 Mar 2020 20:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="onoovAOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCUUaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:30:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43892 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCUUaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Mar 2020 16:30:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id v23so1707ply.10
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2020 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yQE1AGuPuSquTWhE+3+C/nBZtIGBtGuN9+H3HNtBPO4=;
        b=onoovAOqdnHVRsn+D2keLQnUIEXz3fTCxc3cksfVs1zkhu6Vdw8KpjxT6twmbTppwt
         LiZsjy65KFeJalVJfVLzWar6TXUbhOtml6ZyhcTMwc2YhaArKrHhlcULFDAp1aBIPanB
         i6BAT85NkErgBonyqGqRDlbdaBOw9/l8ASyRluZ8jAQoOG+wUwa5fIkbRwgsmwzsyjXB
         60W+PR7D80ZcGQwPrGlgm2tc3oXWoRBqtRHR8l5tVnOfuiX13cOM33maG6HqmbZnHBg2
         EL/j2etChh6dpRxHmVZVnfw2R4aOwpeueag239BNhc45g6EdvlY6juYW2mKEpFrFsSI8
         fd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yQE1AGuPuSquTWhE+3+C/nBZtIGBtGuN9+H3HNtBPO4=;
        b=rJlC0CescBx+8yMMR83ctxM+liiH2zrLT8tqqlcEpCOgHdb007oo2fetrYJusxwxS8
         rwwRpUxtUzUzOxn4YJVZJI7M/iznJh1X+eblPEgQaGlpUdyRpdWW4EZki1dfw3PNNm61
         PQppkOvwZMC2NsYFaMoHgDgItN/mtibMpykyjDD2lD9T3NXz1nspWA+TOnlNs2dal+NQ
         w22+7doOa4vVDjQ4ID58Dkh0+FIa449BxNnZP4BhduTEqAW1ZYYnpJeGfAB9S9Xgcw87
         oxsJ9foF158ePSB5fuGEj+oOpKcVHv7P/jSKbGGjhftsBVkbtKJV7wmmj84F870pLBjv
         LkVQ==
X-Gm-Message-State: ANhLgQ3XL2d5dwgs4EuLQV3eGhndyawtwyVBhKzllrbn9+cxtgwnOdrO
        c0VDZZmBdYe5Ml4Z9pLibQTyGQ==
X-Google-Smtp-Source: ADFU+vtUmqZZZVxes1ZaCw/2dVpYE55mRIa/+emJV6bikExnLRHzXdQZYPtBfcwkAkkR+6uwQRUENw==
X-Received: by 2002:a17:90a:c396:: with SMTP id h22mr16833567pjt.128.1584822599958;
        Sat, 21 Mar 2020 13:29:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y30sm9353091pff.67.2020.03.21.13.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 13:29:59 -0700 (PDT)
Subject: Re: [PATCH V3] block, bfq: fix use-after-free in
 bfq_idle_slice_timer_body
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, paolo.valente@linaro.org
Cc:     linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, yanxiaodan@huawei.com,
        "wubo (T)" <wubo40@huawei.com>, renxudong <renxudong1@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>, linfeilong@huawei.com,
        wangwang2@huawei.com
References: <da33586a-6fc1-0708-e86d-b09e349200f8@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1052be18-ef45-e254-e1bb-09a7cd6d891f@kernel.dk>
Date:   Sat, 21 Mar 2020 14:29:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da33586a-6fc1-0708-e86d-b09e349200f8@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/20 5:18 AM, Zhiqiang Liu wrote:
> 
> In bfq_idle_slice_timer func, bfqq = bfqd->in_service_queue is
> not in bfqd-lock critical section. The bfqq, which is not
> equal to NULL in bfq_idle_slice_timer, may be freed after passing
> to bfq_idle_slice_timer_body. So we will access the freed memory.
> 
> In addition, considering the bfqq may be in race, we should
> firstly check whether bfqq is in service before doing something
> on it in bfq_idle_slice_timer_body func. If the bfqq in race is
> not in service, it means the bfqq has been expired through
> __bfq_bfqq_expire func, and wait_request flags has been cleared in
> __bfq_bfqd_reset_in_service func. So we do not need to re-clear the
> wait_request of bfqq which is not in service.

Applied, thanks.

-- 
Jens Axboe

