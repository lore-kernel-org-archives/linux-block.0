Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14126EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 11:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGULLh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGULLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 07:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF23A92;
        Fri, 21 Jul 2023 04:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73246618E5;
        Fri, 21 Jul 2023 11:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F39C433C8;
        Fri, 21 Jul 2023 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689937811;
        bh=myaPf1oyhAil/xlKJLpDYHkXcaR6WPBFmD+B4wkU+kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQ9XT91I62CH2cogbMjmf8eDfG6SRipgBPNykRuxTWkN75Ln4SmW914w52lOO540A
         8n4Q3BDqaLkQV+sXhj3uZJ3Hr2RZtUq+ud0mjkGmfQVOEZSnH/YBlebfT7DZXwYVvA
         H8hWIss+8QUC2XC5OJJk32DECJHj2l0W4VGXAn/s=
Date:   Fri, 21 Jul 2023 13:10:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] nvmem: add block device NVMEM provider
Message-ID: <2023072118-flyable-aspect-060f@gregkh>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <ZLpCscTMc8h16Tyd@ovpn-8-26.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpCscTMc8h16Tyd@ovpn-8-26.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 21, 2023 at 04:32:49PM +0800, Ming Lei wrote:
> On Wed, Jul 19, 2023 at 11:01:14PM +0100, Daniel Golle wrote:
> > On embedded devices using an eMMC it is common that one or more (hw/sw)
> > partitions on the eMMC are used to store MAC addresses and Wi-Fi
> > calibration EEPROM data.
> > 
> > Implement an NVMEM provider backed by block devices as typically the
> > NVMEM framework is used to have kernel drivers read and use binary data
> > from EEPROMs, efuses, flash memory (MTD), ...
> > 
> > In order to be able to reference hardware partitions on an eMMC, add code
> > to bind each hardware partition to a specific firmware subnode.
> > 
> > This series is meant to open the discussion on how exactly the device tree
> > schema for block devices and partitions may look like, and even if using
> > the block layer to back the NVMEM device is at all the way to go -- to me
> > it seemed to be a good solution because it will be reuable e.g. for NVMe.
> 
> Just wondering why you don't use request_firmware() in drivers which consume
> the data, then the logic can be moved out of kernel, and you needn't to deal
> with device tree & block device.
> 
> Or Android doesn't support udev and initrd?

It does support initrd, but not really udev last I looked.

But it does allow request_firmware() to be called at boot time, so yes,
finding out why that isn't used here would be good.

thanks,

greg k-h
