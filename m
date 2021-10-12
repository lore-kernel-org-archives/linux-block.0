Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B302610A3
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhJLKiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:38:25 -0400
Received: from verein.lst.de ([213.95.11.211]:40869 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236009AbhJLKiY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:38:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6276A67373; Tue, 12 Oct 2021 12:36:20 +0200 (CEST)
Date:   Tue, 12 Oct 2021 12:36:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <20211012103620.GB29640@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com> <20211009034713.1489183-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009034713.1489183-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 09, 2021 at 11:47:11AM +0800, Ming Lei wrote:
> The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> stops and starts the queue unconditionally. And there can be concurrent
> quiesce/unquiesce coming from different unrelated code paths, so
> unquiesce may come unexpectedly and start queue too early.
> 
> Prepare for supporting concurrent quiesce/unquiesce from multiple
> contexts, so that we can address the above issue.
> 
> NVMe has very complicated quiesce/unquiesce use pattern, add one atomic
> bit for makeiing sure that blk-mq quiece/unquiesce is always called in
> pair.

Can you explain the need for these bits a little more?  If they are
unbalanced we should probably fix the root cause.

What issues did you see?
