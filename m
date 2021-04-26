Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEAC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2FA61164
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 14:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhDZOnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 10:43:05 -0400
Received: from verein.lst.de ([213.95.11.211]:41580 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233471AbhDZOnF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:43:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D24C068C4E; Mon, 26 Apr 2021 16:42:17 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:42:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
Message-ID: <20210426144216.GD20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 03:05:57PM -0700, Keith Busch wrote:
> We don't have an nvme status to report if the driver's .queue_rq()
> returns an error without dispatching the requested nvme command. Use the
> return value from blk_execute_rq() for all passthrough commands so the
> caller may know their command was not successful.
> 
> If the command is from the target passthrough interface and fails to
> dispatch, synthesize the response back to the host as a internal target
> error.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c       | 16 ++++++++++++----
>  drivers/nvme/host/ioctl.c      |  6 +-----
>  drivers/nvme/host/nvme.h       |  2 +-
>  drivers/nvme/target/passthru.c |  8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 10bb8406e067..62af5fe7a0ce 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  			goto out;
>  	}
>  
> -	blk_execute_rq(NULL, req, at_head);
> +	ret = blk_execute_rq(NULL, req, at_head);
>  	if (result)
>  		*result = nvme_req(req)->result;
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>  		ret = -EINTR;
> -	else
> +	else if (nvme_req(req)->status)
>  		ret = nvme_req(req)->status;

Just cosmetic, and already in the existing code, but I'd prefer if we
could keep the ret assignments together, something like:

	status = blk_execute_rq(NULL, req, at_head);
  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
	else if (nvme_req(req)->status)
		ret = nvme_req(req)->status;
	else
		ret = blk_status_to_errno(status);

 	if (result)
 		*result = nvme_req(req)->result;

> +	ret = blk_execute_rq(disk, rq, 0);
>  	if (effects) /* nothing to be done for zero cmd effects */
>  		nvme_passthru_end(ctrl, effects);
> +
> +	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
> +		ret = -EINTR;
> +	else if (nvme_req(rq)->status)
> +		ret = nvme_req(rq)->status;
> +

I think we want a helper for all this return value magic instead of
duplicating it.
