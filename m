Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850DCC433F5
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728AB6101C
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 11:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbhKHLR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237360AbhKHLRQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Nov 2021 06:17:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 374566101C;
        Mon,  8 Nov 2021 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636370071;
        bh=qGAdeBQMkx/3cqepXuYISBgQJmXLDOOoCO8r0hQIXXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Wcftaejl53wnWzsJMcQWv7LUoFmdx8TnuXeBs1YCSIl2TNl9mXdFlK2NoT+xcsV5
         ROA/D8c4IwzWvdwdJv0G0DgbQr33sv1KlROd1gpnU/YRRVzbtzbmnGdhissEsseKlc
         AC6isYkr06GlwvZm0OX/TJPYjxcS8vbpMSQqUXIw=
Date:   Mon, 8 Nov 2021 12:14:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Kumaravel.Thiagarajan@microchip.com,
        Pragash.Mangalapandian@microchip.com, Sundararaman.H@microchip.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YYkGkEiPb+6J62hn@kroah.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYkEP62JRb4rCuXQ@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 08, 2021 at 11:04:31AM +0000, Lee Jones wrote:
> On Mon, 08 Nov 2021, Kumaravel.Thiagarajan@microchip.com wrote:
> 
> > Dear Lee Jones,
> > 
> > I am Kumaravel Thiagarajan from Microchip, India and I am new to Linux Kernel development.
> > 
> > I am currently working on linux kernel driver for one of our PCIe based devices whose BAR 0 maps interface registers for a gpio controller, an OTP memory device controller and an EEPROM device controller into the host processor's memory space.
> > 
> > Based on earlier inputs from Linus Walleij, I have developed this as a multi-function device driver - First MFD driver (drivers/mfd) gets loaded for the PCIe device and then it spawns two child devices for OTP/EEPROM and GPIO separately.
> 
> You may wish to speak with Greg about your architectural decisions.
> 
> He usually dislikes the creation of platform devices from PCI ones.

Yes, that is NOT ok.

Platform devices are only for devices that are actually on a platform
(i.e. described by DT or other firmware types).  PCI devices are NOT
platform devices, please use the correct apis for this instead (i.e. the
aux bus)

thanks,

greg k-h
