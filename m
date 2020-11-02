Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD2C00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 13:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DB6223BF
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 13:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="VmrGwZZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKBNES (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgKBNES (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 08:04:18 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7EC0617A6
        for <linux-block@vger.kernel.org>; Mon,  2 Nov 2020 05:04:18 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id dg9so14225788edb.12
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2020 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/q1vhBdyTHY66HKX4WZ7Bax206ccPeTM5MICm/keYCA=;
        b=VmrGwZZr1yRpp5U2PCe7HMxEpzsdLxoYZuHG+6qqew2XJ0Po9B3h3cij6DYNwLbpZU
         4ARCtSNzKKHHg+d6DTdlJUiNCLUr2QsO5H+rb+c2QMdZWOM+SkoUTjL22NjW0AQ3I1mG
         wElpCdlSALwU7TLBsZEmcd51C/I62DAyUzBzwFgQ9kbrbX3R/HGWASVomF61WNZxvzwI
         gWkLkMs6ocZ8iUz2m/I+Dgw+ltZkG9XXBfT4WZGSz0Y9s1goWelXNtLLdIwqjq3s6jDv
         sDdbd4TlKHwbVPjM+qOPOLFKZgOT5RDq8LhSKjIzQ0Ih5CVP3kzW0988aFD1Lh2hOc3F
         te+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/q1vhBdyTHY66HKX4WZ7Bax206ccPeTM5MICm/keYCA=;
        b=ucA028qMzU4vDpAoS7w1TXDtWLmZ3YOtfpR3LzHJQjflfwToBpmsTjJP9ITpQwDQ/z
         /2T9maIo8+4sZLl02lBFj0x2RkW0Sizja6g0hB6ZLuFkROwF5x2eA/t1Iq+HgoPyxYL9
         3p+fSAKatBgXAe3rhComhChFEE/3jmKsbeLJ/e1R7q3IklIUmKYrnn2sI6bElKODoAul
         vBitKQ4jqlWnBdOm2rsGRQeNYWReFBqzNZ+LYQ9ijBAaurnmZ2qyRlMFnjIRJ9UUb4V5
         FKYkBE8HnNFVoRXkaccexE595i9s6tMcr+CG4K3UDlhMbAVwMvFf6Dm/Sejjzl6iRVC7
         9R+Q==
X-Gm-Message-State: AOAM533Xu5ND7vH6bSY8/25I4051Y1KC00zwZfw6hNnCO7Rk4Zy6cwu8
        0flcEMb1RpFsVfz9puiy9RFMOA==
X-Google-Smtp-Source: ABdhPJxQTTxwpPnBTJMErUUF2H5z+Dcavi2Ihqa1SYp061K2Qhx/M/6aSd1MBWE07SpSyh7jRnErvw==
X-Received: by 2002:aa7:cc84:: with SMTP id p4mr16081656edt.97.1604322253141;
        Mon, 02 Nov 2020 05:04:13 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id p4sm509999ejw.101.2020.11.02.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:04:12 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:04:11 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102130411.2vqqrma6zetec543@MacBook-Pro.localdomain>
References: <20201029185753.14368-1-javier.gonz@samsung.com>
 <20201030143146.GA105238@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030143146.GA105238@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30.10.2020 14:31, Niklas Cassel wrote:
>On Thu, Oct 29, 2020 at 07:57:53PM +0100, Javier González wrote:
>> Allow ZNS SSDs to be presented to the host even when they implement
>> features that are not supported by the kernel zoned block device.
>>
>> Instead of rejecting the SSD at the NVMe driver level, deal with this in
>> the block layer by setting capacity to 0, as we do with other things
>> such as unsupported PI configurations. This allows to use standard
>> management tools such as nvme-cli to choose a different format or
>> firmware slot that is compatible with the Linux zoned block device.
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> ---
>>  drivers/nvme/host/core.c |  5 +++++
>>  drivers/nvme/host/nvme.h |  1 +
>>  drivers/nvme/host/zns.c  | 31 ++++++++++++++-----------------
>>  3 files changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index c190c56bf702..9ca4f0a6ff2c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2026,6 +2026,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>  			capacity = 0;
>>  	}
>
>Hello Javier,
>
>>
>> +#ifdef CONFIG_BLK_DEV_ZONED
>
>if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)
>
>is preferred over ifdefs.

