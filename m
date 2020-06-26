Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F95DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FFE2076E
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="rrseKeWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFZGDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZGDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:03:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31AC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:03:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so8212395ejq.6
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6Wa0nRrjgIPv+dA7seaYMqfaMdZ9JAfOV0yYw+e/zWI=;
        b=rrseKeWU4AqvZ9E+Mo151/SvU12F+aJUs4CINTxnd9eGX+9PY7syCuPfo1cGFbicgK
         E/3xJknpU3WG7ijqqtWS23SFmcZojho/Qv7dwgJha3tS+qX3YjVsm68t/pzWhxYd6HfG
         1cs9Jgff2ZLZH5X0vTR8tI3ikBqFUxYDFfANsUt2ewOs7rSPmalQemoOqE0XNq90ftwR
         PwaHXu5wKvj6JmITN+oGq8T4vv+yA1USTs2OGKb5BH2O3kgfuFiLe6NjXlUUOP3ogc97
         xE7K7xpdOeDliXnl3/oIf5MxrdS8zjUQT7zGXMsuwGWGA9zbCcOXh/wlNgjqEkZzQd9b
         273A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Wa0nRrjgIPv+dA7seaYMqfaMdZ9JAfOV0yYw+e/zWI=;
        b=OI2wQJje68fL+SomD4h5UqxxDGVBGTC/p9ypYY9MRlpmCO4ljSLlbfyHO2osuu6i6/
         qK7rE/YH9oWB7X9S5gRTLFyrWZEq8H4OFsj1AoECvLoP6f9jYbNkrJqZknw+H9HwekKZ
         vpfN+YJ8MFu0mxpc/oxCIcf5DJIeXkLCEhzIwZV6ya6ZvXN/Mlih+p5H9VZCkrLAKwvT
         SQ33IjPtCIgXKP+/j+0Lpzl/aKJYZ+Er+abJ8VrFhp7NO2WKPQG0iEo59PBRUXODBYek
         /wZp2HYHglsmh61QXLOO7HEtU0Qjf9/iyF2QyoeVfZficYmF6o/ZstKzn+NIZJZdx8u3
         xYng==
X-Gm-Message-State: AOAM5336iIoFG3+u0J+PK+bWH0UgzStNzBcqKG/vliLuUVZR2fivyjGO
        GWwcjc67+AfqIKEhxg6IH4QRQw==
X-Google-Smtp-Source: ABdhPJzYUtnkQQ7HWNe4Y4eBtjVkFxzMKZ23QI6QGlCbGm88ukdkCaLBHsudMb0qSETQjkDVT4MR6Q==
X-Received: by 2002:a17:906:57c6:: with SMTP id u6mr1160147ejr.194.1593151413616;
        Thu, 25 Jun 2020 23:03:33 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id d5sm2734496eds.40.2020.06.25.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:03:32 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:03:32 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200626060332.erje6ohzmhxzfaj4@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 01:45, Damien Le Moal wrote:
>On 2020/06/25 21:22, Javier González wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> Add zone attributes field to the blk_zone structure. Use ZNS attributes
>> as base for zoned block devices in general.
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  drivers/nvme/host/zns.c       |  1 +
>>  include/uapi/linux/blkzoned.h | 13 ++++++++++++-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index 258d03610cc0..7d8381fe7665 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>>  	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>> +	zone.attr = entry->za;
>>
>>  	return cb(&zone, idx, data);
>>  }
>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>> index 0c49a4b2ce5d..2e43a00e3425 100644
>> --- a/include/uapi/linux/blkzoned.h
>> +++ b/include/uapi/linux/blkzoned.h
>> @@ -82,6 +82,16 @@ enum blk_zone_report_flags {
>>  	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>>  };
>>
>> +/**
>> + * Zone Attributes
>
>This is a user interface file. Please document the meaning of each attribute.
>

Sure.

>> + */
>> +enum blk_zone_attr {
>> +	BLK_ZONE_ATTR_ZFC	= 1 << 0,
>> +	BLK_ZONE_ATTR_FZR	= 1 << 1,
>> +	BLK_ZONE_ATTR_RZR	= 1 << 2,
>> +	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
>These are ZNS specific, right ? Integrating the 2 ZBC/ZAC attributes in this
>list would be nice, namely non_seq and reset. That will imply patching sd.c.
>

Of course. I will look at non_seq and reset. Any other that should go
in here?

>> +};
>> +
>>  /**
>>   * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>>   *
>> @@ -108,7 +118,8 @@ struct blk_zone {
>>  	__u8	cond;		/* Zone condition */
>>  	__u8	non_seq;	/* Non-sequential write resources active */
>>  	__u8	reset;		/* Reset write pointer recommended */
>> -	__u8	resv[4];
>> +	__u8	attr;		/* Zone attributes */
>> +	__u8	resv[3];
>>  	__u64	capacity;	/* Zone capacity in number of sectors */
>>  	__u8	reserved[24];
>>  };
>>
>
>You are missing a BLK_ZONE_REP_ATTR report flag to indicate to the user that the
>attr field is present, used and valid.
>
>enum blk_zone_report_flags {
> 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>+	BLK_ZONE_REP_ATTR	= (1 << 1),
> };
>
>is I think needed.

Good point. I will add that on a V2.

Javier
