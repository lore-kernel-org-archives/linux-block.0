Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752406AbeAQKOg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 05:14:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0HAEIo2079764
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2018 05:14:36 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fj35s3wp8-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2018 05:14:36 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 17 Jan 2018 10:14:33 -0000
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        James Smart <james.smart@broadcom.com>,
        Jens Axboe <axboe@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
References: <20180112025306.28004-3-ming.lei@redhat.com>
 <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
 <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
 <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
 <20180117062251.GC9487@ming.t460p>
 <977e9c62-c7f2-d1df-7d6b-5903f3b21cb6@oracle.com>
 <20180117095744.GF9487@ming.t460p>
 <cd8ebf2d-3215-d1a2-7fce-54f1590e41e3@de.ibm.com>
Date: Wed, 17 Jan 2018 11:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <cd8ebf2d-3215-d1a2-7fce-54f1590e41e3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <fcaa92ab-f740-0e84-e717-6f9a16a79a4f@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 01/17/2018 11:07 AM, Christian Borntraeger wrote:
> 
> 
> On 01/17/2018 10:57 AM, Ming Lei wrote:
>> Hi Jianchao,
>>
>> On Wed, Jan 17, 2018 at 04:09:11PM +0800, jianchao.wang wrote:
>>> Hi ming 
>>>
>>> Thanks for your kindly response.
>>>
>>> On 01/17/2018 02:22 PM, Ming Lei wrote:
>>>> This warning can't be removed completely, for example, the CPU figured
>>>> in blk_mq_hctx_next_cpu(hctx) can be put on again just after the
>>>> following call returns and before __blk_mq_run_hw_queue() is scheduled
>>>> to run.
>>>>
>>>> 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work, msecs_to_jiffies(msecs))
>>> We could use cpu_active in __blk_mq_run_hw_queue() to narrow the window.
>>> There is a big gap between cpu_online and cpu_active. rebind_workers is also between them.
>>
>> This warning is harmless, also you can't reproduce it without help of your
>> special patch, I guess, :-) So the window shouldn't be a big deal. 
> 
> FWIW, every WARN_ON is problematic since there are people running with panic_on_warn.

To make it more clear. Every WARN_ON that can happen in real life without actually being
an error is problematic.

> If a condition can happen we should not use WARN_ON but something else.
> 
