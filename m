Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8939322526;
	Tue, 19 Aug 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606067; cv=none; b=unhSufC6jrw4XZqhVcuoQaXeXlY6700GGVOxeVrIDpIj1wWJ/Wi5H5FROIqo+UMKRt0Wd81xOaj1Rhs6KjPpgq7WBdNk/nQ8N30QnKdYrxHcrTcUBlaGn7LKKbDIJ8YD+7kY3e3eVj2QvlJ7DTJuXryVb6YeSgUggEyXjH9SGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606067; c=relaxed/simple;
	bh=S1kfQ9ViQnCbE3Zzda+xHzyE2dwOAgfNNekrp8jH9Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbr1528LxEba9E2ghmMRR4LwxsJ1w/usyyYAXilo9g8yvL8ogcDNxuCZ7haLI/Nd8C7NN+C/TtqqWRFJlnDseorlFvaP6JJNZ8cLDSeChvOq2yFaQKYnMcIVszvduC3DerFlz4DRV0Ojl13FvjaD3jX5jqXdf7EQxQnTN+2Qf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I5WCQ8T7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I5WCQ8T7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J1CXuL025162;
	Tue, 19 Aug 2025 12:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T8NVFE
	oy1LQZy8A9k+71icJ5Y7n9S7/Zkf03Ajdr80U=; b=I5WCQ8T7Ll9dqkZmq0V3OH
	lxqu5BGMjxIXDB4lzFjb8feBPyLSef0bZWps7dcumC5Udjv5CCwgZBpQP1a1YAIT
	U4ni1hyBuItLAm0NE3fpsAGtwM0iyy0AznbMfHkW2h6DL+5l9PxCF1M1GoaHM4UC
	zNyIyCkJkymlHSo/E1KkZKjJURKbo1kX6umaZ14jZo+xpz9Pp1Vv0Y0kk6NjghVM
	bK5QlHm/unkh5PKpLf3hjqkxplPqP1bg+GJbo5eUqYWh4vdA//KUpQZfIJ4CnZR6
	2wQo9QOk3102zxdq+ftRBIKk1bImy/G6Uqrp66IESW5exj6a+8zBJUUkvqJtS8Ng
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g3mpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:20:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JB16R8003162;
	Tue, 19 Aug 2025 12:20:39 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm9yt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 12:20:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JCKci933751348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 12:20:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2295F58065;
	Tue, 19 Aug 2025 12:20:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A143D58052;
	Tue, 19 Aug 2025 12:20:34 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 12:20:34 +0000 (GMT)
Message-ID: <f0abcc02-48c6-4d09-86d6-5ca8b968dcde@linux.ibm.com>
Date: Tue, 19 Aug 2025 17:50:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] blk-mq: fix elevator depth_updated method
To: Yu Kuai <yukuai1@huaweicloud.com>, yukuai3@huawei.com, axboe@kernel.dk,
        bvanassche@acm.org, ming.lei@redhat.com, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250819012917.523272-1-yukuai1@huaweicloud.com>
 <20250819012917.523272-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250819012917.523272-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NkOgmYpMb-UFKMsW9zGuL2Lofp8g_xY9
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a46c18 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=hDtEYcajhEhDz78CLEAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NkOgmYpMb-UFKMsW9zGuL2Lofp8g_xY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfXwCgsLHbT8g4w
 itI/mlSaxdPSjNtq1ilfHGMod4kYDxCtQzqOcVY/kpXhqz/S3rg+gAnIncOHH+wmQbALvmjd0VW
 ctM0NEbtwjv62Ie4SZrx5zdwW4TB+r55fqbphiqXaKWp7Waf8bMs/8NO0MHz0InzuHrSM79KKVr
 PB8bnoDy22FrbfBUv2TnnHBuybt+CjBurP5Fpx7SFSuoGdRYah2/WiyZSp+VNJSeWmTHlz/c8OH
 VhYtqhTzn3OxXuWsQrexwAOs2jjgwSPUcGfG6JcEg/0GZ4cg6ClRp1jv7qp22f+dE/f/Eh8ioH3
 B+lUhjPPugj0YRsfHv1rx7Kf66FyKPvfgGPVzGZx0iQWzx0AONV+HyLCbzcEpZQBkR4oFxr9e0C
 FHM5mZxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016



