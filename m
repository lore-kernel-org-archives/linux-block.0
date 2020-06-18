Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6771DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBE207D8
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 11:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="srNQCLyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFRLPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgFRLO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 07:14:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9429C06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 04:14:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so5597009wrm.13
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HhS6J6QIgSlraVwU1reISmZ50/T7lrvBlrarxDVThMM=;
        b=srNQCLylt6PWW77F2Q6epaXk+socjZITXSqyIJJhXmDm5lBwlVUaInTBmQsVWpG6RO
         g+JeS+7vLSP4GloE7TEXDNFO7Ue38xcmt8ZDAPJ/wyvTU16EGPim38u4hjT1BWx3qC/J
         Hy5jad6k38AZAc+8vX6gFCQHX7s49jbawHEkmV1x5DY+6DuZcx3hy0/hpVWthL3ghLJ8
         fPMtJZCLwHXALOrmI4N5F8xIGcFHE5aIMPiW1vaPEQZIQRny3KG5mCrZzPBH6LwESWCy
         Jl6+pohEep/J5D4qo2L8lOcrRsmdwkQd+d9geLBMKWLQVrw7+lPw0p7nJ3AC7mKkT9nr
         P/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HhS6J6QIgSlraVwU1reISmZ50/T7lrvBlrarxDVThMM=;
        b=g4dVmiIuwYndFQ9mGI0bJj66/FYMqWZE/LfM4lvaiogmSko51bEbRlJsG2tymcw/mj
         cHKndDo0JeTmqNsFhOuQd7A5eoPxYQ661zF7phWBPt5JIdNdQK37v7K69XdnIRzJgRKX
         UNbjF1ZXW04Bx5/hQl2qRN+uFPq6j8xeBmRD8/K03MH9gjLbZQ+JhtUQjMekzbVA/yxl
         jDb+/qYj9uzZMUFR+8p17BFY9sa62a5o9pQekOkw71e93o8dNjB2Gd1s8RyIrD3OR0RG
         0kNBtjQT6M27pN9G5UmIUNifeVrMtUvt2ouTyxw3r7VdVwyGcNz0CmFHjd+R4xn+D3n4
         8Ehg==
X-Gm-Message-State: AOAM532yuh1nerps2MarjUgF3r6bOGQa5nsmjbwZerXMudZagHEBeFer
        l6sxenQYVtOc56tfY7t3PxH/ty6gV0s=
X-Google-Smtp-Source: ABdhPJx8mEN1PqVPdwbDgoRDG8+QyjmdMCL32bwqDW5OdAa7cGtaqfR10Aat414RqGWHYtZmmHtUUw==
X-Received: by 2002:adf:a306:: with SMTP id c6mr4112323wrb.122.1592478897606;
        Thu, 18 Jun 2020 04:14:57 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id b201sm3173994wmb.36.2020.06.18.04.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 04:14:57 -0700 (PDT)
Subject: Re: [PATCH v1] lightnvm: pblk: Replace guid_copy() with
 export_guid()/import_guid()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20200422130611.45698-1-andriy.shevchenko@linux.intel.com>
 <20200618105755.GR2428291@smile.fi.intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <55791884-ebf2-89bf-46b2-3f032e70a0a9@lightnvm.io>
Date:   Thu, 18 Jun 2020 13:14:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618105755.GR2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/06/2020 12.57, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 04:06:11PM +0300, Andy Shevchenko wrote:
>> There is a specific API to treat raw data as GUID, i.e. export_guid()
>> and import_guid(). Use them instead of guid_copy() with explicit casting.
> Any comment on this?
>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/lightnvm/pblk-core.c     | 5 ++---
>>   drivers/lightnvm/pblk-recovery.c | 3 +--
>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index b413bafe93fdd..6d4523dbf2dbb 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -988,7 +988,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>>   	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
>>   
>>   	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
>> -	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
>> +	export_guid(smeta_buf->header.uuid, &pblk->instance_uuid);
>>   	smeta_buf->header.id = cpu_to_le32(line->id);
>>   	smeta_buf->header.type = cpu_to_le16(line->type);
>>   	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
>> @@ -1803,8 +1803,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
>>   
>>   	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
>>   		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
>> -		guid_copy((guid_t *)&emeta_buf->header.uuid,
>> -							&pblk->instance_uuid);
>> +		export_guid(emeta_buf->header.uuid, &pblk->instance_uuid);
>>   		emeta_buf->header.id = cpu_to_le32(line->id);
>>   		emeta_buf->header.type = cpu_to_le16(line->type);
>>   		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 299ef47a17b22..0e6f0c76e9302 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -706,8 +706,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>>   
>>   		/* The first valid instance uuid is used for initialization */
>>   		if (!valid_uuid) {
>> -			guid_copy(&pblk->instance_uuid,
>> -				  (guid_t *)&smeta_buf->header.uuid);
>> +			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
>>   			valid_uuid = 1;
>>   		}
>>   
>> -- 
>> 2.26.1
>>
Andy, it looks good to me.

Jens, there is three outstanding patches for LightNVM in this round. 
Would you like me to round them up and submit a pull request, or would 
you like to pick them up separately?

Thank you, Matias

