Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E789C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2556103D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhJLPKg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:10:36 -0400
Received: from verein.lst.de ([213.95.11.211]:41856 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJLPKc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 11:10:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F3FD67373; Tue, 12 Oct 2021 17:08:27 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:08:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue
 quiesce/unquiesce
Message-ID: <20211012150827.GB20571@lst.de>
References: <20211009034713.1489183-1-ming.lei@redhat.com> <20211009034713.1489183-7-ming.lei@redhat.com> <20211012103010.GA29640@lst.de> <YWWki6An1sOpx3rV@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWWki6An1sOpx3rV@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 11:06:51PM +0800, Ming Lei wrote:
> > We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
> > at ->quiesce_depth directly.
> 
> I'd rather not to do that given we need to check QUEUE_FLAG_QUIESCED in fast
> path.

Checking an integer vs checking a bit is easier actually faster or at
least the same speed depending on the architecture / micro architecture.
