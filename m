Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88BBC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B34420700
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553693495;
	bh=RLKci5b5TzND1HdHtMBBWNbJPHQf0kaZ7lp6u8VIma8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hVe8wY6cdFGN8CNB4oLzKCpCE/u3SlGtowXLX2l74sDHD9zNxRagzT03uvpRSTqWG
	 9YZ9xekBdiYc1rrQANgZdZmMj26DpPxQzY17UONuRLoY+A1yfseCESoCsIQ05kftrY
	 GV7G+n2uvmqgR6lUNK5wnQJvmv4VpbOBLxZbVswM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfC0Nbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:31:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:40692 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfC0Nbe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 09:31:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 06:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="218020352"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2019 06:31:33 -0700
Date:   Wed, 27 Mar 2019 07:32:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190327133244.GA8448@localhost.localdomain>
References: <20190327085114.12111-1-ming.lei@redhat.com>
 <20190327085114.12111-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327085114.12111-2-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 04:51:13PM +0800, Ming Lei wrote:
> @@ -594,8 +594,11 @@ static void __blk_mq_complete_request(struct request *rq)
>  	/*
>  	 * For a polled request, always complete locallly, it's pointless
>  	 * to redirect the completion.
> +	 *
> +	 * If driver requires to complete the request synchronously,
> +	 * complete it locally, and it is usually done in error handler.
>  	 */
> -	if ((rq->cmd_flags & REQ_HIPRI) ||
> +	if ((rq->cmd_flags & REQ_HIPRI) || sync ||
>  	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
>  		q->mq_ops->complete(rq);
>  		return;

I think this is fine and agree this is fixing a problem, but just
considering an alternative: would it be okay to just temporarily clear
QUEUE_FLAG_SAME_COMP in the necessary error handling that wants a sync
completion so that we're not introducing an additional parameter?
