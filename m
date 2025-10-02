Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904F21348;
	Thu,  2 Oct 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418193; cv=none; b=X+HrincA/c2aTZNrO0hqiwhCaazj5BVUEzjyA34YaR37XwOn8ve7YlMPbJxvz6ROjoF2EM3h/jOtkGq0CnbhYIBa5E8Y0pMXHKPrkNsmeJisdSrF1Pil6GKbyfqjtMapkUxrD0Pj3wzLp2OctV1PMKrB6GTa1U9ovlAQPNwBrlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418193; c=relaxed/simple;
	bh=3CGm9PG5ILZCt0c51xHvV24Bg5BobjK0p8VqNOem5CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHTlM5TSIC6M2v9u63v06Q/WR4U1dhVvTZzQzFkrBr20SBFCjvw71ZatIvJkUbNy5UbInOur3FO7CtSrYW76ZjWG6bVUQukZWSHOjKpC5Q1tdC88a0bflc6EDjI71qpVwC6dVmmpIM3UQF6P/GmvuKiK/6AqBGX/Mvz9u1KBzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VshEI48W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VshEI48W"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Bv1eO001767;
	Thu, 2 Oct 2025 15:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WORjK6
	Ee+NiyPAdI1QmO+wB6QuQBHYftZ5ozMkZgNHs=; b=VshEI48WzurDRQtbzl/5kc
	YIKqbtl5wE/WoRjcoHfa0mFn2Lkehli2I9I6/ImW7neAPT5l0vA9M4/m53FynyBf
	oOuzhq6mHt5VDzmcxA8JXHPGffVgA6cos9Ka0iJSQxSyFmfwm0bpEg6fMULLi0/M
	DLnU0ToxPFaYGTxbmR0TILMVyCnKWBg2SPEyZzi2s8CbC5LGOQlf9qPMKcDnKpv5
	n5+H3CHN6+z5Lgh851A1jWA4NfSMAj7WWhb3yusygwu/2034ooeZ7OP2rm+dNjpR
	Hn42iQVnsBhP0UkKUbzszGa0IFQTMC10itY8iq6LEPJgQGR8riU9rzYrUdD64VZw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n864jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:10:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592ERlNg001667;
	Thu, 2 Oct 2025 15:10:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evfje7tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:10:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592FAq9I36503898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 15:10:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40A1058076;
	Thu,  2 Oct 2025 15:10:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D0B758043;
	Thu,  2 Oct 2025 15:10:48 +0000 (GMT)
Received: from [9.43.27.61] (unknown [9.43.27.61])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Oct 2025 15:10:47 +0000 (GMT)
Message-ID: <91799590-15cd-437d-900f-8bc372f7298b@linux.ibm.com>
Date: Thu, 2 Oct 2025 20:40:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] blk-mq: add a new queue sysfs attribute async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250930071111.1218494-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B6DLcoY_t4OV2Y00M3_0VQihzZZ8x4F4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX7nLnj+JDoTia
 axM/UoW8RmhpANa7SBqPID/3qw2Wq+CyrN90TZHLAo2hfeonAv24chWMz8tCYGEYS54Agh3aeOq
 fXDkEWLPZTgW1dIDkSKxUupH58xCi3cMnBhQbtbrtXn49W04xIdIHzsjxLC68/ubLBSzZkCaoU5
 UnYmjZib3pAFkodz0Q2HSaDST11GcEkjX8+NwS69WZpgM8GUmUK8EATblb/+0bA9SomnrewQB9v
 knnGolqFP6ohKlxpZa017lFGVzEeJr3wqS6dcmc01puCwLviIRZZtZBgiDGhhh2Wmbji41Vcl47
 7cRJkoVIDN9obhXF1wdCBA6oc4O2VQT4LkZIb1F2maqNMEp9v2E5RCk05G5ssUEaixgwmXFhBNa
 smQFVKCTJ1eJpnckpfx0hC2NUt0DgA==
X-Proofpoint-GUID: B6DLcoY_t4OV2Y00M3_0VQihzZZ8x4F4
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68de95fe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=WOpRoUcL_F6Ol7fEhz4A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025



On 9/30/25 12:41 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Add a new field async_depth to request_queue and related APIs, this is
> currently not used, following patches will convert elevators to use
> this instead of internal async_depth.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-core.c       |  1 +
>  block/blk-mq.c         |  4 ++++
>  block/blk-sysfs.c      | 47 ++++++++++++++++++++++++++++++++++++++++++
>  block/elevator.c       |  1 +
>  include/linux/blkdev.h |  1 +
>  5 files changed, 54 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index dd39ff651095..76df70cfc103 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>  	fs_reclaim_release(GFP_KERNEL);
>  
>  	q->nr_requests = BLKDEV_DEFAULT_RQ;
> +	q->async_depth = BLKDEV_DEFAULT_RQ;
>  
>  	return q;
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 09f579414161..260e54fa48f0 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -529,6 +529,8 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>  			data->rq_flags |= RQF_USE_SCHED;
>  			if (ops->limit_depth)
>  				ops->limit_depth(data->cmd_flags, data);
> +			else if (!blk_mq_sched_sync_request(data->cmd_flags))
> +				data->shallow_depth = q->async_depth;
>  		}

In the subsequent patches, I saw that ->limit_depth is still used for the
BFQ scheduler. Given that, it seems more consistent to also retain ->limit_depth
for the mq-deadline and Kyber schedulers, and set data->shallow_depth within their
respective ->limit_depth methods. If we take this approach, the additional 
blk_mq_sched_sync_request() check above becomes unnecessary.

So IMO:
- Keep ->limit_depth for all schedulers (bfq, mq-deadline, kyber).
- Remove the extra blk_mq_sched_sync_request() check from the core code.

Thanks,
--Nilay
