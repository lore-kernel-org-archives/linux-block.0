Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B946C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 20:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjDFUey (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbjDFUeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 16:34:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97AEB750
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 13:32:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l17so4230479ejp.8
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813159; x=1683405159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40/qwsV9wNzTcRPPLOAe/kuqHrqum74DfKbkBeIC4u4=;
        b=WF+iEsHfbzs80/xcwPUBArcOtCHex9vtHX0D9vsVzIAzK98vwwDDcfjcInBjH2mwYZ
         fpV8k9/zWwG4FzWi6ibOJnwUaL+j3za9wvzOG+HmkteV63L940y0Y5eA6I1h0hJh0cvc
         qlXGm8uALDHkkN4nGQwn+jFPwpZzcxJfYYBRqGmVhFOAE1dFvOLwtPYvged6pKLGufB+
         uzSfXlMdQUNGxfIAe7jpr4obivDF/eCH4LTOW3Y70JkNRSkPxi2r4KxoCClpFDJEmNpc
         VyKXSNeOQIVlP95jsiaIEsgmlb6nPb40/PzZv4xpdcdsAy9SGmZboHD5Ufkshb8Px2QA
         4kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813159; x=1683405159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40/qwsV9wNzTcRPPLOAe/kuqHrqum74DfKbkBeIC4u4=;
        b=QI7DMPPtYjT5Z0rQp/fMU9OyPGXXnFLf5DoKET/kzpGA8Hk8wRbuJO+Mq5Kf9tCwNO
         OEiqTaVMa3K0qH7vVrLcBXobdwHy7Yv6K1pQUzPs6djUWjhK3IGRZSG9zIQCq28pvHJn
         Hk8If0igRt4+CWHIUgUW6wl1QMtziGCL2Psg0JmtVBXLTjo2OAokrvSy9WyZ27Ukta0I
         KPllaoHGBUK9xgkz4LoCUNzy5s5JEttC8Wj4lgygEo1nByM2/DvMhnJrYPDXAs7dtZq7
         yslbJH8jUYI4+/81gNOy6byWuEdDM7Qn+ijDcSAY4Y/FK3D7OBDbk7PKGt9KC1vQD4Ts
         Hyog==
X-Gm-Message-State: AAQBX9dVWWuZY2aEN6c76UcwxaJS+tIaaZrlrMnPeVtJG1VjwqF7Co2j
        mpc9Ie7CeBKzwpgnndYsErU=
X-Google-Smtp-Source: AKy350Y2v5eztjbWcRl9seJCbcUS731FU8AR5Xc/PDH68WXzBZv5lG1Rzg23hxKoZHQ8aSN7GMoXOQ==
X-Received: by 2002:a17:907:5ce:b0:931:20fd:3d09 with SMTP id wg14-20020a17090705ce00b0093120fd3d09mr7428579ejb.17.1680813158659;
        Thu, 06 Apr 2023 13:32:38 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906844d00b0090e0a4e1bacsm1223642ejy.159.2023.04.06.13.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:32:38 -0700 (PDT)
Message-ID: <c19a93cc-2a37-4ca8-37f4-e5eee830fa4f@gmail.com>
Date:   Thu, 6 Apr 2023 22:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] sed-opal: geometry feature reporting command
Content-Language: en-US
To:     Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc:     bluca@debian.org, axboe@kernel.dk, hch@infradead.org,
        brauner@kernel.org, jonathan.derrick@linux.dev
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230406131934.340155-2-okozina@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20230406131934.340155-2-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/6/23 15:19, Ondrej Kozina wrote:
> Locking range start and locking range length
> attributes may be require to satisfy restrictions
> exposed by OPAL2 geometry feature reporting.

...

> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 3fc4e65db111..137d47a5e674 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -83,8 +83,10 @@ struct opal_dev {
>   	u16 comid;
>   	u32 hsn;
>   	u32 tsn;
> -	u64 align;
> +	u64 align; /* alignment granularity */
>   	u64 lowest_lba;
> +	u32 logical_block_size;
> +	u8  align_required; /* ALIGN: 0 or 1 */
>   
>   	size_t pos;
>   	u8 *cmd;
> @@ -409,6 +411,8 @@ static void check_geometry(struct opal_dev *dev, const void *data)
>   
>   	dev->align = be64_to_cpu(geo->alignment_granularity);
>   	dev->lowest_lba = be64_to_cpu(geo->lowest_aligned_lba);
> +	dev->logical_block_size = be32_to_cpu(geo->logical_block_size);
> +	dev->align_required = (geo->reserved01 & 0b10000000) ? 1 : 0;

I am not sure if we can use 0b prefix as it is compiler extension (not in C standard, IIRC).

Anyway, align_required returns always 0 for my test drives even when discovery shows ALIGN = 1.
Does it mask the correct bit?

Other geometry attributes work correctly.

Milan


>   }
>   
>   static int execute_step(struct opal_dev *dev,
> @@ -2956,6 +2960,26 @@ static int opal_get_status(struct opal_dev *dev, void __user *data)
>   	return 0;
>   }
>   
> +static int opal_get_geometry(struct opal_dev *dev, void __user *data)
> +{
> +	struct opal_geometry geo = {0};
> +
> +	if (check_opal_support(dev))
> +		return -EINVAL;
> +
> +	geo.align = dev->align_required;
> +	geo.logical_block_size = dev->logical_block_size;
> +	geo.alignment_granularity =  dev->align;
> +	geo.lowest_aligned_lba = dev->lowest_lba;
> +
> +	if (copy_to_user(data, &geo, sizeof(geo))) {
> +		pr_debug("Error copying geometry data to userspace\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>   int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   {
>   	void *p;
> @@ -3029,6 +3053,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>   	case IOC_OPAL_GET_LR_STATUS:
>   		ret = opal_locking_range_status(dev, p, arg);
>   		break;
> +	case IOC_OPAL_GET_GEOMETRY:
> +		ret = opal_get_geometry(dev, arg);
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 042c1e2cb0ce..bbae1e52ab4f 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -46,6 +46,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>   	case IOC_OPAL_GENERIC_TABLE_RW:
>   	case IOC_OPAL_GET_STATUS:
>   	case IOC_OPAL_GET_LR_STATUS:
> +	case IOC_OPAL_GET_GEOMETRY:
>   		return true;
>   	}
>   	return false;
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 3905c8ffedbf..dc2efd345133 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -161,6 +161,18 @@ struct opal_status {
>   	__u32 reserved;
>   };
>   
> +/*
> + * Geometry Reporting per TCG Storage OPAL SSC
> + * section 3.1.1.4
> + */
> +struct opal_geometry {
> +	__u8 align;
> +	__u32 logical_block_size;
> +	__u64 alignment_granularity;
> +	__u64 lowest_aligned_lba;
> +	__u8  __align[3];
> +};
> +
>   #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
>   #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
>   #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
> @@ -179,5 +191,6 @@ struct opal_status {
>   #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
>   #define IOC_OPAL_GET_STATUS         _IOR('p', 236, struct opal_status)
>   #define IOC_OPAL_GET_LR_STATUS      _IOW('p', 237, struct opal_lr_status)
> +#define IOC_OPAL_GET_GEOMETRY       _IOR('p', 238, struct opal_geometry)
>   
>   #endif /* _UAPI_SED_OPAL_H */
