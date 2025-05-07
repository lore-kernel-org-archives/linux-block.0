Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F621CF5C6
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644733; cv=none; b=nrRDOa+7riXz7siAhVId5ed0oD5i5kCFvKvtRzFdntDMD/eB57O0Qv0u7z5Gx+uqTKM+KMswEzguKCP7DoQjkLyFUl6hguKRpiHNYqhV/Mbtr2E3MrzkYcVwyvbhApNATHYFQE3aahSD8yQT2aPls9SG7E37UesjKh7meCHNUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644733; c=relaxed/simple;
	bh=uiT7uZyr9bz/A3EIL6xgOFNNxRm3qmrLLsmp9sUS6eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GipUNhNZwr5elByEXZpFzswwDuVgLpgaPLoz40d5syMNEhC5SVtWk+4V1bZjKjrqK5tOMpuUBetOCXX5miTLfaKHO1KK3J101KLzKYEUb3xHly6Oen16q5A996L2DykdH7io8o1UjUGIXG+oaJI6VTevwqzaLJBK/8dbbb8z5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWredmwY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XWredmwY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547HvKiC018638;
	Wed, 7 May 2025 19:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gr3LDk
	hx4Sgaw6v4FgOV9udhpNCDuXHyH3Oc1UPiKhU=; b=XWredmwYyVa2rPjOQVnEyj
	JPOKdnjf6Zo55LZOAv2BQzHQ8x8+PS0cIDukK61L4Z8YSLYbIf4oLREif53XKz7L
	556d6jAm9LGCpQ7b5XEIY+ujU2cKsp6De4RB6Y4VcqzWBap+RI5W8NoNePsgjUjA
	BVApSYWcv8nGwa9ECWMH3idSIm3I/BtjYiDE7c9Ub+8IEeC3mfhhn2E2Ny+DH0Ab
	9Ep3GtmmM3ksQHsYyWLZcZhRRR1QItUiAyA/ri1w4qMmZweNCXkFO1TULtpSveB6
	R5l4FYimxD1GHS0ktlbaI5uGe1AX9PyD3HhFsT8jGBjtJhKJbW9BrPRtAPnd4AFw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ftjw5c94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:05:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547G4Dqw025807;
	Wed, 7 May 2025 19:05:25 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv0296j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:05:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547J5O9S52363594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 19:05:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B58AB58055;
	Wed,  7 May 2025 19:05:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147FA58043;
	Wed,  7 May 2025 19:05:23 +0000 (GMT)
Received: from [9.67.78.42] (unknown [9.67.78.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 19:05:22 +0000 (GMT)
Message-ID: <70c4554e-f578-44d6-b96c-bface94604f1@linux.ibm.com>
Date: Thu, 8 May 2025 00:35:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-2-ming.lei@redhat.com> <20250507135349.GA1019@lst.de>
 <aBtuCDKTQK1PReDg@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aBtuCDKTQK1PReDg@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7DhJbd5Fu_EZLF6pfuOnhE88I4ZdyRdw
X-Proofpoint-ORIG-GUID: 7DhJbd5Fu_EZLF6pfuOnhE88I4ZdyRdw
X-Authority-Analysis: v=2.4 cv=R4ADGcRX c=1 sm=1 tr=0 ts=681baef6 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=djJIMtrUE8JDwr1xukwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX015M14G/iTIX IUVsSwfwEJjTvWIddtfbNyQZyEdOjK+phFun0m/7pneIYZ546g8K7MAcROOjIslZYi07KuN8q1A 9+GYZaPDV7CzrrMRGZM0lFgHRmqaVogjee2q29iOsXe9ODOLQ00XOqp1y7EXft7lS3F8vGAgc+G
 ysYJV9xaCGZvvfinmJxQWoZwYD8Tr/isLcQ99QTFPUbbFam2pUmUodOeXfGPqNcLQTzESQ8kEGC ewgo4xkLGwB4o9FjtQSPgZc4sTsyAUrHya1oXzQ9y72fUtZt6SFLyBIvrLZa+SfUzlL1TDk/0V9 tGnXznA6f7tvUzDJOutEnx+IqEuXAIFt7dVfESaGKNVVl+PRKfzTYqjwrgs9Mis+ai69CnNZV96
 2OOlOTeauPeeiH73qONIT5fkgxE+7vvBmF398cu2t0vlF7MUIyXPnBeuGaT1ASvkE+l02PRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070170



On 5/7/25 7:58 PM, Ming Lei wrote:
> On Wed, May 07, 2025 at 03:53:49PM +0200, Christoph Hellwig wrote:
>> On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
>>> blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
>>> never return if there is any queued requests.
>>>
>>> Fix it by moving queue quiesce int elevator_change() by adding one flag to
>>> 'struct elv_change_ctx' for controlling this behavior.
>>
>> Why do we even need to quiesce the queue here, and not anywhere else?
> 
> Quiesce is for draining the in-progress critical area, which can't be
> covered by queue freeze. Typically, all requests are freed, the run queue
> activity isn't finished yet, so schedule data can be touched by the un-finished
> code path.
> 
> We did fix this kind of bugs by queue quiesce several times.
> 
Technically after freezing the queue, we don't have any in-flight request when 
blk_mq_freeze_queue returns. Yes we may still have some dispatch operations
running and so we want to wait for it to finish. In that case, we may just call
synchronize_rcu/synchronize_srcu (instead of blk_mq_quiesce_queue) to ensure that
all in-progress dispatch operations are finished. That way we can also avoid
calling blk_mq_unquiesce_queue later when we finish switching elevator. 

Thanks,
--Nilay
