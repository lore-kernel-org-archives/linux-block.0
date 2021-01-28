Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3DC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8C964DD1
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 09:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhA1JVJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 04:21:09 -0500
Received: from verein.lst.de ([213.95.11.211]:56597 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhA1JS1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 04:18:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B835E68B05; Thu, 28 Jan 2021 10:17:45 +0100 (CET)
Date:   Thu, 28 Jan 2021 10:17:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v4 4/8] block: use blk_queue_set_zoned in
 add_partition()
Message-ID: <20210128091745.GC1959@lst.de>
References: <20210128044733.503606-1-damien.lemoal@wdc.com> <20210128044733.503606-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128044733.503606-5-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 28, 2021 at 01:47:29PM +0900, Damien Le Moal wrote:
> When changing the zoned model of host-aware zoned block devices, use
> blk_queue_set_zoned() instead of directly assigning the gendisk queue
> zoned limit.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
