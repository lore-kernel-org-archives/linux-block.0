Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D927C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 23:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJTXee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJTXec (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 19:34:32 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C36AE5B
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 16:34:29 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id f140so997956pfa.1
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 16:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOlRtr7pOh6Yq2YFHY8zxg0oyrmvCgO9VPnOMKNIW5M=;
        b=qNqzMvhlLnMoK2kVV76kZXQvttMSPxrU15VjPnjH6rXJ5h9l2VqAcQ+Muxy/oq8xXf
         LutmnBGIwyirXfcToQZJtleGD00fM8Mwp7eO6AzLjb9q3zSIFeQa38XiwysgwS2wG0TX
         LdA/k/1OdJfV/+wysXANlk3GW6JNrh0tm/uTWlxetsR/DznPMhz8YSRSJ8rcVpjHl1WR
         1Q2wTXIlrbO81QaACl6qKnWxUNOz3rTFWI/EWRvQzU0rfZZlBTpTaErtdFnQLf5MHJRw
         fgXxGnvHipeF+hOiiq/w8zAhqfrfEOAztDZaXBTS1nQ/JjaTBG6U2grJ3F4aIEEKMb4B
         XzEA==
X-Gm-Message-State: ACrzQf0AYt9qVXQ0HRsKs1hb/pJHwgfQEvebZTvr/plSDObKPIli2e0k
        641FaIER6mXZB85zjhIsslc=
X-Google-Smtp-Source: AMsMyM6JZ1zEzP97wtN0idaQqYZSFv+KFFM2ozdLla576361MvlD9YUlaKKxFHXcjMG+qX18IYt0cg==
X-Received: by 2002:a63:8aca:0:b0:45c:71c5:81e5 with SMTP id y193-20020a638aca000000b0045c71c581e5mr13070112pgd.505.1666308868651;
        Thu, 20 Oct 2022 16:34:28 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902860700b001789ee5c821sm13286985plo.61.2022.10.20.16.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 16:34:27 -0700 (PDT)
Message-ID: <5856bd90-9a7f-09c1-3749-2c98c42bfcde@acm.org>
Date:   Thu, 20 Oct 2022 16:34:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 10/10] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yu Kuai <yukuai3@huawei.com>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-11-bvanassche@acm.org>
 <6a72dd3a-2b84-9345-9782-1ef2fe9caa07@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6a72dd3a-2b84-9345-9782-1ef2fe9caa07@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 16:13, Damien Le Moal wrote:
> On 10/20/22 07:23, Bart Van Assche wrote:
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 1f154f92f4c2..bc811ab52c4a 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -157,6 +157,10 @@ static int g_max_sectors;
>>   module_param_named(max_sectors, g_max_sectors, int, 0444);
>>   MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
>>   
>> +static unsigned int g_max_segment_size = 1UL << 31;
> 
> Nit: UINT_MAX ?

Hi Damien,

That would be a valid alternative. I will consider changing the value 
into UINT_MAX.

>> @@ -2088,6 +2100,7 @@ static int null_add_dev(struct nullb_device *dev)
>>   	nullb->q->queuedata = nullb;
>>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>>   	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
>> +	blk_queue_flag_set(QUEUE_FLAG_SUB_PAGE_SEGMENTS, nullb->q);
> 
> Where is this defined ? I do not see this flag defined anywhere in Linus
> tree nor in Jens for-next...

That flag has been defined in patch 05/10 of this series.

In case you would like to take a look, the code I used to test this 
series is available here: 
https://github.com/bvanassche/blktests/commits/master

Thanks,

Bart.
