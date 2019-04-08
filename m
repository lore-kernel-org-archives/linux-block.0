Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134BAC10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E0121473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554740010;
	bh=neE3sd9H/b5kX8gqVFd8rK5mFK9fVue7YlTLzYDx5GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dl1bbWxL1+qJ/73X/5IrBuz4LSyakLM/mH1CrbePo1EAWMPQAgDmlIMuiflYJ3E3N
	 yAinsWgWB7Mcn8gXOdaiKWsulWWafRz5QTDOMTmKWxCdJyi0zsKfntuliu+m6fiNNK
	 BCtPl8COMn5pC0XhSWGHfHI/CEqp/0WFgW+GtUb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDHQNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:13:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:3804 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDHQNa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 12:13:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 09:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="138527002"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2019 09:13:29 -0700
Date:   Mon, 8 Apr 2019 10:15:05 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190408161505.GA32613@localhost.localdomain>
References: <20190408094047.29150-1-ming.lei@redhat.com>
 <20190408094047.29150-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408094047.29150-2-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 05:40:46PM +0800, Ming Lei wrote:
> In NVMe's error handler, follows the typical steps of tearing down
> hardware for recovering controller:
> 
> 1) stop blk_mq hw queues
> 2) stop the real hw queues
> 3) cancel in-flight requests via
> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> cancel_request():
> 	mark the request as abort
> 	blk_mq_complete_request(req);
> 4) destroy real hw queues
> 
> However, there may be race between #3 and #4, because blk_mq_complete_request()
> may run q->mq_ops->complete(rq) remotelly and asynchronously, and
> ->complete(rq) may be run after #4.
> 
> This patch introduces blk_mq_complete_request_sync() for fixing the
> above race.
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-nvme@lists.infradead.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c         | 11 +++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9354835cf51..d8d89f3514ac 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -654,6 +654,17 @@ bool blk_mq_complete_request(struct request *rq)
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
>  
> +bool blk_mq_complete_request_sync(struct request *rq)
> +{
> +	if (unlikely(blk_should_fake_timeout(rq->q)))
> +		return false;
> +
> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +	rq->q->mq_ops->complete(rq);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);

Could we possibly drop the fake timeout in this path? We're using this
in error handling that is past pretending completing requests didn't
happen.

Otherwise this all looks good to me.
