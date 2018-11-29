Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEEC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A281221019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A281221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeK3HqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:46:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:14825 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeK3HqH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 02:46:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 12:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="113897554"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 12:39:26 -0800
Date:   Thu, 29 Nov 2018 13:36:32 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/13] nvme-pci: don't poll from irq context when
 deleting queues
Message-ID: <20181129203632.GE9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129191310.9795-8-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 08:13:04PM +0100, Christoph Hellwig wrote:
> This is the last place outside of nvme_irq that handles CQEs from
> interrupt context, and thus is in the way of removing the cq_lock for
> normal queues, and avoiding lockdep warnings on the poll queues, for
> which we already take it without IRQ disabling.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9ceba9900ca3..fb8db7d8170a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -203,6 +203,7 @@ struct nvme_queue {
>  	unsigned long flags;
>  #define NVMEQ_ENABLED		0
>  #define NVMEQ_SQ_CMB		1
> +#define NVMEQ_DELETE_ERROR	2
>  	u32 *dbbuf_sq_db;
>  	u32 *dbbuf_cq_db;
>  	u32 *dbbuf_sq_ei;
> @@ -2216,7 +2217,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
>  	struct nvme_queue *nvmeq = req->end_io_data;
>  
>  	if (!error)
> -		nvme_poll_irqdisable(nvmeq, -1);
> +		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
>  
>  	nvme_del_queue_end(req, error);
>  }
> @@ -2258,11 +2259,20 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
>  		nr_queues--;
>  		sent++;
>  	}
> -	while (sent--) {
> +	while (sent) {
> +		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
> +
>  		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
>  				timeout);
>  		if (timeout == 0)
>  			return false;
> +
> +		/* handle any remaining CQEs */
> +		if (opcode == nvme_admin_delete_cq &&
> +		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
> +			nvme_poll_irqdisable(nvmeq, -1);

We're dispatchig lots of queue deletions in parallel, and they may
complete in any order. I don't see how you can guarantee that the
wait_for_completion() will return for the nvmeq that you're polling.

You also need to clear NVMEQ_DELETE_ERROR somewhere later, maybe in
nvme_init_queue().
