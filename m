Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A9C2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B920786
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 18:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKCSYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:24:49 -0500
Received: from verein.lst.de ([213.95.11.211]:38568 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCSYs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 13:24:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 845016736F; Tue,  3 Nov 2020 19:24:44 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:24:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com
Subject: Re: [PATCH V3 2/6] nvme-core: split nvme_alloc_request()
Message-ID: <20201103182444.GA23300@lst.de>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com> <20201022010234.8304-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022010234.8304-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 21, 2020 at 06:02:30PM -0700, Chaitanya Kulkarni wrote:
> +static inline unsigned int nvme_req_op(struct nvme_command *cmd)
> +{
> +	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
> +}

Why is this added here while nvme_init_req_from_cmd is added in a prep
patch?  I'm actually fine either way, but doing it differnetly for the
different helpers is a little inconsistent.

> +
> +struct request *nvme_alloc_request_qid_any(struct request_queue *q,
> +		struct nvme_command *cmd, blk_mq_req_flags_t flags)

I'd call this just nvme_alloc_request to keep the short name for the
normal use case.

> +	struct request *req;
> +
> +	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
> +	if (unlikely(IS_ERR(req)))
> +		return req;
> +
> +	nvme_init_req_from_cmd(req, cmd);
> +	return req;

Could be simplified to:

	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
	if (!IS_ERR(req))
		nvme_init_req_from_cmd(req, cmd);
	return req;

Note that IS_ERR already contains an embedded unlikely().

> +static struct request *nvme_alloc_request_qid(struct request_queue *q,
>  		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
>  {
>  	struct request *req;
>  
> +	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
> +			qid ? qid - 1 : 0);
>  	if (IS_ERR(req))
>  		return req;
>  
>  	nvme_init_req_from_cmd(req, cmd);
>  	return req;

Same here.

>  }
> -EXPORT_SYMBOL_GPL(nvme_alloc_request);

I think nvme_alloc_request_qid needs to be exported as well.

FYI, this also doesn't apply to the current nvme-5.10 tree any more.
