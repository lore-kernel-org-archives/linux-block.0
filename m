Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8A4C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 13:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJUNTo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJUNTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:19:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404D2558E
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:19:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B4CD68B05; Fri, 21 Oct 2022 15:19:33 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:19:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <20221021131932.GA22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-3-hch@lst.de> <Y1HyOS9A72GZIQWT@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HyOS9A72GZIQWT@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 09:13:29AM +0800, Ming Lei wrote:
> > -	blk_mq_wait_quiesce_done(q);
> > +	/* nothing to wait for non-mq queues */
> > +	if (queue_is_mq(q))
> > +		blk_mq_wait_quiesce_done(q);
> 
> This interface can't work as expected for bio drivers, the only user
> should be del_gendisk(), but anyway the patch is fine:

Another one is the wb_lat_usec sysfs attribute.  But maybe it is better
do just do this in the callers and WARN?

