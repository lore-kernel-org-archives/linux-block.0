Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA0CA9EAB
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A390121928
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 03:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfJUDoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:44:17 -0400
Received: from verein.lst.de ([213.95.11.211]:56448 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfJUDoR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 23:44:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25A0568BE1; Mon, 21 Oct 2019 05:44:15 +0200 (CEST)
Date:   Mon, 21 Oct 2019 05:44:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2 v2] nvme: Cleanup and rename nvme_block_nr()
Message-ID: <20191021034414.GA11888@lst.de>
References: <20191021034004.11063-1-damien.lemoal@wdc.com> <20191021034004.11063-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021034004.11063-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 12:40:03PM +0900, Damien Le Moal wrote:
> Rename nvme_block_nr() to nvme_sect_to_lba() and use SECTOR_SHIFT
> instead of its hard coded value 9. Also add a comment to decribe this
> helper.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
