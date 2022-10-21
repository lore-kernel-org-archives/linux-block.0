Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88047C43217
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 13:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJUNMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJUNMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:12:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0150426C1BB
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:12:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AAF7168B05; Fri, 21 Oct 2022 15:11:48 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:11:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Message-ID: <20221021131148.GA21741@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-2-hch@lst.de> <Y1HxM+3bXNpsZvzk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HxM+3bXNpsZvzk@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 09:09:07AM +0800, Ming Lei wrote:
> Just one small issue on mtip32xx, which may call blk_mark_disk_dead() in
> irq context, and ->bd_size_lock is actually not irq safe.
> 
> But mtip32xx is already broken since blk_queue_start_drain() need mutex,
> maybe mtip32xx isn't actively used at all.

A while ago active users were still reported.  But I bet no one
regularly tests hot removals with these cards.

