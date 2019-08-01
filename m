Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C683C433FF
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A220679
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PetQWnf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfHATvr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:51:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfHATvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 15:51:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so11524850pfa.13
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gWdCVJ/oKwlp7QcAuVDtz/rvT4u01sDkQGgThw82PeY=;
        b=PetQWnf7/C2Hn8GhN4PiwwxB9+0MlKMUqfCxgfcnl4tPN4jTReLqCbflA0NFkALq+H
         4hBmXzuko8QnJY+DNAb8HjcrgMMrDrS/pB3xuHyAuSs6rG45PsjGkT6Vo6pyxD4aprqX
         83Rmrk+dH28MJ/vMpvR5F5xnNFKkQTyJWlXM2H3+df2Nql3bhQKSBdbp5UhpHiZpy/uY
         ZV62uxaCsgbnmKpofJ4/2E2+En6CMP8wo4l9jLuXuGNJBqMfTiD5Px9Fi8ImbWtB/BIC
         v9uEOIGjmADLA89c7Dv60S6QdlLVZJIJrkFihrB0njVRe5fHUuZ50vEeiOAWptKVfAgB
         fkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gWdCVJ/oKwlp7QcAuVDtz/rvT4u01sDkQGgThw82PeY=;
        b=iL+DyBIbTtGx4xYmYcRsE0Fbz4+TeC+Dglnxel3PrIYTMqLyPWU3modnZXAcQeMAUa
         CFxAwmeGXOMrpL8l+8exRA3VgnBVwZFBdilWlBxURuwfa8aWNOAc5BmZqhnCPSvHfWvj
         EGVPiQX6gRoao/qeSzqaKhlE6DLX50OZtcv3KGD3O8ox7s9WRWRTawH9m+gYWwIc9kOS
         YTtLchGDM317iKC4+t4ydZZDIJARYK2ZFWpMVQ0etZ4a4P2kTRxbXnxy79bU1hR8HCGv
         T6vkAXT1wWaxi13izIyV4YzJacECH6HVk0L7gUovfii+6LuKclg96JOL5XIUJpvooN99
         LDiw==
X-Gm-Message-State: APjAAAXRMOE9egeiehG03HXu2sRV6rytpp3eq1WUCLmmpyb7QcuYfPyU
        YEBNWTF1QxOwApSGoeRikrDY1A==
X-Google-Smtp-Source: APXvYqxtZxwEWMrhaZ1UE+naNvzcWvYiQVnd8m5cAksGm+7aHkaPShRHG0auaydOC/XrpUNGu0Gd6Q==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr480357pjq.64.1564689106872;
        Thu, 01 Aug 2019 12:51:46 -0700 (PDT)
Received: from ?IPv6:2600:380:b425:2d3f:35ea:15f8:c3fe:3268? ([2600:380:b425:2d3f:35ea:15f8:c3fe:3268])
        by smtp.gmail.com with ESMTPSA id z68sm67239287pgz.88.2019.08.01.12.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 12:51:45 -0700 (PDT)
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19115dcc-8a4b-8bb7-f8db-e2474196a5d0@kernel.dk>
Date:   Thu, 1 Aug 2019 13:51:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801102151.7846-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 4:21 AM, Damien Le Moal wrote:
> The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO
> (patch 6a43074e2f46) introduced two problems with BIO fragment handling
> for direct IOs:
> 1) The dio size processed is claculated by incrementing the ret variable
> by the size of the bio fragment issued for the dio. However, this size
> is obtained directly from bio->bi_iter.bi_size AFTER the bio submission
> which may result in referencing the bi_size value after the bio
> completed, resulting in an incorrect value use.
> 2) The ret variable is not incremented by the size of the last bio
> fragment issued for the bio, leading to an invalid IO size being
> returned to the user.
> 
> Fix both problem by using dio->size (which is incremented before the bio
> submission) to update the value of ret after bio submissions, including
> for the last bio fragment issued.

Thanks, applied. Do you have a test case? I ran this through the usual
xfstests and block bits, but didn't catch anything.

-- 
Jens Axboe

