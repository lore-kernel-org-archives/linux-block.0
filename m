Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE5C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D74F20792
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 07:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgG1HTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:19:03 -0400
Received: from verein.lst.de ([213.95.11.211]:47029 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgG1HTD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 03:19:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32BD868B05; Tue, 28 Jul 2020 09:19:00 +0200 (CEST)
Date:   Tue, 28 Jul 2020 09:18:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728071859.GA21629@lst.de>
References: <20200727231022.307602-1-sagi@grimberg.me> <20200727231022.307602-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727231022.307602-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I like the tagset based interface.  But the idea of doing a per-hctx
allocation and wait doesn't seem very scalable.

Paul, do you have any good idea for an interface that waits on
multiple srcu heads?  As far as I can tell we could just have a single
global completion and counter, and each call_srcu would just just
decrement it and then the final one would do the wakeup.  It would just
be great to figure out a way to keep the struct rcu_synchronize and
counter on stack to avoid an allocation.

But if we can't do with an on-stack object I'd much rather just embedd
the rcu_head in the hw_ctx.
