Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB99C10F0F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2028821872
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 15:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z2ePWAeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfDEPKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:10:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56018 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 11:10:04 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so3384092itc.5
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fiq/Ne+GSNud8oxLcwF/SogPF5XpwyQ406WIPTvS4Ig=;
        b=Z2ePWAeT9Vt2KzOVcefw2HLztAy3f8C9dBYX3mcQBlQnTIZTCGmL3QDEF/QlkUgaqA
         G7ZaTeZuuAMbGvkoREzldYxyZXX5RThQ0+fP+DjpNbiOt7lnOW1uXNmE6mccE6QKqugF
         6mL0hEPEIeP1iL1DTgeRiJlylpX727i4MQcdeM+wI58DvCxEXrcUecYTSIDI8OSy6xoU
         j+72+l10KUEGxeBX2pkXvnQp43qZ3petKSnv62l3ERzSBmu5Afkh+wOBXI+U80p9W4zM
         U4a1BNcVnbNcElyL68VO+X1lNU4hfQ71W0tJQYZxLF62XFvLqEiVwAwdeTy7UhIFIiDa
         eJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fiq/Ne+GSNud8oxLcwF/SogPF5XpwyQ406WIPTvS4Ig=;
        b=hSeloUSocjhlD+f8riyWR+PJbuyuzAJ0+Jxf8qJPk/rQzG4bpTi9MMMfLtjNXW2Pxd
         oLCmUWIuGNG9amQvlq1ykS3T7VlIGw1WKTdunweWzS8UJf4tJGSCzMzUCxvCcRPWHbCn
         z1Uk03IKpbMT8VXkilw2vtvNj/mn8oGqFTV1xe0+S3BNfIVVNNYcPG3vevl0YevYGoxr
         A07ozJAonkpd/Ux2kmTODp5XYcKMDX0CQ7fvKecF4J5qUFSpgkDXA3D32ikJTHu2gtEq
         fQvnYEEtLtrL8CwjbLb3H83+5OfkRIKooSk/crSTK7bjZId67g22tX7GEI7VcyW1ddh9
         mIqg==
X-Gm-Message-State: APjAAAWvBJhwqeeug69YBmO2gGORAYLk6jlrvXNMk5t2Thki8Xc8bs6x
        /HXnp9SUu+UjiMF2jI0eqKSb/veHIa/sHw==
X-Google-Smtp-Source: APXvYqyYri6D++rJSzOi+GgXkhsxvokTz1jlvH/2UDQG2BQBk/BH7MGvWcsoIUE9nC4TVVcvStuJuA==
X-Received: by 2002:a24:ac43:: with SMTP id m3mr9305836iti.14.1554477003239;
        Fri, 05 Apr 2019 08:10:03 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c13sm9174452ioi.12.2019.04.05.08.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:10:01 -0700 (PDT)
Subject: Re: [GIT PULL] early nvme updates for 5.2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190405062043.GA26688@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96592ce3-88d6-ac9a-1f10-6175ccae89b7@kernel.dk>
Date:   Fri, 5 Apr 2019 09:10:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405062043.GA26688@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 12:20 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the first batch of nvme updates for 5.2.  This includes the
> performance improvements for single segment I/O on PCIe, which introduce
> new block helpers, so it might be a good idea to get them in early.
> 
>  - various performance optimizations in the PCIe code (Keith and me)
>  - new block helpers to support the above (me)
>  - nvmet error conversion cleanup (me)
>  - nvmet-fc variable sized array cleanup (Gustavo)
>  - passthrough ioctl error printk cleanup (Kenneth)
>  - small nvmet fixes (Max)
>  - endianess conversion cleanup (Max)
>  - nvmet-tcp faspath completion optimization (Sagi)

Pulled, thanks.

-- 
Jens Axboe

