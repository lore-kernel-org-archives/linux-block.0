Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2534EC433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJQNmu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQNmt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 09:42:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86295F02F
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 06:42:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE02868BFE; Mon, 17 Oct 2022 15:42:44 +0200 (CEST)
Date:   Mon, 17 Oct 2022 15:42:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017134244.GA24775@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017133906.GA24492@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
> Having to allocate a struct rcu_synchronize for each of the potentially
> many queues here is a bit sad.
> 
> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
> last week, so I wonder if something like that would also be feasible
> for SRCU, as that would come in really handy here.

Alternatively I wonder if we could simply use a single srcu_struct
in the tag_set instead of one per-queue.  That would potentially
increase the number of read side critical sections
blk_mq_wait_quiesce_done would have to wait for in tagsets with
multiple queues, but I wonder how much overhead that would be in
practive.
