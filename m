Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C22C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82220672
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D82220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLMJQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:16:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:53024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbeLMJQ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 04:16:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00949AE38;
        Thu, 13 Dec 2018 09:16:55 +0000 (UTC)
Subject: Re: [PATCH 3/4] nvme: Should not warn when a disk path is opened
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-4-cascardo@canonical.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c8d9ca76-10bc-4827-f1bd-3164a15fcd33@suse.de>
Date:   Thu, 13 Dec 2018 10:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206164812.30925-4-cascardo@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
> As we hide the disks used for nvme multipath, their open functions
> should be allowed to be called, as their devices are not exposed.
> 
> However, not exposing the devices cause problems with lsblk, which won't
> find the devices and show them, which is even more of a problem when
> holders/slaves relationships are exposed.
> 
> Not warning here allow us to expose the disks without creating spurious
> warnings. A failure should still be returned, which is the case here,
> and still allows lsblk to work.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1dc29795f1ee..22424b2adfad 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1327,8 +1327,8 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>   	struct nvme_ns *ns = bdev->bd_disk->private_data;
>   
>   #ifdef CONFIG_NVME_MULTIPATH
> -	/* should never be called due to GENHD_FL_HIDDEN */
> -	if (WARN_ON_ONCE(ns->head->disk))
> +	/* Should fail as it's hidden */
> +	if (ns->head->disk)
>   		goto fail;
>   #endif
>   	if (!kref_get_unless_zero(&ns->kref))
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
