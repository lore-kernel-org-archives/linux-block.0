Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7466FC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764D2081C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 13:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeLENr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:47:29 -0500
Received: from verein.lst.de ([213.95.11.211]:50496 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbeLENr3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 08:47:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 87FAB68B03; Wed,  5 Dec 2018 14:47:27 +0100 (CET)
Date:   Wed, 5 Dec 2018 14:47:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel crashes after 529262d56dbe "block: remove ->poll_fn"
Message-ID: <20181205134727.GA26794@lst.de>
References: <0bd2d36e-bef0-b836-7039-124ae4d346a6@virtuozzo.com> <c374e085-a86b-6df3-2142-74968f067bc7@kernel.dk> <5e8d3302-a7d0-3483-6540-f0b87c237f7d@virtuozzo.com> <0e6c1e68-38b0-6618-40cd-a2b72dc4e240@kernel.dk> <a6efd5b2-3190-54e7-ad4c-06f9ac441641@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6efd5b2-3190-54e7-ad4c-06f9ac441641@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05, 2018 at 06:39:26AM -0700, Jens Axboe wrote:
> > What device is this?
> 
> This might also help...

Yes, it should.  I had missed that we turned on QUEUE_FLAG_POLL
by default, which is rather odd.  The even weirder things is that
git-blame claims it was me who enabled it :)

> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 0b3874bdbc6a..81f1b105946b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -606,8 +606,7 @@ struct request_queue {
>  				 (1 << QUEUE_FLAG_ADD_RANDOM))
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> -				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
> -				 (1 << QUEUE_FLAG_POLL))
> +				 (1 << QUEUE_FLAG_SAME_COMP))
>  
>  void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
>  void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
> 
> -- 
> Jens Axboe
---end quoted text---
