Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1732D1932;
	Wed, 10 Sep 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499103; cv=none; b=EmEextPd8Bt50Oz15awsOTwUAhILUJ16COprrEsbNv3fj1e7urslp+uAU7pOMO4twHoLQoncESkFLEm18bWMdz4WLB+oY95UqaTYNgEz1RVnJPjtqay58bRxKcWrdDLiUZaqqeo1BbSB0edvnnHRkKni//JjBr89E4mI1AuaFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499103; c=relaxed/simple;
	bh=mNgGsVMqAMdAtiUviVCYG4EplsU77als13NVMjJOAXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHxDSdysog5kHHZvpA8rxb/mC9zjtG9JnK0Nj6qTAorJEE0h7ZLCQfeNSic2cEq7iFcY2nSaXm8PstjFEkzlAXOBD8TaZ2/butHf51iZcs7m4sGGNRUYpE8vI4VvVbwNNFpR+a5oVP0VLQ1crJfEPVE1lwEKESNXSGSm5YX3hzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dnB0Enai; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dnB0Enai"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8116Z018756;
	Wed, 10 Sep 2025 10:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Q40gB
	l+CzBVlt9ozQakiDisEKMOyKsQg9tX+lYGTrU=; b=dnB0Enai2vpZeiaRdaba4x
	NUOJnyhaNAUB9sdJfVDBNHUyQVia6quXlJCFSe1seBuRlxLvlUCTW1jZIlTZma7N
	aDjEKUe7k37/xFCJbB3uVQNaGAyOzDyYRfAedJeqVtDxyxm4j9J0PoeFlgnQFRop
	nM+lzp/YL0MT7mACJG8UURYSPNgR0ym7mD+R5NKlqLJqft/4WLT94uApiddgkfB+
	IUOGVA2oYf5rd3x8Dghj1tsjAXRqlfWJIly2hf+xkylwBRhRfPYOXWiAuSNhXt6F
	+I0Xp80kSjqwsRJZny6MNflk/clhaK4GuMaqSSqtumliyjsyxFQh+2S8LGAZ+eAA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwwc7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:11:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A6XLvJ010666;
	Wed, 10 Sep 2025 10:11:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smyua8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:11:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AABHg95505634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 10:11:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF3CB58055;
	Wed, 10 Sep 2025 10:11:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D96975804B;
	Wed, 10 Sep 2025 10:11:13 +0000 (GMT)
Received: from [9.43.57.88] (unknown [9.43.57.88])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 10:11:13 +0000 (GMT)
Message-ID: <8abbf00d-b1de-48cb-8310-3c8d0a3018cf@linux.ibm.com>
Date: Wed, 10 Sep 2025 15:41:12 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-6.18/block 08/10] blk-mq: fix potential deadlock
 while nr_requests grown
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
 <20250910080445.239096-9-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250910080445.239096-9-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tsDC_Qbkt1Be8o4DT8mRM1wPuVwUYkAA
X-Proofpoint-ORIG-GUID: tsDC_Qbkt1Be8o4DT8mRM1wPuVwUYkAA
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c14ec7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=ULAgg6nowICSNR1rqZIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX1ovhveqwWsyW
 vS+U8dS4aVn592yt+XnOV1JQzRv3w6tf1Tj2DvqcjgvEpwfRcwg7fJN912xFO3ygdQJO7WewMxv
 fWI4SxR+EgTORxdk1dw2wmNd5sFoFKOQDWGjNsd3bQny75nxlVyC5ZakhwEoeoOgNrBkKcVST6N
 ZhhgYnw+WWv1ois+S7InJ2wVNHd7wka/qI80+QL1Y8lmj4a4a/J/VGbLxMn0OnSQ35yiGUzXbjQ
 9I8Qk8sztbheB6Fl53c0RdsIvB1OaK4UECpz1G0AA6CT0vJnVZBwi/Ar1qM1832NM0qhbHslbJu
 9OF4lKKWM6o7l/CeFoN3vMdvjjeXKfHkulMXwGbSya5m4KZl6Li1vI/yMVTSoZbl0gTtuG+8mUV
 ZRLqGIgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025



On 9/10/25 1:34 PM, Yu Kuai wrote:
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

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
