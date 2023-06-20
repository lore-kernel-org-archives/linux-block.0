Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B397EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 05:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFTFls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 01:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjFTFlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 01:41:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053DDC
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 22:41:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84ABD68AA6; Tue, 20 Jun 2023 07:41:41 +0200 (CEST)
Date:   Tue, 20 Jun 2023 07:41:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <20230620054141.GA12626@lst.de>
References: <20230615143236.297456-1-ming.lei@redhat.com> <20230615143236.297456-2-ming.lei@redhat.com> <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com> <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com> <20230616054800.GA28499@lst.de> <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 03:20:38PM +0800, Ming Lei wrote:
> > > GD_DEAD is only set if the device is really dead, then all pending IO
> > > will be failed.
> > 
> > del_gendisk also sets GD_DEAD early on.
> 
> No.
> 
> The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
> bio_queue_enter().

IFF we know we can't do I/O by the time del_gendisk is called, we
need to call mark_disk_dead first and not paper over the problem.

An API that force unfreezes is just broken and will leaves us with
freezecount mismatches.
