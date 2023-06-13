Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC3C88CB2
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 00:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjFMAo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 20:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjFMAo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 20:44:58 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D510D9
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 17:44:57 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-65311774e52so3879528b3a.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 17:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686617097; x=1689209097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UypmltdIzs4+pSkBSQsbhKf6E4jKVySU+odZqLwSJfM=;
        b=IFKmxhOYEqmKja39hMIeNJwTK8n0kBSYCji/kBJyAu08PB86KuS/2yfAfqRa5YR9B+
         I/WY72jUdYle50XKwE/+8kwyda8RmItiJbMKus0OoBh+Y9IuoKZzR8J5ZSVaTrxrWFH2
         LiJtAQqI27K6PpKdKG6o1rtoF80V2aRKdraKDIlspHRgmPcwXDjzi6QGGVIXntrVxFgX
         RgiTD2cLLcrLzl+6JWifyrq1z0oeCcmDEOBFBD61mscUDW3/xLzC6YaUL2kGTM3LX4yH
         yaqiOsZ02ZtTAYmqe4n75UhUsruhBF7luJXqapGhWtgRDTus+7F53jb30P4mu6YQPONo
         kq8g==
X-Gm-Message-State: AC+VfDwBJR/+jiw7A+8R/adZy2eE/ZhHzivk3U0IcsE7IKoGBLpQmbMJ
        onvhnVl7Od5n4W/T3FDGXDM=
X-Google-Smtp-Source: ACHHUZ6abto8Icq8WBCwZ6lXKV2M71SQuiIPtUWRFShd/+SECRGuUhLzgXl7nU5lFdop7v3M1XS2JA==
X-Received: by 2002:a05:6a00:b4d:b0:663:5624:6fde with SMTP id p13-20020a056a000b4d00b0066356246fdemr13223639pfo.22.1686617096644;
        Mon, 12 Jun 2023 17:44:56 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00662610cf7a8sm7609772pfo.172.2023.06.12.17.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 17:44:55 -0700 (PDT)
Message-ID: <2ec5270c-a913-44cf-3a45-0713e6c58224@acm.org>
Date:   Mon, 12 Jun 2023 17:44:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 8/8] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <20230612203314.17820-9-bvanassche@acm.org>
 <407d7371-efa2-154d-a05f-a827171806a0@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <407d7371-efa2-154d-a05f-a827171806a0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/23 15:17, Damien Le Moal wrote:
> On 6/13/23 05:33, Bart Van Assche wrote:
>> @@ -1283,7 +1293,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>>   
>>   	spin_lock_irq(&nullb->lock);
>>   	rq_for_each_segment(bvec, rq, iter) {
>> -		len = bvec.bv_len;
>> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
>> +		bvec.bv_len = len;
> 
> I am still confused by this change... Why is it necessary ? If max_segment_size
> is set correctly, how can we ever get a BIO with a bvec length exceeding that
> maximum ? If that is the case, aren't we missing a bio_split() somewhere ?

Hi Damien,

bio_split() enforces the max_sectors limit but not the max_segment_size 
limit. __blk_rq_map_sg() enforces the max_segment_size limit. null_blk 
does not call __blk_rq_map_sg(). Hence the above code to enforce the 
max_segment_size limit.

Thanks,

Bart.

