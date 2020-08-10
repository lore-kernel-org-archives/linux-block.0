Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6AAC433E0
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 02:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3E52068F
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 02:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHJCRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:17:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgHJCRL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Aug 2020 22:17:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FC9B9E183C1994204DD;
        Mon, 10 Aug 2020 10:17:07 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 10:17:05 +0800
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
To:     Ming Lei <ming.lei@redhat.com>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
References: <20200807090559.29582-1-lengchao@huawei.com>
 <20200807134932.GA2122627@T590>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <61a78a78-73aa-1c67-1e8c-eae8f7c3a4e0@huawei.com>
Date:   Mon, 10 Aug 2020 10:17:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200807134932.GA2122627@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/7 21:49, Ming Lei wrote:
> On Fri, Aug 07, 2020 at 05:05:59PM +0800, Chao Leng wrote:
>> nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
>> one, if there is lots of name spaces, sync wait long time(more than 10s).
>> Multipath can not fail over to retry quickly, cause io pause long time.
>> This is not expected.
>> To reduce quiesce time, we introduce async mechanism for sync SRCUs
>> and quiesce queue.
>>
> 
> Frankly speaking, I prefer to replace SRCU with percpu_refcount:
> 
> - percpu_refcount has much less memory footprint than SRCU, so we can simply
> move percpu_refcount into request_queue, instead of adding more bytes
> into each hctx by this patch
> 
> - percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().
> 
> - with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()
IO pause long time if fail over, this is a serios problem. we need fix
it as soon as possible. SRCU is just used for blocking queue,
non blocking queue need 0 bytes. So more bytes(just 24 bytes) is not
waste.

About using per_cpu to replace SRCU, I suggest separate discussion.
Can you show the patch? This will make it easier to discuss.
> 
> Thanks,
> Ming
> 
> .
> 
