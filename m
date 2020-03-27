Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA163C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7928720658
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="i+G9H0XE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgC0Q05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:26:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44870 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0Q04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 12:26:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so4724833pfb.11
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9wGl6Wa9QcDb2Dodea5tAybsKTGFt4bIi5UGB0n01cs=;
        b=i+G9H0XEanhreLDRyPOrdm3E/anAyqwLOZ+qC4cS/PiYXG6pwl9/qQaaZVRqng5wHG
         a9gYchMK/gcMdHzLIoWL5minq2VRExAsl//MbiQualDRYxuIvBx/3U4rsjaoxTOdZNmj
         YYpuZ5q5Kz5EzYD/xLcxPZ3ndoRseL79xd24pw+4pkVgErTDP2zoQU/3cUzHYiMjkYgP
         g79aqImQisfeL7d6Q73wKV35YKc4hwUYbvtPfxPVvKZ6K3KldSciBSThVvQg0mJ1Vu+r
         apcVbgGzQASsVyxSOrpdLnvmY52yT3a7HgA7IPrTvFWComN5qtDZNH3cIyxqrqWI8iGa
         bL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9wGl6Wa9QcDb2Dodea5tAybsKTGFt4bIi5UGB0n01cs=;
        b=boYTw3MraPT8joNFf30S0KnnKqpsTwFJ2R+83fIdDRkoX8YZzhYoiTloBR6a5j0fvB
         Y3OMeF+9msgs1mcJ3Borf8KOaN7aqZYYj7FksO5WA1d00HbpDs1IhJc9pN+ga2dTAs6F
         4vOGwTixXVUCiVEhYhmkDnqBsGV1dazX5cJV0XFG9UumrbwGu+SDASIpuF8TnKLjcKw4
         POLpVyuu40ycDhBtKWzIGzQF87u7P01Ca82BAO3fxH3z1Dz0dRADKiMj/i0e4OQHoTmv
         7U4tTwg7JQq7oYrwos/xZTwL2WEN+LvFVm3BeP6xCXrosQXzNRtEZZd3D7CO4oE+8lVb
         Y4Xg==
X-Gm-Message-State: ANhLgQ3a8j8RyAhBR+EEaupJ8Ve9Oor1YY6wiGT0ysftnxLkTkGodJ65
        0GNeMqm5T7gm0PlkvRWu9MIzDkXCXqTedw==
X-Google-Smtp-Source: ADFU+vubMB0lGbM3zpgUhH51Md8EsyBIdpegFQwx5b0+Q76FNba1fLDt6/bPPFZndRMdakGtS6Twyg==
X-Received: by 2002:a65:508b:: with SMTP id r11mr95108pgp.143.1585326415251;
        Fri, 27 Mar 2020 09:26:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id iq14sm1538619pjb.43.2020.03.27.09.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 09:26:54 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: simplify queue allocation
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200327083012.1618778-1-hch@lst.de>
 <20200327083012.1618778-5-hch@lst.de>
 <SN4PR0401MB3598BF20E4DCF8F1B129625E9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200327112131.GA1096@lst.de>
 <SN4PR0401MB3598AD1669D1F5BFCA4F20379BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2110f00-6d27-1567-2725-3afb2e83ea5f@kernel.dk>
Date:   Fri, 27 Mar 2020 10:26:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598AD1669D1F5BFCA4F20379BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 10:24 AM, Johannes Thumshirn wrote:
> On 27/03/2020 12:21, Christoph Hellwig wrote:
>> Because the two variants are rather pointless.  And this might get
>> more people to actually pass a useful node ID instead of copy and
>> pasting some old example code. 
> 
> So then everybody will copy the NUMA_NO_NODE ones and in X years someone 
> will come up with a wrapper passing in NUMA_NO_NODE to 
> blk_alloc_queue_node(), because he/she didn't read the commit history.

If you care about numa-node, then you are generally using it for other
allocations as well, so it should come naturally. If you don't, then
the copy/paste is fine. Better to expose it as the main API, so people
don't miss it.

-- 
Jens Axboe

