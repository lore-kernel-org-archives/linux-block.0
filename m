Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C493C4167B
	for <linux-block@archiver.kernel.org>; Wed, 28 Dec 2022 15:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiL1Pv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Dec 2022 10:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiL1PvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Dec 2022 10:51:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EEE186D6
        for <linux-block@vger.kernel.org>; Wed, 28 Dec 2022 07:51:16 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EA5968C7B; Wed, 28 Dec 2022 16:51:12 +0100 (CET)
Date:   Wed, 28 Dec 2022 16:51:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, hch@lst.de,
        martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/2] block: save user max_sectors limit
Message-ID: <20221228155111.GA388@lst.de>
References: <20221227191009.2277326-2-kbusch@meta.com> <202212280931.RDVmPBnX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212280931.RDVmPBnX-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 28, 2022 at 10:04:16AM +0800, kernel test robot wrote:
> >> block/blk-sysfs.c:254:20: warning: comparison of distinct pointer types ('typeof (max_hw_sectors_kb) *' (aka 'unsigned long *') and 'typeof (2560U >> 1) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]

Seems like the local max_sectors_kb variable also needs to be turned
into an unsigned int from the current unsigned long.

And btw, while I'm getting philosophical during my early morning
coffee here, I wonder if we need to actually get rid of or at least
bump BLK_DEF_MAX_SECTORS.  It's pretty ridiculous for modern devices,
and with CDL support that defintion would also include hard drives
eventually.
