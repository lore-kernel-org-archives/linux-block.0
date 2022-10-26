Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC55CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiJZNC5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiJZNC4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 09:02:56 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F075F9841
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 06:02:56 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id g12so13411169wrs.10
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 06:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtrfWAcgGb0M/SBvYB4J30r7X8J7A6DigDTfmctW7LU=;
        b=0LD7i9UALdE06NdYir+dby4XWM44mqLQH0x9DyyPvWRKI6mVlZYqcNCJ8LoQJaaQZY
         v8mjeheGquKHqjTUGunmYM7f5+LJih5NN+sOVzm4EvGxsAyqxWOk0W2fxLsW8ejTXzdV
         VM8ZlAWBTzOPRvqrgNCz8QToLLzOvNvpk5J/7DqYuZsDfrGFqNXNdbavzuE4u7jIiW9S
         AAh7EUxBPJdTpsYFY2kK99qBCqq3tIG1IrqYZlzUWaTOB71de/NjtjIvRSfx/+fU7vAg
         rvKoLlw3IF0YMatiwhObPCRIUK8X/NQWba73x+hUAFMarE/VSEmGQp/QbUYbbbA63HsT
         XX1A==
X-Gm-Message-State: ACrzQf3zupHAAtIMZf5JhDbKp1oA0UG+E7STDEHZ4pzQ8eiPVuDtGUas
        QkrKC9P3AoU4yZopvio1QVU=
X-Google-Smtp-Source: AMsMyM4gUCtZTDq9YICmQjTiN7WWJY9Q2lnJCPmzBs0h6XilL3FEW4eISqYfrPlE2de9D6/ZZqemTQ==
X-Received: by 2002:adf:f989:0:b0:236:5730:62f1 with SMTP id f9-20020adff989000000b00236573062f1mr17835966wrr.98.1666789374715;
        Wed, 26 Oct 2022 06:02:54 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b003c452678025sm2046253wmo.4.2022.10.26.06.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:02:53 -0700 (PDT)
Message-ID: <ec2b88b5-9335-4ed2-3a25-ff7850df720f@grimberg.me>
Date:   Wed, 26 Oct 2022 16:02:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 16/17] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-17-hch@lst.de>
 <05e7fdd0-a2fc-2944-679a-dac3d4755f14@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <05e7fdd0-a2fc-2944-679a-dac3d4755f14@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> @@ -315,6 +315,31 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +
>> +    mutex_lock(&set->tag_list_lock);
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +        if (!blk_queue_skip_tagset_quiesce(q))
>> +            blk_mq_quiesce_queue_nowait(q);
>> +    }
>> +    blk_mq_wait_quiesce_done(set);
>> +    mutex_unlock(&set->tag_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
>> +
>> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +
>> +    mutex_lock(&set->tag_list_lock);
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +        blk_mq_unquiesce_queue(q);
> We should add the check of blk_queue_skip_tagset_quiesce() to keep 
> consistent
> with blk_mq_quiesce_tagset(), it doesn't make much sense, but maybe look 
> a little better.
>          if (!blk_queue_skip_tagset_quiesce(q))
>              blk_mq_unquiesce_queue(q);

I agree.
