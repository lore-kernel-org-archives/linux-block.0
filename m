Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE55EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 07:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGTHKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 03:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjGTHKe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 03:10:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842D272B;
        Thu, 20 Jul 2023 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kbhmn8oR5OOV5tSBbW4U51FnK1m7BQc/34zgRLjEx8c=; b=1BatbgoYaxGUMsm/ICuM2NaTuA
        usabJD6Bep/k/pJH0UL5dnBbCejqVqbafRBrW4zKeYuCzyDz5pPULpcSP2JthxKZsKY1CO6RT84dd
        2dvgvI8CSwdKGJZwDfI2VnuL6bASksfAW5b2w5+mPVMqfz5mV9QPkVi3/MvSEEf7lh8wvgzGlROyi
        37Lw/86YaiM69PNteAGENc1AINpN7I0Eg/3jyrBzzqFUdhI2adH8DYmo9E2Hr1RbTZa73oxQLXW9p
        lLnQ0xcXM3aFjd3CTntqkAog0teBYsTq8dzt3ht6pTjjKim6/BZAsZfDAiNfjrWyHDLpX2FOTYufG
        REDe2+aQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMNmf-00A3ta-0l;
        Thu, 20 Jul 2023 07:09:09 +0000
Date:   Thu, 20 Jul 2023 00:09:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
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
Subject: Re: [RFC PATCH 0/6] nvmem: add block device NVMEM provider
Message-ID: <ZLjdlbf0TXZSZa2t@infradead.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689802933.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 19, 2023 at 11:01:14PM +0100, Daniel Golle wrote:
> This series is meant to open the discussion on how exactly the device tree
> schema for block devices and partitions may look like, and even if using
> the block layer to back the NVMEM device is at all the way to go -- to me
> it seemed to be a good solution because it will be reuable e.g. for NVMe.

If only NVMe did something sane there.  NVMe copied the completely
idiotic idea of boot partitions from eMMC/SD, and made it even worse
by first requiring bit banged register access for them, and now adding
a weird admin command to read them, which is not bound to a block
device.  If we want to support that in NVMe we'll need code in the
nvme core, but I hope we can avoid it and no one sane (that is
everyone but the completely clueless BIOS people at Intel) will never
use this completely fucked up boot partition concept.

