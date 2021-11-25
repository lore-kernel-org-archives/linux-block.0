Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64407C433F5
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 14:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355694AbhKYOOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 09:14:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4167 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353108AbhKYOMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 09:12:48 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J0KV43KQVz689Kb;
        Thu, 25 Nov 2021 22:08:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 15:09:34 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 14:09:34 +0000
Subject: Re: [PATCH RFT 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <hare@suse.de>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <7fba1b1e-63a6-6315-e5ca-6d5ae9de6dbb@huawei.com>
 <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9859e133-e3b8-4e53-dfad-cbf75ed3102f@huawei.com>
Date:   Thu, 25 Nov 2021 14:09:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <b18285f4aa0e8be796aea19cdfde0293@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/11/2021 13:46, Kashyap Desai wrote:
>> John -
>>
>> I will try something this week and let you know.
> John - I tested patchset and looks good.  Issue reported at below thread is
> fixed.
> https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/
> 
> Here is perf top data.
> 
> 5.70%  [megaraid_sas]                [k] complete_cmd_fusion
>     3.80%  [megaraid_sas]                [k]
> megasas_build_and_issue_cmd_fusion
>     2.75%  [kernel]                      [k] syscall_return_via_sysret
>     2.68%  [kernel]                      [k] entry_SYSCALL_64
>     2.22%  [kernel]                      [k] io_submit_one
>     2.19%  [megaraid_sas]                [k] megasas_build_ldio_fusion
>     1.95%  [kernel]                      [k] llist_add_batch
>     1.80%  [kernel]                      [k] llist_reverse_order
>     1.79%  [kernel]                      [k] scsi_complete
>     1.73%  [kernel]                      [k] scsi_queue_rq
>     1.66%  [kernel]                      [k] check_preemption_disabled
>     1.37%  [megaraid_sas]                [k] megasas_queue_command
>     1.16%  [kernel]                      [k] native_irq_return_iret
>     1.11%  [kernel]                      [k] aio_complete_rw
>     1.07%  [kernel]                      [k] read_tsc
>     1.06%  fio                           [.] __fio_gettime
>     1.05%  [kernel]                      [k] flush_smp_call_function_queue
>     1.03%  [kernel]                      [k] blk_complete_reqs
>     1.00%  [kernel]                      [k] blk_mq_free_request
>     0.98%  [kernel]                      [k] sbitmap_get
> 
> 
> I will continue testing and let you know how it goes.

ok, good to know, thanks. But I would still like to know what is 
triggering blk_mq_queue_tag_busy_iter() so often. Indeed, as mentioned 
in this cover letter, this function was hardly optimised before for 
shared sbitmap.

And any opinion whether we would want this as a fix? Information 
requested above would help explain why we would need it as a fix.

Cheers,
John
