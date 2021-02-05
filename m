Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB623C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F00164F87
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBECDD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:03:03 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4606 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBECDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 21:03:02 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DWzD16hg1zY5t0;
        Fri,  5 Feb 2021 10:01:05 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 5 Feb 2021 10:02:17 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 5 Feb
 2021 10:02:17 +0800
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210203161455.GB4116@lst.de>
 <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
 <20210204080442.GA30542@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <47992bb8-3f37-ac6a-1544-e2cd30caefae@huawei.com>
Date:   Fri, 5 Feb 2021 10:02:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210204080442.GA30542@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/2/4 16:04, Christoph Hellwig wrote:
> On Thu, Feb 04, 2021 at 01:56:34PM +0800, Chao Leng wrote:
>> This looks good to me.
>> Thank you very much.
> 
> Thanks a lot to you!
> 
> Please double check there version here:
> 
> http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.12
Looks good.
> .
> 
