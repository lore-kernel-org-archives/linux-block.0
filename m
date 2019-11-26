Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330DC432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C418D20722
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574784354;
	bh=B7xnvXOa92BwBxjpFV+X9M2ewk2oriqIb18JEy/bGxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=On7EKIa94jYTHqbBPeKqJGMTYL1uzPM61ZkO9sYAVUt2+QKUllb/LgKhC2f9NIHM1
	 XfkgV33vtSAykYRSyFUphMdakJHdzxa4zhp9CTkeJJRSVjBhRl0TWqZ8PZ0zqjp9pH
	 1JUCh5K7vsddz43YB5mZGekQic9rVGXnlCske5/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfKZQFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfKZQFy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 11:05:54 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318E82071E;
        Tue, 26 Nov 2019 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574784353;
        bh=B7xnvXOa92BwBxjpFV+X9M2ewk2oriqIb18JEy/bGxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJ1JFkTn6UqyCfSvU3YbkF3xASiFmw3NztZbpw3CAYKmKPGiUveGytES/tjx+ewQp
         3G7MmPYeeXzrXjFioUPWdMYiDXdV+Rb9GS8k6Cl8onpzmL+1YaHdu2SZM6wf/J7tcq
         LTXG2ru8XmYPosxPxsOtPDMu212JP6Frq1UdPwtI=
Date:   Wed, 27 Nov 2019 01:05:46 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, John Meneghini <johnm@netapp.com>,
        Jen Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
Message-ID: <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
References: <20191126133650.72196-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126133650.72196-1-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[cc'ing linux-block, Jens]

On Tue, Nov 26, 2019 at 02:36:50PM +0100, Hannes Reinecke wrote:
> This patch fixes a bug in nvme_complete_rq logic introduced by
> Enhanced Command Retry code. According to TP-4033 the controller
> only sets CDR when the Command Interrupted status is returned.
> The current code interprets Command Interrupted status as a
> BLK_STS_IOERR, which results in a controller reset if
> REQ_NVME_MPATH is set.

I see that Command Interrupted status requires ACRE enabled, but I don't
see the TP saying that the CQE CRD fields are used only with that status
code. I'm pretty sure I've seen it used for Namespace Not Ready status
as well. That would also fail MPATH for the same reason as this new
status...

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 108f60b46804..752a40daf2b3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -201,6 +201,8 @@ static blk_status_t nvme_error_status(u16 status)
>  	switch (status & 0x7ff) {
>  	case NVME_SC_SUCCESS:
>  		return BLK_STS_OK;
> +	case NVME_SC_COMMAND_INTERRUPTED:
> +		return BLK_STS_RESOURCE;
>  	case NVME_SC_CAP_EXCEEDED:
>  		return BLK_STS_NOSPC;
>  	case NVME_SC_LBA_RANGE:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index d688b96d1d63..3a0d84528325 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t error)
>  	case BLK_STS_NEXUS:
>  	case BLK_STS_MEDIUM:
>  	case BLK_STS_PROTECTION:
> +	case BLK_STS_RESOURCE:
>  		return false;
>  	}

I agree we need to make this status a non-path error, but we at least
need an Ack from Jens or have this patch go through linux-block if we're
changing BLK_STS_RESOURCE to mean a non-path error.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index f61d6906e59d..6b21f3888cad 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1292,6 +1292,8 @@ enum {
>  
>  	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
>  
> +	NVME_SC_COMMAND_INTERRUPTED	= 0x21,

This command status was actually already defined in commit
48c9e85b23464, though with a slightly different name.
