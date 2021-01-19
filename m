Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742BDC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 01:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBD220878
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 01:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392759AbhASBvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 20:51:00 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2355 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392748AbhASBu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 20:50:58 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DKWlK2W61z13M0X;
        Tue, 19 Jan 2021 09:48:29 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 19 Jan 2021 09:50:16 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Tue, 19
 Jan 2021 09:50:15 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Christoph Hellwig <hch@lst.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <kbusch@kernel.org>, <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
 <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
 <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
 <20210118174913.GA8700@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <2483994e-1bc2-8d80-468e-94b898b7dc09@huawei.com>
Date:   Tue, 19 Jan 2021 09:50:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210118174913.GA8700@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/19 1:49, Christoph Hellwig wrote:
> On Mon, Jan 18, 2021 at 11:22:16AM +0800, Chao Leng wrote:
>>> Well, certainly this one-shot always return 0 and complete the command
>>> with HOST_PATH error is not a good approach IMO
>> So what's the better option? Just complete the request with host path
>> error for non-ENOMEM and EAGAIN returned by the HBA driver?
> 
> what HBA driver?
mlx4 and mlx5.
> .
> 
