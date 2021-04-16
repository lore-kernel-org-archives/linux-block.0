Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7618CC43460
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596E3610FC
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 14:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhDPOJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:09:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242032AbhDPOIZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 10:08:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17803AF11;
        Fri, 16 Apr 2021 14:08:00 +0000 (UTC)
Subject: Re: [PATCH v2 3/4] nvme: introduce FAILUP handling for
 REQ_FAILFAST_TRANSPORT
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-4-snitzer@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <6185100e-89e6-0a7f-8901-9ce86fe8f1ac@suse.de>
Date:   Fri, 16 Apr 2021 16:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231530.95464-4-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 1:15 AM, Mike Snitzer wrote:
> If REQ_FAILFAST_TRANSPORT is set it means the driver should not retry
> IO that completed with transport errors. REQ_FAILFAST_TRANSPORT is
> set by multipathing software (e.g. dm-multipath) before it issues IO.
> 
> Update NVMe to allow failover of requests marked with either
> REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT. This allows such requests
> to be given a disposition of either FAILOVER or FAILUP respectively.
> FAILUP handling ensures a retryable error is returned up from NVMe.
> 
> Introduce nvme_failup_req() for use in nvme_complete_rq() if
> nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
> the request is completed with a retryable IO error when appropriate.
> __nvme_end_req() was factored out for use by both nvme_end_req() and
> nvme_failup_req().
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4134cf3c7e48..10375197dd53 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -299,6 +299,7 @@ enum nvme_disposition {
>  	COMPLETE,
>  	RETRY,
>  	FAILOVER,
> +	FAILUP,
>  };
>  
>  static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> @@ -318,10 +319,11 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  	    nvme_req(req)->retries >= nvme_max_retries)
>  		return COMPLETE;
>  
> -	if (req->cmd_flags & REQ_NVME_MPATH) {
> +	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
>  		if (nvme_is_path_error(nvme_req(req)->status) ||
>  		    blk_queue_dying(req->q))
> -			return FAILOVER;
> +			return (req->cmd_flags & REQ_NVME_MPATH) ?
> +				FAILOVER : FAILUP;
>  	} else {
>  		if (blk_queue_dying(req->q))
>  			return COMPLETE;
> @@ -330,10 +332,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  	return RETRY;
>  }
>  
> -static inline void nvme_end_req(struct request *req)
> +static inline void __nvme_end_req(struct request *req, blk_status_t status)
>  {
> -	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> -
>  	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>  	    req_op(req) == REQ_OP_ZONE_APPEND)
>  		req->__sector = nvme_lba_to_sect(req->q->queuedata,
> @@ -343,6 +343,24 @@ static inline void nvme_end_req(struct request *req)
>  	blk_mq_end_request(req, status);
>  }
>  
> +static inline void nvme_end_req(struct request *req)
> +{
> +	__nvme_end_req(req, nvme_error_status(nvme_req(req)->status));
> +}
> +
> +static void nvme_failup_req(struct request *req)
> +{
> +	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> +
> +	if (WARN_ON_ONCE(!blk_path_error(status))) {
> +		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
> +			 blk_status_to_errno(status));
> +		status = BLK_STS_IOERR;
> +	}
> +
> +	__nvme_end_req(req, status);
> +}
> +
>  void nvme_complete_rq(struct request *req)
>  {
>  	trace_nvme_complete_rq(req);
> @@ -361,6 +379,9 @@ void nvme_complete_rq(struct request *req)
>  	case FAILOVER:
>  		nvme_failover_req(req);
>  		return;
> +	case FAILUP:
> +		nvme_failup_req(req);
> +		return;
>  	}
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_rq);
> 

Hmm. Quite convoluted, methinks.
Shouldn't this achieve the same thing?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e89ec2522ca6..8c36a2196b66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -303,8 +303,10 @@ static inline enum nvme_disposition
nvme_decide_disposition(struct request *req)
        if (likely(nvme_req(req)->status == 0))
                return COMPLETE;

-       if (blk_noretry_request(req) ||
-           (nvme_req(req)->status & NVME_SC_DNR) ||
+       if (blk_noretry_request(req))
+               nvme_req(req)->status |= NVME_SC_DNR;
+
+       if ((nvme_req(req)->status & NVME_SC_DNR) ||
            nvme_req(req)->retries >= nvme_max_retries)
                return COMPLETE;


Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
