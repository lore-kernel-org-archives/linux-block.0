Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E22C10F03
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793392082C
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dJ4w6UQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfCVLx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732685AbfCVLxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2MBmqed000797;
        Fri, 22 Mar 2019 11:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5kIC1lIBPr6kULrAGUH8q+RWbSEpFtG1sSRhYzaZhYs=;
 b=dJ4w6UQIrnRYAYrcR76eJ0QEemtElXs93Djzx1N0YDxwLPmLqWrC7GXH2FL4Pg51rXco
 0RCZ9tloVNZHSuA8XHkSdyNGenwbLAgZb5FiRiLtaC6sfzGzsiT4evYz5/xQ3gCG74wn
 X1ghOhPTa6Oy1ydm8C/+7lRAVFpPQRVcqtClI15yAZjMxpciaIzkyDNi+Aa2oDApjOiO
 moD2qNK9BcIrwCwttPbuw2jk3bNZl37EL33XyMg08l1Z+Uc0CU0uyRsmBxwxXc9u3vfv
 6MTdlS/5lEB6pgZLyN2RyCEyJcyLsHK+DDMccbkSvqZr591f4iH6gbJiVRiA9cEoYXfY 0w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssrwf66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 11:53:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2MBr64q002866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 11:53:07 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2MBr6qY017040;
        Fri, 22 Mar 2019 11:53:06 GMT
Received: from [192.168.2.8] (/106.39.150.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Mar 2019 04:53:06 -0700
Subject: Re: [PATCH] block/mq: blk map queues by core id
To:     luferry <luferry@163.com>
References: <20190322100949.5555-1-luferry@163.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <6d6ca45d-fa9e-6a1c-e6e6-b07ba195a8f2@oracle.com>
Date:   Fri, 22 Mar 2019 19:53:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190322100949.5555-1-luferry@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9202 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903220089
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/22/2019 06:09 PM, luferry wrote:
> under virtual machine environment, cpu topology may differ from normal

Would mind share the name of virtual machine monitor, the command line if
available, and which device to reproduce.

For instance, I am not able to reproduce with qemu nvme or virtio-blk as I
assume they use pci or virtio specific mapper to establish the mapping.

E.g., with qemu and nvme: -smp 8,sockets=1,cores=4,threads=2

Indeed I use three queues instead of twp as one is reserved for admin.

# ls /sys/block/nvme0n1/mq/*
/sys/block/nvme0n1/mq/0:
cpu0  cpu1  cpu2  cpu3  cpu_list  nr_reserved_tags  nr_tags

/sys/block/nvme0n1/mq/1:
cpu4  cpu5  cpu6  cpu7  cpu_list  nr_reserved_tags  nr_tags

> physical server.
> for example (machine with 4 cores, 2 threads per core):
> 
> normal physical server:
> core-id   thread-0-id  thread-1-id
> 0         0            4
> 1         1            5
> 2         2            6
> 3         3            7
> 
> virtual machine:
> core-id   thread-0-id  thread-1-id
> 0         0            1
> 1         2            3
> 2         4            5
> 3         6            7
> 
> When attach disk with two queues, all the even numbered cpus will be
> mapped to queue 0. Under virtual machine, all the cpus is followed by
> its sibling cpu.Before this patch, all the odd numbered cpus will also
> be mapped to queue 0, can cause serious imbalance.this will lead to
> performance impact on system IO
> 
> So suggest to allocate cpu map by core id, this can be more currency
> 
> Signed-off-by: luferry <luferry@163.com>
> ---
>  block/blk-mq-cpumap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 03a534820271..4125e8e77679 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -35,7 +35,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  {
>  	unsigned int *map = qmap->mq_map;
>  	unsigned int nr_queues = qmap->nr_queues;
> -	unsigned int cpu, first_sibling;
> +	unsigned int cpu, first_sibling, core = 0;
>  
>  	for_each_possible_cpu(cpu) {
>  		/*
> @@ -48,9 +48,10 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
>  		} else {
>  			first_sibling = get_first_sibling(cpu);
> -			if (first_sibling == cpu)
> -				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> -			else
> +			if (first_sibling == cpu) {
> +				map[cpu] = cpu_to_queue_index(qmap, nr_queues, core);
> +				core++;
> +			} else
>  				map[cpu] = map[first_sibling];
>  		}
>  	}
> 
