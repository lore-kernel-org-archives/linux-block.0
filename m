Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D139C04A95
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 20:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiIWUys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 16:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiIWUyY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 16:54:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047F115A45
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 13:54:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z191so869127iof.10
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/K/GOu02xfTZ/9xI05vqPiDNx5hkxNdjNt0qyrC4Qyw=;
        b=nvLIB0RJXe73WL+xXeF3BnfdKLnrKGY8ZDslI6lmL0cQeakLC6BCZhPiuK243GoOB4
         4c8WWHLlshW3gZOfu4mYXdYgFCEVijcufrrV3yk7klbW+ebOtX34BSloqb33h3lWwgDj
         BZ3lJ/bXZbnQnIMovtT87ZG0Y4Aii4Xf4atHWFoRryKMtvYl6VJHhJ9dkNRPfjF/UrDU
         xCpD2eFIQIb6Qb+lUeMaAAl4IgolpacRuJSWRKROeEWNyrB8gwl/OZzwwc2/GFVRH3SY
         YT/Xan5f47fBd5dlECLqU4y8pUy5sIlubvt0nLaLlHI80v8k25j3U+KF5sKm24pBmCGc
         r9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/K/GOu02xfTZ/9xI05vqPiDNx5hkxNdjNt0qyrC4Qyw=;
        b=edboyVqmxYcTu1alRzmmOpSZc1W4fBBBHv2Ph0Kmqc6gzjuKna8GcUjCAuJbp6xZbz
         K4pvxQP9IY+O88TpXi6AwyAr/rGW7mOXbd2Q9owK2L20y/1vMdpAh0gvWDrGMGvtZ3iD
         B/O8FPOey9hY+Uicy75TMgShL71ZH4Ia+LDxrKYhxRM8OXZRcrBYRnFWTkqwiZgDYtjn
         9aoS3QLioPS7IUWjRtIJVb6C5s3rCdB5rkmQQP1izO4ljhZJOJL7Ji8WAsd+dcpzQIqj
         lAyWyOJVfxY2fhFNFuzkeHtVCQ3/FFAMmvvK69elyBpIahVZFL9m7sCF4aLReYRwipvN
         QG1g==
X-Gm-Message-State: ACrzQf0HZRQshNR5kTF9iX6uRJCA22/SPKZj4GRQApA2DXQ/+3mkMot4
        FiC3TgtXA111bXzDF+zjthQNvNeLKl+ksA==
X-Google-Smtp-Source: AMsMyM7fQ9X8DI4XxBLuNaKvje1XDwW71d2cJffEU6cwqjPF4VEwKC+YAJvorV6dYRuBCbuSX+CV7Q==
X-Received: by 2002:a6b:1c7:0:b0:6a3:2e71:2a91 with SMTP id 190-20020a6b01c7000000b006a32e712a91mr4959223iob.158.1663966452346;
        Fri, 23 Sep 2022 13:54:12 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d194-20020a0262cb000000b0035a42c43e3bsm3820406jac.81.2022.09.23.13.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 13:54:11 -0700 (PDT)
Message-ID: <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
Date:   Fri, 23 Sep 2022 14:54:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, joshi.k@samsung.com,
        Pankaj Raghav <pankydev8@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-2-axboe@kernel.dk>
 <CGME20220923145245eucas1p107655755f446bb1e1318539a3f82d301@eucas1p1.samsung.com>
 <20220923145236.pr7ssckko4okklo2@quentin>
 <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/22 9:13 AM, Pankaj Raghav wrote:
> On 2022-09-23 16:52, Pankaj Raghav wrote:
>> On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
>>> The filesystem IO path can take advantage of allocating batches of
>>> requests, if the underlying submitter tells the block layer about it
>>> through the blk_plug. For passthrough IO, the exported API is the
>>> blk_mq_alloc_request() helper, and that one does not allow for
>>> request caching.
>>>
>>> Wire up request caching for blk_mq_alloc_request(), which is generally
>>> done without having a bio available upfront.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 71 insertions(+), 9 deletions(-)
>>>
>> I think we need this patch to ensure correct behaviour for passthrough:
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index c11949d66163..840541c1ab40 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>>         WARN_ON(!blk_rq_is_passthrough(rq));
>>  
>>         blk_account_io_start(rq);
>> -       if (current->plug)
>> +       if (blk_mq_plug(rq->bio))
>>                 blk_add_rq_to_plug(current->plug, rq);
>>         else
>>                 blk_mq_sched_insert_request(rq, at_head, true, false);
>>
>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>> devices:
>>
>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>> {
>> 	/* Zoned block device write operation case: do not plug the BIO */
>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>> 		return NULL;
>> ..
> 
> Thinking more about it, even this will not fix it because op is
> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
> 
> @Damien Should the condition in blk_mq_plug() be changed to:
> 
> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
> {
> 	/* Zoned block device write operation case: do not plug the BIO */
> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
> 		return NULL;

That looks reasonable to me. It'll prevent plug optimizations even
for passthrough on zoned devices, but that's probably fine.

-- 
Jens Axboe


