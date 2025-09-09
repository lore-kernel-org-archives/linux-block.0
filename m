Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145C22A7E4;
	Tue,  9 Sep 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401751; cv=none; b=G782z1HK7FOc5gv9yWVQr8R9G4ItfUuWmg5V1/ZmBc5AThMw//Zia3+C3ztf+72dLFAXm+HAK2Ok8XTbP+UGfjbm8473nV2elV5nATMpGXepsgKdhht3GYVXCdMIM9BKaeZ9ACddsb7A6QNYnf2ebGydgtUnuFUk3+uOLbfIyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401751; c=relaxed/simple;
	bh=jAm3K1RdcR5C4Btwsz1XiVHYMEuOCQMrB0HsmV5Dt2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIPg/KJkUlJ1ezfjaCeKuKb5us+J3OljFgYZfJS97lfSwyjUz30dOvQpA1Se/OHPW8hb3kw0Xht5RaC/IvzIm7+OlZGnYqsfP6ZDKERoRAm7LokuNMI3g9HvSNG38eGs+uQ2+oJuAOELp9aICsV5KkKKKCRwyhFBOQf1BKNNu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YOT4jQ98; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YOT4jQ98"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896fLbh018487;
	Tue, 9 Sep 2025 07:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p4OXU+
	X2qJd+c3DKXtgsU4Ypt8ZSGes2gDmocO3kiW8=; b=YOT4jQ98cZyWN/1jnAeCaZ
	K9kqJ0EHTqxrT5p0m4MMjYnBbZ35HdgSN0y5NUYzYU1AAkwSpz/ua690YI6yxY5u
	alzVRSI4zwaea5tugwlsiap1EgR5AizXAoNopAIJAv2MaGJuanu1I9ByizdUGSbm
	6v+Xf45sb2Cq67HS1qJIosV8hX99a+pTmrydn/6D8m8Bz44GzmV4oYz3WjGT1y9e
	0phplGPOwZoglwDKgpgBVc+LqkS2g2/aL0Of+t6d4UrCfuHHhjj11yKaAG9D/jbn
	+uVnzeMTDlQt1fkSe0jm9HPzLEWddPV7E1GGG//xs62lY2xKFMQmN0Gom1dFwL6w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeb9qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:08:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896IRJR007982;
	Tue, 9 Sep 2025 07:08:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109phv24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:08:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58978jZd1508094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 07:08:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F6B058222;
	Tue,  9 Sep 2025 06:39:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB8455821A;
	Tue,  9 Sep 2025 06:39:16 +0000 (GMT)
Received: from [9.43.113.79] (unknown [9.43.113.79])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 06:39:16 +0000 (GMT)
Message-ID: <484c552e-462f-488f-90bf-18fe5042f1bb@linux.ibm.com>
Date: Tue, 9 Sep 2025 12:09:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 08/10] blk-mq: fix potential deadlock while
 nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-9-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX/ebgbA3RKYNh
 elOKyTLFRoBS88JQTzCmqT6ItsGyHUCrZPjx06uP7oSExTVDHhO+lYYGFAeA67Wvnxmu8RVMBNy
 AchcjQ35A5Li8SgPzRfyVaSncp+l2VpPHTejAAPepdWnRK4jZp16XA01iMLUPCVx2+fzRp0q3kC
 uji178lYlop33590B/F2avifU1lzgnCf2a3RpsQl9ebSf2g7IrFIuqn76LIfmJ/TATrcKjj4t+B
 R2M2VgDqYmSCTBncoDhmYPDnhAAzbtNfIlF/YAk86qd61sb4AO4+v1KFs9VUdcoeQaRQzuOh2sO
 UQwBRXjoYMwTc2M+Aq5tg1T/0MUkFw96Ycih+nJU25XShi6NN+26lDks6ANmFad4jmuxUvm/8GF
 +EDZH6ea
X-Proofpoint-ORIG-GUID: M8vTnCqBh7MFdp7i4gMvOvi0O5KVJp56
X-Proofpoint-GUID: M8vTnCqBh7MFdp7i4gMvOvi0O5KVJp56
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bfd27e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=eVc7BTMwAaXTG348FLsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Allocate and free sched_tags while queue is freezed can deadlock[1],
> this is a long term problem, hence allocate memory before freezing
> queue and free memory after queue is unfreezed.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
[...]
[...]

> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 7ea15bf68b4b..a0a7ebad378f 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -64,11 +64,12 @@ static ssize_t queue_requests_show(struct gendisk *disk, char *page)
>  static ssize_t
>  queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>  {
> -	unsigned long nr;
> -	int ret, err;
> -	unsigned int memflags;
>  	struct request_queue *q = disk->queue;
>  	struct blk_mq_tag_set *set = q->tag_set;
> +	struct elevator_tags *et = NULL;
> +	unsigned int memflags;
> +	unsigned long nr;
> +	int ret;
>  
>  	ret = queue_var_store(&nr, page, count);
>  	if (ret < 0)
> @@ -90,16 +91,24 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>  		goto unlock;
>  	}
>  
> +	if (q->elevator && nr > q->elevator->et->nr_requests) {
> +		/* allocate memory before freezing queue to prevent deadlock */
> +		et = blk_mq_alloc_sched_tags(set, q->nr_hw_queues, nr);
> +		if (!et) {
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
> +	}
> +
I think we should add a comment above explaining why is it safe 
to access q->elevator without holding ->elevator_lock.

Thanks,
--Nilay
