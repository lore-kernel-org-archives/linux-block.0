Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172DFC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEED213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEED213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeK3ESF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:18:05 -0500
Received: from verein.lst.de ([213.95.11.211]:44831 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbeK3ESE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:18:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A22C568B02; Thu, 29 Nov 2018 18:11:59 +0100 (CET)
Date:   Thu, 29 Nov 2018 18:11:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
Message-ID: <20181129171159.GA28238@lst.de>
References: <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk> <20181128021959.GG11128@ming.t460p> <20181128070010.GA20369@lst.de> <20181128100659.GA16495@ming.t460p> <20181128100848.GA23567@lst.de> <20181128154927.GE6401@localhost.localdomain> <ddc31c4c-5d5f-c5ca-67bf-33acdd03ed54@kernel.dk> <20181128162655.GF6401@localhost.localdomain> <20181128223146.GH6401@localhost.localdomain> <20181128233629.GA8332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128233629.GA8332@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a82830f39933..d0ef540711c7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -647,7 +647,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
>  
>  int blk_mq_request_started(struct request *rq)
>  {
> -	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
> +	return blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT;
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_request_started);

Independ of this series this change looks like the right thing to do.
But this whole area is a mine field, so separate testing would be
very helpful.

I also wonder why we even bother with the above helper, a direct
state comparism seems a lot more obvious to the reader.

Last but not least the blk_mq_request_started check in nbd
should probably be lifted into blk_mq_tag_to_rq while we're at it..

As for the nvme issue - it seems to me like we need to decouple the
nvme loop frontend request from the target backend request.  In case
of a timeout/reset we'll complete struct request like all other nvme
transport drivers, but we leave the backend target state around, which
will be freed when it completes (or leaks when the completion is lost).
