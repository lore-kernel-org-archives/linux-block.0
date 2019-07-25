Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4EC7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 09:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174D72190F
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 09:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jh52v1Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfGYJuh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:50:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35882 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJuh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 05:50:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P9mvUR101792;
        Thu, 25 Jul 2019 09:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=U/qiXrRFcaFM9CRiBfPTauNWy2G1sS27L0VHU7OviLU=;
 b=jh52v1DthW4C+PnHPKEOeHSsNTsMuQA+ZV9Y6BpQVraIO7sClN5tgQ86rq2sL9hKu57b
 Tme0g/FP5d6QN7eD6+6WM1rbGYhUFxYjndkgXQrjCQo2D7IL8a0lE0CWwbMmfuNOO12e
 47OHsMaOoFqkT0X9QOsERajYPRCPDBXhNLKMTx1acJht3s+8a0wul5iQdL2bfb6APG1E
 VnPs72pFeBtSUELxVtDEEULhDXZ30ym2kyBT1M3MyM3kRb4582YlLPeNZaB14Hm0rH2Q
 BILLL8jJLi6DweJwCQb5PwyE8d2Ffspfs0BmGK0/tyYV/DAeOfajFIvHKzXPe/XAH+by Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tx61c2tpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 09:50:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P9li4e077847;
        Thu, 25 Jul 2019 09:50:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tx60xqj4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 09:50:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6P9oR9v030975;
        Thu, 25 Jul 2019 09:50:29 GMT
Received: from [10.191.28.95] (/10.191.28.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 02:50:27 -0700
Subject: Re: [PATCH V2] blk-mq: balance mapping between present CPUs and
 queues
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20190725094146.18560-1-ming.lei@redhat.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <24c27638-b48b-2f5c-e9dc-71b446732f89@oracle.com>
Date:   Thu, 25 Jul 2019 17:50:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190725094146.18560-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250118
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/19 5:41 PM, Ming Lei wrote:
> Spread queues among present CPUs first, then building mapping on other
> non-present CPUs.
> 
> So we can minimize count of dead queues which are mapped by un-present
> CPUs only. Then bad IO performance can be avoided by unbalanced mapping
> between present CPUs and queues.
> 
> The similar policy has been applied on Managed IRQ affinity.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Bob Liu <bob.liu@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> 
> V2:
> 	- make sure that sequential mapping can be done
> 
>  block/blk-mq-cpumap.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index f945621a0e8f..0157f2b3485a 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -15,10 +15,10 @@
>  #include "blk.h"
>  #include "blk-mq.h"
>  
> -static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
> -			      unsigned int nr_queues, const int cpu)
> +static int queue_index(struct blk_mq_queue_map *qmap,
> +		       unsigned int nr_queues, const int q)
>  {
> -	return qmap->queue_offset + (cpu % nr_queues);
> +	return qmap->queue_offset + (q % nr_queues);
>  }
>  
>  static int get_first_sibling(unsigned int cpu)
> @@ -36,21 +36,36 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  {
>  	unsigned int *map = qmap->mq_map;
>  	unsigned int nr_queues = qmap->nr_queues;
> -	unsigned int cpu, first_sibling;
> +	unsigned int cpu, first_sibling, q = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		map[cpu] = -1;
> +
> +	/*
> +	 * Spread queues among present CPUs first for minimizing
> +	 * count of dead queues which are mapped by all un-present CPUs
> +	 */
> +	for_each_present_cpu(cpu) {
> +		if (q >= nr_queues)
> +			break;
> +		map[cpu] = queue_index(qmap, nr_queues, q++);
> +	}
>  
>  	for_each_possible_cpu(cpu) {
> +		if (map[cpu] != -1)
> +			continue;
>  		/*
>  		 * First do sequential mapping between CPUs and queues.
>  		 * In case we still have CPUs to map, and we have some number of
>  		 * threads per cores then map sibling threads to the same queue
>  		 * for performance optimizations.
>  		 */
> -		if (cpu < nr_queues) {
> -			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> +		if (q < nr_queues) {
> +			map[cpu] = queue_index(qmap, nr_queues, q++);

Yeah, that's what I was trying to say.

>  		} else {
>  			first_sibling = get_first_sibling(cpu);
>  			if (first_sibling == cpu)
> -				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> +				map[cpu] = queue_index(qmap, nr_queues, q++);
>  			else
>  				map[cpu] = map[first_sibling];
>  		}
> 

Reviewed-by: Bob Liu <bob.liu@oracle.com>
