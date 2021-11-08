Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 12:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E97C61288
	for <linux-block@archiver.kernel.org>; Mon,  8 Nov 2021 12:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhKHMF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238100AbhKHMF5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Nov 2021 07:05:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FBA1611C0;
        Mon,  8 Nov 2021 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636372993;
        bh=iUquAhK1pe6WbCgNnyN0FkZoVabpGTyRukbbNwh8Ics=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y6zI3G9dq6IwJdQXThAO6mGGpwKucH6IDfn9LTiIY39bPb2D7bsOKHuoEl6LAn39F
         gUQOY83+OShPjZZaCZY3VmL3lZimX4A2/bNzx0YjdsyycJsGid/X2YaAzPrc+58qfX
         VM/INvaaJ6CbILWI8JpAAjZcWwi+VnVue2Kbytv8=
Date:   Mon, 8 Nov 2021 13:03:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Kumaravel.Thiagarajan@microchip.com,
        Pragash.Mangalapandian@microchip.com, Sundararaman.H@microchip.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YYkR/szsDirtj1FP@kroah.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com>
 <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYkJsbbHH6wdPvB9@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 08, 2021 at 11:27:45AM +0000, Lee Jones wrote:
> On Mon, 08 Nov 2021, Greg KH wrote:
> > On Mon, Nov 08, 2021 at 11:04:31AM +0000, Lee Jones wrote:
> > > On Mon, 08 Nov 2021, Kumaravel.Thiagarajan@microchip.com wrote:
> > > 
> > > > Dear Lee Jones,
> > > > 
> > > > I am Kumaravel Thiagarajan from Microchip, India and I am new to Linux Kernel development.
> > > > 
> > > > I am currently working on linux kernel driver for one of our PCIe based devices whose BAR 0 maps interface registers for a gpio controller, an OTP memory device controller and an EEPROM device controller into the host processor's memory space.
> > > > 
> > > > Based on earlier inputs from Linus Walleij, I have developed this as a multi-function device driver - First MFD driver (drivers/mfd) gets loaded for the PCIe device and then it spawns two child devices for OTP/EEPROM and GPIO separately.
> > > 
> > > You may wish to speak with Greg about your architectural decisions.
> > > 
> > > He usually dislikes the creation of platform devices from PCI ones.
> > 
> > Yes, that is NOT ok.
> > 
> > Platform devices are only for devices that are actually on a platform
> > (i.e. described by DT or other firmware types).
> 
> This is probably a bit of an over-simplification.  Lots of legitimate
> platform devices are actually described by DT et al.

We are in violent agreement here, that is what I was trying to say :)

> However, it is true that devices which reside on definite buses; PCI,
> USB, PCMIA, SCSI, Thunderbolt, etc should not spawn their children off
> as platform devices.

Agreed, that is not ok, as those are not what the platform device code
was designed for.

thanks,

greg k-h
