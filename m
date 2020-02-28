Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A08C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 16:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF452467B
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 16:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr6fzKmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1QPy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:15:54 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45253 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1QPy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 11:15:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id y3so1872626qtv.12;
        Fri, 28 Feb 2020 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zLIJhgQeKoM3TVL9grxpHNsOStPobz8lrWJ9NwMsV+Q=;
        b=dr6fzKmS/ZJsM2KdGT4NPnZoIn+O5/0IHmWnkeXpEeRIAt6s+9PUJLPYzLkmxGWXD9
         binTX/BydlMFCdqtSI2+IjzMBclxja+ctgBFbzziq9dSgyYBpxN/AW9ASGkdfD3YuzEl
         atbR5wo5RUmakZaSIfaa63+Y5U3RmStM1azs4QqNRSBkFoY2I+HLCAywgEREMZVpN9zI
         V9WjXjWR5AUNzTO8MupJaADcIdjHXzE4x0yfAri9WCsZ/fZ9HoQAJEawOipLyCvmMTap
         DmFHHpjA89OInEbW5wv+lMVsG9XVKq6QRaG7TOPlpk3E1wFxhU80AxH3Vt7ZeB6lUmSh
         uiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLIJhgQeKoM3TVL9grxpHNsOStPobz8lrWJ9NwMsV+Q=;
        b=b5ApnTkenerIYPpW2A0TnY05Q5z2zeuC9z0Di/cm+azANoMx/WkbwzqBSRXyYQ995b
         iIf3mXaAD4Q7dtzRCh8XBlLk1bQrSdWty1c14Zj+ghQcmDoNEDiYmbYol7mjtywWMml8
         ANvp85PfABdbvyR0OHaOs7MhGfNG8LJdZ7MeQN6SqUQtsARfOHM4TRZ8IPf2XaxjZmR8
         WDnMCmebVOFAbB0ZNWZTQbtoRkVUt/aDfFfsT/lLheo3clacej/ity3sZVtED+XSIqu5
         t7clPhoN4axqxctOq7UA+DUkM3XBiXC4unHCa4OFZRBMfkuNDJLWDIGsAOfzpiVP0Jgy
         c19w==
X-Gm-Message-State: APjAAAX2CB2K74PV2u/g6BFryPTmIy2gvB+DRwUJTaotqHCGZJh/hR/Z
        GIBYjkDc+p+oXeMbqBFBAfE=
X-Google-Smtp-Source: APXvYqwK70Lmxb9fTle2n2GIET2hRKLee49wsz+JltoPSU4dAApvyy75G3jJzZy75EiDTtmdRFBMGQ==
X-Received: by 2002:aed:234a:: with SMTP id i10mr4808945qtc.155.1582906553566;
        Fri, 28 Feb 2020 08:15:53 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:500::3:7b95])
        by smtp.gmail.com with ESMTPSA id o55sm5501871qtf.46.2020.02.28.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:15:52 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:15:50 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] loop: Fix IS_ERR() vs NULL bugs in loop_prepare_queue()
Message-ID: <20200228161550.GA26021@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20200228141350.iaviwnry3z4ipjqe@kili.mountain>
 <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c106c6ec-7171-3586-d5c5-5c14e386b3d5@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

es65;5603;1cOn Fri, Feb 28, 2020 at 07:25:58AM -0700, Jens Axboe wrote:
> On 2/28/20 7:13 AM, Dan Carpenter wrote:
> > The alloc_workqueue() function returns NULL on error, it never returns
> > error pointers.
> > 
> > Fixes: 29dab2122492 ("loop: use worker per cgroup instead of kworker")
> 
> I can't seem to find this commit?
> 
> -- 
> Jens Axboe
>

This went through Andrew's tree as patch series "Charge loop device
i/o to issuing cgroup", v3., it is currently in linux-next.

Thanks for fixing this Dan.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
