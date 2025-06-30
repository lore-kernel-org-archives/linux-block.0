Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EDC1F8691;
	Mon, 30 Jun 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280087; cv=none; b=hvoubW01ZucnTMeeIv4HrY/N+r9+gZmi+pE9auvAe5irSA9g0v18+RSC7WwvkoeG2oYU5p8THogxTN+I+/HT0mQKpeBvyOJPSvENLVLijaM7EBOMyhA0Ota+ibwmg0b0P+J2AsMMgTYitKvBjhEuIR4QUvPYSHNu+3KmWYB/m0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280087; c=relaxed/simple;
	bh=Aaihtn+lbGVZl/8yJbeLECyjWVpfc4LymOW18ipEcIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+6N/OQ1pLqaY/O3vQE3lMMh+VWx2/D5kR21wJZ3NCxtuaIzmwTxX5HExJQOyd1q2qt1xtbE7dPOMOe6G8vi75oQbOrvICo1ZEdmelLmJlbryMmPT2X7mfPa55addmf8DNuifEOQkzNg2/edwPeZ+8VGW0vmVnALLbL4jtvcpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AJfoRn8O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AJfoRn8O"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4muw7025176;
	Mon, 30 Jun 2025 10:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P8X+64
	+7LUiKdRgKSuWacnq6CITlx8G1mp1YsoR5fZ0=; b=AJfoRn8O1SdGFxwJZfu7ga
	TWTM3VpkSkkVLoIdLYSQYwIZqauHiW10RlBiuFNCGyqnUTIsQS0w+CHmvK0HWtD1
	gCAGoXeXr2SXwPddh9g/Q53zqRqhFrmuaaZtCp8f/XOHb1e/W7TurKQeOS6QmjBK
	XdUBPfyLLq7LKmaAekRBWPNp5XrFWQHuPVCPh1j7j84xFgh/bQV5x9kT9OoUOIpP
	BtcxYSWiX/kB1PH08flX6YSPKrWwN0vbnH0XC9bnvK7xHOBTM2zatDWFuoTbxDR6
	D/xX/BIQB7bJo9gcdr0ULQ/lLQkLcwMwt+sjdGtV+iqmgWI3ExRgjbyEbzdXebzQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1gu5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:41:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U9gGbs021934;
	Mon, 30 Jun 2025 10:41:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpdea7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:41:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UAf6IH19530454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 10:41:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1352158056;
	Mon, 30 Jun 2025 10:41:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86F558052;
	Mon, 30 Jun 2025 10:41:03 +0000 (GMT)
Received: from [9.43.10.179] (unknown [9.43.10.179])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 10:41:03 +0000 (GMT)
Message-ID: <6a9bf05f-f315-417a-b328-6a243de3568e@linux.ibm.com>
Date: Mon, 30 Jun 2025 16:11:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
 <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
 <7e4ff7e0-b2e0-4e2d-92a4-65b3d695c5e1@linux.ibm.com>
 <344a0eef-6942-455a-9fb2-f80fd72d4668@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <344a0eef-6942-455a-9fb2-f80fd72d4668@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UctT0kDWsL7sF0AsxcvPKI3p62yvSlJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4NSBTYWx0ZWRfX/er402KbNDZd pbDWmyW9JMu5rpqA55qZvmSXaMtYfbJH+xjpT6c5E+ciCA3rCCDJD/r9UteSSlkKrqV5lF15AdW f5qJvIy14Ori01DJJABY0aaSq2LKcZXhn7BtdFeJm9NB8m/L1js5iI5zr40PUaylfH/bsiaLXKA
 XBh2FvuxDPAhCRWfnwnflV2maaIjdbUYgqxWx+U8pPCEpvsqEiEGlpRMPmWuaOBlxGDzan4CLkS sc4/BXxbU/NRi4/kx13wKPgD1iRXNK/Lw5XLLjYR39+Lrgg0xvNXB7kPnZuS6gv6AiUiW0iWzem kfh+4bz5ZhlLpsgbswpi8ZvuzyV6UgD9RhUINlhpV6T1Dk7EKt16Cjgqsjrj7uNSPXHeC6NnitJ
 LSgueWtrg61AhtTGLYK7DJTcDRQJQHAMW7CDux6Iz9lES0DZtnUuE4Bk0memh8fQVvgVmzJH
X-Proofpoint-GUID: UctT0kDWsL7sF0AsxcvPKI3p62yvSlJ6
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=686269c3 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ukeuSQTfHjOFx7Hybm4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300085



On 6/27/25 8:40 PM, Bart Van Assche wrote:
> On 6/26/25 11:16 PM, Nilay Shroff wrote:
>> Thanks! this makes sense now. But then we do have few other limits
>> (e.g. iostats_passthrough, iostats, write_cache etc.) which are accessed
>> during IO hotpath. So if we were to update those limits then we acquire
>> ->limits_lock and also freezes the queue. So I wonder how could those be
>> addressed?
> 
> Is there any Linux distro that sets these sysfs attributes from a udev
> rule? If not, I don't think that we have to worry about these sysfs
> attributes.
> 

I think that's not only about distro udev rules setting queue limits.
It's quite possible that some user applications may programmatically update
these queue limits during runtime. In such cases, the application would need
to freeze the queue before making changes. So even if no current distro sets
these attributes via udev, that could change in the future, and we don't have
control over that.

Looking at your earlier dmsetup command:
# dmsetup table mpatha
0 65536 multipath 1 queue_if_no_path 1 alua 1 1 service-time 0 1 2 8:32 1 1 

In the above rule, the option queue_if_no_path seems bit odd (unless used 
with timeout). Can't we add module param queue_if_no_path_timeout_secs=<N>
while loading dm-multipath and thus avoid hanging the queue I/O indefinitely 
when all paths of a multipath device is lost? IMO, queue_if_no_path without
timeout may make sense when we know that the paths will eventually recover 
and that applications should simply wait.

Thanks,
--Nilay
