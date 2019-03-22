Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3ACC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FBE218E2
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TwYPEBnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfCVL61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33548 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbfCVL61 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2MBnJno030483;
        Fri, 22 Mar 2019 11:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nBL4+RHOYzG4OWB9aNyOjbCEf0XNxXIGQYLtHZrRaEU=;
 b=TwYPEBnFFZYF2kSvZvWHnl3P8vv6DFCp5rnrETRkyMomrVy8YjYXxDOfoi0NYYvx8bAd
 sxkBobpDVQ+hKhFqASDYEB8fBg9P062T6GdJSOItGFwn8PiUctH57cuJGRUcsUVQl3Tq
 EiJ0ahrcfBkNbOeedff8dixTdTOFtZhbDDPkoyUlPflCNu821G8ft2TE3rtvfxAvhuI6
 pPRHzs+7B9kqkEqSSZGkQ8HW68flbXGEzPcF1HsDWXG4MZyvC5CsDVmatEnqyTWqs2rc
 CRthmYuz42d3uMr1lbn7vtYFOAL/Y5o0LZa3D5/zTROKp9fZgvFLp3jD4SrXzc3X+alZ TQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r8pnf5tnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 11:58:15 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2MBwEds030966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 11:58:14 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2MBwEtr022364;
        Fri, 22 Mar 2019 11:58:14 GMT
Received: from [10.191.13.95] (/10.191.13.95)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Mar 2019 04:58:14 -0700
Subject: Re: [PATCH] block/mq: blk map queues by core id
To:     luferry <luferry@163.com>
References: <20190322100949.5555-1-luferry@163.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <9fa3eda2-536c-86a1-a7a3-c157fd0cdfdc@oracle.com>
Date:   Fri, 22 Mar 2019 19:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190322100949.5555-1-luferry@163.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9202 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903220089
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/22/2019 06:09 PM, luferry wrote:
> under virtual machine environment, cpu topology may differ from normal
> physical server.

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


Thank you very much!

Dongli Zhang

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
