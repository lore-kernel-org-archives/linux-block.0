Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE712FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544812; cv=none; b=VyC8PheOGKfGEu+Z3FxmR0L69k82GGLTtm6dGR0occMc+9b9SsVKwf3fL+2K7TkH7e8Cj1ezr0wGv5v3Muhb8L6t8dWLdclh6JmV1/B1d9OgIgpHIjimw6Qenqu2wtQbnadULp940DDKHlyOntEKAbeFeY36OTLgsVXjSS1QiAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544812; c=relaxed/simple;
	bh=U1RCOhCZOVsjsAkOrO3H6XFO9ySkHRN06fb5dEmKTvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AJlwpo6bxzBhOf2skpvvjpkAW2SgJ6fnV3EkFyFu4Sz8RaaIM7yGVEfBo1BoAemTX7eTq6I/VApenwVN1n8Y7lEEiwUx0CzPn63PNXihy0X6cJ7lfvCfv+bLxk/UZuCd5dIYFpmr1BM3SaagdF0MgK8gWcD2X1q4bdb7UZXggJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BCaHnVFo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BCaHnVFo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604CELii011872;
	Sun, 4 Jan 2026 16:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IqO7tq
	Ny8P8EnUtKgeLvc0dnPg7ygfT04NH5H4WbYc0=; b=BCaHnVFobIc/iUVgiYsN/R
	sE4wb2WrtQ4MbBK5o1Xak3NSF2l6KWlOENU5fbKUMt0JaF5khJ3DGV5hrhZAdids
	enAiInWhX0u/KBlG8AfpscfnaOmOGrpgAzLjeAMXMuCMrjSm6YFJDvCZgw5hd0gn
	1h5ZMZOmjEkqs/uE5ZIuZB4vadby6ttNpbWs3sw4aWK/SxSLNStaIzdHKb42koCc
	XsP7WtbbeOLmFddf504DXpBbdymVOwTWDVKzDbDHin2gPdwn75KUNs0oqfAwyxr0
	EgIFQBeSw9Tcowbz6X3F9oHOKYh2Sha/GJy8M/FdaWhLFlKbrfY/jpEEISO5AgDg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspv4d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:39:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604Dd4Ib029632;
	Sun, 4 Jan 2026 16:39:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfdtxj675-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:39:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GduIF30737100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:39:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60EBA58043;
	Sun,  4 Jan 2026 16:39:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E69A058053;
	Sun,  4 Jan 2026 16:39:53 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:39:53 +0000 (GMT)
Message-ID: <7697d4c6-d3c5-4d0a-98a8-b6934f685e41@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:09:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/16] blk-iocost: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-13-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-13-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nyRD1WK8CwGcCxfTKya4MVAr_Jn0hi9y
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695a97de cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=r2BwZxqds70EAL1L_7UA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: nyRD1WK8CwGcCxfTKya4MVAr_Jn0hi9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX2XwaP5PsPk/u
 tbmr+TpRrSoveYXRtnwojd/wh2fcpSZX4ddIfPAZTHPRn87ziuqlNALoRoRxbtAav0qRygEW4mK
 jW+buR1eYCAtsJacy6zNGzjBcKnoznpOmmkxcFZ2nujF30L+h6eUv4PivFGRze1bwm2PfGMs7KU
 d3BDWFpF51kFHIGeDho9p/1IjyUKPd91rioGBGEqveUVYUKXDvjGBOH0WY8Mf39C4tl8zcpKf+Z
 8F9d1DpInFCd7Q5eucRHUtFMb46Bdy95GziOAJG9xMjEBImCHDixUYXCN3ETEFNKvLhDUmGwASJ
 mTzDeAoKkpFS/5HCYMwkRwurieQYeL2+SZojbwFh1LBZmfszuqTtmN+uKTiLFJj74o/4ZOeinw/
 D8xU3ukUM6rGkoq5kUnPZDvxJtsK/dPfiK34CSyLkM3TPeC6YdDIvSFQJYYbhvdXxwTy5hdveHR
 cmcTfknWuKpChOuCSZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> Like wbt, rq_qos_add() can be called from two path and the lock order
> are inversely:
> 
> - From ioc_qos_write(), queue is already frozen before rq_qos_add();
> - From ioc_cost_model_write(), rq_qos_add() is called directly;
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from ioc_cost_model_write(), then since all rq_qos_add() callers
> already freeze queue, convert to use rq_qos_add_frozen().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
