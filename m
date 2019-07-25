Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3120C7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 08:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D4A21871
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 08:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJRD4Pl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbfGYIgD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:36:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbfGYIgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 04:36:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P8XOjh143308;
        Thu, 25 Jul 2019 08:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Mh8uCX6VMQ3XCjUjNRBpA3aBq5kT+94PaY9Rg+igy+Y=;
 b=nJRD4Pl+UbkZebYU+AigmHpYmybaWdtQsmbEZpNhYVLphEt0WETsncw8OsiTsl7xuDFC
 ZKpNXzJV5IvBBc4X+ko3ziJwe016/ij2j0azDlefvPlI6/PXoGQ/15qbYv+4jNKM6WVO
 giSe2tgwJv07R49sHV7TVDK3iSqNHRNpPGIJE37lpMEpZKzrTU8FMMezppgDUlHz1NS/
 3p+MYerEuEanN0syg8x2roNrXtJBeQpf/IfS9t8ixjgSdICDJZwyrBu3mVgDroRiB83Y
 MUtpC6K4Mh0uTvMHi1PsZ5x2Ifwge0lst7vq/vf6884kAyV53FliwuvFS1VSVjWsM7rS Bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tx61c2cmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 08:35:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P8X5W2034769;
        Thu, 25 Jul 2019 08:35:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tx60ysxpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 08:35:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6P8ZmoC021126;
        Thu, 25 Jul 2019 08:35:48 GMT
Received: from [10.191.2.53] (/10.191.2.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 01:35:45 -0700
Subject: Re:[PATCH] blk-mq: balance mapping between CPUs and queues
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20190725075604.1106-1-ming.lei@redhat.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <0225f4eb-364c-fa0c-5d72-e2a58bf9ae68@oracle.com>
Date:   Thu, 25 Jul 2019 16:35:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190725075604.1106-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250102
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/19 4:26 PM, Ming Lei wrote:
> Spread queues among present CPUs first, then building the mapping
> on other non-present CPUs.
> 
> So we can minimize count of dead queues which are mapped by un-present
> CPUs only. Then bad IO performance can be avoided by this unbalanced
> mapping between CPUs and queues.
> 
> The similar policy has been applied on Managed IRQ affinity.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-cpumap.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index f945621a0e8f..e217f3404dc7 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -15,10 +15,9 @@
>  #include "blk.h"
>  #include "blk-mq.h"
>  
> -static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
> -			      unsigned int nr_queues, const int cpu)
> +static int queue_index(struct blk_mq_queue_map *qmap, const int q)
>  {
> -	return qmap->queue_offset + (cpu % nr_queues);
> +	return qmap->queue_offset + q;
>  }
>  
>  static int get_first_sibling(unsigned int cpu)
> @@ -36,23 +35,36 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
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
> +		map[cpu] = queue_index(qmap, q++);
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

Why not keep this similarly? 

> +		first_sibling = get_first_sibling(cpu);
> +		if (first_sibling == cpu) {
> +			map[cpu] = queue_index(qmap, q);
> +			q = (q + 1) % nr_queues;
>  		} else {
> -			first_sibling = get_first_sibling(cpu);
> -			if (first_sibling == cpu)
> -				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> -			else
> -				map[cpu] = map[first_sibling];
> +			map[cpu] = map[first_sibling];

Then no need to share queue if nr_queues is enough for all possible cpu.

Regards, -Bob

