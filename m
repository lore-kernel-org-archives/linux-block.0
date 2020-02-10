Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD81C352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 23:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B32A20715
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 23:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Os5N2DQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJX2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:28:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43072 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgBJX2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 18:28:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so9428244ljm.10
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2020 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cu3MW944ItoyJVaF3AWz8XwBeLXBvPLX1kISUHTawLE=;
        b=Os5N2DQBOLyoaklJVoaMBMdFIZqwf8xnxT9lBjzpO94qQb99hYrBo36IdM6mGstNEk
         +OBhs3fKf5vXnsKChs9uLvBrC8xVIHyGN9GMwALJrdBBTclVM6X1p7nFtR7py7rgeb2h
         a0NoJ+ZiRWktkmZizF4RWqfzZpl+D+6bmgr713Y5qJmR+xyiiu12oksoQ+fXLM/wKcWp
         vVt/TSBFwiDjYwOwTHzPnOFpD8TV+To98TwyR5ksLXxlGJwEfEORRgCtBcMLtSw9nXAh
         xK8gWFznL8UMeXMX7Yqw5XZRLD7/U4MAkOlf7BXh1FvT//8tPWMVYA4GA6rgbsSClaIG
         4Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cu3MW944ItoyJVaF3AWz8XwBeLXBvPLX1kISUHTawLE=;
        b=r2qbDczcEGKiQNm6txMqicDafCeiSlgpSOfCyYCF54BuEF6EFOWDJFw0/xgUQODoEX
         Wf3eMIf/zlGs9gwXE7Zhoe1l3p8FfV4nEYoDE7JQM6XJm2h/ffu6Cs0eJJ9kKA9aWe8w
         8AgYtyfOrHo1NJ+irgNHQRQ6S5JM0r1Ac4FJR3V1RJsIPN5z4Gi14NRyOC+XbHU3rdgp
         nd8KyocAZYeif4gpsTN3OwScJEXjBaORM3xmVAP3oyuS5ussvQfQX+Q0xvlP9asAJLIx
         pipVU1yJqhEg836STOBrGqzF+LhNohSa0pc0MmsJXXq9Mmg6yxdkQG1ZQejnKlcbUgYp
         VBlw==
X-Gm-Message-State: APjAAAXqNAM7XKfotVnd8nejUz8zbiUq+bAyL/LwaRssaJitSQtdZTXK
        IGfTLnzcTGqGiQ+ojhFH9tUGi0nqhPY=
X-Google-Smtp-Source: APXvYqwCUkMR+ePbjkUhcM9kSQtX/qRRoCPaR0gQ+MU7uxgHBUiDsci2dRmIFrf3TYRj8wIwQtNLLQ==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr2377811ljg.57.1581377297314;
        Mon, 10 Feb 2020 15:28:17 -0800 (PST)
Received: from [192.168.1.12] (176-20-99-20-dynamic.dk.customer.tdc.net. [176.20.99.20])
        by smtp.gmail.com with ESMTPSA id t9sm782656lfl.51.2020.02.10.15.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 15:28:16 -0800 (PST)
Subject: Re: [PATCH v2] block: support arbitrary zone size
To:     Alexey Dobriyan <adobriyan@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, damien.lemoal@wdc.com
References: <20200210220816.GA7769@avx2> <20200210222045.GA1495@avx2>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <afaa196d-ca85-3b6d-fa67-d25b24ff812e@lightnvm.io>
Date:   Tue, 11 Feb 2020 00:28:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200210222045.GA1495@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/02/2020 23.20, Alexey Dobriyan wrote:
> SK hynix is going to ship ZNS device with zone size not being power of 2.
>
> Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
> ---

Nack from here as well. The power of 2 is a strict requirement. All SMR 
HDDs Zone Sizes are a power of two, and ZNS SSDs should be as well if 
they want Linux eco-system support.

The ZNS specification is specifically written to accommodate this. It 
has two type of zone sizes, the Zone Size (which is what should be a 
power of two) and the Zone Capacity (that is the writable capacity of 
the zone). For Linux support, your ZNS SSD implemention must have a zone 
size that is power of two, and instead use the Zone Capacity field to be 
the "Zone Size" that you have now. Then it works as expected, making 
both the host and device happy. The host gets power of two, and device 
can communicate the non-power of two writeable LBAs within the zone.

Best, Matias

