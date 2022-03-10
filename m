Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F62C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 08:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiCJIdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiCJIdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 03:33:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAE05BE58;
        Thu, 10 Mar 2022 00:32:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3EFC468BFE; Thu, 10 Mar 2022 09:32:34 +0100 (CET)
Date:   Thu, 10 Mar 2022 09:32:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com,
        javier@javigon.com, mcgrof@kernel.org, a.manzanares@samsung.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
Message-ID: <20220310083233.GB26614@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com> <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com> <20220308152105.309618-9-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-9-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 08:50:56PM +0530, Kanchan Joshi wrote:
> +/* Unlike blk_rq_map_user () this is only for fixed-buffer async passthrough. */
> +int blk_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
> +		     u64 ubuf, unsigned long len, gfp_t gfp_mask,
> +		     struct io_uring_cmd *ioucmd)
> +{

This doesn't belong into a patch title nvme.  Also please add a proper
kernel-doc comment.

> +EXPORT_SYMBOL(blk_rq_map_user_fixedb);

EXPORT_SYMBOL_GPL, please.

> +static inline bool nvme_is_fixedb_passthru(struct io_uring_cmd *ioucmd)
> +{
> +	return ((ioucmd) && (ioucmd->flags & IO_URING_F_UCMD_FIXEDBUFS));
> +}

No need for the outer and first set of inner braces.

> +
>  static int nvme_submit_user_cmd(struct request_queue *q,
> -		struct nvme_command *cmd, void __user *ubuffer,
> +		struct nvme_command *cmd, u64 ubuffer,
>  		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
>  		u32 meta_seed, u64 *result, unsigned timeout,
>  		struct io_uring_cmd *ioucmd)
> @@ -152,8 +157,12 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>  	nvme_req(req)->flags |= NVME_REQ_USERCMD;
>  
>  	if (ubuffer && bufflen) {
> -		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> -				GFP_KERNEL);
> +		if (likely(nvme_is_fixedb_passthru(ioucmd)))
> +			ret = blk_rq_map_user_fixedb(q, req, ubuffer, bufflen,
> +					GFP_KERNEL, ioucmd);
> +		else
> +			ret = blk_rq_map_user(q, req, NULL, nvme_to_user_ptr(ubuffer),

Overly long line.
