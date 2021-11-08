Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C8CC433F5
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 11:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CB661242
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhKHLHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhKHLHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Nov 2021 06:07:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380AC061570
        for <linux-block@vger.kernel.org>; Mon,  8 Nov 2021 03:04:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d5so26149576wrc.1
        for <linux-block@vger.kernel.org>; Mon, 08 Nov 2021 03:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=at7QYPQleIMyEEiP1lZWrA5vbZFNe1ByBa3JnUgvYTI=;
        b=FPH5lEqXwqlOdS3lvEYdwU26USTg3AEjZSimrTz1xHhQrSKichFIylk7o9x/NHKuBA
         qreJo9Ey7fEuHTO2q7KjgQJ60W1tmR666UJY0uakKru4yMWHw7//3dXQGLyAFZYwHqPB
         v4+Rcac6ESMS7NqmuvS6/nevgAO0AEeAmVi4g4pSy+3d4MAfKyy8sJSasrjOwi6Yvfhl
         Yv2BkLhtEmjJZGwOBvVmFQNqnXe0t9GbebqG3rL79ktLUffsdixSm8ra6jQJMocCLBPO
         3fzjfRNlz83kQn5BK+QHhVkhZF2Dv9lGldQGZDMqUX+ecg8lkbBkdvPzH+5oLyvn2O2k
         WlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=at7QYPQleIMyEEiP1lZWrA5vbZFNe1ByBa3JnUgvYTI=;
        b=QWuFqa41z9WNIh8Vio1IAIUyAlWVxeg8pfO65sAtfTyEWgVt4uWj79QcmCJMB/5+gg
         XnzTQtwm0f25z02BLIf3cVuUh4y7y5ZEc602U9Rthk/NhYiE4mWFJlzZ1Wx1ttHAv+06
         AeJcH5+HRxjUkNN475dORpuyTCkFtSwFU2Nu+qkk/ITFDPH60x9DB7mfmFs5mlvN7a4S
         r3Ok8XiQEij92f2KwElvsUC5rhuP85dtnSj2jFR4mwXIfxuzmrAlDtvFFqTNmqiAd0z1
         4priZpIW/dLYZFahgNsAIv4VMyDPttrE93xcNEIORmgeI/Nok1ZTI2DilxNjYgv8uQPI
         +NVw==
X-Gm-Message-State: AOAM533vfpFcoalFNBrIgp/eWOOx86VG1DfUZrYJ060Dz6MMnVzOpKB6
        CdzdR8oXV9giIHZlrf4P7srgia4+03vZ9A==
X-Google-Smtp-Source: ABdhPJxIfD+/oLL8LVP2PucEMUp/d5K/YpD0mOO8GuwyEaidcy7PY+TFfSS5H5IeiitZm+5gCyvSmg==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr43363396wrp.112.1636369478423;
        Mon, 08 Nov 2021 03:04:38 -0800 (PST)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id g13sm14916391wmk.37.2021.11.08.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 03:04:38 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:04:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     Pragash.Mangalapandian@microchip.com, Sundararaman.H@microchip.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, gregkh@linuxfoundation.org
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YYkEP62JRb4rCuXQ@google.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 08 Nov 2021, Kumaravel.Thiagarajan@microchip.com wrote:

> Dear Lee Jones,
> 
> I am Kumaravel Thiagarajan from Microchip, India and I am new to Linux Kernel development.
> 
> I am currently working on linux kernel driver for one of our PCIe based devices whose BAR 0 maps interface registers for a gpio controller, an OTP memory device controller and an EEPROM device controller into the host processor's memory space.
> 
> Based on earlier inputs from Linus Walleij, I have developed this as a multi-function device driver - First MFD driver (drivers/mfd) gets loaded for the PCIe device and then it spawns two child devices for OTP/EEPROM and GPIO separately.

You may wish to speak with Greg about your architectural decisions.

He usually dislikes the creation of platform devices from PCI ones.

> I have four new files in my local linux source tree as below for community submission.
> 
> 1. mchp_pci1xxxx_gp.h under include/linux/mfd
> 2. mchp_pci1xxxx_gp.c under drivers/mfd
> 3. mchp_pci1xxxx_gpio.c under drivers/gpio
> 4. mchp_pci1xxxx_ otpe2p.c under drivers/mtd/devices
> 
> I have a doubt with the location of the fourth file for the following reasons.
> 
> 1. I have visualized and architected the OTP and EEPROM memories of my device as individual block devices so that I am able to use the linux dd command to program these memories from a binary file directly or edit them directly using applications like hexedit, both of which I am able to do.
> 2. These only look more like block devices to me and not MTD devices (only writes and reads are possible and not erase).
> 
> Can I move the fourth file directly under drivers/block or should there be a new sub directory under drivers/block or leave it as such under drivers/mtd/devices ?

Those are questions for the MTD/Block Maintainers.

I've Cc'ed all of the relevant parties for you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
