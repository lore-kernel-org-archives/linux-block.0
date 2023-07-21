Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26ABEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 13:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGUNce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGUNcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 09:32:33 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E781711;
        Fri, 21 Jul 2023 06:32:32 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qMqEZ-00024i-03;
        Fri, 21 Jul 2023 13:31:51 +0000
Date:   Fri, 21 Jul 2023 14:31:42 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] block: implement NVMEM provider
Message-ID: <ZLqIvuK2EX2hROJo@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
 <e5b709e15739dc0563e9497a2dbbe63050381db0.1689802933.git.daniel@makrotopia.org>
 <ZLonS7QXLj2lg4Zg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLonS7QXLj2lg4Zg@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 20, 2023 at 11:35:55PM -0700, Christoph Hellwig wrote:
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> > +			      void *val, size_t bytes)
> > +{
> > +	pgoff_t f_index = from >> PAGE_SHIFT;
> > +	struct address_space *mapping;
> > +	struct blk_nvmem *bnv = priv;
> > +	size_t bytes_left = bytes;
> > +	struct folio *folio;
> > +	unsigned long offs, to_read;
> > +	void *p;
> 
> Btw, this function really should be using kern_read on a file
> using filp_open instead of poking into block device internals.

Unfortunately filp_open requires a device inode on a filesystem to be
able to open a block device. What if the root filesystem has not yet
been mounted, or even requires NVMEM (let's say for the Ethernet MAC
address to be known for a nfsroot, nbd or iSCSI to work) to be
available first?

Can you imagine we could implement something like filp_open_bdev which
takes a (struct block_device *) as parameter instead of (const char *)?

That would allow the driver to open and read from the block device
before any filesystems (incl. /dev) become ready.

> That way you can even have a generic file provider that works
> on anything that can be read from.
> 

While this could also be useful, it doesn't fulfil the requirement of
making NVMEM available as early as possible for other drivers to use,
e.g. for the Ethernet MAC address.

And it would also heavily deviate from how things work with other types
of flash storage typically used in embedded Linux devices such as SPI
NOR or NAND flash which is represented as MTD device.

Sidenote: block2mtd is also not an option because one cannot reference
block2mtd devices in device tree, hence they cannot serve as NVMEM
providers.
