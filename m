Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB5BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 06:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DD923977
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 06:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhANGvT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:51:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2543 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbhANGvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 01:51:19 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DGZg9565kzQsZj;
        Thu, 14 Jan 2021 14:49:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:50:37 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:50:36 +0800
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_set_request_complete
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-2-lengchao@huawei.com>
 <6ce3e173-4ac3-e84d-88ca-76057a8d8e1e@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <5868f270-9fda-be39-808d-929e270f52dc@huawei.com>
Date:   Thu, 14 Jan 2021 14:50:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6ce3e173-4ac3-e84d-88ca-76057a8d8e1e@grimberg.me>
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



On 2021/1/14 8:17, Sagi Grimberg wrote:
> 
>> In some scenarios, nvme need setting the state of request to
>> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
>> For details, see the subsequent patches.
> 
> Its kinda difficult to understand the meaning of all of this...
> the cover letter tells us nothing, and patches 1/2 also tells us
> to see subsequent patches.
> 
> This is saved in the git change log history, so please try
> describe what it is you are going with this, even if there are
> overlaps between patches.
ok, thanks for your suggest.
> .
