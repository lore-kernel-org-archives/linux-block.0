Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF53C4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 14:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8D960FEB
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 14:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFWOnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 10:43:53 -0400
Received: from verein.lst.de ([213.95.11.211]:51113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhFWOnv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 10:43:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 06FD867373; Wed, 23 Jun 2021 16:41:31 +0200 (CEST)
Date:   Wed, 23 Jun 2021 16:41:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: loop cleanups
Message-ID: <20210623144130.GA738@lst.de>
References: <20210621101547.3764003-1-hch@lst.de> <48fc3b1d-37b2-3f1f-3b2d-63a5711491bd@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48fc3b1d-37b2-3f1f-3b2d-63a5711491bd@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 08:15:27PM +0900, Tetsuo Handa wrote:
> On 2021/06/21 19:15, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series contains a bunch of cleanups for the loop driver,
> > mostly related to probing and the control device.
> > 
> 
> Please fold
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a4a5466b998f..6c10400d4d38 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2163,8 +2163,9 @@ static int loop_add(int i)
>  	disk->queue		= lo->lo_queue;
>  	sprintf(disk->disk_name, "loop%d", i);
>  	add_disk(disk);
> +	err = lo->lo_number;
>  	mutex_unlock(&loop_ctl_mutex);
> -	return lo->lo_number;
> +	return err;
>  
>  out_free_queue:
>  	blk_cleanup_queue(lo->lo_queue);
> @@ -2253,8 +2254,9 @@ static int loop_control_get_free(int idx)
>  	mutex_unlock(&loop_ctl_mutex);
>  	return loop_add(-1);
>  found:
> +	ret = lo->lo_number;
>  	mutex_unlock(&loop_ctl_mutex);
> -	return lo->lo_number;
> +	return ret;
>  }

Good find.  But we already have local variables holding the index
in both functions, so we can just use those.

> By the way, how can we fix a regression introduced by commit 6cc8e7430801fa23
> ("loop: scale loop device by introducing per device lock") ?
> Conditionally holding global lock like below untested diff?

It would be nice to factor the global locking into helpers, but otherwise
this looks ok.  Maybe also rename loop_configure_mutex into
loop_validate_mutex
