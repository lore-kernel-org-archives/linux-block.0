Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E943C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4695320823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLTbinaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4695320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeKSTVP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:21:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeKSTVP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 14:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C9EBn/npVuPiYxeMHCBFKi7NQeM9Vn4qO/S4Q+Wg4IY=; b=JLTbinaNQWYJWkdew8/qUHATH
        f2h5Rq6EB1N1NBv6rzUWGM7KCZMN4alVcbYXmBPG3xsFToV47MlqDjV8SiTABD0sIiZYCFOu0lQtk
        HklZlyROnjUqzf6892sT6ZDJnLUk9aVhRrY7moSWnq5wNQFFXHypHSRSEiBNS83v17Zfa8srnHtcf
        mxHPtC9EGuhMkZWl9JDnXMFv6QVHJVJS3XN3J1LOwaR/ifQCxxwgM6MvuTtsat16o1SdujbIzkDzy
        q8rumJ4mZcxYaBkD6g5Bqe8kK2C3yCFUkCtbNPW2JEz8rA6ONr0WG/a2nji93dk7YRhe2pF8e0Pns
        o6/NTKVDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOfNn-0000G8-N6; Mon, 19 Nov 2018 08:58:15 +0000
Date:   Mon, 19 Nov 2018 00:58:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
Message-ID: <20181119085815.GB29626@infradead.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115175820.13391-3-keith.busch@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> index 5d83a162d03b..c1d5e4e36125 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
>  
>  static void scsi_mq_done(struct scsi_cmnd *cmd)
>  {
> +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
> +		return;
>  	trace_scsi_dispatch_cmd_done(cmd);
> -	blk_mq_complete_request(cmd->request);
> +	if (unlikely(!blk_mq_complete_request(cmd->request)))
> +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
>  }

This looks a little odd to me.  If we didn't complete the command
someone else did.  Why would we clear the bit in this case?

>  static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
> @@ -1701,6 +1704,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			goto out_dec_host_busy;
>  		req->rq_flags |= RQF_DONTPREP;
>  	} else {
> +		cmd->flags &= ~SCMD_COMPLETE;
>  		blk_mq_start_request(req);
>  	}
>  
> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index d6fd2aba0380..ded7c7194a28 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -58,6 +58,9 @@ struct scsi_pointer {
>  #define SCMD_TAGGED		(1 << 0)
>  #define SCMD_UNCHECKED_ISA_DMA	(1 << 1)
>  #define SCMD_INITIALIZED	(1 << 2)
> +
> +#define __SCMD_COMPLETE		3
> +#define SCMD_COMPLETE		(1 << __SCMD_COMPLETE)

This mixing of atomic and non-atomic bitops looks rather dangerous
to me.  Can you add a new atomic_flags just for the completed flag,
and always use the bitops on it for now? I think we can eventually
kill most of the existing flags except for SCMD_TAGGED over the
next merge window or two and then move that over as well.

Otherwise the concept looks fine to me.
