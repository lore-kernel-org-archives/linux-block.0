Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1334C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDLHUW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDLHUW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:20:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FE4225
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:20:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61E1868AA6; Wed, 12 Apr 2023 09:20:10 +0200 (CEST)
Date:   Wed, 12 Apr 2023 09:20:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 08/18] blk-mq: fold __blk_mq_insert_req_list into
 blk_mq_insert_request
Message-ID: <20230412072009.GA21504@lst.de>
References: <20230412053248.601961-1-hch@lst.de> <20230412053248.601961-9-hch@lst.de> <fd0e02c6-8fbb-cb7b-4925-331c132aeb7a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd0e02c6-8fbb-cb7b-4925-331c132aeb7a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 12, 2023 at 04:16:36PM +0900, Damien Le Moal wrote:
> >  	} else {
> > +		trace_block_rq_insert(rq);
> 
> Shouldn't we keep the trace call under ctx->lock to preserve precise tracing ?

ctx->lock doesn't synchronize any of the in the request that is traced
here.
