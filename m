Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95512FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544831; cv=none; b=BPRJn+uh769abq3GaMPz2vrzXH+Bl+sW84lWcov+1oeBAIsefskSo4+aqk6V7kDrNAWkRVzpLt1QSmiNnYWICTbAFBLZnk07tcOWDez0PLyHN/S2DHpjsMsibXpDIEIQXNbPwF+voAr9/0LRcpR8iHVyqQ9o5+3004puuxSCBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544831; c=relaxed/simple;
	bh=mpeiNJiWc/Y9Rg36NcH/SQfjVkHD4YfToYt9kmMOZQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mn2dffQR19EOvKMVEk1dDuADnAVkku0jHGAnMiGRAypshR+xqdthrPUwV+NdU1WnFbhUNJFmauu7WmAcQ2CV3F+8jE5dpuwC0Lo/jU0gy/BG6xO4DtntgeH286M9DMPGIRY29LJW9gjV3W8EmqoGAWiv7dg+n5AWoKOunmNfpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U8PXg4m2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U8PXg4m2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604FFWeU015803;
	Sun, 4 Jan 2026 16:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vreU6L
	kaSMy5DWc62HX+BNHO72abVuZAm0A6H7AnwpA=; b=U8PXg4m2xSAKhsaqQaPqSe
	dBOM6bu3P5xO7wd+RVUxKqz0b1FxKndx3tKWXf335MKPAwuOZGStsZGlRmHu0sSH
	cZSYybcdt8HkclStkgSgCDpbZTs7wbwlfBm4LT7B5D9pgGTCXQedYfIyWmHulKNA
	/qUzMLoEf3/+1iWArdJ+AHopL+/WCyX8SSp8QMfW9mgiLVugRkwNSiwIJJ5bSCZH
	h2L4oJHOa10CYBJfrjF7q3yq3AYDI5dX0PZun2peSKOIdihVDXmYXiDY5OfJZaWS
	yrSH3bgmfLM9O2Wc+vtZyFhIHejJGAratr8786T0mwtSoelIGkPt+JScO4DH3ZUA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5v41c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:40:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604Fha1E012604;
	Sun, 4 Jan 2026 16:40:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnj1vf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:40:17 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GeHP211272712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:40:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F129358059;
	Sun,  4 Jan 2026 16:40:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8104758043;
	Sun,  4 Jan 2026 16:40:14 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:40:14 +0000 (GMT)
Message-ID: <e8ebca32-c029-4684-8244-ae96e60513ee@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:10:12 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/16] blk-iolatency: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-14-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-14-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695a97f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=jLYGpROefC-xJR0wIO8A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: DCNnzJFC5ID9GlIEs193NLs_F5nkc1Hb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX7UmH4gKu+QDg
 WZR/1rbBCeukFbH4W3HGXsK/0MjlrMC8BA+NEaadrftcbSbH9aZQL2/jrtEy1EWTGgxCSFCtJb7
 sUSCpbdUDppDiijP3d5+29+48dZU40jyOZCpiuasyNCU9UucslSJq0CTE9UnUbs5Golhd8rQCzO
 BXaWBEyIHQDv8+FQWIFwFCFM7q9foobmg19OBWMvcGClgYGtfhwCIVm8Nae+iDwIel6XHNebIc+
 ZYQ1M7p3nF7WVYapQjKzm01Mh77YEyRglMWzUxMs5ZkT1dyxr3eEI/hvOHs9hodpquM3ACZWDQQ
 H56dHEiDH2aSyOFzbwI2eHZzlQp2+SmBsNgLahHM49zpxJ7gnFcvLWOaFZpv6ae50x2hnXiIH+y
 oo9B+Bbgdq/eKfjNyODhHGhRDAQH+ihyTSaWiHvvxOKFQ9MRe+ZnzbIKWSTTCOuIXhBTo2PBX8D
 oX64Hk06Z+c/XB0/M7w==
X-Proofpoint-GUID: DCNnzJFC5ID9GlIEs193NLs_F5nkc1Hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> Currently blk-iolatency will hold rq_qos_mutex first and then call
> rq_qos_add() to freeze queue.
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from iolatency_set_limit(), and convert to use rq_qos_add_frozen().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
