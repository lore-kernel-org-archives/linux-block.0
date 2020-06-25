Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA398C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FE020775
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="gZx9xpZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405591AbgFYPNN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405502AbgFYPNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 11:13:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FFFC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 08:13:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e15so4507659edr.2
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ixdzoPeHqTjtWCkjfG+wRupSHf8MX9sNzTZVFeYguNQ=;
        b=gZx9xpZ8xp2kLXzmjlge8TgWKxXJbtic7sXC//V0R/IFNIziL2ZRF0C2MNKf0FvuXb
         8S6XEn5qU6OeoWVIXvFoLLMZIi06r3YSWTbmJB/IrD4RMbKfAAkSDyTPOH7lQYqrlohl
         pr6NYaLYBxDIIZyk5sO+pyiUvj9AU7kGKdvio1pRVrkmxd24Z8EGrnfb3GzC5zH5Wlft
         wXAqQHOgXIOKHS4bufmpAfM8OcRaqcVQ3+hrbB/0D/3L6/AC/A4WY1g/BWS1rdHnH9v6
         7XCVLphiB1LvbOEAUyBk7pt4r1ndYkhKvYwKwr5uC1q4NKRU3pXBRWB/vuqVJosMtJiB
         f7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ixdzoPeHqTjtWCkjfG+wRupSHf8MX9sNzTZVFeYguNQ=;
        b=Tc2iiylkkgcCglJzyVYOLe9MplI1dHZ1nHmL6OP9Cwi3elIcew34MrTxLISX8xvT1X
         w7Hoe9BGcHrOlZwmChWSdZR59rwlzNLGuYOzZ5xVyR3Z8u7PP7Bfe/qAiScZBimEtsWl
         F+JeaN522+qDkAxeAyXVECdlW9CEsy/SXMFjenXKR6c347unFzafDZA5HfdR9RfhBEBE
         Kyz6pldYBhcmC7BQ67b26ssEuhIULYe+pNkllrDQ2qce2cwqEuF4zCrtF9VKp1invTLe
         z4VnqtkOGmZIWPab8uzXudJsvu/LSZfCHyh6Fk8ebWYMiJaLuLhvMm0B3TfG8tEqcgbi
         UZvg==
X-Gm-Message-State: AOAM530qh72/rPa/XGWLO+Rr7rgTFVDJxlssxmYyMVgNF6jM/5x/6F0r
        ePKKw/Mli7Brv5KQaV1AmhAVVg==
X-Google-Smtp-Source: ABdhPJwMIRBPr3Srqb6v+nLNKSuOmvLocW13PX16x6OR7/WzTgLCBYVK6/lEIgATq6RrYUpc++hvVA==
X-Received: by 2002:a05:6402:1285:: with SMTP id w5mr33047361edv.73.1593097991757;
        Thu, 25 Jun 2020 08:13:11 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id a13sm18315114edk.58.2020.06.25.08.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 08:13:10 -0700 (PDT)
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9ac40166-5731-692a-d476-0da9aad2a9aa@lightnvm.io>
Date:   Thu, 25 Jun 2020 17:13:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-6-javier@javigon.com>
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
> Add zone attributes field to the blk_zone structure. Use ZNS attributes
> as base for zoned block devices in general.
>
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   drivers/nvme/host/zns.c       |  1 +
>   include/uapi/linux/blkzoned.h | 13 ++++++++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 258d03610cc0..7d8381fe7665 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>   	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>   	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>   	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +	zone.attr = entry->za;
>   
>   	return cb(&zone, idx, data);
>   }
> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
> index 0c49a4b2ce5d..2e43a00e3425 100644
> --- a/include/uapi/linux/blkzoned.h
> +++ b/include/uapi/linux/blkzoned.h
> @@ -82,6 +82,16 @@ enum blk_zone_report_flags {
>   	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>   };
>   
> +/**
> + * Zone Attributes
> + */
> +enum blk_zone_attr {
> +	BLK_ZONE_ATTR_ZFC	= 1 << 0,
> +	BLK_ZONE_ATTR_FZR	= 1 << 1,
> +	BLK_ZONE_ATTR_RZR	= 1 << 2,

The RZR bit is equivalent to the RESET bit accessible through the reset 
byte in struct blk_zone.

ZFC is tied to Zone Active Excursions, as there is no support in the 
kernel zone model for that. This should probably not be added until 
there is generic support.

Damien, could we overload the struct blk_zine reset variable for FZR? I 
don't believe we can due to backward compatibility. Is that your 
understanding as well?

> +	BLK_ZONE_ATTR_ZDEV	= 1 << 7,

There is not currently an equivalent for zone descriptor extensions in 
ZAC/ZBC. The addition of this field should probably be in a patch that 
adds generic support for zone descriptor extensions.

> +};
> +
>   /**
>    * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>    *
> @@ -108,7 +118,8 @@ struct blk_zone {
>   	__u8	cond;		/* Zone condition */
>   	__u8	non_seq;	/* Non-sequential write resources active */
>   	__u8	reset;		/* Reset write pointer recommended */
> -	__u8	resv[4];
> +	__u8	attr;		/* Zone attributes */
> +	__u8	resv[3];
>   	__u64	capacity;	/* Zone capacity in number of sectors */
>   	__u8	reserved[24];
>   };


