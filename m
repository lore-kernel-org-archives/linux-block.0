Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9EBC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 13:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDKNOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjDKNOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 09:14:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA130FE
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 06:14:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1D2068BFE; Tue, 11 Apr 2023 15:14:02 +0200 (CEST)
Date:   Tue, 11 Apr 2023 15:14:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 03/12] block: Send requeued requests to the I/O
 scheduler
Message-ID: <20230411131402.GA16377@lst.de>
References: <20230407235822.1672286-1-bvanassche@acm.org> <20230407235822.1672286-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407235822.1672286-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 07, 2023 at 04:58:13PM -0700, Bart Van Assche wrote:
> +		blk_mq_sched_insert_request(rq, /*at_head=*/true, false, false);

The whole usage of at_head in the request_list-related code looks
suspicious to me.

All callers of blk_mq_add_to_requeue_list except for blk_kick_flush
pass at_head=true.  So the request_list is basically LIFO except for
that one caller.

blk_mq_requeue_work than does a HEAD insert for them, unless they
are marked RQF_DONTPREP because the driver already did some setup.
So except for the RQF_DONTPREP we basically revert the at_head insert.

This all feels wrong to me.  I think we need to get to a point where
the request_list itself is always added to at the tail, processed
head to tail, but inserted into the scheduler or the hctx rq_list
before other pending requests, probaly using similar code as
blk_mq_flush_plug_list / blk_mq_dispatch_plug_list.
