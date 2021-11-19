Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD1BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF9D61AA7
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhKSO4F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhKSO4E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 09:56:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E178615E2;
        Fri, 19 Nov 2021 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637333583;
        bh=a6WLrgJ5At75ApGLxwNCqBp4zXbio5sU4DQJ1u+W7Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJ3mRcfP6tO+xSL7Dl9ozHY5vfMOb4grglxa4itdEcphpz8Ndc+32OGSwuJiRPtH+
         UHi6xskn7ETcyFzZAOLCh6y34YiGwsxDDJ76Qzc57rfPUtkXvK+wMkocOe9hYrvMNS
         JqN2tDF4Yc0QAAXJ1ywQpcPv0HXBQ0P5CmUO+dUM=
Date:   Fri, 19 Nov 2021 15:53:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     lee.jones@linaro.org, Pragash.Mangalapandian@microchip.com,
        Sundararaman.H@microchip.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        LakshmiPraveen.Kopparthi@microchip.com, Ronnie.Kunin@microchip.com
Subject: Re: Reg: New MFD Driver for my PCIe Device
Message-ID: <YZe6TPrf4Drh7HpI@kroah.com>
References: <CH0PR11MB5380F5BD18F15014BA8B8479E9919@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YYkEP62JRb4rCuXQ@google.com>
 <YYkGkEiPb+6J62hn@kroah.com>
 <YYkJsbbHH6wdPvB9@google.com>
 <YYkR/szsDirtj1FP@kroah.com>
 <CH0PR11MB5380791976D5837E024D5679E9999@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YZO+KktO3OhDEtlq@kroah.com>
 <CH0PR11MB5380439460BADE102D91C18AE99C9@CH0PR11MB5380.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB5380439460BADE102D91C18AE99C9@CH0PR11MB5380.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 19, 2021 at 09:16:29AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> Dear Greg KH,
> 
> I went through the documentation of aux bus and felt that it would be the correct way to go as you said.
> I will migrate from MFD to aux bus. 
> 
> I have one more architectural question as below.
> I have written the driver such that it enumerates the OTP memory and EEPROM memory as two separate block devices or disks each of size 8KB and this enables me to use the linux dd command with "direct" option to dump the configuration binary onto OTP or EEPROM devices.
> Also, this enables me to use the application like hexedit to view the OTP or EEPROM devices in raw binary format.
> These devices are not based on mtd (memory technology device) architecture as we don't have any erase functionality here.
> Can you please let me know a suitable location in kernel source tree for my block or disk device driver?

So they are a read-only block device?

Why use a block device and not just the "normal" eeprom driver?  Or a
char device node and mmap the memory?

Anyway, no idea where to put them, drivers/misc/ ?

thanks,

greg k-h