I will address this in a v2.

>
>> +	if (!ns->zone_sup)
>> +		capacity = 0;
>> +#endif
>> +
>>  	set_capacity_revalidate_and_notify(disk, capacity, false);
>>
>>  	nvme_config_discard(disk, ns);
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 87737fa32360..42cbe5bbc518 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -443,6 +443,7 @@ struct nvme_ns {
>>  	u8 pi_type;
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  	u64 zsze;
>> +	bool zone_sup;
>
>Perhaps a more descriptive name? zoned_ns_supp ?

Sure. I can do that.

>
>>  #endif
>>  	unsigned long features;
>>  	unsigned long flags;
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index 57cfd78731fb..77a7fed508ef 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -44,20 +44,23 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  	struct nvme_id_ns_zns *id;
>>  	int status;
>>
>> -	/* Driver requires zone append support */
>> +	ns->zone_sup = true;
>
>I don't think it is wise to assign it to true here.
>E.g. if kzalloc() failes, if nvme_submit_sync_cmd() fails,
>or if nvme_set_max_append() fails, you have already set this to true,
>but zoc or power of 2 checks were never performed.

I do not think it will matter much as it is just an internal variable.
If any of the checks you mention fail, then the namespace will not even
be initialized.

Is there anything I am missing?

>Perhaps something like this would be more robust:
>
>@@ -53,18 +53,19 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>        struct nvme_command c = { };
>        struct nvme_id_ns_zns *id;
>        int status;
>+       bool new_ns_supp = true;
>+
>+       /* default to NS not supported */
>+       ns->zoned_ns_supp = false;
>
>-       /* Driver requires zone append support */
>        if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>                        NVME_CMD_EFFECTS_CSUPP)) {
>                dev_warn(ns->ctrl->device,
>                        "append not supported for zoned namespace:%d\n",
>                        ns->head->ns_id);
>-               return -EINVAL;
>-       }
>-
>-       /* Lazily query controller append limit for the first zoned namespace */
>-       if (!ns->ctrl->max_zone_append) {
>+               new_ns_supp = false;
>+       } else if (!ns->ctrl->max_zone_append) {
>+               /* Lazily query controller append limit for the first zoned namespace */
>                status = nvme_set_max_append(ns->ctrl);
>                if (status)
>                        return status;
>@@ -80,19 +81,16 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>        c.identify.csi = NVME_CSI_ZNS;
>
>        status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id));
>-       if (status)
>-               goto free_data;
>+       if (status) {
>+               kfree(id);
>+               return status;
>+       }
>
>-       /*
>-        * We currently do not handle devices requiring any of the zoned
>-        * operation characteristics.
>-        */
>        if (id->zoc) {
>                dev_warn(ns->ctrl->device,
>                        "zone operations:%x not supported for namespace:%u\n",
>                        le16_to_cpu(id->zoc), ns->head->ns_id);
>-               status = -EINVAL;
>-               goto free_data;
>+               new_ns_supp = false;
>        }
>
>        ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
>@@ -100,17 +98,14 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>                dev_warn(ns->ctrl->device,
>                        "invalid zone size:%llu for namespace:%u\n",
>                        ns->zsze, ns->head->ns_id);
>-               status = -EINVAL;
>-               goto free_data;
>+               new_ns_supp = false;
>        }
>
>+       ns->zoned_ns_supp = new_ns_supp;
>        q->limits.zoned = BLK_ZONED_HM;
>        blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>        blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>        blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
>-free_data:
>-       kfree(id);
>-       return status;
> }
>
> static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>

Sure, we can use a local assignment as you suggest. I'll send a V2 with
this.

Javier

