Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA521C7619A
	for <linux-block@archiver.kernel.org>; Sun, 26 Mar 2023 23:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCZXme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Mar 2023 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Mar 2023 19:42:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16B44B4
        for <linux-block@vger.kernel.org>; Sun, 26 Mar 2023 16:42:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 681B768BEB; Mon, 27 Mar 2023 01:42:29 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:42:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Message-ID: <20230326234229.GA20017@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230318062909.GB24880@lst.de> <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org> <20230323082756.GD21977@lst.de> <80988a60-f340-529a-0931-30689599e724@acm.org> <4f48b57f-e8bb-4164-355a-95f5887bac36@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f48b57f-e8bb-4164-355a-95f5887bac36@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 25, 2023 at 11:15:40AM +0900, Damien Le Moal wrote:
> Such standardization effort is likely to face a lot of headwind because
> defining a zone append command for ATA (T13 ACS) is not possible with a
> single self-contained command (as one cannot return the written sector
> using sense data like with scsi).

The same was true for CDL and it got in anyway.  And yes, CDL on ATA
is a complete f**king mess, and needs to be fixed.  So ATA needs to byte
the bullet and extent the FIS anyway, so we might as well get started on
it ASAP.  Fortunately the only implementations that really matter now
are AHCI and SAS expanders, so it sounds very doable to get there.

> And when it comes to ZBC, keeping it in sync with ZAC is desired...

There is so many features in SCSI and not ATA, most notably protection
information that this sounds like a BS argument to me.  That being
said supporting Zone Append and properly doing CDL in ATA would be
very useful.
