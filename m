Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169AC43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50FF21939
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 21:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1+v/Jwlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbeLVVpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 16:45:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34929 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeLVVpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 16:45:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so4079311plo.2
        for <linux-block@vger.kernel.org>; Sat, 22 Dec 2018 13:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KLMNWOQ40plTVNd2ahJsYnqWBM3pkzqAgp5g9Es2Xrk=;
        b=1+v/JwltAndTiznvMM0g/rGwRcUrQqSelg9n9j91pTAG69+ohYNbBXdxp3POf13j2b
         u72CEzVE27K+DAw38qQS0EXQU3A5msSEejHqWLB6Xklrax1OyYKPojmm+YxALUnmOfjT
         RmPQidcIGJNDNTYALXUDQhvAXVv2vGmgh4O08AQ8lM7jHk9PxpLAkOab3h+PJIcRtkrK
         lq/dQPWsEJioU1Gsf1sxhND1dtSwkJy+lfTiIGarxuuiB/3c6LPclKUVrsRyTQhEwpQE
         wsV3sU4Btbx43hxJG9eeZTZRMFAZ7VBGAWD/SsIkwjbkrkomWVU3Ll+JOx+AWBO2JOd0
         iviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLMNWOQ40plTVNd2ahJsYnqWBM3pkzqAgp5g9Es2Xrk=;
        b=GfYWkmBJMQNCF9RWMhAICyQ38MM67YPkWxcsQMY/x+nGUAAYX8+tCK6f3Fm+ZofmrE
         hf/ommme09MEE0Dg+VYtgtHROXdrnYbnkhEePEn72DZiFmEp2DYvtvMXMvtuePVxwowT
         /rw1o+c4mjpJeiLvrLGVv0HB7J41k3cAOQgbNekaUaMkjBduTj6VIWVzuBURTfxkqjbF
         9OBhnM4cjhDFEg+aqzFLm9JNAawM+Eq+TsmPEMWAiC+B0XMSEpP2Sq7BFa/QCyTpeCef
         qPXGgAsUh/u8n4YeixDQMJpHAhnuTGnDhB+IVqrhURS36AN4nqpu8sL3UySHOUSNayXc
         lP+g==
X-Gm-Message-State: AJcUukesy3z8NRe1ZD7sH8GwPStmdezLXcQlWNhmUBp1BlV0diX9tNaL
        GO2glgsMNQvHW8OuAeMrhbXFUw==
X-Google-Smtp-Source: ALg8bN7iFwu0fUYL4DM++5oDsmWkdlt7pA3at1eB7neDOCAstqsf2vcXndYDYGkKkXaAFkMWFlVmzg==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr7558255pla.252.1545515120614;
        Sat, 22 Dec 2018 13:45:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 196sm105308844pfc.77.2018.12.22.13.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 13:45:19 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: fix use-after-free bug
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Igor Konopko <igor.j.konopko@intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181222073952.GA11561@embeddedor>
 <1992ea52-cc13-c704-4653-7fbe667b1c5a@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06e20d48-1029-6dad-6037-d88e13a1708e@kernel.dk>
Date:   Sat, 22 Dec 2018 14:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1992ea52-cc13-c704-4653-7fbe667b1c5a@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/18 11:30 AM, Matias Bjørling wrote:
> On 12/22/18 8:39 AM, Gustavo A. R. Silva wrote:
>> Remove one of the calls to function bio_put(), so *bio* is only
>> freed once.
>>
>> Notice that bio is being dereferenced in bio_put(), hence leading to
>> a use-after-free bug once *bio* has already been freed.
>>
>> Addresses-Coverity-ID: 1475952 ("Use after free")
>> Fixes: 55d8ec35398e ("lightnvm: pblk: support packed metadata")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/lightnvm/pblk-recovery.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 3fcf062d752c..5ee20da7bdb3 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -418,7 +418,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>>   	if (ret) {
>>   		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>   		bio_put(bio);
>> -		bio_put(bio);
>>   		return ret;
>>   	}
>>   
>>
> 
> Thanks Gustavo. I missed that one.
> 
> Jens, if possible could you please pick this up?

Yep, added for the later pull.

-- 
Jens Axboe

