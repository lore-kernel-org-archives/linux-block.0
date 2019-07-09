Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B65C73C46
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 13:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6720861
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 13:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGINhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:37:35 -0400
Received: from verein.lst.de ([213.95.11.211]:42989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINhf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 09:37:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4108A227A81; Tue,  9 Jul 2019 15:37:34 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:37:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH] block: Fix potential overflow in blk_report_zones()
Message-ID: <20190709133734.GB2201@lst.de>
References: <20190709075348.24823-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709075348.24823-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 09, 2019 at 04:53:48PM +0900, Damien Le Moal wrote:
> For large values of the number of zones reported, the sector increment
> calculated with "blk_queue_zone_sectors(q) * n" can overflow the
> unsigned int type used. Fix this with a cast to sector_t type.

How about just returning a sector_t from blk_queue_zone_sectors, turning
this into an automatic implicit cast for all callers?
