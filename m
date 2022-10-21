Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E98C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 15:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJUP0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJUP0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 11:26:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E024BAAC
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 08:26:41 -0700 (PDT)
Received: from frapeml500007.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mv7Yv6vwYz688NJ;
        Fri, 21 Oct 2022 23:24:51 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:26:39 +0200
Received: from [10.126.168.107] (10.126.168.107) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:26:38 +0100
Message-ID: <9346fa37-bbe6-062b-43be-729a0c362dd3@huawei.com>
Date:   Fri, 21 Oct 2022 16:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: Issue in blk_mq_alloc_request_hctx()
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, <linux-block@vger.kernel.org>
References: <b44c42f8-db20-eff8-fba4-07a64ca47918@huawei.com>
 <65e2a1ec-34b4-cb5b-06f7-410160b8da96@acm.org>
In-Reply-To: <65e2a1ec-34b4-cb5b-06f7-410160b8da96@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.168.107]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/10/2022 15:54, Bart Van Assche wrote:
> On 10/21/22 04:16, John Garry wrote:
>> -    return blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
>> +    rq = blk_mq_rq_ctx_init(&data, blk_mq_tags_from_data(&data), tag,
>>                       alloc_time_ns);
>> +    if (!rq)
>> +        goto out_queue_exit;
>> +
>> +    rq->__data_len = 0;
>> +    rq->__sector = (sector_t) -1;
>> +    rq->bio = rq->biotail = NULL;
>> +    return rq;
> 
> Hi John,
> 
> Shouldn't the new struct request member initializations be moved into 
> blk_mq_rq_ctx_init() such that all blk_mq_rq_ctx_init() callers are fixed?

That would seem reasonable. I just wonder why it was not there in the 
first place.

Anyway, I'll look to make that change.

thanks,
John
