Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807FCC433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 02:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE13222E9
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 02:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbgJTCxZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:53:25 -0400
Received: from smtp.h3c.com ([60.191.123.56]:17530 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390804AbgJTCxZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 22:53:25 -0400
Received: from DAG2EX09-IDC.srv.huawei-3com.com ([10.8.0.72])
        by h3cspam01-ex.h3c.com with ESMTPS id 09K2qjIx075291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 10:52:45 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX09-IDC.srv.huawei-3com.com (10.8.0.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Oct 2020 10:52:46 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Tue, 20 Oct 2020 10:52:46 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "raghavendra.kt@linux.vnet.ibm.com" 
        <raghavendra.kt@linux.vnet.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: remove the calling of local_memory_node()
Thread-Topic: [PATCH] blk-mq: remove the calling of local_memory_node()
Thread-Index: AQHWpfIblb4hxO1wEUaIIqHsdHbO2qmeRzOAgAGEP4A=
Date:   Tue, 20 Oct 2020 02:52:46 +0000
Message-ID: <eadeb35dc2ea4b9c9df6b36b9e9f19e2@h3c.com>
References: <20201019082047.31113-1-tian.xianting@h3c.com>
 <20201019114011.GE27114@dhcp22.suse.cz>
In-Reply-To: <20201019114011.GE27114@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 09K2qjIx075291
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Michal,
Hi, raghavendra, Jens
Could you help comment this issue? Thanks in advance.

-----Original Message-----
From: Michal Hocko [mailto:mhocko@suse.com] 
Sent: Monday, October 19, 2020 7:40 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: axboe@kernel.dk; raghavendra.kt@linux.vnet.ibm.com; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: remove the calling of local_memory_node()

On Mon 19-10-20 16:20:47, Xianting Tian wrote:
> We don't need to check whether the node is memoryless numa node before 
> calling allocator interface. SLUB(and SLAB,SLOB) relies on the page 
> allocator to pick a node. Page allocator should deal with memoryless 
> nodes just fine. It has zonelists constructed for each possible nodes.
> And it will automatically fall back into a node which is closest to 
> the requested node. As long as __GFP_THISNODE is not enforced of course.
> 
> The code comments of kmem_cache_alloc_node() of SLAB also showed this:
>  * Fallback to other node is possible if __GFP_THISNODE is not set.
> 
> blk-mq code doesn't set __GFP_THISNODE, so we can remove the calling 
> of local_memory_node().

yes, this is indeed the case. I cannot really judge the blg-mq code but it seems to be unnecessary. Maybe there are some subtle details not explained by bffed457160ab though.

> Fixes: bffed457160ab ("blk-mq: Avoid memoryless numa node encoded in 
> hctx numa_node")

But the existing code is not broken. It just overdoes what needs to be done. So effectively bffed457160ab was not needed. I do not think that Fixes is really necessary.

> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  block/blk-mq-cpumap.c | 2 +-
>  block/blk-mq.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c index 
> 0157f2b34..3db84d319 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -89,7 +89,7 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map 
> *qmap, unsigned int index)
>  
>  	for_each_possible_cpu(i) {
>  		if (index == qmap->mq_map[i])
> -			return local_memory_node(cpu_to_node(i));
> +			return cpu_to_node(i);
>  	}
>  
>  	return NUMA_NO_NODE;
> diff --git a/block/blk-mq.c b/block/blk-mq.c index 
> cdced4aca..48f8366b2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2737,7 +2737,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>  		for (j = 0; j < set->nr_maps; j++) {
>  			hctx = blk_mq_map_queue_type(q, j, i);
>  			if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
> -				hctx->numa_node = local_memory_node(cpu_to_node(i));
> +				hctx->numa_node = cpu_to_node(i);
>  		}
>  	}
>  }
> --
> 2.17.1

--
Michal Hocko
SUSE Labs
