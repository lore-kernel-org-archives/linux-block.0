Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3CBC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B09D20835
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfD3O1i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:27:38 -0400
Received: from charlie.dont.surf ([128.199.63.193]:56680 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfD3O1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 10:27:37 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 10:27:36 EDT
Received: from apples.localdomain (77.241.131.189.mobile.3.dk [77.241.131.189])
        by charlie.dont.surf (Postfix) with ESMTPSA id 581F5BF5B7;
        Tue, 30 Apr 2019 14:17:28 +0000 (UTC)
Date:   Tue, 30 Apr 2019 16:17:22 +0200
From:   Klaus Birkelund <klaus@birkelund.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme-pci: optimize mapping single segment requests
 using SGLs
Message-ID: <20190430141722.GA19100@apples.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321231037.25104-15-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 21, 2019 at 04:10:36PM -0700, Christoph Hellwig wrote:
> If the controller supports SGLs we can take another short cut for single
> segment request, given that we can always map those without another
> indirection structure, and thus don't need to create a scatterlist
> structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 47fc4d653961..38869f59c296 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -819,6 +819,23 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
>  	return 0;
>  }
>  
> +static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
> +		struct request *req, struct nvme_rw_command *cmnd,
> +		struct bio_vec *bv)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
> +	if (dma_mapping_error(dev->dev, iod->first_dma))
> +		return BLK_STS_RESOURCE;
> +	iod->dma_len = bv->bv_len;
> +
> +	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
> +	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
> +	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
> +	return 0;
> +}
> +
>  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		struct nvme_command *cmnd)
>  {
> @@ -836,6 +853,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
>  				return nvme_setup_prp_simple(dev, req,
>  							     &cmnd->rw, &bv);
> +
> +			if (iod->nvmeq->qid &&
> +			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
> +				return nvme_setup_sgl_simple(dev, req,
> +							     &cmnd->rw, &bv);
>  		}
>  	}
>  
> -- 
> 2.20.1
> 

Hi Christoph,

nvme_setup_sgl_simple does not set the PSDT field, so bypassing
nvme_pci_setup_sgls causing controllers to assume PRP.

Adding `cmnd->flags = NVME_CMD_SGL_METABUF` in nvme_setup_sgl_simple
fixes the issue.


-- 
Klaus
