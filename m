Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0120C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB9260E97
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhJLPJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:09:45 -0400
Received: from verein.lst.de ([213.95.11.211]:41849 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJLPJo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 11:09:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D336667373; Tue, 12 Oct 2021 17:07:41 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:07:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <20211012150741.GA20571@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com> <20211009034713.1489183-5-ming.lei@redhat.com> <20211012103620.GB29640@lst.de> <YWWjXN3GEzypVFZ/@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWWjXN3GEzypVFZ/@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 11:01:48PM +0800, Ming Lei wrote:
> There are lots of unbalanced usage in nvme, such as
> 
> 1) nvme pci:
> 
> - nvme_dev_disable() can be called more than one times before starting
> reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().
> 
> 2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
> are never quiesced, and similar usage can be seen in tcp/fc/rdma too
> 
> Once the quiesce and unquiesce are run from difference context, it becomes
> not easy to audit if the two is done in pair.

Yes, but I'm not sure a magic flag is really the solution here.
I think we need to work on our state machine here so that this is less
of a mess.
