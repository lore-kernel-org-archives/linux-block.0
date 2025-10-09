Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E582DA762;
	Thu,  9 Oct 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008945; cv=none; b=rj99Yok0OUz7Q2a8ikFFN+KKWXQ/RBK2QiO/HNWLHbigJqWORhse21m+4l/MfHPKobl919/1Cc7O6xjNzV6NY5xMI06Qqoi9uJxpatmZ7VU7ezcoXCV7iFKApRcl5iy9zmuRH49xBdCdnBFzgoyRoGas9V9BsSGTYfCgopvX1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008945; c=relaxed/simple;
	bh=QqzQyQoVlUUDLH713bZE5/qJKJMNhqfDHKERxzr82W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bA0+PWYqIqVtqpF4Ulv2AgLvQAMm+2COCcQ2FaqC5iRmNcYPelvf5PyRYKlWuEQ/TwGQqcy+4qaMK7JSUCCibDPqIaAjMWXeVTrA0Jeb01ggkIzf46QccjrgPSqikgYb07ubMRttYWiq7GysW+Z03l9qRbhQkoUr6DDvkm1B5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GQ/Ve0eH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GQ/Ve0eH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995wuZf002774;
	Thu, 9 Oct 2025 11:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ro7ErT
	96akQOU1ctiBdqsseja7ItMM41r38WJIWc/7U=; b=GQ/Ve0eHEpXxCEIUcgZ5CC
	2K+X1mO1QvnTzJ0lbE+elvxGuAGBJacc1QqZFxrP9BcB9ruFELe4kTQ6k9bcAvGc
	fcZa4Ubf0zN0qbLz5iQybxAKUdrmFbSpEbglY04cgIWvxRNnSKt3i1Erod3Ne9Ue
	RmmSO/y6uyYMoQ13PhNbqUR96VGRLV2r7P9saQeofqai7ww9pVst0BNmO0U2WKnk
	9RM0C4A3FsEbqtebbakK5zRNcyzQPpmepnPEz0MvodFxQFHehYfH4rDPZEeEPV5L
	5aO1s7iIZxq0h4bKt9KIxu3bxlD5mQ4LlHQRZWGKwrLBcdm0pqGcgcIElyt5aBZg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv86vb3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:22:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998GSq2021058;
	Thu, 9 Oct 2025 11:22:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nv8sm7jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:22:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599BM5SR21430948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 11:22:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8B445805C;
	Thu,  9 Oct 2025 11:22:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309C15805F;
	Thu,  9 Oct 2025 11:22:02 +0000 (GMT)
Received: from [9.109.198.200] (unknown [9.109.198.200])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 11:22:01 +0000 (GMT)
Message-ID: <e3d333a0-e0d2-4e3f-bb7b-d64935f872b9@linux.ibm.com>
Date: Thu, 9 Oct 2025 16:52:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 6/7] block, bfq: convert to use
 request_queue->async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-7-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251009074634.527661-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kX0WZ0vjfbVGsOQFHnkBPhB-5hsD5unr
X-Proofpoint-ORIG-GUID: kX0WZ0vjfbVGsOQFHnkBPhB-5hsD5unr
X-Authority-Analysis: v=2.4 cv=MKNtWcZl c=1 sm=1 tr=0 ts=68e79adf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=dr6qpCbY_iyHjMTHIhQA:9 a=QEXdDO2ut3YA:10 a=Ba5x5ocL4jwA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8cYCW4JSAsW1
 7E/17sOon8KU56oH4nFaKHKW51qwKQ8NzVaLmBOyuWSPqeIYtnIqip0NKV1fcul3tuL6grEbewT
 SL37+ITRSxmzIGt4VGyieig8MGH2lt4stoBfsi6UsOvrVMdsvIOCfNUTYv0kttE2n1Seh2iCi78
 aBFsFazmMmuIgqlnxdM6r9LHsQ7dbXhZz2VajhdwL5yo4ewR+h8KvBPY0L/Tp66cLJcIlFnbHap
 sRZQJlGMKkzxUgHrmAGEi4CEeCtlXFlKlGIYdT7WthJBEJngHjhDJ3M/5BqiQDtdW4FtkJ3QDqz
 cP0hbQWC8t1oslxZcLeKg4l96T87BWwwKc46mvIL7Oa876k7S1uxXc4VBSNYKBeKdH4UyoWESUs
 91RR9YJ6lTRm+SExkWOfA4m4M9ALhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121



On 10/9/25 1:16 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The default limits is unchanged, and user can configure async_depth now.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
