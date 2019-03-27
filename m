Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36BFC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BF92087E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 00:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553645031;
	bh=nCnqtOpGfDBmPCIcZQZJQCDa7AXUZ58008r2BPqSplw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WfEIIXdKnoogpu2nREH5+BF4T7kTHn5DWHwquyqsgGMDhoyclnWqYkFnjcfS+caWI
	 4xstxXXwFyPxo5uLCDHpmqtcobcnnXrS84KZsuHja9dotHMtVtYxnXvHe+Xk8hAi8W
	 2dzT7Lz7uThK+0xOnnwtO5xm04z7xsD3irH/h5yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfC0ADu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:03:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:13970 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbfC0ADu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 20:03:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 17:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="155493076"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2019 17:03:49 -0700
Date:   Tue, 26 Mar 2019 18:05:00 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
Message-ID: <20190327000500.GD4328@localhost.localdomain>
References: <20190326120712.41657-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326120712.41657-1-hare@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 26, 2019 at 01:07:12PM +0100, Hannes Reinecke wrote:
> When a queue is dying or dead there is no point in calling
> blk_mq_run_hw_queues() in blk_mq_unquiesce_queue(); in fact, doing
> so might crash the machine as the queue structures are in the
> process of being deleted.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c181603cbd..b1eeba38bc79 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -258,7 +258,8 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>  	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>  
>  	/* dispatch requests which are inserted during quiescing */
> -	blk_mq_run_hw_queues(q, true);
> +	if (!blk_queue_dying(q) && !blk_queue_dead(q))
> +		blk_mq_run_hw_queues(q, true);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);

We actually still have to unquieces the queue to flush entered requests to
a failed completion after killing that queue, like in nvme_set_queue_dying().
