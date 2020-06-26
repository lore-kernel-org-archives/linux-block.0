Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3096BC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F402F2076E
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 06:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="PCtR5uzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgFZGtl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZGtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 02:49:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C15C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:49:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so6056594edr.12
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tGyvC7aD/nKPwlz3EkMHVqwcl4yrJwWIm4ok1mb5AU0=;
        b=PCtR5uzRaA4teCUGfCpfb3i5VeKwWwDiJt+qVZpSOjwhEzDzFIkavujreygaMCBzMi
         mlDvtLFE5+jya+WIDAYrFu5wDlYBFJ9gNNpCcTACfUa8YnTPvF62sDxakZ/+IClKQbdT
         gVFrwYRHgyTW3j6krotL/LkQ/kaLUfZIcEjMAM9q1KcLmZUaqw8031iEt6IXizW5ZnZi
         5xQ55TEG6y5lU10HfJiVGfhY8+jFOkso/eEAtHN72O0+iDrqC6t8dF96KNXcbn4tU40A
         shy0Nz1/HauGvGIVRuRhyFl0XNioB04xj+5VbN4w8H3lzo2b/ysDICH5ro/ldg/W9mmc
         opqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tGyvC7aD/nKPwlz3EkMHVqwcl4yrJwWIm4ok1mb5AU0=;
        b=JvgezOcYXU7M6l0tjrIhR3vgCXR954oCTnLaMuwj//6atPE8b13XEAsStDVBWeWHMz
         gUQ0irAlkJDHrFyZceiXbV3eBo82lDCz9ocKq7N6iDjovUCpeLUrkLNudAxpCpnnTyYf
         NiHHe8E2xGJJKceNOrfEvC4SFSk1f2yR2tGsPe+Yawt3/Vue+asxZdw3QvT6kSpXkBcd
         K4NoeYBNYf5491IG/5v2tC/+FAop/jIXxTYptDIgax2xvPxRWcbA7wHRXhosFOrMYR0c
         IeddckSstBYhmF5vj0qq32IGxhawxj4s+iTeOc0nQwBjGjgI+w13hVHTcHkXDNXNOlhc
         u/gw==
X-Gm-Message-State: AOAM533J2vDfhnaKuqoBFFUbfCEXh1v5EsB6Jpq2EgHJ+QsdBjoxvn3V
        ZyH1dwDe7gRm0yk0ruJ2lXNJFQ==
X-Google-Smtp-Source: ABdhPJxHO0g8pV5on8q+mYSasErJil68s5nGRDswzUD8GkRN4rk5PEuDbjcC72kpRVNIX+otnuqHHw==
X-Received: by 2002:aa7:d446:: with SMTP id q6mr1936003edr.218.1593154179222;
        Thu, 25 Jun 2020 23:49:39 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id t21sm13046960ejr.68.2020.06.25.23.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:49:38 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:49:38 +0200
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
Message-ID: <20200626064938.wuwofgh64qef5ygu@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <CY4PR04MB3751FFD1B1D2003B48465C64E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060332.erje6ohzmhxzfaj4@mpHalley.localdomain>
 <CY4PR04MB3751CFFB03844247C3177071E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751CFFB03844247C3177071E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 06:38, Damien Le Moal wrote:
>On 2020/06/26 15:03, Javier González wrote:
>> On 26.06.2020 01:45, Damien Le Moal wrote:
>>> On 2020/06/25 21:22, Javier González wrote:
>>>> From: Javier González <javier.gonz@samsung.com>
>>>>
>>>> Add zone attributes field to the blk_zone structure. Use ZNS attributes
>>>> as base for zoned block devices in general.
>>>>
>>>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>> ---
>>>>  drivers/nvme/host/zns.c       |  1 +
>>>>  include/uapi/linux/blkzoned.h | 13 ++++++++++++-
>>>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>>> index 258d03610cc0..7d8381fe7665 100644
>>>> --- a/drivers/nvme/host/zns.c
>>>> +++ b/drivers/nvme/host/zns.c
>>>> @@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>>>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>>>>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>>>>  	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>>>> +	zone.attr = entry->za;
>>>>
>>>>  	return cb(&zone, idx, data);
>>>>  }
>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>>> index 0c49a4b2ce5d..2e43a00e3425 100644
>>>> --- a/include/uapi/linux/blkzoned.h
>>>> +++ b/include/uapi/linux/blkzoned.h
>>>> @@ -82,6 +82,16 @@ enum blk_zone_report_flags {
>>>>  	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>>>>  };
>>>>
>>>> +/**
>>>> + * Zone Attributes
>>>
>>> This is a user interface file. Please document the meaning of each attribute.
>>>
>>
>> Sure.
>>
>>>> + */
>>>> +enum blk_zone_attr {
>>>> +	BLK_ZONE_ATTR_ZFC	= 1 << 0,
>>>> +	BLK_ZONE_ATTR_FZR	= 1 << 1,
>>>> +	BLK_ZONE_ATTR_RZR	= 1 << 2,
>>>> +	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
>>> These are ZNS specific, right ? Integrating the 2 ZBC/ZAC attributes in this
>>> list would be nice, namely non_seq and reset. That will imply patching sd.c.
>>>
>>
>> Of course. I will look at non_seq and reset. Any other that should go
>> in here?
>
>See ZBC specs. These are the only 2 zone attributes defined.

Good. We will add this in V2.

Javier
