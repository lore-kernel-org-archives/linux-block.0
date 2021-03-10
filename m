Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1869DC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 01:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73E0650F2
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 01:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCJBNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 20:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCJBNq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 20:13:46 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EAAC06174A;
        Tue,  9 Mar 2021 17:13:46 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a4so10251547pgc.11;
        Tue, 09 Mar 2021 17:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HAvrErAtPddyjYyJYAyf788CsMnyM1RI7DtELqfq+ic=;
        b=RV+aERCThFCVgscdZboFZd7Uq+eloAhBXvO9Xw8cETG9WOBDmcUXxdna+bRNwZzXco
         d25hyE6VQJRqwsvsErDGzftMheK8lZkdl7xUVC81IFN6FKLHN5rukiTIYGmGqbwLSGaj
         lRxv87zD6w+W+5U9BDHbioH3ExjdLWzyBxZldHquLWG/1LAa4x1NTre6GH57uhSXmiNv
         Afhw+9H8GmfFJri4NmOCEZqkWpQU8MqJrlQS62XoIOUCcui4ihhAz9a6edkYWuBGgi82
         aXLD91kyXanfntaYGvGEokLEKtu9Po/sPRs2NgUcDFZA//Y6EdCITBsbOqs/LSVPAoAN
         5kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HAvrErAtPddyjYyJYAyf788CsMnyM1RI7DtELqfq+ic=;
        b=HKOa77o7SZD/qDbFfO1cPAkZLyDi+95mADbvFWeUuzGo/AVNcZC7fNF3smn65kzd5z
         gKzqQRaM2lN6zdDejj+fNFI8+i6JNn22H7LB/1wMZXTvcQPjxhc9bCc4uvN4C18nsGtq
         uU/qUeV+mpLHRRi8NPOGrKBUnJC6zte0DBBFx9lhJNJg1BJaSxwqj4FHbDm0u68Q6voS
         mEIYuIJ+r8hckds2YfrvpXrwLpwSDHMoKPVi3s4q59hxq59hf6RW/ShrK//NDcTgOafL
         /HEv966WU8elkOBQVEdSXFvDYkB1ZxUnkHvYRiCtpPHCda3kPyOTYOPFJohCdK8foX6e
         P//w==
X-Gm-Message-State: AOAM5328xBMBeanQw+VH6JbZwOEA2w1Xw91bKQYbyBzZZAm5Ruui54PV
        Wy8drvjoEJAUNnL3BEmZevW/+dnwLM5+nZhb
X-Google-Smtp-Source: ABdhPJwGBk0Dixui9JMCtm7RGKjxDs5DtOcvorAnSHG6EIX9f+zAin4cuiqNJaMEBLXmUsu7Ob98Kw==
X-Received: by 2002:a63:ab05:: with SMTP id p5mr516446pgf.149.1615338825867;
        Tue, 09 Mar 2021 17:13:45 -0800 (PST)
Received: from [10.38.0.14] ([45.135.186.59])
        by smtp.gmail.com with ESMTPSA id s28sm14629138pfd.155.2021.03.09.17.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 17:13:45 -0800 (PST)
Subject: Re: [PATCH] block: rsxx: fix error return code of rsxx_pci_probe()
To:     Jens Axboe <axboe@kernel.dk>, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210308100554.10375-1-baijiaju1990@gmail.com>
 <cf2dd66c-0e1e-944e-f4c5-542095f6c9d7@kernel.dk>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <0a0a6160-f469-9be8-a9e2-3067c02f0b57@gmail.com>
Date:   Wed, 10 Mar 2021 09:13:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cf2dd66c-0e1e-944e-f4c5-542095f6c9d7@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/3/10 4:59, Jens Axboe wrote:
> On 3/8/21 3:05 AM, Jia-Ju Bai wrote:
>> Some error handling segments of rsxx_pci_probe() do not return error code,
>> so add error code for these segments.
>>
>> Fixes: 8722ff8cdbfa ("block: IBM RamSan 70/80 device driver")
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/block/rsxx/core.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
>> index 63f549889f87..6b3b9b31a3e8 100644
>> --- a/drivers/block/rsxx/core.c
>> +++ b/drivers/block/rsxx/core.c
>> @@ -760,13 +760,17 @@ static int rsxx_pci_probe(struct pci_dev *dev,
>>   	pci_set_drvdata(dev, card);
>>   
>>   	st = ida_alloc(&rsxx_disk_ida, GFP_KERNEL);
>> -	if (st < 0)
>> +	if (st < 0) {
>> +		st = -ENOMEM;
>>   		goto failed_ida_get;
>> +	}
>>   	card->disk_id = st;
>>   
>>   	st = pci_enable_device(dev);
>> -	if (st)
>> +	if (st) {
>> +		st = -EIO;
>>   		goto failed_enable;
>> +	}
>>   
>>   	pci_set_master(dev);
> Maybe there are some valid parts to the patch, but the two above at
> least make no sense - we're returning the error here as passed from
> ida_alloc or pci_enable_device, why are you overriding them?
>

Ah, sorry for these incorrect parts...
I will send a new patch.


Best wishes,
Jia-Ju Bai
