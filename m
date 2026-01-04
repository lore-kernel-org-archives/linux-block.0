Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957612FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544753; cv=none; b=KiAY+hfLsZQ8lCfAo+ma1dxG0kD4KyHqE/Iy39YHe31l0RlREK/PB/xeoTGRFPFZfaSsghI4Y1z+trMp6Bb4st/YwvoAdwkwAOgqrP7k1jtj2uEwy8m6v42aRMGDN61olORKFRH0Jta3ZjnO7B757WrSRWPqYEqFrOzbfiWyfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544753; c=relaxed/simple;
	bh=i2d5mS5032dDyGtZH32d0eU/pYY8zlcqZ5wT2rj7BpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=daQopLjG5iGn/G/XLJKOGvlewdjq/G0wNeTnBVJRIax6j0qpPZrvRyUdgM9MDJaaZ1IoeH/T41LkDsiYmlg4c/QQ3PsN4BdtU63PM02yHSnnmVVLdhD6oyH4ldHD9VHa4YaQLFR/jbrj0I10tfhefFJp2YjzI1gfeSD2xeAHsfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KKFLlAX1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KKFLlAX1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604BRMZE028030;
	Sun, 4 Jan 2026 16:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CcIe00
	VU8HX+CNaXTdwFsonKWcfj63I0foZh56Y/xDY=; b=KKFLlAX1m3JbveTp208Fzf
	ra/VkMig40WSgy8f3m3VQraI/qa8BuCuHMaU+UXrcEpEBSErrLFfsFNS5gn3PowS
	gsMfsbmY/0DgyfS3eVFRcfcDqEzh5HQyCQZAnKr1t+PlnmmcqLyAmWDa3BzcYHE6
	N5MTjsqd19/QK6vwMddF0B6PRz310WYCbVxzihZaZ44wJoqPZ3ec88p4cVKBb5pR
	H+dvUSzljEEJA/badx8rizV5P2rYgQbH7xHS1060yyam8j6eAMn68BUlfOY3VYmC
	+GIw7pq2zaMGMsLOIzUsYS/kz7eMXsdSy5jbySiXD5pbW36U9P476q0QHopRWMzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm6v4vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:38:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604GHEb2019177;
	Sun, 4 Jan 2026 16:38:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg50ssvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:38:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GcrUp60096944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:38:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B358558059;
	Sun,  4 Jan 2026 16:38:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25D7758053;
	Sun,  4 Jan 2026 16:38:51 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:38:50 +0000 (GMT)
Message-ID: <4638071a-df70-4295-8082-eb5a2957501e@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:08:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/16] blk-throttle: fix possible deadlock for fs
 reclaim under rq_qos_mutex
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-10-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-10-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695a979f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=DuAXc3mGnazSLxeS_qgA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: k-Ir46rHVsJAp5s-YngRgZ2E4Cv_Uv2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX13Q2g9k9R4L8
 vNrGhIA8W3qglQ3HJanyo/44NjyhbgVTCFXFhemd9e7OkDaHdiRw0Y8He/k1LQf8m4DhfUtUVRY
 pVfzNWUKvWPII3Wsup2jCWgvImjicWtstv1PJSjzHjbMyaGzjtB8wfbTRq7h0ipCjmGrU9NVQ6q
 4uMxFr5W9aB9AOmpkEnctxbVsmSHl7S/t1ypSZl+fPFHPqCqqFe1liTlZ/8Rawy+7CkcG53J6CT
 zjOk/w7t524FiWX/r2nPAqdUDehFKE3PAb6BqK0FI5fjxm9J/25z299gY5kDAu6G0RZtysurH48
 XgZHF2zgVHQl+NnepLbMnqmy3gPhnH7jwIxEHu/6WzSuQLCtFy06Fb2oT73Bn2WK/MY5P3ws6hj
 YWKHtr0BCgnXERBJcnGFW7ofG0uTWNGNeVEfzS9dHk9UZiuixDBmPgg2CLyQj04VyqJlyspRwfW
 ys6OpeJvCuB4iPfQD6Q==
X-Proofpoint-ORIG-GUID: k-Ir46rHVsJAp5s-YngRgZ2E4Cv_Uv2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> blk_throtl_init() can be called with rq_qos_mutex held from blkcg
> configuration, and fs reclaim can be triggered because GFP_KERNEL is used
> to allocate memory. This can deadlock because rq_qos_mutex can be held
> with queue frozen.
> 
> Fix the problem by using blkg_conf_open_bdev_frozen(), also remove
> useless queue frozen from blk_throtl_init().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
