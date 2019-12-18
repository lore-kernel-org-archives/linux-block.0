Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2FC43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8002176D
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 01:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tQpqCkIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfLRBKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:10:34 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39425 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRBKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 20:10:34 -0500
Received: by mail-il1-f193.google.com with SMTP id x5so219000ila.6
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2019 17:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1tD7kHhmkZs6te+fjNwiddlYys5It4mEm2OpL5exhDU=;
        b=tQpqCkIvH4mshhh8QRMOZ5Zp1pJZ4s8hFMQ9foZn9TjOaMG0PvYa7SiaH6fd3KtnXM
         J9EF80n3JZP2kI8izrBZYbBoT38RE/0JJHVHvwKYgDMFD9LsDPdCAvqkbzzZ9uNdwvjz
         YtSKRh283MO9tFalHameaOBXC6KhYhjHRTZn9l8vdd0W7Xe3nD8SW9ltsISiL6BAKIU8
         RkPoQChsk+9layzPqg6EDdWF7asMc9toJncWoTC9AQZgyysfbteU324uhgYNKgI/v1bM
         VMvXgRW+/sXysQiZCmRcubhVk41ZEqMNyCQwx/sfTna0Xt1EiA6010zHMMLo9L+F2MWk
         n0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tD7kHhmkZs6te+fjNwiddlYys5It4mEm2OpL5exhDU=;
        b=mvDuXgtAcdb29QUq3D3m1Hh7ZxFg4eKFy8M4E29Iuw+fUusWclog+p0hN73yo2czB8
         NPjOLcwcD/z5pRHuIFiINlKd3Q+domkkGr5y6WvPBCOFgEcsAZDsJmD3kpkh/AE1d5Eb
         +ZaU1C+JMKrvGgYrKGSEJO23XIJ7liXhSrJtRhJvj7vunk9M1mbjrn/HGrvRF3DC64UF
         odG5AwpAmocq12Wxjjdi0QDCXcIoYk3aGOjNnGPVny9T0Y7dq+Q7uczFBj4iJlgTMUht
         pK2VkT8GfhiYtVWaIl/EDOkIwboJspCmQxGkBwBXNrmNMk0Y0S1tpw+ttROVg+znPqgd
         Qbwg==
X-Gm-Message-State: APjAAAXSnpHod3R5mdWPpbB+mojIFnKypQsh0RpxsUVe/wvFg+otPSTF
        8NB498TsgKAv9C4JbYCOBk9u7zdIdbULng==
X-Google-Smtp-Source: APXvYqxJUeLwa3b78mEiG2qE/FyEW+67N3zXztOU5sZqbqudAFlhRnrxqnB+MK9zIJBiyJIM8SmBGQ==
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr270884ilq.37.1576631433355;
        Tue, 17 Dec 2019 17:10:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm108244iod.61.2019.12.17.17.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 17:10:32 -0800 (PST)
Subject: Re: [PATCH] block: Fix the type of 'sts' in bsg_queue_rq()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>
References: <20191218002329.48593-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7249e66a-decb-10a2-9b1c-12136a302240@kernel.dk>
Date:   Tue, 17 Dec 2019 18:10:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218002329.48593-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/19 5:23 PM, Bart Van Assche wrote:
> This patch fixes the following sparse warnings:
> 
> block/bsg-lib.c:269:19: warning: incorrect type in initializer (different base types)
> block/bsg-lib.c:269:19:    expected int sts
> block/bsg-lib.c:269:19:    got restricted blk_status_t [usertype]
> block/bsg-lib.c:286:16: warning: incorrect type in return expression (different base types)
> block/bsg-lib.c:286:16:    expected restricted blk_status_t
> block/bsg-lib.c:286:16:    got int [assigned] sts

Applied, thanks Bart.

-- 
Jens Axboe

