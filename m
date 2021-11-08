Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62CC433F5
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 11:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EAF60E8B
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 11:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhKHLaj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhKHLai (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Nov 2021 06:30:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECDAC061570
        for <linux-block@vger.kernel.org>; Mon,  8 Nov 2021 03:27:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u18so26229469wrg.5
        for <linux-block@vger.kernel.org>; Mon, 08 Nov 2021 03:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xVkvsEXoAtnCua5wtCXj6xBNGgctLW+5eOtfZn3AarU=;
        b=fzMPTlXSbDS6deEYHjAF4P5gzALLMMoWwvbb2glVOksWEnjA7qiKxEsU9cAHj+5rQ1
         Ac9LEe4C7Vqq8PP819CMJ9jlRaQ8oVhdSiv/ocrSIel/Q1WtCmMq/9tVqXuH4YpI6dbh
         nSs6teYPZhMHr3ebfmnjl2JgsCwMVJlC5kpOXrKAm1FIdCd6gN5jOWJLpArFx/ApDG4t
         O6g0n56QYRz036fQ8MGxcXt0t73WUROAba0KGAKBZMOpYTRGFOGbWZ+w3l+9ajNMhdAx
         v+oZzqDwUi2i7FRNoUROgUsolhk8rUTkrTl2Cd749MDe+KSMHwXjOjQQS9QpNbYxKw+6
         DE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xVkvsEXoAtnCua5wtCXj6xBNGgctLW+5eOtfZn3AarU=;
        b=p+qpHuIgly3YJE5h2AbsKd4bH1XNQ9DHa2xImBOciY+4v4ZVsApLX7rs5zeFqFELHX
         /DFO3vimrj8sfAw/ut7600f/d/7/JQ05lMqlyxHZOERaKoAlzzWTUMU/jPaNcowmqDOO
         BtEe/Zy9+F7EZ1TN3k4ac5oE7riJT0cvRLfs23tQhIxHAYAC29giakpqOv9t6yjiovMo
         zWJQENzen9VOH2Nc7MAoxrAaboC4H1O82VuTQ89vFdIfU1L5oHGapQxrjFN9WdU/5t/F
         MwoV9+d6t4lcY60YjmPEB+DbuYhskEL3+Sucn82q93lvEJtml8GG8hbsyzYmTix1iv7o
         yFVQ==
X-Gm-Message-State: AOAM532JIeXpXeWsHWiqcm1qbHGaMV7oshxXea2yax8FLDjsguVGiPGU
        evraTjB4nT4uhAS+rqZaMzWV8Q==
X-Google-Smtp-Source: ABdhPJzQ5q9U5aMhrt+itvgDKscaUMvPUE2D61sy6ASoH1wdDWh2fCF1RVVKQwjeWQRX/k7ivG8uAg==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr43532793wrp.112.1636370873064;
        Mon, 08 Nov 2021 03:27:53 -0800 (PST)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id k37sm16276291wms.21.2021.11.08.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:27:52 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:27:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kumaravel.Thiagarajan@microchip.com,
        Pragash.Mangalapandian@microchip.com, Sundararaman.H@microchip.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YYkJsbbHH6wdPvB9@google.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com>
 <YYkGkEiPb+6J62hn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYkGkEiPb+6J62hn@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 08 Nov 2021, Greg KH wrote:
> On Mon, Nov 08, 2021 at 11:04:31AM +0000, Lee Jones wrote:
> > On Mon, 08 Nov 2021, Kumaravel.Thiagarajan@microchip.com wrote:
> > 
> > > Dear Lee Jones,
> > > 
> > > I am Kumaravel Thiagarajan from Microchip, India and I am new to Linux Kernel development.
> > > 
> > > I am currently working on linux kernel driver for one of our PCIe based devices whose BAR 0 maps interface registers for a gpio controller, an OTP memory device controller and an EEPROM device controller into the host processor's memory space.
> > > 
> > > Based on earlier inputs from Linus Walleij, I have developed this as a multi-function device driver - First MFD driver (drivers/mfd) gets loaded for the PCIe device and then it spawns two child devices for OTP/EEPROM and GPIO separately.
> > 
> > You may wish to speak with Greg about your architectural decisions.
> > 
> > He usually dislikes the creation of platform devices from PCI ones.
> 
> Yes, that is NOT ok.
> 
> Platform devices are only for devices that are actually on a platform
> (i.e. described by DT or other firmware types).

This is probably a bit of an over-simplification.  Lots of legitimate
platform devices are actually described by DT et al.

However, it is true that devices which reside on definite buses; PCI,
USB, PCMIA, SCSI, Thunderbolt, etc should not spawn their children off
as platform devices.

> PCI devices are NOT
> platform devices, please use the correct apis for this instead (i.e. the
> aux bus)

Grep for "auxiliary_device".

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
