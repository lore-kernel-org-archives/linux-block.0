Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9234EC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 08:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCWI2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjCWI2D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 04:28:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E631AB
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 01:28:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4484268AA6; Thu, 23 Mar 2023 09:27:57 +0100 (CET)
Date:   Thu, 23 Mar 2023 09:27:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Message-ID: <20230323082756.GD21977@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230318062909.GB24880@lst.de> <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0c7538-1a51-61dd-6359-8c618fde6c1b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 10:22:41AM -0700, Bart Van Assche wrote:
> How to achieve optimal performance with REQ_OP_ZONE_APPEND for SCSI 
> devices? My understanding of how REQ_OP_ZONE_APPEND works for SCSI devices 
> is as follows:
> * ATA devices cannot support this operation directly because there are
>   not enough bits in the ATA sense data to report where appended data
>   has been written.

ATA doesn't really have autosense in the SCSI way.  It could be handled
the same way that CDL completions are handled.  That is a complete
mess, and between CDL and Zone Append we'll probably eventually need
an extended FIS for SATA if we want to keep ATA alive.

> * T10 has not yet started with standardizing a zone append operation.

Time to get it started then!

> * The code that emulates REQ_OP_ZONE_APPEND for SCSI devices (in
>   sd_zbc.c) serializes REQ_OP_ZONE_APPEND operations (QD=1).

Because that's the only thing that actually works.

> * To achieve optimal performance, QD > 1 is required.

If you have something magic that works, this code is the place to take
advantage of it.
