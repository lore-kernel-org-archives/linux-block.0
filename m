Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB52C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE82087C
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Nz3CPcq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCEOfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:35:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38793 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfCEOfA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 09:35:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so7406113edb.5
        for <linux-block@vger.kernel.org>; Tue, 05 Mar 2019 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q1SYQBF6GNDZHBAAuF2BtTKgJrFxoQowHPULG9yqbtY=;
        b=Nz3CPcq15V53KfccoTsw8WrS3yr7eP0tcY7gYpS2+0L6gnYxzn+2F5COOcAF/oOxBu
         Aqc/FCk5lLhbMbNHPhmOG0NM8xwz3BkPBGyZ9rSYSXTymrS4dxqVmUjSpSicx9kPMyrd
         lBZoh/kZJZA2SlTzfY6C2J/d5xhJSwVCOQw5tmpD6DjMcKrapIfZ9+Guuv2sWAjNIzoY
         C6NnQY4+eWMESaxhSyubeKpXBvc91JpU+PcYNy8FNcurvLIRmUSS3NuiLO2bAJV96v6x
         VtwD7XwiX8/GKZwCQ80lhE7Ob57ndiYR2J13D6NQO1x1azcDabi6fliDZT2EbCnzTfW4
         cVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1SYQBF6GNDZHBAAuF2BtTKgJrFxoQowHPULG9yqbtY=;
        b=HrwN6gr/MchvpbKG6x6CYH5TvaNlORxtpk44j6c0YHRPSwpeGnAluJmq0Hm3+bVUeK
         SkPzg7vC0LhxQ8ZRHvFEHYy0iFP6WmmRmTSm61md/1MQjtRJbNe1h9CJ8h8hFq/PjfMj
         m7Cft8VfI60MYdctjb4c3SI/exW/qXhC5UETAcjCoYo/S4lASBNFkYB+Lbx7Y/xA2/Cn
         A1/H1DZyQPgrEH0AdsgYEHaTrW0ciBvSTxFDvkisV8uUxeUhZBcdWk1U08EdLj1OBkr/
         pVlyCet3nZV6fkpUUgn8czc8h0IBhDNRMso5hnZc5LBxoiy4ojd66t995b3wKsM5/4CG
         YEVQ==
X-Gm-Message-State: APjAAAW6e4IBk6w76y5QVk5/13BsneQ2rQYedcDl/K7KJ0oEQbzHQas6
        idaIsCDoSYbo6Ig92IHjtAFJMcCNTg4=
X-Google-Smtp-Source: APXvYqw0dl8HSJzIUcq3opokYGmp1ThtmSd5/XrSbfKVisibEg/5/NWVzHM24GNBbmZyOSWy9OslLQ==
X-Received: by 2002:a17:906:5583:: with SMTP id y3mr499586ejp.42.1551796498229;
        Tue, 05 Mar 2019 06:34:58 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id e14sm3172684edd.9.2019.03.05.06.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 06:34:57 -0800 (PST)
Subject: Re: [PATCH v2 8/8] lightnvm: Inherit mdts from the parent nvme device
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-9-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <fbe81dc8-fcf4-57ce-5443-11b44f3478bf@lightnvm.io>
Date:   Tue, 5 Mar 2019 15:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190305135120.29284-9-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/19 2:51 PM, Igor Konopko wrote:
> Current lightnvm and pblk implementation does not care about NVMe max
> data transfer size, which can be smaller than 64*K=256K. There are
> existing NVMe controllers which NVMe max data transfer size is lower
> that 256K (for example 128K, which happens for existing NVMe
> controllers which are NVMe spec compliant). Such a controllers are not
> able to handle command which contains 64 PPAs, since the the size of
> DMAed buffer will be above the capabilities of such a controller.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> ---
>   drivers/lightnvm/core.c      | 9 +++++++--
>   drivers/nvme/host/lightnvm.c | 1 +
>   include/linux/lightnvm.h     | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 5f82036..c01f83b 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -325,6 +325,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>   	struct nvm_target *t;
>   	struct nvm_tgt_dev *tgt_dev;
>   	void *targetdata;
> +	unsigned int mdts;
>   	int ret;
>   
>   	switch (create->conf.type) {
> @@ -412,8 +413,12 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
>   	tdisk->private_data = targetdata;
>   	tqueue->queuedata = targetdata;
>   
> -	blk_queue_max_hw_sectors(tqueue,
> -			(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> +	mdts = (dev->geo.csecs >> 9) * NVM_MAX_VLBA;
> +	if (dev->geo.mdts) {
> +		mdts = min_t(u32, dev->geo.mdts,
> +				(dev->geo.csecs >> 9) * NVM_MAX_VLBA);
> +	}
> +	blk_queue_max_hw_sectors(tqueue, mdts);
>   
>   	set_capacity(tdisk, tt->capacity(targetdata));
>   	add_disk(tdisk);
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 949e29e..4f20a10 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -977,6 +977,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>   	geo->csecs = 1 << ns->lba_shift;
>   	geo->sos = ns->ms;
>   	geo->ext = ns->ext;
> +	geo->mdts = ns->ctrl->max_hw_sectors;
>   
>   	dev->q = q;
>   	memcpy(dev->name, disk_name, DISK_NAME_LEN);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 5d865a5..d3b0270 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -358,6 +358,7 @@ struct nvm_geo {
>   	u16	csecs;		/* sector size */
>   	u16	sos;		/* out-of-band area size */
>   	bool	ext;		/* metadata in extended data buffer */
> +	u32	mdts;		/* Max data transfer size*/
>   
>   	/* device write constrains */
>   	u32	ws_min;		/* minimum write size */
> 

I think I can pick this up. I'll let Javier/Hans rereview.

Given Javier's feedback on broken existing mdts implementations. When 
they are brought to light, we may want to add in a quirk list to update 
MDTS accordingly. Javier, will this address the issue you have regarding 
using mdts?

-Matias

