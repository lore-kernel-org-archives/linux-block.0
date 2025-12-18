Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EE1D6187
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067622; cv=none; b=YgqBOP6I6oiQuborzOEOlJWHDAgfn5IK1No7UYeN4Ui/UYxBUbCjL7BYvGgLVlDXpq2xqbBCkpyihmjXC/pRiHaKezDPAATttcg2VSN8YQnqq3hYjOKJ8puIggM+WEnYR2B8dhQSbp/bIKqRAKnR5a/wR2r/mUK/Sn7joPkf40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067622; c=relaxed/simple;
	bh=fWex/GhEVPOpbWpQK0YVPTyNyd3vQn+E7kUFj022A8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kGTo5ndXW1cOFQ92LRNUoyOTncb6yaa0DeNqlOjSaifHyePnUJl7vQ9dMcPNqaO2g/b+vzV/Fq2KLYKbPlM24zcbD5avaApJ5DaKEf/7urCIfBHH9PtRBlkWSEqJ8rlR8PukqtwOL43H7ReA3CgaODciGQ4e6lztGSWNKSLqSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oVyZTkIQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oVyZTkIQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIC0L3S029646;
	Thu, 18 Dec 2025 14:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3JyS4/
	3EZ/NzAuTOozgG3QZD2w+2qs5cW4iA3RIudbY=; b=oVyZTkIQJE2Z/4RRMY1tCX
	oYrfSPhyZENrFChl27q4suQZmfUKs2kG/IStZFSZLb4EuGsDFgOGF5VM/Cq1LPHp
	oQA3gG/ijI/0DuBhy+JNUWMptqDiWFqpE/7p3bTHuowHk5JxoUm0WFYORik+EwoY
	egVrwuZccTHsJVWgsfGRRkDCmRnjWPv6HPskZ6911h2kilEW0+XyzoXysTiZtVeL
	Tjefjv3uGTA/SEyvPCNQwp1IEaCrY9x1iE5XhiZPsKSAXgzJvHlg/GvBpxz+R19B
	gUvpVEYFF/rl54r6afQLD3aZrR7ajn2XMPx7xj3A7/6aps+1YMxu1jX6h+T/k9gA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yvbk0tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:20:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIBXgHm014344;
	Thu, 18 Dec 2025 14:20:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpk8fvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 14:20:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BIEK8wX8324026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 14:20:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B5F58052;
	Thu, 18 Dec 2025 14:20:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55F4B58045;
	Thu, 18 Dec 2025 14:20:05 +0000 (GMT)
Received: from [9.111.59.18] (unknown [9.111.59.18])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Dec 2025 14:20:04 +0000 (GMT)
Message-ID: <f2cf6374-9cc1-426c-89fe-2a99c129ae31@linux.ibm.com>
Date: Thu, 18 Dec 2025 19:50:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/13] blk-wbt: fix possible deadlock to nest
 pcpu_alloc_mutex under q_usage_counter
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251214101409.1723751-1-yukuai@fnnas.com>
 <20251214101409.1723751-3-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251214101409.1723751-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/JwEOni c=1 sm=1 tr=0 ts=69440d99 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=NL1F5aIbUArUtQSLZB8A:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-GUID: 8sC0XLhsqr_Z2YRGVR4ZBop1fgGu2MW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX1dvt1rYvFJ7g
 GA1gYhGMoZ4+p17oRONlQpaKzaIM+RPRH0b5uX5Nz+Q5vFy93odSelUuPfhT3C4Yr1hJa+UajDq
 yP1k0a5YJ+x38J+PRGdRmsRPe5wqtjTrf8/yb+Oh+zTAdmXbvG59sfBY5bArf2Tr73D4tPTUHGq
 DLWC1kDDvHtz6usjRipephsnHPnj9lHjnjKB/6QaY2EUoa7bdGemHvrDI8bhQQFpYDjkEnIDjG+
 /nIj0d5k9Rn2ySH8tgKEVFwuH41ii3WglylBEKM1/zrI5vR1LGSVdmmXZTivqSjlZP7JzV9rwjG
 uE9jNx1EFDpyIK8KYrPBmWyn3+h7srqPXYK7MUcC/bWUKoZZi8wxPZVNiiBacIZezUXJyx3iS60
 gf9zmJ67+R3t9zWLdwyNmbWZe1z46Q==
X-Proofpoint-ORIG-GUID: 8sC0XLhsqr_Z2YRGVR4ZBop1fgGu2MW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023



On 12/14/25 3:43 PM, Yu Kuai wrote:
> If wbt is disabled by default and user configures wbt by sysfs, queue
> will be frozen first and then pcpu_alloc_mutex will be held in
> blk_stat_alloc_callback().
> 
> Fix this problem by allocating memory first before queue frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
