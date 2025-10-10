Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7F235041;
	Fri, 10 Oct 2025 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760071730; cv=none; b=i9qXQP4NDUdE5KVAfPvOzs9Nc0ywAtRyEXdMxWMGbmk6hdcJsw71lKQOTx461R7tyzlKHjGYy5XkXmwuBxAsP/KcXhKqet7H0g1M3grxzl7jnTxyaY3FL3UBjYivyE+yIPrrpRscvkQUHnaLpebeYgKv3Vlua3oRmoYff4ode3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760071730; c=relaxed/simple;
	bh=phRHx/VwWkrpOoRQmlu4l7O8Qm607TEQdv9DuALw9sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbhM9twyI6x9OJP3uh2Q2em3p7Uy/HZNumr2bs3i170L/wSCvPcjOyhTNI7lER6Qx1MySNC3X/6NTSVtp4Y7EV8xNA4A5o12TcFL3hh1Y+BEVOR+P6N/5kV/HqaQ41uRuxZlFaSJxlv8SzfbI/GA3Jc0Tb6iFkrkkr6JzeRe8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PNhnxSES; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNhnxSES"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599H7NBD016972;
	Fri, 10 Oct 2025 04:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Ur/6w
	0hOmkNV21C6M65ov7/SvzsTHLXyOAAfFKYIgU=; b=PNhnxSESXjG+tUH6bBIleH
	WP9Iy8PLZMXcAe41FQlf5yzOrz4xSDtcCBw55B3G+0X3837llpy21i4oVV3bzFNM
	0NwjmJOLSsQjbbk1Rf3tBynvvCLQHTf1xURzdNgYssfsJirY9JS0u97f2yQ4UyC3
	ESe0kv3OsHXfH9cLgXomZfQG+/ViPNm1MErMo38420LTX5A8mzQlRZWfOqY20u8y
	R2jJLZte/d9nj9ja+qqMaw1Jm6HM5X2vzddb8qTBsLnccisq4OUg1p9MyFTS/e7s
	asiOyS6I2XO8I0AIv1ViyLDhsJ34FNz7S7ShxxDHzMOX+aorqyKkG9Sc+oQ3bcuw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84rj3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 04:48:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A31Krp026015;
	Fri, 10 Oct 2025 04:48:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamr4rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 04:48:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59A4mExK63504696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 04:48:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 176065805C;
	Fri, 10 Oct 2025 04:48:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB6CC5805A;
	Fri, 10 Oct 2025 04:48:10 +0000 (GMT)
Received: from [9.43.29.178] (unknown [9.43.29.178])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Oct 2025 04:48:10 +0000 (GMT)
Message-ID: <b6518c17-e65f-4410-930c-04d3be364f9e@linux.ibm.com>
Date: Fri, 10 Oct 2025 10:17:47 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] blk-mq: add a new queue sysfs attribute
 async_depth
To: Yu Kuai <yukuai@kernel.org>, axboe@kernel.dk, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251010022812.2985286-1-yukuai@kernel.org>
 <20251010022812.2985286-4-yukuai@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251010022812.2985286-4-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e89010 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=cHuC2WqR6wHazkE0P-8A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 99dCmogKHKYFfp0IG1KEOinpd3QmFxqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwQM3DYYaY6QJ
 by83CHB0GzauMZmc7O6SU/TwvqShxdhcKR979tQhkq5CamBe/Uu6gjY0DH2Z/eYaBTytvazmnYj
 +VNHk4l/fc7CWxARJFfe99XdLynrwqEsWSKJBgN2QEtVobrMZ1GJIBREAq/8TwJWfAx/hxO1dCX
 h+n92KZ+QNfVUP+guXqXqJdryVG5pHNVqpLXT7lHZnN51Np4SwETNU9dSgCWmzPTn4o6Swd2Hn0
 cDQbZMZ818WToUlwkvVNpsYS0XkekAo1cy6wmKMZJwXw8vJM+gAtbVoCClKY/jthCXtV3tsyXS0
 MsOsvVu0kmiH6qTNRjkyUG/oyw3sum4LPwHUdGw1gSxl80FEWFhs+4tMuXFvnsYSdC3bfX4hTPC
 LrbHv2m1zSDNGiW7GMfLC8LF4SPGOA==
X-Proofpoint-ORIG-GUID: 99dCmogKHKYFfp0IG1KEOinpd3QmFxqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/10/25 7:58 AM, Yu Kuai wrote:
> +static ssize_t
> +queue_async_depth_store(struct gendisk *disk, const char *page, size_t count)
> +{
> +	struct request_queue *q = disk->queue;
> +	unsigned int memflags;
> +	unsigned long nr;
> +	int ret;
> +
> +	if (!queue_is_mq(q))
> +		return -EINVAL;
> +
> +	ret = queue_var_store(&nr, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (nr == 0)
> +		return -EINVAL;
> +
> +	memflags = blk_mq_freeze_queue(q);
> +	scoped_guard(mutex, &q->elevator_lock) {
> +		if (q->elevator) {
> +			q->async_depth = min(q->nr_requests, nr);
> +			if (q->elevator->type->ops.depth_updated)
> +				q->elevator->type->ops.depth_updated(q);
> +		} else {
> +			ret = -EINVAL;
> +		}
> +	}
> +	blk_mq_unfreeze_queue(q, memflags);
> +
> +	return ret;
> +}
> +
With this change, we've got the first user of scoped_guard() in the 
block subsystem!

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

