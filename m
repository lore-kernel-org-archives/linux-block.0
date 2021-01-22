Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD117C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A203922B43
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAVBrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:47:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4145 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbhAVBrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 20:47:36 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DMMXj2DXmzY1f8;
        Fri, 22 Jan 2021 09:45:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:46:42 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:46:42 +0800
Subject: Re: [PATCH v3 2/5] nvme-core: introduce complete failed request
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-3-lengchao@huawei.com> <20210121084150.GB25963@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <c833e26b-623e-47f5-2493-13cb83014905@huawei.com>
Date:   Fri, 22 Jan 2021 09:46:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210121084150.GB25963@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/21 16:41, Christoph Hellwig wrote:
>> +static inline void nvme_complete_failed_req(struct request *req)
> 
> I think the name is too generic, and the function also needs a little
> comment, especially as it forces a specific error code.
Ok, thank you for your suggestion. Use error status as a parameter may
be a better choice.
> 
>> +{
>> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>> +	blk_mq_set_request_complete(req);
>> +	nvme_complete_rq(req);
>> +}
> 
> Also no need to mark this as an inline function.
Yes, export the function is ok.
> .
> 
