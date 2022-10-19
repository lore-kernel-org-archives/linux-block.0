Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD45C433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 07:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJSHZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJSHZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:25:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64505A88C
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:25:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 830AA68C4E; Wed, 19 Oct 2022 09:25:35 +0200 (CEST)
Date:   Wed, 19 Oct 2022 09:25:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221019072535.GA11402@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1> <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590> <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 10:15:26AM +0300, Sagi Grimberg wrote:
> nvme-tcp will opportunistically try a network send directly from
> .queue_rq(), but always with MSG_DONTWAIT, so that is not a problem.
>
> nbd though can block in .queue_rq() with blocking network sends, however
> afaict nbd allocates a tagset per nbd_device, and also a request_queue
> per device, so its effectively the same if the srcu is in the tagset or
> in the request_queue.

Yes, the only multiple request_queue per tag_set cases right now
are nvme-tcp and mmc.  There have been patches from iSCSI, but they
seem to be stuck.
