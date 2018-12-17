Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4BFC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42EB2133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 11:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLQLYx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:24:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47275 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeLQLYw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 06:24:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA3128F4FB;
        Mon, 17 Dec 2018 11:24:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F16CA5ED50;
        Mon, 17 Dec 2018 11:24:46 +0000 (UTC)
Date:   Mon, 17 Dec 2018 19:24:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-pci: don't share queue maps
Message-ID: <20181217112441.GF1329@ming.t460p>
References: <20181217111627.22635-1-hch@lst.de>
 <20181217111627.22635-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217111627.22635-2-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 17 Dec 2018 11:24:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 12:16:27PM +0100, Christoph Hellwig wrote:
> Now that the block layer checks if a queue map has any queues inside
> it there is no more reason to duplicate the maps for the non-default
> types.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fb9d8270f32c..698b350b38cf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -496,11 +496,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		map->nr_queues = dev->io_queues[i];
>  		if (!map->nr_queues) {
>  			BUG_ON(i == HCTX_TYPE_DEFAULT);
> -
> -			/* shared set, resuse read set parameters */
> -			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
> -			qoff = 0;
> -			offset = queue_irq_offset(dev);
> +			continue;
>  		}
>  
>  		/*
> -- 
> 2.19.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
