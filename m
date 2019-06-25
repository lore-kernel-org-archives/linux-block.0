Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CDC4646B
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 01:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F904206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 01:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxUColHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFYB3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:29:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfFYB3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 21:29:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5P1O3ai122691;
        Tue, 25 Jun 2019 01:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xzWudCQ+8i4nLaNS2ZZ42MaVwcl/EpXW3dPwWriyTbU=;
 b=SxUColHZZQSspUhbeR+Sp8Ox1niDMcetEhn/Fi9NTQXA4iENyCSUk7kchWF518srcjxj
 xOxVI0NtiyfC6MZq75rkL7Dq2rQ7MTBNM6BNCgEI8//uxf8B5AoQ+dLWfEn0wAqTDYFc
 Bp9FhmA+Bup+b6Dlvk6XbVlEQBqqJ2yr0HzlhREvTSPeapmDgfQ3l2xLLHRQTwwmh1yv
 G7lrUMcQ6NIUbdBpo0ogZP9NFmaMwBuhePc7NDLtJpQjU62sOOiBNi1oODX9d89JsPUN
 zp+u07Fe+T+MhjpYI5oSXsHS4bhMM4GeLcy6P2Ser+Z1LC5ctw0NOZZX2jKDxoqJKP1u lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brt1agx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 01:27:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5P1PplU114563;
        Tue, 25 Jun 2019 01:27:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f3k3qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 01:27:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5P1RO74020914;
        Tue, 25 Jun 2019 01:27:25 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 18:27:24 -0700
Subject: Re: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug
To:     Wenbin Zeng <wenbin.zeng@gmail.com>
Cc:     axboe@kernel.dk, keith.busch@intel.com, hare@suse.com,
        ming.lei@redhat.com, osandov@fb.com, sagi@grimberg.me,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wenbin Zeng <wenbinzeng@tencent.com>
References: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <d69e96cf-8f58-3b2a-d8d4-7b77589aefbd@oracle.com>
Date:   Tue, 25 Jun 2019 09:30:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Wenbin,

On 6/24/19 11:24 PM, Wenbin Zeng wrote:
> Currently hctx->cpumask is not updated when hot-plugging new cpus,
> as there are many chances kblockd_mod_delayed_work_on() getting
> called with WORK_CPU_UNBOUND, workqueue blk_mq_run_work_fn may run
> on the newly-plugged cpus, consequently __blk_mq_run_hw_queue()
> reporting excessive "run queue from wrong CPU" messages because
> cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) returns false.
> 
> This patch added a cpu-hotplug handler into blk-mq, updating
> hctx->cpumask at cpu-hotplug.
> 
> Signed-off-by: Wenbin Zeng <wenbinzeng@tencent.com>
> ---
>  block/blk-mq.c         | 29 +++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ce0f5f4..2e465fc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -39,6 +39,8 @@
>  #include "blk-mq-sched.h"
>  #include "blk-rq-qos.h"
>  
> +static enum cpuhp_state cpuhp_blk_mq_online;
> +
>  static void blk_mq_poll_stats_start(struct request_queue *q);
>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
>  
> @@ -2215,6 +2217,21 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
>  
> +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask)) {
> +		mutex_lock(&hctx->queue->sysfs_lock);
> +		cpumask_set_cpu(cpu, hctx->cpumask);
> +		mutex_unlock(&hctx->queue->sysfs_lock);
> +	}
> +
> +	return 0;
> +}
> +

As this callback is registered for each hctx, when a cpu is online, it is called
for each hctx.

Just taking a 4-queue nvme as example (regardless about other block like loop).
Suppose cpu=2 (out of 0, 1, 2 and 3) is offline. When we online cpu=2,

blk_mq_hctx_notify_online() called: cpu=2 and blk_mq_hw_ctx->queue_num=3
blk_mq_hctx_notify_online() called: cpu=2 and blk_mq_hw_ctx->queue_num=2
blk_mq_hctx_notify_online() called: cpu=2 and blk_mq_hw_ctx->queue_num=1
blk_mq_hctx_notify_online() called: cpu=2 and blk_mq_hw_ctx->queue_num=0

There is no need to set cpu 2 for blk_mq_hw_ctx->queue_num=[3, 1, 0]. I am
afraid this patch would erroneously set cpumask for blk_mq_hw_ctx->queue_num=[3,
1, 0].

I used to submit the below patch explaining above for removing a cpu and it is
unfortunately not merged yet.

https://patchwork.kernel.org/patch/10889307/


Another thing is during initialization, the hctx->cpumask should already been
set and even the cpu is offline. Would you please explain the case hctx->cpumask
is not set correctly, e.g., how to reproduce with a kvm guest running
scsi/virtio/nvme/loop?

Dongli Zhang
