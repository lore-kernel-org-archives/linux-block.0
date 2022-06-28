Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C0CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 02:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245444AbiF1CtR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiF1Cs4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 22:48:56 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16122A1AE
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 19:48:18 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id z14so10900186pgh.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 19:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l7owPl8/JaAHXzXxFn60GtYyLPaftYYs5Llja/vJKGc=;
        b=Tv5AkLI4rpTYdzeHIXq4FY36nuZuC+I2VX9jIuRus/ifdJUzVnJnd6vtkTWp6fAKoD
         bEBJ92D2pmMIemIpy+SqYjYOT0wPxdtb/KcNQ3geOOUU05+cZ4KoD5Mhf7190Nk7p6sE
         wOSQ4Rw53qAWewBTN0HOzS4TeVr2ldvpC1DtYr8QdGVmV3VKwakIBuV7m4BpLEm3N/b9
         rG3JV5Kc/+98A/dk37gNHYQAZ7JxAj3JsDadjoh0AeisTfJz61ApJc5xuAmWFhReYlU4
         qLwqr1lFA38LXsBL+g5urUr29pqpBoiPncGlr2LLodFuiPT0ILUXEyIImnnusCUiufI5
         GyrA==
X-Gm-Message-State: AJIora/MXC+ap8CeA4rgWp6rKTEso6AbfIK/XLbZWDagieLXkNE1kRuC
        1SDivNSSX0C1z+USRt9wGdY=
X-Google-Smtp-Source: AGRyM1skxa64e35SNOjgV4ODhJKD4DbiJ7GctpSgqhXlONk4UOMuUb9qZ5bhwHCjvo6CxSbsgCV9Tw==
X-Received: by 2002:a05:6a00:a8e:b0:527:9d23:c613 with SMTP id b14-20020a056a000a8e00b005279d23c613mr2289040pfl.53.1656384497225;
        Mon, 27 Jun 2022 19:48:17 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k21-20020a6568d5000000b0040d5abae51esm7851705pgt.91.2022.06.27.19.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 19:48:16 -0700 (PDT)
Message-ID: <cd657392-36eb-3c1e-5891-77ec247b7ceb@acm.org>
Date:   Mon, 27 Jun 2022 19:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 7/8] nvme: Make the number of retries command specific
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20220627234335.1714393-1-bvanassche@acm.org>
 <20220627234335.1714393-8-bvanassche@acm.org>
 <f3c1e76d-34b2-6c33-11a3-88c56e2a14fa@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f3c1e76d-34b2-6c33-11a3-88c56e2a14fa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/22 17:48, Chaitanya Kulkarni wrote:
> 
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 0da94b233fed..ca415cd9571e 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -160,6 +160,7 @@ struct nvme_request {
>>    	union nvme_result	result;
>>    	u8			genctr;
>>    	u8			retries;
>> +	u8			max_retries;
>>    	u8			flags;
>>    	u16			status;
>>    	struct nvme_ctrl	*ctrl;
> 
> If I understand correctly then per command max_retries count is only
> needed for zoned devices.
> 
> why not make struct nvme_request->max_retries field and subsequent code
> configurable under CONFIG_BLK_DEV_ZONED ?
> 
> That will avoid increasing size of the nvme_request for
> !CONFIG_BLK_DEV_ZONED case where per command
> nvme_request->max_retries has no use.

Hi Chaitanya,

Thanks for the review.

We may disagree about whether or not this patch increases the size
of struct nvme_request. I think the new member fills an existing
hole and hence does not increase the size of struct nvme_request :-)

Bart.

