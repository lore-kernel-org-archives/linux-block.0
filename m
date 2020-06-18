Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64DC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EF4206F7
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QWt4A4wS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFRPRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRPRe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:17:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7AC06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 08:17:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z63so2936602pfb.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FzFENWMhHswF+9xOdBLzOnnmRWo2CelZdpJYXT0hRVc=;
        b=QWt4A4wS1xIUiDUxjmPpeTraadtDAikMNEns2roxx28xfbex792Pwp1rDP2L4L0jJ5
         bCB9fF4G3elQpDS4Jlzg7FvxN47Ppd8aBsp+v24beAC06B87aARobpTgkpKiQbnQMUUY
         7EEYS/e7JQn313W1pF3lC8/hYudjLWxCBLn4K0r9edSebfzFs4JzTO0AexZrsfp8CCWS
         8lUR/VBHO1aiCe3ijXXGcZ06zyiMgB1S3IWGz29SNEYIxIvj37jL4CZPktqPYVTeIDxG
         lpnVLtLIgvy+/t2/BRXarP0JyimdX9mDOQ6M5fUjk5kqeTiZe8vdzbLQ2UvtGqd9Ts+1
         w2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FzFENWMhHswF+9xOdBLzOnnmRWo2CelZdpJYXT0hRVc=;
        b=ZnfV+nUjbs/70b8DqUQaZDuyu9TnwX1M8+Zys03UCyRRtE/mjs4mZ5p9Ptr6rYBdU1
         iMnuwYFUIK7UqL15+faz2heZ1sqfrwaHrf7PTxX62iC65ygYEt/F+PsrUXJrstCrt8SC
         YDQ2eZNLDWDNt3dGz+pELa1F20HUJEaS1SD1NKHqYvcWIndSZ40N7qCGZ1CXleDdT7iH
         zqbPUuuI9uznibY5E3AiRI14XZ+E3NuZaLPV40auj5+4KzxavAuzvX80oDftAPbZGOp5
         KVFwfI56qUNRlz/o35pT+6zQPP2mX/+VA92EflhrjgdAX4Z+Q1mLboF48ouULv3L86U8
         mEqw==
X-Gm-Message-State: AOAM530uGR3OuMKjXrXuRxAO1A0XWS0yaKVUDoaFvYEWv08MswhCxelS
        hdO3hlpP+rIAWWakKaY3WRT/JItBh+rHyA==
X-Google-Smtp-Source: ABdhPJyxsNrENXYAXiPW3kqx5inWTo3SA8gspO2WKLG+TmldTNwXkSpM77nv5A/WgNaPPdJgsFEtHg==
X-Received: by 2002:a62:8487:: with SMTP id k129mr4105310pfd.296.1592493452647;
        Thu, 18 Jun 2020 08:17:32 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w5sm3227680pfn.22.2020.06.18.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:17:31 -0700 (PDT)
Subject: Re: [PATCH v1] lightnvm: pblk: Replace guid_copy() with
 export_guid()/import_guid()
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org
References: <20200422130611.45698-1-andriy.shevchenko@linux.intel.com>
 <20200618105755.GR2428291@smile.fi.intel.com>
 <55791884-ebf2-89bf-46b2-3f032e70a0a9@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c02b2676-6e57-902f-8b2d-a37cbe3d6502@kernel.dk>
Date:   Thu, 18 Jun 2020 09:17:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <55791884-ebf2-89bf-46b2-3f032e70a0a9@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/20 5:14 AM, Matias Bjørling wrote:
> On 18/06/2020 12.57, Andy Shevchenko wrote:
>> On Wed, Apr 22, 2020 at 04:06:11PM +0300, Andy Shevchenko wrote:
>>> There is a specific API to treat raw data as GUID, i.e. export_guid()
>>> and import_guid(). Use them instead of guid_copy() with explicit casting.
>> Any comment on this?
>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c     | 5 ++---
>>>   drivers/lightnvm/pblk-recovery.c | 3 +--
>>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index b413bafe93fdd..6d4523dbf2dbb 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -988,7 +988,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>>>   	bitmap_set(line->lun_bitmap, 0, lm->lun_bitmap_len);
>>>   
>>>   	smeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
>>> -	guid_copy((guid_t *)&smeta_buf->header.uuid, &pblk->instance_uuid);
>>> +	export_guid(smeta_buf->header.uuid, &pblk->instance_uuid);
>>>   	smeta_buf->header.id = cpu_to_le32(line->id);
>>>   	smeta_buf->header.type = cpu_to_le16(line->type);
>>>   	smeta_buf->header.version_major = SMETA_VERSION_MAJOR;
>>> @@ -1803,8 +1803,7 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
>>>   
>>>   	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
>>>   		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
>>> -		guid_copy((guid_t *)&emeta_buf->header.uuid,
>>> -							&pblk->instance_uuid);
>>> +		export_guid(emeta_buf->header.uuid, &pblk->instance_uuid);
>>>   		emeta_buf->header.id = cpu_to_le32(line->id);
>>>   		emeta_buf->header.type = cpu_to_le16(line->type);
>>>   		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>>> index 299ef47a17b22..0e6f0c76e9302 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -706,8 +706,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>>>   
>>>   		/* The first valid instance uuid is used for initialization */
>>>   		if (!valid_uuid) {
>>> -			guid_copy(&pblk->instance_uuid,
>>> -				  (guid_t *)&smeta_buf->header.uuid);
>>> +			import_guid(&pblk->instance_uuid, smeta_buf->header.uuid);
>>>   			valid_uuid = 1;
>>>   		}
>>>   
>>> -- 
>>> 2.26.1
>>>
> Andy, it looks good to me.
> 
> Jens, there is three outstanding patches for LightNVM in this round. 
> Would you like me to round them up and submit a pull request, or would 
> you like to pick them up separately?

Please just send a pull request, makes it easier for me.

-- 
Jens Axboe

