Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C631C433E0
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 15:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4686822A83
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 15:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbhAJPCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 10:02:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbhAJPCB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 10:02:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09169ACC6;
        Sun, 10 Jan 2021 15:01:19 +0000 (UTC)
Subject: Re: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
References: <20210109104254.1077093-1-hch@lst.de>
 <20210109104254.1077093-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3269f70a-2bd4-9aa6-5f14-b13e5b67687e@suse.de>
Date:   Sun, 10 Jan 2021 16:01:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210109104254.1077093-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/21 11:42 AM, Christoph Hellwig wrote:
> Unconditionally call set_disk_ro now that it only updates the hardware
> state.  This allows to properly set up the Linux devices read-only when
> the controller turns a previously writable namespace read-only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   drivers/nvme/host/core.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ce1b6151944131..3a0557ccc9fc5d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2114,9 +2114,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	nvme_config_discard(disk, ns);
>   	nvme_config_write_zeroes(disk, ns);
>   
> -	if ((id->nsattr & NVME_NS_ATTR_RO) ||
> -	    test_bit(NVME_NS_FORCE_RO, &ns->flags))
> -		set_disk_ro(disk, true);
> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> +		test_bit(NVME_NS_FORCE_RO, &ns->flags));
>   }
>   
>   static inline bool nvme_first_scan(struct gendisk *disk)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
