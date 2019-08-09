Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A32C433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 03:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5559021743
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 03:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YF0cVW+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404971AbfHIDhe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:37:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32922 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404791AbfHIDhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 23:37:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so45265692pfq.0
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l8uvhVmiLOUuoBD2DsymgnII3DhTiQrrRavMVCwTWvg=;
        b=YF0cVW+LEZEOhj2lkMbpDTeEziFJe18dEPvbdM9a92eFRcT8NkofQz1+eFoRT/uvWR
         3SttROjq3WaSQr2NrZqQOouIR0oqO4tCtMv6nX3T4vEH4VRMNVDgNMbh6WvNZxWZ8WW/
         lYYh6YkbECaPFUIvL2BzNKx7bPIMfcBO0qNnoOnGYyou+G5Tn28kfibTYj2LX0CtKZCx
         I2JjtlfLbfmxhPKtAFADgNxyIGau12/q8+u0K+cjKQ8u9FSHAwQ4oa1rLFNQ4gjgJAwr
         ATyd9GUinTma2jIf5iUFUzdMx6XFcM8A9tjDrU9pQAtzF+N4uB3c47Zx9KXO34E18GUX
         g76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l8uvhVmiLOUuoBD2DsymgnII3DhTiQrrRavMVCwTWvg=;
        b=MgxZS21Z/dwZGt+d7s8XtFS2gIAP6KnHcMQy8sHG02sE2cYZ/TB2Kq6FYeFnXhYNGN
         Egrx+LJPGipsDLmDV2msg8jESpw9jjrZn6F52uMSoEUTZIgDoNfZfhpGNlPzHaXdnQZp
         2uKjy8q+cdILEREPbhvbjWAbEEyWi4IfSxsnvHoUUI69F4QGQ+m0y0xB/HTucJD6XqJM
         HqO+KQSjpgPGSAjCcbzzxQNnbx1kV+b23fm8aXRHtsmqEbJo2MHkaQMmYLA+bjZGHKWe
         9w8DPWowAWaQrsw6xHs46Ph2ZAjXkuw1rCWqV1FIWSCaKU1kmxbffKr26e1XJaniFNWj
         PL4Q==
X-Gm-Message-State: APjAAAVh6LVf8HNCUoWkihABEIn3/eSNe5fUDMYAnILYkJaetvRfGWAE
        2LCTHHCwqpAkgkaypNcJcDOx/3KjyFotaw==
X-Google-Smtp-Source: APXvYqy9Xo+pwgMa1FRn8RZBzakocfYBKxf1JQAP0xBoWzukhxIdbbg6da0mHdI7POsGw3vf5UzIcA==
X-Received: by 2002:a63:20a:: with SMTP id 10mr15485368pgc.226.1565321853255;
        Thu, 08 Aug 2019 20:37:33 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:3965:6e7a:8c2:c21b? ([2605:e000:100e:83a1:3965:6e7a:8c2:c21b])
        by smtp.gmail.com with ESMTPSA id x67sm100643053pfb.21.2019.08.08.20.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 20:37:32 -0700 (PDT)
Subject: Re: [PATCH] Add arm64 memory barriers support
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1565318439-13992-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c34db65-26aa-31c5-b255-595de70b43bd@kernel.dk>
Date:   Thu, 8 Aug 2019 20:37:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565318439-13992-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/19 7:40 PM, Jackie Liu wrote:
> making liburing on arm64 platform failed. let's support it.
> 
> root@Kylin:/# cat /etc/os-release
> PRETTY_NAME="Debian GNU/Linux buster/sid"
> 
> root@Kylin:/# gcc -v
> gcc version 8.2.0 (Debian 8.2.0-20)
> 
> root@Kylin:~/liburing# make
> make[1]: Entering directory '/root/liburing/src'
> cc -g -fomit-frame-pointer -O2 -Wall -Iinclude/ -c -o setup.ol setup.c
> In file included from include/liburing.h:14,
>                   from setup.c:10:
> include/liburing.h: In function 'io_uring_cq_advance':
> include/liburing/barrier.h:73:2: warning: implicit declaration of function 'smp_mb'; did you mean 'smp_wmb'? [-Wimplicit-function-declaration]
>    smp_mb();    \
>    ^~~~~~
> include/liburing.h:111:3: note: in expansion of macro 'smp_store_release'
>     smp_store_release(cq->khead, *cq->khead + nr);
>     ^~~~~~~~~~~~~~~~~

Applied, thanks.

-- 
Jens Axboe

