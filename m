Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E49C433E9
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 01:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9971164DDD
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 01:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhA1Bfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:35:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2970 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhA1BfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 20:35:10 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DR2zb3tnBz5LYf;
        Thu, 28 Jan 2021 09:33:15 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 09:34:28 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 28
 Jan 2021 09:34:27 +0800
Subject: Re: [PATCH v4 1/5] blk-mq: introduce blk_mq_set_request_complete
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-2-lengchao@huawei.com> <20210127164020.GA23417@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <15301bba-f7db-a0c9-c7fa-6efaafefd21c@huawei.com>
Date:   Thu, 28 Jan 2021 09:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210127164020.GA23417@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/28 0:40, Christoph Hellwig wrote:
>> +static inline void blk_mq_set_request_complete(struct request *rq)
>> +{
>> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>> +}
> 
> This function needs a detailed comment explaining the use case.
> Otherwise we'll get lots of driver abuses.
ok, thanks.
> .
> 
