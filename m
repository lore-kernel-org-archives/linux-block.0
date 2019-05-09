Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB56DC04AB3
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 11:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF2020989
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 11:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEILYZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 07:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfEILYZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 07:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 045ED307E05F;
        Thu,  9 May 2019 11:24:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A098D643D8;
        Thu,  9 May 2019 11:24:17 +0000 (UTC)
Date:   Thu, 9 May 2019 19:24:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     keith.busch@intel.com, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: fix single segment detection
Message-ID: <20190509112410.GA20711@ming.t460p>
References: <20190509110409.19647-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509110409.19647-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 09 May 2019 11:24:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 09, 2019 at 01:04:09PM +0200, Christoph Hellwig wrote:
> blk_rq_nr_phys_segments isn't exactly accurate at the request/bio
> level, so work around that fact with a few crude sanity checks.  To
> be fixed for real in the block layer soon.
> 
> Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2a8708c9ac18..9a4253be2723 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -824,7 +824,15 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  	blk_status_t ret = BLK_STS_RESOURCE;
>  	int nr_mapped;
>  
> -	if (blk_rq_nr_phys_segments(req) == 1) {
> +	/*
> +	 * Crude hack to work around the block layer accounting for the fact
> +	 * that the SG mapping can merge multiple physically contigous segments
> +	 * in blk_rq_nr_phys_segments() despite the fact that not everyone is
> +	 * mapping the request to a scatterlist.  To be fixed for real in the
> +	 * block layer eventually..
> +	 */
> +	if (blk_rq_nr_phys_segments(req) == 1 &&
> +	    !req->bio->bi_next && req->bio->bi_vcnt == 1) {
>  		struct bio_vec bv = req_bvec(req);

I'd suggest to fix block layer instead of working around the issue here,
then any driver may benefit from the fix.

Especially checking bio->bi_vcnt is just a hack, and drivers should
never use .bi_vcnt.


Thanks,
Ming
