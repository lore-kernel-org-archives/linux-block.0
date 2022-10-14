Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733DEC4332F
	for <linux-block@archiver.kernel.org>; Fri, 14 Oct 2022 02:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJNCMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 22:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJNCMw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 22:12:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF22E5EDD
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 19:12:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpVCv6jcNzmVDm;
        Fri, 14 Oct 2022 10:08:11 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:12:48 +0800
Subject: Re: [PATCH v2 0/2] improve nvme quiesce time for large amount of
 namespaces
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <d83c88c8-0486-072d-a03d-d0a3a8e4387c@nvidia.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <e785f247-7ae1-ef26-6dd2-d7379fc739e6@huawei.com>
Date:   Fri, 14 Oct 2022 10:12:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <d83c88c8-0486-072d-a03d-d0a3a8e4387c@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/10/13 22:32, Chaitanya Kulkarni wrote:
> On 10/13/22 02:44, Chao Leng wrote:
>> This set improves the quiesce time when using a large set of
>> namespaces, which also improves I/O failover time in a multipath environment.
>>
> 
> by how much and what are the problems exits with current timing needs to
> be documented, i.e. add quantitative data if you are posting patches for
> time/performance improvement.
Theoretically, every synchronize_rcu/synchronize_srcu need to wait more than 10ms.
Now nvme quiesce all queues of namespace one by one, The more namespace,
the longer the waiting time.

The test result:
Test Scenario: nvme over roce with multipathing, 256 namespaces
When send I/Os to all namespaces, simulate a path fault, the fail over waiting time
is more than 20 seconds.
After analysis, it was found that the total of quiesce waiting time for 256 namespace is
more than 20 seconds.
After optimization, same scenario the fail over waiting time is less than 1 second.
> 
> -ck
> 
