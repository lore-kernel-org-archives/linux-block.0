Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F802E40E;
	Tue,  9 Sep 2025 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420370; cv=none; b=p9f6BbO/vUhL08FD9rh7xRmOe4xJXhSCZiZUPR0IzMTpdZSjc/7G4H3+PUP2NHXWk7zh6vy4wCEqbmYaet7AggrWkk5TEdMvInuKz0pvS3OJTpF/oMN0xRrryX+xwriLeEvNNTuWOTzZujvmYD7GYgDCic3jdaefH5Cb0/5Oo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420370; c=relaxed/simple;
	bh=feszLr576pDSGZXGjidDKJRWgzUpB3Lq6jjUz635Ob0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+XPUUy/BFUMGdVyis3Vhbkk41IdDoJp6ptf5KSlDFyMZ6Fnrm2gpETldqLrNaF7tRHhITUMopTG9BjwUSx9mhCjYjB8don9YHl9wwoD9JCWmZNEW4fPboDjJfeFemVq0668T4ee7LrsrpeDvyxmx2hZs2rujVSzh9aptaLktIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jgJ+wP3u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jgJ+wP3u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896ksof004387;
	Tue, 9 Sep 2025 12:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oPk7EQ
	+BpeOJKoIWXFeP960lHP3XsW+wBAFdua97VBk=; b=jgJ+wP3uzlecifxuR2EmnS
	KS1NMLISGi2E6vAwdrKaD1OJP2LqUAsuUWHTSABhgyFL4HJUzOn6g7C5AZ5vfmZj
	r5jbFrJBMsO2E7nhVxLafejeFh1i57cjrR3vBkkSQkt+OKH0wXk6tInQrrDf1w1n
	WmF12Zqv3BO1Xyhf8Q3AZFAeR/jR/QfHnNyyF9/oOPAyYorBDoiiNbCQ9hwmQA1d
	QrUls8PEqTs1Ecw5/Bx9aCqcClXWs2nl+wT0eILWrcOiiZuP2t0FW8HYU65S97G+
	WlfEboXbYL0Ye+odvtuUag6xLyjXqZxKi5ZtLGdL2pvycvkMnlDeo3sghtyaCd5Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsqd6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:19:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589BPgjJ001177;
	Tue, 9 Sep 2025 12:19:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203ardu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:19:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589CJGGq3932876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 12:19:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24D5958057;
	Tue,  9 Sep 2025 12:19:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99A4B58061;
	Tue,  9 Sep 2025 12:19:12 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 12:19:12 +0000 (GMT)
Message-ID: <1da608e8-5603-47df-bf79-a32032a9fcb9@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:49:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 07/10] blk-mq-sched: add new parameter
 nr_requests in blk_mq_alloc_sched_tags()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-8-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-8-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXzmlbvzjEzO+e
 HXYwkCS0Mn0890BTk8Fw66SU6kpEZi++eeG4F/QFaKyGR8nKwg0EAm1ByratD703McZhWeXDTeW
 VXcNXWD4tzUumahxr6W9DRNCUziNBgNCN9flgva5YAndAUmhlklIwVQpf8W0qsBS6MM8GhguG11
 BfpNYTNZcMp5XVsMfjblt5q7BGabadFNXaScOiPXAB1qkcxHIzIKF5evFDL3AerF+MRZlEN+xE3
 FqlOvWYd+ST47gLGlMxtGUKctuWvxF4kyCpJ60iLTZBgUDyW4xt/+4YKFhOUBfEfw2YdDV36OxN
 lF75/SEHCBhObwneXF8hv2dow+H6csxN6JZDf3WyYTMS3L1LsqWevHz85v5nbgjvkbRY2HBamKO
 XQFQ9jyL
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c01b45 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=tYaLi_SPQAiz_1EOLDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vARs_BjkrWIB0rdaeR8kOPtr3KexKkI6
X-Proofpoint-ORIG-GUID: vARs_BjkrWIB0rdaeR8kOPtr3KexKkI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This helper only support to allocate the default number of requests,
> add a new parameter to support specific number of requests.
> 
> Prepare to fix potential deadlock in the case nr_requests grow.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
