Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6716C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01EC61452
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhGAJzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:55:00 -0400
Received: from verein.lst.de ([213.95.11.211]:47023 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhGAJy7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:54:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 188EF6736F; Thu,  1 Jul 2021 11:52:27 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:52:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <20210701095226.GB2066@lst.de>
References: <20210629074951.1981284-1-ming.lei@redhat.com> <20210629074951.1981284-2-ming.lei@redhat.com> <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com> <YNu7rs7j5/KtQjAi@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNu7rs7j5/KtQjAi@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 08:32:46AM +0800, Ming Lei wrote:
> Indeed, we may replace BLK_MQ_F_STACKING with BLK_MQ_F_NOT_USE_MANAGED_IRQ
> (BLK_MQ_F_NO_MANAGED_IRQ) too, and the latter is one general solution.

And now turn the polarity around and make it a BLK_MQ_F_MANAGED_IRQ set
by the map_queue helpers that rely on managed irqs.
