Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB88C3A5A8
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D721670
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfIDRvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:51:46 -0400
Received: from verein.lst.de ([213.95.11.211]:41045 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDRvq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 13:51:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 97B6C227A81; Wed,  4 Sep 2019 19:51:42 +0200 (CEST)
Date:   Wed, 4 Sep 2019 19:51:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v2 1/1] block: centralize PI remapping logic to the
 block layer
Message-ID: <20190904175142.GA21990@lst.de>
References: <1567614452-26251-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567614452-26251-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 04, 2019 at 07:27:32PM +0300, Max Gurtovoy wrote:
> @@ -1405,6 +1406,11 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  	if (!req->bio)
>  		return false;
>  
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req,
> +			nr_bytes >> blk_integrity_interval_shift(req->q));

I think it would be nicer to just pass nr_bytes to t10_pi_complete and 
do the calculation internally.  That keeps the caller a littler cleaner.

> -void t10_pi_prepare(struct request *rq, u8 protection_type)
> +void t10_pi_prepare(struct request *rq)
>  {
> +	u8 protection_type = rq->rq_disk->protection_type;

The protection_type variable is only used once, so we might as well
remove it.

> +void t10_pi_complete(struct request *rq, unsigned int intervals)
>  {
> +	u8 protection_type = rq->rq_disk->protection_type;

Same here.

> +static void nvme_set_disk_prot_type(struct nvme_ns *ns, struct gendisk *disk)
> +{
> +	switch (ns->pi_type) {
> +	case NVME_NS_DPS_PI_TYPE1:
> +		disk->protection_type = T10_PI_TYPE1_PROTECTION;
> +		break;
> +	case NVME_NS_DPS_PI_TYPE2:
> +		disk->protection_type = T10_PI_TYPE2_PROTECTION;
> +		break;
> +	case NVME_NS_DPS_PI_TYPE3:
> +		disk->protection_type = T10_PI_TYPE3_PROTECTION;
> +		break;
> +	default:
> +		disk->protection_type = T10_PI_TYPE0_PROTECTION;
> +		break;
> +	}
> +}

We just passed the value in direttly before, so I think we can keep
it that way.  In fact it might make sense to just remove the
NVME_NS_DPS_PI_TYPE* values entirely (in a separate patch).

But I think we should remove the pi_type field in struct nvme_ns here,
just like in sd.
