Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbcGGTaZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 7 Jul 2016 15:30:25 -0400
Date: Thu, 7 Jul 2016 21:30:19 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] nvme: switch to use pci_alloc_irq_vectors
Message-ID: <20160707193019.GA8802@dhcp-27-118.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-13-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467621574-8277-13-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 04, 2016 at 05:39:33PM +0900, Christoph Hellwig wrote:
> @@ -1575,6 +1546,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.cmd_size = nvme_cmd_size(dev);
>  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>  		dev->tagset.driver_data = dev;
> +		dev->tagset.affinity_mask = to_pci_dev(dev->dev)->irq_affinity;
>  
>  		if (blk_mq_alloc_tag_set(&dev->tagset))
>  			return 0;

Are there any post-init uses of blk_mq_tag_set::affinity_mask other than
calling to blk_mq_alloc_tag_set()? If no, blk_mq_tag_set::affinity_mask
is redundant, since the mask could be passed as a parameter.