On 8/19/25 6:59 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Current depth_updated has some problems:
> 
> 1) depth_updated() will be called for each hctx, while all elevators
> will update async_depth for the disk level, this is not related to hctx;
> 2) In blk_mq_update_nr_requests(), if previous hctx update succeed and
> this hctx update failed, q->nr_requests will not be updated, while
> async_depth is already updated with new nr_reqeuests in previous
> depth_updated();
> 3) All elevators are using q->nr_requests to calculate async_depth now,
> however, q->nr_requests is still the old value when depth_updated() is
> called from blk_mq_update_nr_requests();
> 
> Fix those problems by:
> 
> - pass in request_queue instead of hctx;
> - move depth_updated() after q->nr_requests is updated in
>   blk_mq_update_nr_requests();
> - add depth_updated() call in blk_mq_init_sched();
> - remove init_hctx() method for mq-deadline and bfq that is useless now;
> 
> Fixes: 77f1e0a52d26 ("bfq: update internal depth state when queue depth changes")
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Fixes: 42e6c6ce03fd ("lib/sbitmap: convert shallow_depth from one word to the whole sbitmap")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c   | 21 ++++-----------------
>  block/blk-mq-sched.c  |  3 +++
>  block/blk-mq-sched.h  | 11 +++++++++++
>  block/blk-mq.c        | 23 ++++++++++++-----------
>  block/elevator.h      |  2 +-
>  block/kyber-iosched.c | 10 ++++------
>  block/mq-deadline.c   | 15 ++-------------
>  7 files changed, 37 insertions(+), 48 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 50e51047e1fe..c0c398998aa1 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7109,9 +7109,10 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>   * See the comments on bfq_limit_depth for the purpose of
>   * the depths set in the function. Return minimum shallow depth we'll use.
>   */
> -static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
> +static void bfq_depth_updated(struct request_queue *q)
>  {
> -	unsigned int nr_requests = bfqd->queue->nr_requests;
> +	struct bfq_data *bfqd = q->elevator->elevator_data;
> +	unsigned int nr_requests = q->nr_requests;
>  
>  	/*
>  	 * In-word depths if no bfq_queue is being weight-raised:
> @@ -7143,21 +7144,8 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>  	bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
>  	/* no more than ~37% of tags for sync writes (~20% extra tags) */
>  	bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
> -}
> -
> -static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
> -{
> -	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
> -	struct blk_mq_tags *tags = hctx->sched_tags;
>  
> -	bfq_update_depths(bfqd, &tags->bitmap_tags);
> -	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
> -}
> -
> -static int bfq_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int index)
> -{
> -	bfq_depth_updated(hctx);
> -	return 0;
> +	blk_mq_set_min_shallow_depth(q, 1);
>  }
>  
>  static void bfq_exit_queue(struct elevator_queue *e)
> @@ -7628,7 +7616,6 @@ static struct elevator_type iosched_bfq_mq = {
>  		.request_merged		= bfq_request_merged,
>  		.has_work		= bfq_has_work,
>  		.depth_updated		= bfq_depth_updated,
> -		.init_hctx		= bfq_init_hctx,
>  		.init_sched		= bfq_init_queue,
>  		.exit_sched		= bfq_exit_queue,
>  	},
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index e2ce4a28e6c9..bf7dd97422ec 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -585,6 +585,9 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>  			}
>  		}
>  	}
> +
> +	if (e->ops.depth_updated)
> +		e->ops.depth_updated(q);
>  	return 0;
>  

Overall changes look good. That said, I think it might be cleaner to structure
it this way:

elevator_switch -> blk_mq_init_sched ->init_sched ==> sets async_depth
blk_mq_update_nr_requests ->depth_updated ==> updates async_depth

This way, we don’t need to call ->depth_updated from blk_mq_init_sched.

In summary:
- Avoid calling ->depth_updated during blk_mq_init_sched
- Set async_depth when the elevator is initialized (via ->init_sched)
- Update async_depth when nr_requests is modified through sysfs (via ->depth_updated)

Thanks,
--Nilay
