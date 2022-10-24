Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A6C433FE
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 01:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJXB5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Oct 2022 21:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJXB5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Oct 2022 21:57:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA06DAFE
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 18:57:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwdP12sMQzmVJw;
        Mon, 24 Oct 2022 09:52:21 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:57:11 +0800
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
 <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
Date:   Mon, 24 Oct 2022 09:57:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/22 5:22, Bart Van Assche wrote:
> On 10/20/22 03:56, Christoph Hellwig wrote:
>> From: Chao Leng <lengchao@huawei.com>
>>
>> Drivers that have shared tagsets may need to quiesce potentially a lot
>> of request queues that all share a single tagset (e.g. nvme). Add an
>> interface to quiesce all the queues on a given tagset. This interface is
>> useful because it can speedup the quiesce by doing it in parallel.
>>
>> Because some queues should not need to be quiesced(e.g. nvme connect_q)
> 
> should not need -> do not have
> 
>> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
> 
> quiesce -> quiescing
> 
> . So -> ,
> 
>> tagset quiesce interface to skip the queue.
> 
> Hi Christoph,
> 
> Are there any drivers that may call blk_mq_quiesce_tagset() concurrently from two different threads? blk_mq_quiesce_queue() supports this but blk_mq_quiesce_tagset() cannot support this because of the mechanism used to mark request queues that should be skipped (queue flag).
> 
blk_mq_quiesce_tagset() support concurrency. blk_mq_quiesce_tagset() just
check the flag(QUEUE_FLAG_SKIP_TAGSET_QUIESCE), it has no impact on concurrency.
