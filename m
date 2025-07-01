Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E726A47
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347252; cv=none; b=M4W0D189OqEfht9jTejj6POUlZmdPafhVYGQC5kiXGNV2XAXVn6xFOxBdDgxx2bPYIUZI5wd8Ea2ESg5EAP5fg9Y646ZxmkotOODRCJRaXHqR3FRrrT3OAjb76DaqyBNyLQAfQ4tEypl+M2+3vcyRifCZ5dwfJiWfsCnSFZ6sF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347252; c=relaxed/simple;
	bh=RCqCGSpti0cW3sguUKzWnM5VbafNVBq7pNQ8481zl6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucg9qQHiXuxxHMow9xofiT/zMr9bLKC10K202jrlO4CA7S567K8avVNvH3245MqEzcj7Vpb1jyF/VLGfL5wFjskneyecgNeG+8FUWYbdzvrZjjZ5PA+pV0HXgy/u9RwPFODvl0u5qAiLfp4a+pCkQn2m5LBRikXaaT2XirOgWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QzZJ6nPm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QzZJ6nPm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UKcRHN023854;
	Tue, 1 Jul 2025 05:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2CbltS
	csmR1vHSSnlOiv2uAvrOFzf6o6ASJUoXxF/3k=; b=QzZJ6nPmO50wOtgRhFnq8d
	pSCDQdZe5KFQuEhBFGXK6+akvyblMCFQUGbfraHQcCYTehWtLO+ZHjLGJg9er9aO
	lfMX3N5UnrDVIuifnqGiFta61Ptv2Qu7T+dJBeP46veUKAAoMgOhF6PLn6QXdKrZ
	GtKllgqB0l+wxCAHAozANMCjXs+ut4/mYYw9mRHcIepepGadaEPrIIMZ3NHUf8Ou
	W1/UzbnKr3NYgBX80HXgPhyQMD1csdvaH4IdxG6KFPUdHb8d4IQib2VJCNSk/qMT
	eIQydDj7JfVeqv+Y8Iw0gjNCaCNsJtIUSR5BW1zYPfurFZWwWmiLTczdTk9yZRrA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1nbp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:20:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56136dWI021946;
	Tue, 1 Jul 2025 05:20:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqph5nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:20:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5615KaAu7275142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 05:20:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DDE258050;
	Tue,  1 Jul 2025 05:20:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9BFF58052;
	Tue,  1 Jul 2025 05:20:39 +0000 (GMT)
Received: from [9.109.198.197] (unknown [9.109.198.197])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 05:20:39 +0000 (GMT)
Message-ID: <05207abc-7787-4fe4-913f-c04775a7862d@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:50:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 3/3] block: fix potential deadlock while running
 nr_hw_queue update
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        sth@linux.ibm.com, lkp@intel.com, gjoyce@ibm.com
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-4-nilay@linux.ibm.com> <aGNU3PPJ1wU--x-O@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aGNU3PPJ1wU--x-O@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c08fxcEwUVn_1EPdWm6Vld4a5o4YaRAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyNSBTYWx0ZWRfX9mVZk9lKmqFH jlw7p+1xW87x2DMZ6GPQmHO4JD6/QDGIjUfQ94M79mgkRHsJX+5+ofaqf3MA/AF3J+MfMaSbLlK opvzSxONNk2BiOTocnLI92Vt5gOfpQvYloA615kk0ZGRgwlBJ3tTE7wlC5Yr4ZV0MY7DLiG9BUO
 X8Fgb53l4fc336KwInRK9kUBMMpKbqyF6sTB0bStNB6+/U4I6SyETipMXkkfH2DZnpZyyspf68/ vENAJpcDvtc0Tz/9e2lUnWg4KRmIYZtTKjRxraK6knK5xxYcj7vt4ogmBT7rt+Gx+ohwNDWCoIS HfR2i44gqdNeAZp+/wjCxNn6BgTTcnpsBphCuqJbpj197Ymh8426BIRrclGXxRwEbbKg+8sMaYZ
 vGARpsobdn2CGCZlQz4zuE8893UCDU/oH67dXn9+cQCY/oXmcD2oG7l5OaXORWJyBI30cayn
X-Proofpoint-GUID: c08fxcEwUVn_1EPdWm6Vld4a5o4YaRAj
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6863702b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=y0u-dav7CRZbYzo4eMEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010025



On 7/1/25 8:54 AM, Ming Lei wrote:

>> diff --git a/block/elevator.c b/block/elevator.c
>> index 50f4b78efe66..8ba8b869d5a4 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -705,7 +705,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>>   * The I/O scheduler depends on the number of hardware queues, this forces a
>>   * reattachment when nr_hw_queues changes.
>>   */
>> -void elv_update_nr_hw_queues(struct request_queue *q)
>> +void elv_update_nr_hw_queues(struct request_queue *q, struct xarray *et_table)
> 
> et_table isn't necessary to expose to elv_update_nr_hw_queues(), and it is
> less readable than passing 'struct elevator_tags *' directly, but it can be
> one followup improvement.
> 
Yeah, makes sense... I will update this in the subsequent patchset.

Thanks,
--Nilay

