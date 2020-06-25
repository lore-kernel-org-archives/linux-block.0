Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E236C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A2C20702
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="KMgnFMxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405274AbgFYOMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbgFYOMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 10:12:23 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D7DC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 07:12:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so6110944ejb.2
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+nMSMJQyXiE0FGbsQZwYsm4NFtgtlfZJ3JVTvDS4SSY=;
        b=KMgnFMxPBn1sGRdOuz8OvBu75FpD4WqvG0wi8Tf8bGAGM+NAlIP1X2kGtmQ1jGzpm5
         ogKTBT5A6eegg3i7/WJWua9PPWYOqaM2/PEjiqhRft+DLz8uDFaehSUgqR1S0uSdlgia
         UDPCviP5pZGAekVaQUv466tJ7EfHCtUAaT2n70ktxASnqkykXuFLInTkbqbXNFaUOjSX
         89WHlSN1p2lcvR1DAHrPkQ/VmjWK0GbSiNcSnufd4U7qwLrDhADAoO+3jqWhOMR9uCie
         KTJCTlpwHkDDYXraMp99J8gIl6prQv4q/MqUkLyjvXKZqFZdwSjTow4ChIsZyEElZNbQ
         w5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+nMSMJQyXiE0FGbsQZwYsm4NFtgtlfZJ3JVTvDS4SSY=;
        b=rglEutqNG0ZBRaul2ZQ+c6vX64rVOBF4yV6xNog+jNOTVaW7DgVNf7I4BGcJgeafqm
         1Oyz+yhMt2/3iks8o0FlcfTj35KHy4qQs2VsenKFGy2f3RPtvFdczg+TwyPk1QOb4w6s
         tkuEEwNwU6Apn0gIpuDf/e0b9I/so+pTSRgTn2//32BFYVz5I8N+a443t9VeipiiT58U
         2wuU7r3RjfzCPjxkKhJE/P5VOJ/BJuIX7UDSWWDPPLmVK6Alen485yLdPCXDact52ths
         iAih1HyADZJiDHN2a5JRQPvasViaAw3FlwtdPUDhK/B204KXq0okzm2/qrx+gz9aesu8
         aBXA==
X-Gm-Message-State: AOAM532d9QQbFTjLEcoI81NMrdWI7GwdN/wNHDTLFL09T5HRYO8Lvan/
        +iYE2ArXgnJoxHShapFbH1F9wahzfqE=
X-Google-Smtp-Source: ABdhPJxCB4Rza2JDytyHAFa7yyQZEBHzr/3VlxA+k8lx7JXqsIRk4YRul7SSEzSH97M7xSnPsv7HiA==
X-Received: by 2002:a17:906:27c9:: with SMTP id k9mr24206720ejc.74.1593094342363;
        Thu, 25 Jun 2020 07:12:22 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id e20sm16855953ejh.22.2020.06.25.07.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 07:12:21 -0700 (PDT)
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
Date:   Thu, 25 Jun 2020 16:12:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-4-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/06/2020 14.21, Javier González wrote:
> From: Javier González <javier.gonz@samsung.com>
>
> Add support for offline transition on the zoned block device using the
> new zone management IOCTL
>
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   block/blk-core.c              | 2 ++
>   block/blk-zoned.c             | 3 +++
>   drivers/nvme/host/core.c      | 3 +++
>   include/linux/blk_types.h     | 3 +++
>   include/linux/blkdev.h        | 1 -
>   include/uapi/linux/blkzoned.h | 1 +
>   6 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 03252af8c82c..589cbdacc5ec 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] = {
>   	REQ_OP_NAME(ZONE_CLOSE),
>   	REQ_OP_NAME(ZONE_FINISH),
>   	REQ_OP_NAME(ZONE_APPEND),
> +	REQ_OP_NAME(ZONE_OFFLINE),
>   	REQ_OP_NAME(WRITE_SAME),
>   	REQ_OP_NAME(WRITE_ZEROES),
>   	REQ_OP_NAME(SCSI_IN),
> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>   	case REQ_OP_ZONE_OPEN:
>   	case REQ_OP_ZONE_CLOSE:
>   	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_OFFLINE:
>   		if (!blk_queue_is_zoned(q))
>   			goto not_supported;
>   		break;
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 29194388a1bb..704fc15813d1 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>   	case BLK_ZONE_MGMT_RESET:
>   		op = REQ_OP_ZONE_RESET;
>   		break;
> +	case BLK_ZONE_MGMT_OFFLINE:
> +		op = REQ_OP_ZONE_OFFLINE;
> +		break;
>   	default:
>   		return -ENOTTY;
>   	}
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f1215523792b..5b95c81d2a2d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>   	case REQ_OP_ZONE_FINISH:
>   		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>   		break;
> +	case REQ_OP_ZONE_OFFLINE:
> +		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
> +		break;
>   	case REQ_OP_WRITE_ZEROES:
>   		ret = nvme_setup_write_zeroes(ns, req, cmd);
>   		break;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 16b57fb2b99c..b3921263c3dd 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -316,6 +316,8 @@ enum req_opf {
>   	REQ_OP_ZONE_FINISH	= 12,
>   	/* write data at the current zone write pointer */
>   	REQ_OP_ZONE_APPEND	= 13,
> +	/* Transition a zone to offline */
> +	REQ_OP_ZONE_OFFLINE	= 14,
>   
>   	/* SCSI passthrough using struct scsi_request */
>   	REQ_OP_SCSI_IN		= 32,
> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>   	case REQ_OP_ZONE_OPEN:
>   	case REQ_OP_ZONE_CLOSE:
>   	case REQ_OP_ZONE_FINISH:
> +	case REQ_OP_ZONE_OFFLINE:
>   		return true;
>   	default:
>   		return false;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bd8521f94dc4..8308d8a3720b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>   				  unsigned int cmd, unsigned long arg);
>   extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>   				  unsigned int cmd, unsigned long arg);
> -
>   #else /* CONFIG_BLK_DEV_ZONED */
>   
>   static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index a8c89fe58f97..d0978ee10fc7 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -155,6 +155,7 @@ enum blk_zone_action {
>   	BLK_ZONE_MGMT_FINISH	= 0x2,
>   	BLK_ZONE_MGMT_OPEN	= 0x3,
>   	BLK_ZONE_MGMT_RESET	= 0x4,
> +	BLK_ZONE_MGMT_OFFLINE	= 0x5,
>   };
>   
>   /**

I am not sure this makes sense to expose through the kernel zone api. 
One of the goals of the kernel zone API is to be a layer that provides 
an unified zone model across SMR HDDs and ZNS SSDs. The offline zone 
operation, as defined in the ZNS specification, does not have an 
equivalent in SMR HDDs (ZAC/ZBC).

This is different from the Zone Capacity change, where the zone capacity 
simply was zone size for SMR HDDs. Making it easy to support. That is 
not the same for ZAC/ZBC, that does not offer the offline operation to 
transition zones in read only state to offline state.

