Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E8C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12B6214DE
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVXhd/3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbfIFPwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:52:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43565 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393058AbfIFPwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 11:52:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so4755958pfo.10
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=is5TM2fD9RZzPE+IWHSxSuXojz8aQOvYKFWgricphkw=;
        b=MVXhd/3StMjYtn/U+4Xf+PSA43MP/9J74/eLlHmOpaCOFwwmwMpdQKfv93tvuh1BLY
         aRI59PXcxEYAIehJiR+JqV1Jl7SD4L0VhPPpBs3XzOPL/ek6EMNn0etZzHL8AJfjrim5
         QlRG/o/4C/oEJW/rRXxOF20ipzj8sUXEVbN2BABkzUR2zUqluVbpY+BbNcnvwQIq+nJ9
         6GODQSWddAKeliJhN+/NK1P/Wx/SCmAiBPbv5C1DsqrnDW0X/6DV8r5W/G9nNfpLKSQp
         NPodTSlnJeXdyZ5MonuQKcwPmDjNZatAbIfTtul6HGsGhGffbbZi58ogD3yyWkUdlJuq
         kUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=is5TM2fD9RZzPE+IWHSxSuXojz8aQOvYKFWgricphkw=;
        b=rNYBAf9Aw/WmNC58g7SN82JX9ohOj5nHkqhMph5NUwfOxuU5RH4bpWQ7zzrnStlXoj
         HE9Tv3QKVce3Ih/eweTALwy7p12vVRWyeyXaTJeOG8U8hloYnviaBSFVeZLiIlwGaIVo
         qSlL6oyRBhM5RPCsVgmaQB1Wh1YLTlaKhZNaz975wD6FnBtxiFieQhgA0ZXE5vba3IhQ
         jRAgLiqRK8cDyvPVBzZzQrC3rV5zVn09EgVpwjUVIEBsoz1LWZB59YRuVYTmFzrpEgle
         JN+JzcG1dKito+EJiQu6eGWRCIFXRtqkZsXoRY6Z+f9l8O5mq6syiDCY92RsoyU5aKan
         hAcw==
X-Gm-Message-State: APjAAAXNp9VR+JBJWYusJQsd2ct/pByjotUclCm4mGjM2rj0217420wL
        x2MumrDjuydQMU/Mfx9Fz8c=
X-Google-Smtp-Source: APXvYqybUgEmDG/NmYfiiwpiEnVQorzO5eIwAhzsFPtHhxc1+pCgv5CRm30nU1IB3etF3J3xhooLLA==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr10526228pjq.102.1567785168691;
        Fri, 06 Sep 2019 08:52:48 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id v5sm727246pfv.76.2019.09.06.08.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 08:52:47 -0700 (PDT)
Date:   Sat, 7 Sep 2019 00:52:45 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] block: centralize PI remapping logic to the block
 layer
Message-ID: <20190906155245.GA8113@minwoo-desktop>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-09-05 19:43:54, Max Gurtovoy wrote:
> Currently dif_prepare/dif_complete functions are called during the

Maybe nicer if:
	s/dif_prepare\/dif_complete/t10_pi_prepare\/t10_pi_complete

> NVMe and SCSi layers command preparetion/completion, but their actual
> place should be the block layer since T10-PI is a general data integrity
> feature that is used by block storage protocols.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
> 
> changes from v2:
>  - remove local variable for protection_type
>  - remove remapping between NVMe T10 definition to blk definition
>  - added patches 2/3 and 3/3
>  - remove pi_type from ns structure
> 
> changes from v1:
>  - seperate from nvme_cleanup command patches
>  - introduce blk_integrity_interval_shift to avoid div in fast path
> 
> ---
>  block/blk-core.c         |  5 +++++
>  block/blk-mq.c           |  4 ++++
>  block/blk-settings.c     |  1 +
>  block/t10-pi.c           | 16 ++++++----------
>  drivers/nvme/host/core.c | 27 ++++++++++-----------------
>  drivers/nvme/host/nvme.h |  1 -
>  drivers/scsi/sd.c        | 28 ++++++++++------------------
>  drivers/scsi/sd.h        |  1 -
>  drivers/scsi/sd_dif.c    |  2 +-
>  include/linux/blkdev.h   | 12 ++++++++++++
>  include/linux/genhd.h    |  1 +
>  include/linux/t10-pi.h   | 10 ++++------
>  12 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d0cc6e1..eda33f9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/t10-pi.h>
>  #include <linux/debugfs.h>
>  #include <linux/bpf.h>
>  
> @@ -1405,6 +1406,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  	if (!req->bio)
>  		return false;
>  
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req, nr_bytes);
> +
>  	if (unlikely(error && !blk_rq_is_passthrough(req) &&
>  		     !(req->rq_flags & RQF_QUIET)))
>  		print_req_error(req, error, __func__);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0835f4d..30ec078 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -30,6 +30,7 @@
>  #include <trace/events/block.h>
>  
>  #include <linux/blk-mq.h>
> +#include <linux/t10-pi.h>
>  #include "blk.h"
>  #include "blk-mq.h"
>  #include "blk-mq-debugfs.h"
> @@ -693,6 +694,9 @@ void blk_mq_start_request(struct request *rq)
>  		 */
>  		rq->nr_phys_segments++;
>  	}
> +
> +	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
> +		t10_pi_prepare(rq);
>  }
>  EXPORT_SYMBOL(blk_mq_start_request);
>  
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 2c18312..8183ffc 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -330,6 +330,7 @@ void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
>  void blk_queue_logical_block_size(struct request_queue *q, unsigned short size)
>  {
>  	q->limits.logical_block_size = size;
> +	q->limits.logical_block_shift = ilog2(size);
>  
>  	if (q->limits.physical_block_size < size)
>  		q->limits.physical_block_size = size;
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 0c00946..7d9a151 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -171,7 +171,6 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
>  /**
>   * t10_pi_prepare - prepare PI prior submitting request to device
>   * @rq:              request with PI that should be prepared
> - * @protection_type: PI type (Type 1/Type 2/Type 3)
>   *
>   * For Type 1/Type 2, the virtual start sector is the one that was
>   * originally submitted by the block layer for the ref_tag usage. Due to
> @@ -181,13 +180,13 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
>   *
>   * Type 3 does not have a reference tag so no remapping is required.
>   */
> -void t10_pi_prepare(struct request *rq, u8 protection_type)
> +void t10_pi_prepare(struct request *rq)
>  {
>  	const int tuple_sz = rq->q->integrity.tuple_size;
>  	u32 ref_tag = t10_pi_ref_tag(rq);
>  	struct bio *bio;
>  
> -	if (protection_type == T10_PI_TYPE3_PROTECTION)
> +	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
>  		return;

What do you think about making rq->rq_disk->protection_type with a
helper?  Would it be no need or more confusing if helper provided?

Thanks!
