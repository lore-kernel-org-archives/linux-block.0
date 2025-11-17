Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB926FA4E;
	Mon, 17 Nov 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374316; cv=none; b=MaacW+6uvq4cJhRzrS5ntebQPNCaAMltVAlkjLsXFA7ZSLW2SNfxCTIyg2XQVSU8csqTBAN6CrGhbKR+v/B053ABMyIGxkdYZgMAzQcLB4FKSbRLj9VE4G3b2bWSkmVhAHWBQObqG39yLDQJM5WE1SbsXreHPQYRN2l29C7bKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374316; c=relaxed/simple;
	bh=bc9jKXL61vyFGaLZXRt+T2cz2RalXaUriD80YIZzSLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GZMmwMRuubtT550MPNqZCg4ejv6Ei8Gbbug+2kvQhPH6iNhL0AKOfJX6mHkJLStsQM+9GrmwciGG5GIwwP1DOtfpP6TimLPCWdlKzhGQThNNm+8e+rAw2/uqAM1uRy+MK0KdADhhCqpwm/Pb43ky9ixqKiYAcbrMoVlvNyt7xAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ktb18Wwe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ktb18Wwe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGLXBPO007312;
	Mon, 17 Nov 2025 10:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wE7I+Y
	Zs6BKpDFgGKlnzcKlSzZ/Pbb0/MyUIMA+Ez7g=; b=ktb18Wwe3gfIbYZCFrnOph
	IG5jfYs4MnZ0Jc/nrh0fn4iFnDuhHjC6fijtqm5SOJiiFW41r3uFOpYkPRxcM31V
	Vyq1Vpc/lEfEZiRbMkj6mIpJ1w1hHw543a6jAfSftneQrPn57BVifVwY6HUteB7k
	IFKmhi1P8LHNywGTR0GQGljMeYpveT+n6RL1FwgnHEsBrOmVtNru4CVHrdQLEBLa
	hM4QaU7GbysFWW+sKzWADg4NlhorfoEfgspMzfHqyT6EL4P3rke5hWA0AORiQ7s2
	Tj9xIphwcvdbdmqAANmYY36BDNuLwEVxrnJfMoe2m2yY/w0kXHKxFw9URQBr+WhA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejgwncax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:11:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH8ajEt017319;
	Mon, 17 Nov 2025 10:11:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1cwnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 10:11:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHABgP926411588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:11:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14BC45805E;
	Mon, 17 Nov 2025 10:11:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C160C58065;
	Mon, 17 Nov 2025 10:11:39 +0000 (GMT)
Received: from [9.61.140.236] (unknown [9.61.140.236])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 10:11:39 +0000 (GMT)
Message-ID: <d653c3c3-4b81-4af5-a05b-f95e972a0f01@linux.ibm.com>
Date: Mon, 17 Nov 2025 15:41:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 3/5] blk-iocost: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, ming.lei@redhat.com
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-4-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251116041024.120500-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: myrXS45mhKMpfkz7tyuOPwdLbwJfuD7f
X-Authority-Analysis: v=2.4 cv=YqwChoYX c=1 sm=1 tr=0 ts=691af4df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=GMA-ChsNDpLoEvl0DtgA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: myrXS45mhKMpfkz7tyuOPwdLbwJfuD7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7cAGCqNUDQ/f
 NQPeYhRf+kIPTVIC+xN/riHehmg/9tRIT8fOveQVV0s6adnd/GCNdemOwH1ej8xFSuaUMpx5WDq
 xCIa1NJjOgcnz0OPzG1+1JJYUn80xRoC1BEU/XUx8AQtpUdTR/REn629IRlVYyfd/CLRh1c5aqS
 BJP2gm4PyIflsqwD3HuSrKyt/xLwompl/+yU0bJRNO8bCxt7y0C9KIdYXC9BuJKNB0zDTp4jnCW
 bzZnPrsPPR282X50Z8dd6/KOelNIwlcA4/hW9dTJjmjapeSLTXnQInu/15u/2ISlnQkNamOn6e6
 6/VoHx/cW77zjzYfQqZiwWlC4M2UHpTbyFAHqY9FWdsOZL6U+b4XClTtqyzVMw/yf5CBm8mQuIi
 RulwqHAu1Ecm2ShTtfN01rLvIt4skw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032



On 11/16/25 9:40 AM, Yu Kuai wrote:
> Like wbt, rq_qos_add() can be called from two path and the lock order
> are inversely:
> 
> - From ioc_qos_write(), queue is already freezed before rq_qos_add();
> - From ioc_cost_model_write(), rq_qos_add() is called directly;
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from ioc_cost_model_write(), then since all rq_qos_add() callers
> already freeze queue, convert to use rq_qos_add_freezed.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
