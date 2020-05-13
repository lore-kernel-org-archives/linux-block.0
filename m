Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC2CC2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A509E20661
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgEMJWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:22:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgEMJWV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:22:21 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 51264219B84C37D45BE6;
        Wed, 13 May 2020 10:22:20 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.35) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 10:22:18 +0100
Subject: Re: [PATCH V11 11/12] blk-mq: re-submit IO in case that hctx is
 inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
 <20200513034803.1844579-12-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <657924a4-ec2b-059a-f65d-8eb126d1272b@huawei.com>
Date:   Wed, 13 May 2020 10:21:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200513034803.1844579-12-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.35]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/05/2020 04:48, Ming Lei wrote:
> +static void blk_mq_resubmit_rq(struct request *rq)
> +{
> +	struct request *nrq;
> +	unsigned int flags = 0;
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +	struct blk_mq_tags *tags = rq->q->elevator ? hctx->sched_tags :
> +		hctx->tags;
> +	bool reserved = blk_mq_tag_is_reserved(tags, rq->internal_tag);
> +
> +	if (rq->rq_flags & RQF_PREEMPT)
> +		flags |= BLK_MQ_REQ_PREEMPT;
> +	if (reserved)
> +		flags |= BLK_MQ_REQ_RESERVED;
> +	/*
> +	 * Queue freezing might be in-progress, and wait freeze can't be
> +	 * done now because we have request not completed yet, so mark this
> +	 * allocation as BLK_MQ_REQ_FORCE for avoiding this allocation &
> +	 * freeze hung forever.
> +	 */
> +	flags |= BLK_MQ_REQ_FORCE;
> +

So setting this flag triggers this WARN:

[  101.308666] Modules linked in:
[  101.311710] CPU: 23 PID: 1491 Comm: bash Not tainted 
5.7.0-rc2-00106-g63430d85fea8 #337
[  101.319698] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[  101.328816] pstate: 60000005 (nZCv daif -PAN -UAO)
[  101.333593] pc : blk_get_request+0xa4/0xac
[  101.337676] lr : blk_get_request+0xa4/0xac
[  101.341758] sp : ffff800021773aa0
[  101.345059] x29: ffff800021773aa0 x28: 0000000000000004
[  101.350357] x27: 0000000000000004 x26: 0000000000000004
[  101.355655] x25: 0000000000000000 x24: ffff800010414b20
[  101.360953] x23: 0000000000000008 x22: ffff001fb0ecf900
[  101.366251] x21: ffff001fb0a42f40 x20: 0000000000004000
[  101.371549] x19: 0000000000000010 x18: 0000000000000000
[  101.376846] x17: 0000000000000000 x16: 0000000000000000
[  101.382144] x15: 0000000000000000 x14: 0000000000000000
[  101.387441] x13: 0000000000000000 x12: 0000000000000000
[  101.392739] x11: 000000000000064f x10: 0000000000000008
[  101.398036] x9 : ffff8000118f1c28 x8 : 2074736575716572
[  101.403334] x7 : 5f7465675f6b6c62 x6 : ffff041febee21d0
[  101.408632] x5 : 0000000000000000 x4 : 0000000000000000
[  101.413930] x3 : 0000000000000000 x2 : ffff041febee9080
[  101.419229] x1 : 0000000100000000 x0 : 000000000000001a
[  101.424527] Call trace:
[  101.426961]  blk_get_request+0xa4/0xac
[  101.430698]  blk_mq_hctx_deactivate+0x270/0x3e4
[  101.435215]  blk_mq_hctx_notify_dead+0x198/0x1b4
[  101.439821]  cpuhp_invoke_callback+0x170/0x1e0
[  101.444253]  _cpu_down+0x100/0x238
[  101.447642]  cpu_down+0x40/0x68
[  101.450770]  cpu_device_down+0x14/0x1c
[  101.454508]  cpu_subsys_offline+0xc/0x14
[  101.458417]  device_offline+0x98/0xc4
[  101.462065]  online_store+0x3c/0x88
[  101.465541]  dev_attr_store+0x14/0x24
[  101.469192]  sysfs_kf_write+0x44/0x4c
[  101.472840]  kernfs_fop_write+0xfc/0x208
[  101.476751]  __vfs_write+0x18/0x3c
[  101.480140]  vfs_write+0xb4/0x1b8
[  101.483442]  ksys_write+0x4c/0xac
[  101.486743]  __arm64_sys_write+0x1c/0x24
[  101.490654]  el0_svc_common.constprop.3+0xb8/0x170
[  101.495431]  do_el0_svc+0x70/0x88
[  101.498734]  el0_sync_handler+0xf0/0x12c
[  101.502643]  el0_sync+0x140/0x180
[  101.505944] ---[ end trace 137fed615521bd97 ]--

(the series tests ok, apart from that)

Thanks,
John

> +	/* avoid allocation failure by clearing NOWAIT */
> +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> +	if (!nrq)
> +		return;
