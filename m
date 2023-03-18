Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1759CC761A6
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 06:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCRGZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 02:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCRGZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 02:25:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EB1C5A9
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 23:25:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F4B268C4E; Sat, 18 Mar 2023 07:25:11 +0100 (CET)
Date:   Sat, 18 Mar 2023 07:25:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] block: Support splitting REQ_OP_ZONE_APPEND bios
Message-ID: <20230318062510.GA24880@lst.de>
References: <20230317195036.1743712-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195036.1743712-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 12:50:35PM -0700, Bart Van Assche wrote:
> Make it easier for filesystems to submit zone append bios that exceed
> the block device limits by adding support for REQ_OP_ZONE_APPEND in
> bio_split(). See also commit 0512a75b98f8 ("block: Introduce
> REQ_OP_ZONE_APPEND").

You can't do that.  ZONE_APPEND reports the written sector in bi_sector,
so it can't be split.

> This patch is a bug fix for commit d5e4377d5051 because that commit
> introduces a call to bio_split() for zone append bios without adding
> support for splitting REQ_OP_ZONE_APPEND bios in bio_split().

That commit never splits ZONE_APPEND bios, and it pre-splits bios
about to become ZONE_APPEND bios specifically using bio_split_rw
instead of bio_split.
