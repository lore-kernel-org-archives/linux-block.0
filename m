Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF515C433F5
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCC861175
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbhKPOXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbhKPOX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 09:23:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65FE261502;
        Tue, 16 Nov 2021 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637072429;
        bh=Q20/g1l8rwfLVJucsg0fsXG7lkYQoLbtbOKw8Cy6Wn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qADXFzDwg9EW9wLcTrtUHzWXjLxmsdUkga0I4W3t+MTAQ3ikfHGNlOUnlYaars6ID
         Xpjfgd0pEt+aTx/WCvXBbxtfTK16YV0hYvBqYUE+wSVh7H3ZBbc9/jZHOgKFLBuCQt
         GErLyMDwwaGObxBDjnLipH8mF6JiZ3xovAWxsJEQ=
Date:   Tue, 16 Nov 2021 15:20:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     lee.jones@linaro.org, Pragash.Mangalapandian@microchip.com,
        Sundararaman.H@microchip.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        LakshmiPraveen.Kopparthi@microchip.com
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YZO+KktO3OhDEtlq@kroah.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com>
 <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com>
 <YYkR/szsDirtj1FP@kroah.com>
 <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 11:34:24AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> Dear Greg K-H & Lee Jones,
> 
> Thanks for your inputs and I need more of your help to understand things better.
> 
> I took this MFD route not just based on the recommendation from Linus Walleij but also based on the kernel documentation @ /Documentation/driver-api/driver-model/platform.rst which states as below.
> 
> "Rarely, a platform_device will be connected through a segment of some other kind of bus; but its registers will still be directly addressable."
> 
> I visualized these two (GPIO controller & OTP/EEPROM controller) devices as platform devices present on the same PCI function and these two devices are not detectable unless the base PCI function driver enumerates them and anyway their registers are directly addressable.
> Hence, I thought that the platform driver architecture is inclusive of devices like this.

Sorry, but no.  Again, platform devices are ONLY for actual platform
devices, not "things on a device that happens to be on another bus
device".  Like PCI devices.

That is what the auxiliary bus code was written for, please read
Documentation/driver-api/auxiliary_bus.rst for how to use it.

> Please let me know your comments.
> 
> Also please let me know if I can talk to any of you over a webex call to get clarifications on my further doubts.

Email works best, video chats for every patch review does not scale at
all :)

thanks,

greg k-h
