Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C070C433E2
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BEE2063A
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgF2Slk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:41:40 -0400
Received: from verein.lst.de ([213.95.11.211]:58786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbgF2Slg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19BC168C4E; Mon, 29 Jun 2020 17:04:38 +0200 (CEST)
Date:   Mon, 29 Jun 2020 17:04:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
Message-ID: <20200629150437.GA25144@lst.de>
References: <20200629094759.2002708-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629094759.2002708-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 05:47:59PM +0800, Ming Lei wrote:
> It is natural to release driver tag when this request is completed by
> LLD or device since its purpose is for LLD use.
> 
> One big benefit is that the released tag can be re-used quicker since
> bio_endio() may take too long.
> 
> Meantime we don't need to release driver tag for flush request.


Reviewed-by: Christoph Hellwig <hch@lst.de>

A bunch of comments on the surrounding code from reviewing it, though:

 - blk_mq_put_driver_tag and __blk_mq_put_driver_tag can and should be
   moved to blk-mq.c and marked static in a follow on patch (and possibly
   merged as well)
 - The rq->internal_tag == BLK_MQ_NO_TAG check in shold probably be
   replaced with a !data->q->elevator check to make it more obvious
   that we are only putting the driver tag for the iosched case
