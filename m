Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2E2D7DE5;
	Thu,  9 Oct 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009225; cv=none; b=vGfp6iyyRwMjWiNMSa8mM6TvinvIU3Zph4TiLsiL4VumFdYNNG/TmEX9ANoPhJ+5q/gfgRBwHXakzEUXybH8cktva8rjL6zYUNKSRjalUm4qTQDUZGDNESAQRsMtQWoB6G6l3aa7ChtAHYduUZwMyRjtm2DOZjDzdlWVUkZ4L8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009225; c=relaxed/simple;
	bh=KBQEGWpCXM52AVpHce0jra0MILJNrs8zPY54Cq818DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqVpIX8Chu1WwAH3XdYtKn6ima+DlfClzR+Fasc6kiluHVa3JPqI/m/LCJrUhZOcNPLTp0W2DeDGpLLY9Dyu4+C10NR08TCRVnvvdxh5DHQ3JdBgUmU8Z1qvNjAR0iM7qxbBzlETtgR1aqkUhGEX7O0Br/XTybx6u5/aao1/2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=coOu6h2h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="coOu6h2h"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59965po5030347;
	Thu, 9 Oct 2025 11:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XnR/BE
	y7+63dJxgajRBAjuhxIvapUlAjMvDTKRzjSsA=; b=coOu6h2hpC5TS4cS+jbVkB
	4EZ15tTgZflDGDSVxZf5PJY1ay5NTNu/3wUnj2wyxcjGHHutkp6MtPYNuMcdHU3q
	/1ZXETKfTbBcrrv9TgmceHaD3oRVzISIiNh7CB60aKs9Uod1G757jB3a16e88UtP
	XmZzNO2Ww6bYvHvRVxe21A27WMgCGrSaAls9G5BcWH53EbePo5u9mGnpvKPCOyMn
	R+u6rtopiwH2pbBZrsjxUNkq4O5oeQJhvAds1l/y3T47leRf/zGq0lfod+k5eafJ
	dbvLpT2hb+oft7t2XlFWOl5E11GYlWe+FTWuQKIxw0CSvFz48m3kEW3PolbvToCg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81ma4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:21:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998MNAC026019;
	Thu, 9 Oct 2025 11:21:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamm76h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:21:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599BLbF230016044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 11:21:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50A5458056;
	Thu,  9 Oct 2025 11:21:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D1258052;
	Thu,  9 Oct 2025 11:21:33 +0000 (GMT)
Received: from [9.109.198.200] (unknown [9.109.198.200])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 11:21:33 +0000 (GMT)
Message-ID: <6b43dd1e-d128-4d07-b589-8d683735d92e@linux.ibm.com>
Date: Thu, 9 Oct 2025 16:51:32 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 5/7] mq-deadline: covert to use
 request_queue->async_depth
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
        ming.lei@redhat.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251009074634.527661-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gJclL4_SbgAAFfPhzu_tuzUnbj6cSF36
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzQtows2qI/CD
 AhN6usJKlKYaO+Ics6nDJ5vBml/L+1+aPTj9mmAd4dJlW/HaHM3W9kjn1FvsyCdCnYrWBJwCuep
 y34tayVVbyYeNiE/gsZlw4PmqJQt3JKsX4dYUuOHo6S4oaURhz5/eNANwgEyctapOPIX7FEy1MH
 Eg7s7+O3MW1eewntrN9bk/Nlyz4zbJlHbDWKiSLq5pXlMi1roKTHtt63S7G53lJElSWDKWp1vXL
 Yw19wL9bsoF5i2vKx7hneyDU33x5YPHyrKilOyhSjpQa2sFuV7XbUaN/sHjJMhxqFC1Z9Xvpw45
 46M9CWbZPkl1n8IdEPduz4n6nVEC/MUfDrDNJU47p9kYwjo/+hhP+DLkXfyYW702jMSw+h7Mlvf
 qOKq6WlbD6acqd9hc72llb72wik0XQ==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e79ac3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=uRv04f0bpIKDJRt5AmAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: gJclL4_SbgAAFfPhzu_tuzUnbj6cSF36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On 10/9/25 1:16 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>

> Fix this problem by converting to request_queue->async_depth, where
> min_shallow_depth is set each time async_depth is updated.
> 
> Noted elevator attribute async_depth is now removed, queue attribute
> with the same name is used instead.
> 
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

