Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F6C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5568206B7
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 09:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfCRJoQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:44:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:4614 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfCRJoP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 05:44:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 02:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="329584206"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.237.142.141])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 02:44:13 -0700
Subject: Re: [PATCH] lightnvm: pblk: set write thread affinity to particular
 cpu
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
 <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com>
 <D45E9938-F025-446D-8E48-CAE954B791A6@javigon.com>
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Message-ID: <a63ef9e7-214a-a701-5c40-d1d1107de4a4@intel.com>
Date:   Mon, 18 Mar 2019 10:44:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <D45E9938-F025-446D-8E48-CAE954B791A6@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 3:22 PM, Javier González wrote:
> 
>> On 14 Mar 2019, at 07.22, Javier González <javier@javigon.com> wrote:
>>
>>> On 14 Mar 2019, at 07.17, Marcin Dziegielewski <marcin.dziegielewski@intel.com> wrote:
>>>
>>> In some cases write thread migration between cpus can cause
>>> sending writes in improper order and in consequence a lot of
>>> errors from device.
>>>
>>> Write thread affinity to particular cpu prevent before it.
>>>
>>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
>>> drivers/lightnvm/pblk.h      |  1 +
>>> drivers/nvme/host/lightnvm.c |  1 +
>>> include/linux/lightnvm.h     |  2 ++
>>> 4 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index 81e8ed4..bd25004 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -21,6 +21,8 @@
>>>
>>> #include "pblk.h"
>>> #include "pblk-trace.h"
>>> +#include <linux/cpumask.h>
>>> +#include <linux/numa.h>
>>>
>>> static unsigned int write_buffer_size;
>>>
>>> @@ -47,6 +49,8 @@ struct pblk_global_caches {
>>>
>>> struct bio_set pblk_bio_set;
>>>
>>> +cpumask_t free_cpumask;
>>> +
>>> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>>> 			  struct bio *bio)
>>> {
>>> @@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk *pblk)
>>>
>>> static int pblk_writer_init(struct pblk *pblk)
>>> {
>>> +	cpumask_t tmp_cpumask, cpumask;
>>> +	int cpu;
>>> +
>>> 	pblk->writer_ts = kthread_create(pblk_write_ts, pblk, "pblk-writer-t");
>>> 	if (IS_ERR(pblk->writer_ts)) {
>>> 		int err = PTR_ERR(pblk->writer_ts);
>>> @@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk *pblk)
>>> 		return err;
>>> 	}
>>>
>>> +	cpumask_and(&tmp_cpumask, cpumask_of_node(pblk->dev->parent->node),
>>> +			cpu_online_mask);
>>> +	cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>>> +
>>> +	if (!cpumask_weight(&free_cpumask)) {
>>> +		free_cpumask = CPU_MASK_ALL;
>>> +		cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>>> +	}
>>> +
>>> +	cpu = cpumask_last(&cpumask);
>>> +
>>> +	kthread_bind(pblk->writer_ts, cpu);
>>> +
>>> +	cpumask_clear_cpu(cpu, &free_cpumask);
>>> +	pblk->writer_cpu = cpu;
>>> +
>>> 	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
>>> 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
>>>
>>> @@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk *pblk)
>>> 			"Stopping not fully synced write buffer\n");
>>>
>>> 	del_timer_sync(&pblk->wtimer);
>>> -	if (pblk->writer_ts)
>>> +	if (pblk->writer_ts) {
>>> +		set_cpus_allowed_ptr(pblk->writer_ts, cpu_online_mask);
>>> 		kthread_stop(pblk->writer_ts);
>>> +		cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
>>> +	}
>>> }
>>>
>>> static void pblk_free(struct pblk *pblk)
>>> @@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
>>> {
>>> 	int ret;
>>>
>>> +	free_cpumask = CPU_MASK_ALL;
>>> +
>>> 	ret = bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
>>> 	if (ret)
>>> 		return ret;
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 381f074..650f983 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -690,6 +690,7 @@ struct pblk {
>>> 	atomic_t inflight_io;		/* General inflight I/O counter */
>>>
>>> 	struct task_struct *writer_ts;
>>> +	int writer_cpu;
>>>
>>> 	/* Simple translation map of logical addresses to physical addresses.
>>> 	 * The logical addresses is known by the host system, while the physical
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index 949e29e..971a19f 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>>> 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>> 	dev->ops = &nvme_nvm_dev_ops;
>>> 	dev->private_data = ns;
>>> +	dev->node = node;
>>> 	ns->ndev = dev;
>>>
>>> 	return nvm_register(dev);
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 5d865a5..312029e 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -427,6 +427,8 @@ struct nvm_dev {
>>> 	char name[DISK_NAME_LEN];
>>> 	void *private_data;
>>>
>>> +	int node;
>>> +
>>> 	void *rmap;
>>>
>>> 	struct mutex mlock;
>>> --
>>> 1.8.3.1
>>
>> We have a per-CPU semaphore that only allows to send a single I/O in
>> order to prevent write pointer violations. Are you seeing this error, or
>> is it theoretical?
>>
>> Javier
> 
> I meant per PU (parallel unit)…
> 

You are right, for current upstream implementation it's theoretical. I 
saw it after some experimental changes in lightnvm layer.

But I see one more potential benefit from this patch (correct me if I'm 
wrong), after this patch we will be sure that write thread is working on 
cpu from right numa node for device. Now I think, we can also take under 
consideration binding to whole set of cpus from right numa node instead 
of particular one.

Marcin
