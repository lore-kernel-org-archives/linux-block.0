Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA6C77B6C
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjDMGOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMGOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:14:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB825B9E
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:14:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE1876732D; Thu, 13 Apr 2023 08:14:28 +0200 (CEST)
Date:   Thu, 13 Apr 2023 08:14:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 08/18] blk-mq: fold __blk_mq_insert_req_list into
 blk_mq_insert_request
Message-ID: <20230413061428.GB15376@lst.de>
References: <20230412053248.601961-1-hch@lst.de> <20230412053248.601961-9-hch@lst.de> <fd0e02c6-8fbb-cb7b-4925-331c132aeb7a@kernel.org> <20230412072009.GA21504@lst.de> <d95970c1-1fea-7e35-e29b-6013d2ba42e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95970c1-1fea-7e35-e29b-6013d2ba42e1@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 12, 2023 at 04:33:04PM +0900, Damien Le Moal wrote:
> I am not worried about the values shown by the trace entries, but rather the
> order of the inserts: with the trace call outside the lock, the trace may end up
> showing an incorrect insertion order ?

... turns out none of the other calls to trace_block_rq_insert is
under ctx->lock either.  The I/O scheduler ones are under their
own per-request_queue locks, so maybe that counts as ordering,
but blk_mq_insert_requests doesn't lock at all.
