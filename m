Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18669C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B8861042
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhDZOcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:32:31 -0400
Received: from verein.lst.de ([213.95.11.211]:41514 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233803AbhDZOca (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:32:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE78E68C4E; Mon, 26 Apr 2021 16:31:46 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:31:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH 1/2] block: return errors from blk_execute_rq()
Message-ID: <20210426143146.GB19408@lst.de>
References: <20210423215800.40648-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423215800.40648-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 02:57:59PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the errno from the
> completion status.
> 
> Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c       | 6 ++++--
>  include/linux/blkdev.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..3877a2677dd4 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
>  {
>  	struct completion *waiting = rq->end_io_data;
>  
> -	rq->end_io_data = NULL;
> +	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));

I think we should propagate the blk_status_t here as we're entirely inside
the block layer.  I.e. declare a blk_status_t on-stack in blk_execute_rq
and pass a pointer to it in ->end_io_data.

> -extern void blk_execute_rq(struct gendisk *, struct request *, int);
> +extern int blk_execute_rq(struct gendisk *, struct request *, int);

It would be nice to drop the extern here and spell out the argument
names.
