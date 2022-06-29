Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B1CCCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 07:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiF2HWn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiF2HWn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 03:22:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D62656F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 00:22:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 57A1367373; Wed, 29 Jun 2022 09:22:39 +0200 (CEST)
Date:   Wed, 29 Jun 2022 09:22:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: move ->ia_ranges from the request_queue to
 the gendisk
Message-ID: <20220629072239.GA20215@lst.de>
References: <20220629062013.1331068-1-hch@lst.de> <20220629062013.1331068-2-hch@lst.de> <36d397c2-3cfd-4872-1baa-f375d50aa6ba@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d397c2-3cfd-4872-1baa-f375d50aa6ba@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 04:08:29PM +0900, Damien Le Moal wrote:
> On 6/29/22 15:20, Christoph Hellwig wrote:
> > Independent access ranges only matter for file system I/O and are only
> > valid with a registered gendisk, so move them there.
> 
> Would this potentially affect the use of ranges in DM ? E.g. exposing a
> dm-linear device targets as ranges. I do not think so but I did not check
> the details.

Device mapper only ever does file system I/O.  Passthrough I/O must
be initiated by the actual driver like scsi or nvme.

