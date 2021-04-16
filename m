Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB5C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 348926117A
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 14:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhDPOB1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:01:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235196AbhDPOB0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 10:01:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0484EB12D;
        Fri, 16 Apr 2021 14:01:01 +0000 (UTC)
To:     Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-3-snitzer@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v2 2/4] nvme: allow local retry for requests with
 REQ_FAILFAST_TRANSPORT set
Message-ID: <da184561-2c97-5807-5c5b-9cc6593693c6@suse.de>
Date:   Fri, 16 Apr 2021 16:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231530.95464-3-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 1:15 AM, Mike Snitzer wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> REQ_FAILFAST_TRANSPORT was designed for SCSI, because the SCSI protocol
> does not define the local retry mechanism. SCSI implements a fuzzy
> local retry mechanism, so REQ_FAILFAST_TRANSPORT is needed to allow
> higher-level multipathing software to perform failover/retry.
> 
> NVMe is different with SCSI about this. It defines a local retry
> mechanism and path error codes, so NVMe should retry local for non
> path error. If path related error, whether to retry and how to retry
> is still determined by higher-level multipathing's failover.
> 
> Unlike SCSI, NVMe shouldn't prevent retry if REQ_FAILFAST_TRANSPORT
> because NVMe's local retry is needed -- as is NVMe specific logic to
> categorize whether an error is path related.
> 
> In this way, the mechanism of NVMe multipath or other multipath are
> now equivalent. The mechanism is: non path related error will be
> retried locally, path related error is handled by multipath.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [snitzer: edited header for grammar and clarity, also added code comment]
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/nvme/host/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 540d6fd8ffef..4134cf3c7e48 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -306,7 +306,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>  	if (likely(nvme_req(req)->status == 0))
>  		return COMPLETE;
>  
> -	if (blk_noretry_request(req) ||
> +	/*
> +	 * REQ_FAILFAST_TRANSPORT is set by upper layer software that
> +	 * handles multipathing. Unlike SCSI, NVMe's error handling was
> +	 * specifically designed to handle local retry for non-path errors.
> +	 * As such, allow NVMe's local retry mechanism to be used for
> +	 * requests marked with REQ_FAILFAST_TRANSPORT.
> +	 */
> +	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
>  	    (nvme_req(req)->status & NVME_SC_DNR) ||
>  	    nvme_req(req)->retries >= nvme_max_retries)
>  		return COMPLETE;
> 
Huh?

#define blk_noretry_request(rq) \
        ((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
                             REQ_FAILFAST_DRIVER))

making the only _actual_ change in your patch _not_ evaluating the
REQ_FAILFAST_DRIVER, which incidentally is only used by the NVMe core.
So what is it you're trying to solve?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
