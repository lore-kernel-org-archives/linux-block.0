Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298886342;
	Thu,  2 Oct 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418005; cv=none; b=e20M82TzEbRc3NXrH9dmVAtf5AMetQKd+f7SepJc8jZS+1KEV5lSm+rgdxOuA2ksCC9wLNtNLO55S57M3AMzs5aWG+9GHVgfsz9N/qL2HQsi+N6p1PuuXsrQfUDy5/AAlVyuNW8gsO17KNKlPemJl2UDS1CQuSN1U2MN5/qpaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418005; c=relaxed/simple;
	bh=LpPXaMSA/v5S3oPaSSJpUykYM4xuxN7MEFYn5zR9OR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qu7vtdLqEA/5llQqkp76IHV6tiIST+szhrtWyUb8eH+MJps3FqplXmUJldIAjAedqIbMWhCzdcwepz7hXeodp2qTvZaJDYmwLzIifRyZp/k4MsglFJoEBU/f1Gt92apyM73qt+NjVHQ136chojAWEtgnF9sZHxW3/64a6T+Du7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iDtNfyCe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iDtNfyCe"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5928ZBYe000332;
	Thu, 2 Oct 2025 15:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ICrFZW
	tzEcc/DYZsF+/Ku/klFBfHQUS5dvQIjsTnYv8=; b=iDtNfyCegBmmHFKb69GDFU
	hxEzdyefVhOkLYcn6nACNT3/H1AR1Dc6zTbKSL/KcORA0LYW/gCIyCD6931sVxLa
	n9nQ1jShFh3pvTBK3ixl7JjMi9kTP8BiHuz4anXbXLI/bapp8JDDphQ3h7OokOL0
	m4ZP64jS7GM9vflb9s/38pFoW9aJb5ej8q5GaUls4sZxDW1pYKvd175+dsogFsYU
	e+N8N7zTqXk0vyOFmAwGkUYjPPoUeF/1YLVyJpwI5oioSAowiEtqxiKRvDiHGNtQ
	SZ2FS95l/YnS0qegbsGrvkd+C00WEosanuD02L414rIlva4pqHNu/P+l1lpJxXAA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhw807-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:12:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592DmBlI026752;
	Thu, 2 Oct 2025 15:12:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n6gse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 15:12:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 592FCtcH34472414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Oct 2025 15:12:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E2758043;
	Thu,  2 Oct 2025 15:12:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D10558059;
	Thu,  2 Oct 2025 15:12:50 +0000 (GMT)
Received: from [9.43.27.61] (unknown [9.43.27.61])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Oct 2025 15:12:50 +0000 (GMT)
Message-ID: <cbdb4a5a-a8ca-436b-a2ed-59f650a3dce7@linux.ibm.com>
Date: Thu, 2 Oct 2025 20:42:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] blk-mq: add documentation for new queue attribute
 async_dpeth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
 <20250930071111.1218494-8-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250930071111.1218494-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68de9678 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=8rCECXInrZZGTntQbewA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfXw5hcvswR/o/t
 lpqK8UEbc5Z+/Au/RPbQhCTi+cLSrSub6h5kyVgE9+Qcdc7gqZH9XNOSe3KAkKLfhirKBNEbOc1
 LPKPy6souPvo5kZ2qVFffYl3ki6ObaqSLxhdDZkFpqGx/HuzRvowOIxiSQwFesqQkdQENlN2Lv9
 H18Vd/ytZw/ewyyNpK0qfm4gV0+oZvi1YJlyBQMgyqt5/MM6Xg+OZNQBlkq2keMb3je10m2NtZD
 yW6j3BBJoo/cM6lfYZJjeBzxBwwXejhMbtB67T4CnUA8KvjCUIE/S2vMkILG4bZMZN6XYgSmhDJ
 zQ2UntWP2zzqdelp9aAdSzMzbSMBYasxAPDkRR+KyhDEP1SHHLVjBRXZW+frWly8FOP4yCwFY3n
 3GXRnWahnLLHd+4nedQjR8102Ollzg==
X-Proofpoint-GUID: pprgsBV7M6uICuP4qURKZFqmJ4qAYKn_
X-Proofpoint-ORIG-GUID: pprgsBV7M6uICuP4qURKZFqmJ4qAYKn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010



On 9/30/25 12:41 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Explain the attribute and the default value in different case.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 0ed10aeff86b..09b9b3db9a1f 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -609,6 +609,16 @@ Description:
>  		enabled, and whether tags are shared.
>  
>  
> +What:		/sys/block/<disk>/queue/async_depth
> +Date:		August 2025
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] This controls how many async requests may be allocated in the
> +		block layer. If elevator is none, then this value is nr_requests.
> +		By default, this value is 75% of nr_requests for bfq and kyber,
> +		abd nr_requests for mq-deadline.
> +
Hmm, it seems we need to further elaborate above documentation, seeing the
way this new sysfs interface is playing out now for different I/O schedulers. 
I'd suggest rewriting this as follow (you may further modify/simplify it based
on your taste, if needed):

Description:
[RW] Controls how many asynchronous requests may be allocated in the
block layer. The value is always capped at nr_requests.

  When no elevator is active (none):
  - async_depth is always equal to nr_requests.

  For bfq scheduler:
  - By default, async_depth is set to 75% of nr_requests. 
    Internal limits are then derived from this value:
    * Sync writes: limited to async_depth (≈75% of nr_requests).
    * Async I/O: limited to ~2/3 of async_depth (≈50% of nr_requests).

    If a bfq_queue is weight-raised:
    * Sync writes: limited to ~1/2 of async_depth (≈37% of nr_requests).
    * Async I/O: limited to ~1/4 of async_depth (≈18% of nr_requests).

  - If the user writes a custom value to async_depth, BFQ will recompute
    these limits proportionally based on the new value.

  For Kyber:
  - By default async_depth is set to 75% of nr_requests.
  - If the user writes a custom value to async_depth, then it override the
    default and directly control the limit for writes and async I/O.

  For mq-deadline:
  - By default async_depth is set to nr_requests.
  - If the user writes a custom value to async_depth, then it override the
    default and directly control the limit for writes and async I/O.

Thanks,
--Nilay

