Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13505C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 09:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJRJw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRJw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 05:52:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB42B14E4
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:52:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ms8H9268YzJn2g;
        Tue, 18 Oct 2022 17:50:13 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:52:50 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <sagi@grimberg.me>, <kbusch@kernel.org>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017134244.GA24775@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <00e6ce8b-5b27-d670-cd50-865fdb57e60b@huawei.com>
Date:   Tue, 18 Oct 2022 17:52:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221017134244.GA24775@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/17 21:42, Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
>> Having to allocate a struct rcu_synchronize for each of the potentially
>> many queues here is a bit sad.
>>
>> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
>> last week, so I wonder if something like that would also be feasible
>> for SRCU, as that would come in really handy here.
> 
> Alternatively I wonder if we could simply use a single srcu_struct
> in the tag_set instead of one per-queue.  That would potentially
> increase the number of read side critical sections
> blk_mq_wait_quiesce_done would have to wait for in tagsets with
> multiple queues, but I wonder how much overhead that would be in
> practive.
Now we submit request based on queues, maybe it is difficult to use
a single srcu_struct in the tag instead of one per-queue.
Using start_poll_synchronize_rcu  still need a unsigned long array.
> 
> .
> 
