Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E21C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 11:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiGSLAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiGSLAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 07:00:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BADA1A6
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 04:00:18 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LnG3d4fVDzVgBW;
        Tue, 19 Jul 2022 18:56:29 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 19:00:16 +0800
Received: from [10.174.177.235] (10.174.177.235) by
 dggpeml500009.china.huawei.com (7.185.36.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 19:00:16 +0800
Message-ID: <724badcd-a65f-15e4-2d8e-23d882583ae0@huawei.com>
Date:   Tue, 19 Jul 2022 19:00:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>
References: <20220718123528.178714-1-yuyufen@huawei.com>
 <YtZ4uSRqR/kLdqm+@T590>
From:   Yufen Yu <yuyufen@huawei.com>
In-Reply-To: <YtZ4uSRqR/kLdqm+@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.235]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/7/19 17:26, Ming Lei wrote:
> On Mon, Jul 18, 2022 at 08:35:28PM +0800, Yufen Yu wrote:
>> We do test on a virtio scsi device (/dev/sda) and the default mq
>> scheduler is 'none'. We found a IO hung as following:
>>
>> blk_finish_plug
>>    blk_mq_plug_issue_direct
>>        scsi_mq_get_budget
>>        //get budget_token fail and sdev->restarts=1
>>
>> 			     	 scsi_end_request
>> 				   scsi_run_queue_async
>>                                     //sdev->restart=0 and run queue
>>
>>       blk_mq_request_bypass_insert
>>          //add request to hctx->dispatch list
> 
> Here the issue shouldn't be related with scsi's get budget or
> scsi_run_queue_async.
> 
> If blk-mq adds request into ->dispatch_list, it is blk-mq core's
> responsibility to re-run queue for moving on. Can you investigate a
> bit more why blk-mq doesn't run queue after adding request to
> hctx dispatch list?
> 

In my IO hung scenario, no one issue any IO any more after calling blk_finish_plug().
There is no chance of run queue.

Thanks,
Yufen

