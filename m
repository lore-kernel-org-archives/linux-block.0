Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199271D6187
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067536; cv=none; b=HMWkcRfN/SyuutCz+hVr98vlpofyI3hOLVzLw1pFDS1pR6DxAfUhM9gBxZxgm52SoS9mFArmfb6RzrIeJEHv+XYvMyHlxoGp9pvbCKu5SXqmJZaSfBb85IDoQCJE3IYdIKzLTme6dTmy0A8uUOnK93EtBszcdjM+6kG6N4vAgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067536; c=relaxed/simple;
	bh=R5F/7i0HtyJpqEKE9f/AzYMDdnNvh+mmL+fSpOwGJRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gD3Keq+5rCe1Ulay41KoBmv0onkNDA02qkUUxi/ud1VYFIH0ti3guFx6gfRbp4OfnrTpVbr0rPw7wOoPx1SC24QewAAAFDQmZtfnUMAHyUTrh+PfeSJG2J9Km8YQVZo2D0HA04mmJNIBDNV8+BUnZTRjjcdBoH0ZTpe/GlXiK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nCwkxXbM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nCwkxXbM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIARYU3026434;
	Thu, 18 Dec 2025 14:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2jJd85
	Wbq5faTpARkk3gXFpZZkkNwIgIYOS6Gzn7TMs=; b=nCwkxXbMbitqlNBrBF0cS+
	l+l8joCKSFXBVBtDFb5aoSpF8Qc2aJzgLGKtwUVVT2NToXG7+nDlaHcKDbJKAq72
	62iG+mbJkuXyQgBCGlEMNeOw4BGqXgmpRZUFXh8yhPItkU9ReXyrUgotz0uxb7O+
	hdXG7YHKCZARPpYNiZ7fuyb7nqrsxbYwz7ucLdmepLrChhmEyamri4xtA/xjeJNI
	+5/VgEc1WWkzvLpc/lXg78Rs4qhhQR1EN20P/8lnQgG7QYUQpvT5vZ6CTUbSJoha
	OfqIDvLDMN+Nat/Sbgn/MElpGy15WZ7heurXG/eLKdElsF1ZWt6z1kfo5XGZonMw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8u4ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:18:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIC3nDt005686;
	Thu, 18 Dec 2025 14:18:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp7duf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:18:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIEIekW21758662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 14:18:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0067C58052;
	Thu, 18 Dec 2025 14:18:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01AB358050;
	Thu, 18 Dec 2025 14:18:38 +0000 (GMT)
Received: from [9.111.59.18] (unknown [9.111.59.18])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 14:18:37 +0000 (GMT)
Message-ID: <96af7e1a-8b8b-42b3-9247-b52df56af2ec@linux.ibm.com>
Date: Thu, 18 Dec 2025 19:48:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] blk-wbt: factor out a helper wbt_set_lat()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-2-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251214101409.1723751-2-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX2iyHkS9gzqJa
 PxTsvYFmT3lMJPk6EZRlddJ7gbfFkxgstEOE51R7z0JAYhUejl8ukN1plCBlm4hN9coljDQ6l8Y
 hVs+Nl5aJlhCC7WKOQIBSK07/0hoqIJOiSRVUJaA6nYFcImydIWuF6l7PUwITEfjhDD7x/BZjDF
 9iK7pJyWAVwwtXJ2HP05a8IcwYlXqYKX565rJnrretwuYoh9COO2iAIHdHWvK6pwKmhKy049m+0
 NFKH35catpCCIjR/f8bYiqZglejstRAoxYkkF6lVMCh4pFAYvy8Beayo2pRsBTPQKNVLBDVqPyG
 K5ipTpDeKs7WXFUjJhh+YnOOC+oeco9ZP7ckcwmcy8FfHkxUrhXvqZDCFYHwYpreo90jOURMPbT
 SuOrqbv5aW6eFULt+TLtIt6egfy+AQ==
X-Proofpoint-GUID: ahvPA6GErM_AFT-uat3j9FzkKQiKX5zK
X-Proofpoint-ORIG-GUID: ahvPA6GErM_AFT-uat3j9FzkKQiKX5zK
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69440d42 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=Xr457Ox3nHxwgcePNx4A:9 a=QEXdDO2ut3YA:10
 a=A3mqa8q7df4A:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018



On 12/14/25 3:43 PM, Yu Kuai wrote:
> To move implementation details inside blk-wbt.c, prepare to fix possible
> deadlock to call wbt_init() while queue is frozen in the next patch.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
