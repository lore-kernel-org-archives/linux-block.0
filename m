Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5682CC43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 06:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGVGDs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGVGDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:03:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E202545DC
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:03:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6379968BEB; Fri, 22 Jul 2022 08:03:43 +0200 (CEST)
Date:   Fri, 22 Jul 2022 08:03:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/5] block: fix max_zone_append_sectors inheritance in
 blk_stack_limits
Message-ID: <20220722060342.GB31300@lst.de>
References: <20220720142456.1414262-1-hch@lst.de> <20220720142456.1414262-3-hch@lst.de> <e4bb0162-4280-a8e3-ebbc-9daf428085a4@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4bb0162-4280-a8e3-ebbc-9daf428085a4@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 02:59:30PM +0900, Damien Le Moal wrote:
> Hmmm... Given that max_zone_append_sectors should never be zero for any
> zoned block device, that is OK. However, DM targets combining zoned and
> non-zoned devices to create a non zoned logical drive, e.g. dm-zoned with
> a regular ssd for metadata, should not have a non-zero
> max_zone_append_sectors. So I am not confident this change leads to
> correct limits in all cases.

Good point.

I think we can drop this patch, as I just need to call
blk_set_stacking_limits instead of blk_set_default_limits in the
btrfs code, which should sort all this out.
