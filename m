Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082DC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 06:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BB02086B
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 06:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BB02086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeKORF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:05:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727984AbeKORF4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 12:05:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1EA97AF4C;
        Thu, 15 Nov 2018 06:59:20 +0000 (UTC)
Subject: Re: [PATCH 12/16] umem: don't override the queue_lock
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20181114160219.28328-1-hch@lst.de>
 <20181114160219.28328-13-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d02216e6-6bef-0fff-e8fb-23a555d83006@suse.de>
Date:   Thu, 15 Nov 2018 07:59:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181114160219.28328-13-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 5:02 PM, Christoph Hellwig wrote:
> The umem card->lock and the block layer queue_lock are used for entirely
> different resources.  Stop using card->lock as the block layer
> queue_lock.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/umem.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/umem.c b/drivers/block/umem.c
> index be3e3ab79950..8a27b5adc2b3 100644
> --- a/drivers/block/umem.c
> +++ b/drivers/block/umem.c
> @@ -888,8 +888,7 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   	card->biotail = &card->bio;
>   	spin_lock_init(&card->lock);
>   
> -	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE,
> -					   &card->lock);
> +	card->queue = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
>   	if (!card->queue)
>   		goto failed_alloc;
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
