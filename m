Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E5C32771
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 03:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC01C2187F
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 03:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgAMDWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:22:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733020AbgAMDWs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jan 2020 22:22:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 87A5D70EE8BB58B41749;
        Mon, 13 Jan 2020 11:22:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.163) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 11:22:37 +0800
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
To:     Christoph Hellwig <hch@infradead.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <jens.axboe@oracle.com>, <namhyung@gmail.com>,
        <bharrosh@panasas.com>, Mingfangsen <mingfangsen@huawei.com>,
        <zhengbin13@huawei.com>, Guiyao <guiyao@huawei.com>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
 <20200108133153.GA4455@infradead.org>
From:   renxudong <renxudong1@huawei.com>
Message-ID: <8d36013f-432c-4629-2ea6-73648f1bffdd@huawei.com>
Date:   Mon, 13 Jan 2020 11:22:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108133153.GA4455@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.163]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/1/8 21:31, Christoph Hellwig wrote:
> On Mon, Dec 30, 2019 at 08:17:41PM +0800, Zhiqiang Liu wrote:
>> +	if (!len || !virt_addr_valid(kbuf))
> 
> While this is a somewhat useful sanity check, it should never triggger
> except for a grave bug in the caller.  So this needs a WARN_ON_ONCE
> and a better explanation on how you triggered it, and most likely a
> real fix for the caller.
> 
> .
> 
Sorry, I haven't been able to respond to your e-mails in time due to 
busy work.
As you said，We pass an illegal address when sending scsi cmd in our 
module. When io is completed, the destination address of memcpy is an 
illegal address, and oops appears when copying.
I think your suggestion is very fine. It should trigger an warn when an 
abnormal address is detected, not just return.
i will add WARN_ONCE in the v2 patch

