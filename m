Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910EB235074;
	Tue,  9 Sep 2025 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399394; cv=none; b=DAHzhh6vl6sF0eJwhuRvpaOOqYbO9CZgc2L/ubRE7GBR76AHqBqCIfgKVgAi9F4eg0aGQic0Z1y+bgRKv6fXUO5ZtFjCMDuW4xwKRrHlTMkGTIrSxe5AYsruDWX461w2HfnFbE2aTCh/xkGotz5Gdr5AqjjegydcepRPhTNkQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399394; c=relaxed/simple;
	bh=0WLL0f8NJ8cwHD/XemZya+D9Typtd/p+CMu9DQSWELg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBvx1HTunmBokPykJV6CWrvCZVqXZXstPQ1BOf+OYBNPl+J7GaxIsVi7+NVKXb3bcsYDQ+4KQyjmQwZp/qav4R+EWP9u5vnYbEHwLHM3Pivyo9B/9nNHZaXWEILVW+5exl1EBqkZZMkepIMxQLwK6kvML07wAEor/W6vVMwXhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s6P+gDxP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s6P+gDxP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588NNHxM007706;
	Tue, 9 Sep 2025 06:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x4YCRX
	khUrlDStIx0Xc+Fh8XD2rBEsPOtnP39d9u0fQ=; b=s6P+gDxPBLtf9llt9lwdTE
	+WLV/+5jZDlUb+ApemK3qeCgxJoXLXj7Ing3Vsdy4yR75bKJK0l0qT9dYmaSxqcI
	cIQqB9KT0OyBwiyOKq5U+FZMLcYAoNbyL+V6WvHOB5Nu26+UT8NF+nSTaYTkHYuz
	OTDOhXI8hzDWEs2spcZH+bMEiD98bhMPXwJfcbPnCxtgaqudWBU2jx1OOt79WIDQ
	Hi9yTkg1qSfEJlxWJY5DuINjYdOrf0y6QAcOJynXNx5CI8sm8kgMtJb2S3H9YDfT
	70CXNLz1Gt4NpieCiXCy1neheTWvbv9OTv4laCahXqgOuCpNHTN2JAwa+y2RcTxg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyctryf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:29:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58961PUh007950;
	Tue, 9 Sep 2025 06:29:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109phpdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:29:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5896TLHG26411524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 06:29:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9532589AA;
	Tue,  9 Sep 2025 06:29:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9E705895B;
	Tue,  9 Sep 2025 06:29:23 +0000 (GMT)
Received: from [9.43.113.79] (unknown [9.43.113.79])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 06:29:06 +0000 (GMT)
Message-ID: <9708abeb-7677-4c0e-931b-7ca5fe0a0242@linux.ibm.com>
Date: Tue, 9 Sep 2025 11:59:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 04/10] blk-mq: convert to serialize
 updating nr_requests with update_nr_hwq_lock
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cTXGwRW51Wo6sC56ajiyl6LPDS97EPLu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXyIxwDe2B/HjY
 uBlblX17dXK26nbg8CTnwenOnlIgy8EG75WkhnAPOcweDX3cg8SbsOKNr9Mp/c+X6AvDjkEbLI1
 otTKVqpKpDSd3cSKLV9PKAJ6WyirE2a4HVV3QFtehd9aLCB3lf8CzhFfPv8g5kJAwKhwpRVl58I
 tAEKiLqGZvjT04UlKk/cTLMtAmPqvRLcmzvapkpkP+Um8Z5LX4x4GBa2CfOXvQG53wtQa0sU7qH
 TNkLnl7Q0JGpCSIoR0S/1D6ZbQG4oQ3y7YLKQY/VK8ksACm2Gs/nizaI2lU2Cuzuj/+6Qo4/XOO
 i3HXy2iWuUzgdxOcsidg16egZMCSD+0710M52+na5W2NRN4p+c13KRiUJ6U14rIkFMaSrJUP+qf
 +CBy4rpv
X-Proofpoint-GUID: cTXGwRW51Wo6sC56ajiyl6LPDS97EPLu
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68bfc94c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=CTgejVLxCpRuXOwdBJ0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> request_queue->nr_requests can be changed by:
> 
> a) switching elevator by update nr_hw_queues
> b) switching elevator by elevator sysfs attribute
> c) configue queue sysfs attribute nr_requests
> 
> Current lock order is:
> 
> 1) update_nr_hwq_lock, case a,b
> 2) freeze_queue
> 3) elevator_lock, cas a,b,c
> 
> And update nr_requests is seriablized by elevator_lock() already,
> however, in the case c), we'll have to allocate new sched_tags if
> nr_requests grow, and do this with elevator_lock held and queue
> freezed has the risk of deadlock.
> 
> Hence use update_nr_hwq_lock instead, make it possible to allocate
> memory if tags grow, meanwhile also prevent nr_requests to be changed
> concurrently.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-sysfs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f99519f7a820..7ea15bf68b4b 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>  	int ret, err;
>  	unsigned int memflags;
>  	struct request_queue *q = disk->queue;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	ret = queue_var_store(&nr, page, count);
>  	if (ret < 0)
>  		return ret;
>  
> -	memflags = blk_mq_freeze_queue(q);
> -	mutex_lock(&q->elevator_lock);
> +	/* serialize updating nr_requests with switching elevator */
> +	down_write(&set->update_nr_hwq_lock);
>  
For serializing update of nr_requests with switching elevator,
we should use disable_elv_switch(). So with this change we 
don't need to acquire ->update_nr_hwq_lock in writer context 
while running blk_mq_update_nr_requests but instead it can run
acquiring ->update_nr_hwq_lock in the reader context.

So the code flow should be,

disable_elv_switch  => this would set QUEUE_FLAG_NO_ELV_SWITCH
...
down_read ->update_nr_hwq_lock
acquire ->freeze_lock
acquire ->elevator_lock;
...
...
release ->elevator_lock;
release ->freeze_lock

clear QUEUE_FLAG_NO_ELV_SWITCH
up_read ->update_nr_hwq_lock

Thanks,
--Nilay


