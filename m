Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B89C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 09:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B9661450
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 09:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhD2JrI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:47:08 -0400
Received: from verein.lst.de ([213.95.11.211]:52491 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhD2JrI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 05:47:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D725A67373; Thu, 29 Apr 2021 11:46:18 +0200 (CEST)
Date:   Thu, 29 Apr 2021 11:46:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
Message-ID: <20210429094618.GA15311@lst.de>
References: <20210427161619.1294399-1-hch@lst.de> <20210427161619.1294399-15-hch@lst.de> <YIjJRiyA26gELV+d@T590> <20210429072737.GA3873@lst.de> <YIpiS0d1NeoX6p0H@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIpiS0d1NeoX6p0H@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 29, 2021 at 03:37:47PM +0800, Ming Lei wrote:
> > > BLK_MQ_F_BLOCKING is set for nvme-tcp, and the blocking may be done inside
> > > nvme_ns_head_submit_bio(), is that one problem?
> > 
> > The point of BLK_MQ_F_BLOCKING is that ->queue_rq can block, and
> > because of that it is not called from the submitting context but in
> > a work queue.  nvme-tcp also sets QUEUE_FLAG_NOWAIT, just like all blk-mq
> > drivers.
> 
> BLK_MQ_F_BLOCKING can be called from submitting context, see
> blk_mq_try_issue_directly().

The all drivers setting it have a problem, as the blk-mq core sets
BLK_MQ_F_BLOCKING for all of them.  The right fix would be to not make
it block for REQ_NOWAIT I/O..
