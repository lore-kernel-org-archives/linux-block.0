Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3EBC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA09B2081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 07:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA09B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeK2SIb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:08:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeK2SIb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 13:08:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF737C05B01B;
        Thu, 29 Nov 2018 07:04:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ADC65EDE4;
        Thu, 29 Nov 2018 07:04:03 +0000 (UTC)
Date:   Thu, 29 Nov 2018 15:03:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] ataflop: implement mq_ops->commit_rqs() hook
Message-ID: <20181129070357.GB27186@ming.t460p>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 29 Nov 2018 07:04:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 06:35:36AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/ataflop.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index f88b4c26d422..a0c6745b0034 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1471,6 +1471,15 @@ static void setup_req_params( int drive )
>  			ReqTrack, ReqSector, (unsigned long)ReqData ));
>  }
>  
> +static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	spin_lock_irq(&ataflop_lock);
> +	atari_disable_irq(IRQ_MFP_FDC);
> +	finish_fdc();
> +	atari_enable_irq(IRQ_MFP_FDC);
> +	spin_unlock_irq(&ataflop_lock);
> +}
> +
>  static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  				     const struct blk_mq_queue_data *bd)
>  {
> @@ -1947,6 +1956,7 @@ static const struct block_device_operations floppy_fops = {
>  
>  static const struct blk_mq_ops ataflop_mq_ops = {
>  	.queue_rq = ataflop_queue_rq,
> +	.commit_rqs = ataflop_commit_rqs,
>  };
>  
>  static struct kobject *floppy_find(dev_t dev, int *part, void *data)
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming
