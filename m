Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDBEC2D0ED
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6644120748
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J80NARwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0PGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:06:39 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:36728 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgC0PGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 11:06:39 -0400
Received: by mail-pg1-f171.google.com with SMTP id j29so4705270pgl.3
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eXeiwmriuUHSGPIQ5FE/vs4fhtvCZSUZ3+noRetg2ao=;
        b=J80NARwEAtfKj8z76W4AvMB6js5ArpMXn6a03i9pbVQzqrM4mOTeWkHm5iLUvzWKq6
         dvdMjte/1ibknnyKRwJhQgpA9uL2d4OucbWEktnWOfDfUhE3/Nin1yfF2DN9FgqoNm33
         hNQKG3GYV1fXckGDsLsUagkYTLnTHw/Qic1FS1/hf0/YhrQ4qXe1NQblwT7DoW48ZfK8
         Tc8Nej4b7pM3v2HivVo+eMvOYFgDALiweWzEwovBxrxHrGk39ihgZVhs902Mi+z/24FN
         3bS482It5MEKjA2IRfolXEyRT4Xikvj3228njhM/OHjzR7GRbY7uJQ7fnAy1dRUMpOWy
         yI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eXeiwmriuUHSGPIQ5FE/vs4fhtvCZSUZ3+noRetg2ao=;
        b=HC/i2FY+UGFvkw4O0FE8nfrBVped04yy5Hq6QJfCZlGax8M6l2zjTjXRC+LfOh6zXy
         sPPuw26U/a+3cQrlcsoJy5ZFBFSW6uqcEG/c3pTOCdmD/NGFMNh8CstypyrOV7Kw6+1R
         l0FaehF+o1k5vBIJDdcEcVirS0EUDhfh2/yP61zYsWY6y1UbC0yKtO0SAwiwanTzdSrL
         LnJodHX9APknzbaYgD9hY31qRBtZ7b7UDne4qdUEH8Vv2P3Xcimhw6tStTEnhpJmGaJN
         iY6wE9a4pTWPxrcvKP89i/9bKjDflverN4o//SsnG76VkWoX4ini98X9BUy2pCooBK+o
         LEKg==
X-Gm-Message-State: ANhLgQ09F+qebhYVbQdaK80k01mWirSbZaR8oxqdWb/ROtKXGaDD7aAS
        jYRxMJxal8ixo0pzGuWPZkq7bQ==
X-Google-Smtp-Source: ADFU+vs++DC7KxyU52I45Ga6jyMEVqGhwA7nu9vY/NNIxQmvXKQm1JdR/hw70GKZk7t4FSJKe8SEjw==
X-Received: by 2002:a63:ef41:: with SMTP id c1mr13864299pgk.195.1585321596559;
        Fri, 27 Mar 2020 08:06:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id mq18sm4255882pjb.6.2020.03.27.08.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 08:06:35 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
To:     syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, dongli.zhang@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <0000000000004760b805a1cc03fc@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa743a2c-f79e-6021-7c2b-72e178f913f4@kernel.dk>
Date:   Fri, 27 Mar 2020 09:06:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0000000000004760b805a1cc03fc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/20 7:28 PM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 768134d4f48109b90f4248feecbeeb7d684e410c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Nov 11 03:30:53 2019 +0000
> 
>     io_uring: don't do flush cancel under inflight_lock

This is definitely an utterly bogus bisect, not related at all.

-- 
Jens Axboe

