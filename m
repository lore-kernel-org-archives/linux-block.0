Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68BBC07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C242054F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iaop42lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C242054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLKNoD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:44:03 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34481 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeLKNoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 08:44:02 -0500
Received: by mail-pl1-f173.google.com with SMTP id w4so6962706plz.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2GW2o9a23E0jSVrF2wM/5Q2xKuAJGjGxNC0pa41CSBc=;
        b=iaop42lxkrt76wj+mU79vto8aC2uUvnQViu+Bhngbw819w5KjwKJao+nqlihYppnxs
         x+Ca04/A464y3ErjwhzJ5iUriKo4evjCTzApc4XvTRrMxdwSgMNJsILq3ZZCtlgQbl3a
         XOhnGuf27y/dU+mGq1OJ5+XukvXcfe6r15kUkB+GMdk3MYvcg/CDqUzDU1HzmZEN5SGq
         rZ+Vwcq6y+jilgzGlgJbZ6QyjwawS2SmNGN4CexSwrY/JC5RNv+4rvWeXN95vAlTG4gr
         PcVoM9CikvfOCLOkGSInA2EiLR9T3xJ1BL/U3Asoa/yAYVP3oSOtJPPS0XX1GJ4/rLQ2
         iznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GW2o9a23E0jSVrF2wM/5Q2xKuAJGjGxNC0pa41CSBc=;
        b=hh6RiWWjFfJWmyJhoU2xVl2kFgkmKdhpVm+HjEssQ+fUEXDLF+9TpUmYocaXAI+1Vw
         9DaJ2vSM+SPjuLgjTRV+NnrBx/G8moUnhNIlKNCGNJYoqa1xAM+TMXAzJez2HriYpYpc
         GiXyx5ZfJPE1vv3h0SdeUYS6RDOHprF/a7LUkDwzKYc6zFX6Z6yOFxfdGeerPBrGuPCv
         0GTht8hC+AliWheRRiDy9PYh9zHbEFuc7FZ8E0FFBSxrsbGU6tYfF/KyJIj94mPJa9CT
         WI2MtAhztAhEaLNnVRMSh6286tg1qDqJWKkLJWmO3upBnLtzM8hYlWRTSEzRmkqHmFD+
         DO2g==
X-Gm-Message-State: AA+aEWZAEIouYe2cjdAoWYJcQ9cFpK1XJupIvQ3dfTIBWF1CvEqhcDEz
        1D96y79h2Hq6/oOHia40N4z9azKuLGL4sQ==
X-Google-Smtp-Source: AFSGD/VKcWXyM2w9BPIrfTi3luK6MlsSuSEUJVsTX5uAWCq5UO1z6QrsVSmqTbQmOs/00CTfSlo+hA==
X-Received: by 2002:a17:902:8f97:: with SMTP id z23mr16304895plo.283.1544535841650;
        Tue, 11 Dec 2018 05:44:01 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y29sm17920485pga.59.2018.12.11.05.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:44:00 -0800 (PST)
Subject: Re: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Damien.LeMoal@wdc.com, Matias.Bjorling@wdc.com
References: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <35b326a9-e428-7195-06ea-fc6c5d201ef1@kernel.dk>
Date:   Tue, 11 Dec 2018 06:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 5:08 AM, Shin'ichiro Kawasaki wrote:
> null_blk_zoned creation fails if the number of zones specified is equal to or is
> smaller than 64 due to a memory allocation failure in blk_alloc_zones(). With
> such a small number of zones, the required memory size for all zones descriptors
> fits in a single page, and the page order for alloc_pages_node() is zero. Allow
> this value in blk_alloc_zones() for the allocation to succeed.

Looks good to me, this looks like 4.20 material.

-- 
Jens Axboe

