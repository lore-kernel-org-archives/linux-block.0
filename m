Return-Path: <SRS0=uy3D=AZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E417FC433E1
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 08:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9692193E
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 08:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="irw3nMlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGNIZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNIZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jul 2020 04:25:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA7C061755
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2020 01:25:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so16180674edb.13
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2020 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xZ2OdY0qIdsBZAj8mtj7FWcdDgOIO8FGxK3quwm7nbQ=;
        b=irw3nMlpEhpItOFgii5ezupRLDs822w8JZUO1WtN+SNiTdnNcxc5ZmJlLOd2QNhW+f
         ENyYHquwkrD5alooj8VhAmnqwO87kdp30q6jkW93BKWDk9XNwp9GEiUuMTuYNu4ICOld
         haEH4fHnXaiVVPfO3YyvT9ZMCCHTZO3FWbmCUZRBCxLM3RZIoF1Yo4Trzf0IJeHT4pH4
         kCvezGkaQuKZX3dlg7XP+i5aPQ087aOBZROS6jROVmbzlwq5s7M0DnROUdjbFG/oF+Xb
         knq05bplZofSSET39mLRmzsXjQPn6BqNrL6KsHoFASBkFJvXHvg6yR574LBzgWl5xkSs
         oucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xZ2OdY0qIdsBZAj8mtj7FWcdDgOIO8FGxK3quwm7nbQ=;
        b=ZY/AQXu4ztNror8wBxGK9g7x/bXeF8uFkXPANagWMhjWYEfrKQrctRhMCuK2rZ11vg
         NUDWSbkhAG7OcuYnj0pH1wp5u4zmV5aXIMMuo7RIMN3iFTQ5ALAnwBD0L/7QIluMbHMO
         3tTGnLnqjaTD5OgJ3Ua6bNBmHt8v0XH4lajYARNwg5PirqnEjEkSG5l1ZzLZ3gK0hp9r
         cVk1zd+1Df6ziss+OZDA6Qf72L/GSBuaSQ0PKM53ea0urrJDpLmQu94x3+IQ7oXAA+r/
         LGcZs8JYYk2PhydE5ZFdo0KUX1xU6l37qO2aDQn769B3s5VgOQU2+Y/WqIxEHGPVA3B8
         M/IQ==
X-Gm-Message-State: AOAM5312hypMU2Szk2vrvb9cepop4Gni2OXijg+oE5Cy/lg/LG7dZTi2
        YhfUiGbVEN9t8unjnbpM0PBma4C/1A4=
X-Google-Smtp-Source: ABdhPJyMggBzX4Yku1DHwLGv0JVpX1wZkBUNy4U32J8Rv0Nei2A9NxKExiGJvO85/hCO4xYrg/0jvw==
X-Received: by 2002:a05:6402:17ee:: with SMTP id t14mr3371340edy.359.1594715104151;
        Tue, 14 Jul 2020 01:25:04 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4814:b400:587:bfc1:3ea4:c2f6? ([2001:16b8:4814:b400:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id m14sm11774133ejx.80.2020.07.14.01.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 01:25:03 -0700 (PDT)
Subject: Re: [PATCH RFC V2 1/4] block: add a statistic table for io latency
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
 <20200713211321.21123-2-guoqing.jiang@cloud.ionos.com>
 <SN4PR0401MB3598BB82CD8660B4A8ACBC479B610@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <62737df2-482a-7efc-1dcb-2b9ac5e89392@cloud.ionos.com>
Date:   Tue, 14 Jul 2020 10:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598BB82CD8660B4A8ACBC479B610@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/20 9:43 AM, Johannes Thumshirn wrote:
> On 13/07/2020 23:14, Guoqing Jiang wrote:
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index d9d632639bd1..036eb04782de 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1411,6 +1411,34 @@ static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>>   	}
>>   }
>>   
>> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>> +/*
>> + * Either account additional stat for request if req is not NULL or account for bio.
>> + */
>> +static void blk_additional_latency(struct hd_struct *part, const int sgrp,
>> +				   struct request *req, unsigned long start_jiffies)
>> +{
>> +	unsigned int idx;
>> +	unsigned long duration, now = READ_ONCE(jiffies);
>> +
>> +	if (req)
>> +		duration = jiffies_to_nsecs(now) - req->start_time_ns;
>> +	else
>> +		duration = jiffies_to_nsecs(now - start_jiffies);
>> +
>> +	duration /= NSEC_PER_MSEC;
>> +	duration /= HZ_TO_MSEC_NUM;
>> +	if (likely(duration > 0)) {
>> +		idx = ilog2(duration);
>> +		if (idx > ADD_STAT_NUM - 1)
>> +			idx = ADD_STAT_NUM - 1;
>> +	} else
>> +		idx = 0;
>> +	part_stat_inc(part, latency_table[idx][sgrp]);
>> +
>> +}
>> +#endif
>> +
>>   static void blk_account_io_completion(struct request *req, unsigned int bytes)
>>   {
>>   	if (req->part && blk_do_io_stat(req)) {
>> @@ -1440,6 +1468,9 @@ void blk_account_io_done(struct request *req, u64 now)
>>   		part = req->part;
>>   
>>   		update_io_ticks(part, jiffies, true);
>> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
>> +		blk_additional_latency(part, sgrp, req, 0);
>> +#endif
> Not commenting on the general idea here but only the code. The above introduces quite a
> lot of ifdefs in code. Please at least move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT
> into the function body of blk_additional_latency() so you don't need any ifdefs at the
> call sites.

Sure, will do it, thanks for your suggestion.

Thanks,
Guoqing
