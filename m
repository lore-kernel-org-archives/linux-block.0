Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE91CD213
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955425; cv=none; b=cj4GbcV8xkQ4FpeTdRG8BiEoRbitbBT2OEk5ecsXi2Ozgl2v3IgujS+24g5MJjkp3lOeS2/rfP+g6ugaKI3Y8YNRq/NmgOOu+vKDl5uVkSyyA/Q6MGx/6e7tFkketD6WCCpGUCCE4AAVyHX16UQIHXyFEYflSylb2FULJg4jZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955425; c=relaxed/simple;
	bh=AzEw+269bv0PnC3nl8E55FrFHurRHiuH4dbi2mwUZZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FZbNqGxTpIv1S+On7CM3VySzJgWAFK3QApfaHph0JPIEGOEOocPuJl3PBkFYFXWxx6V7eqj28Dj1py5Prw5XCwz4Qy5c6hDhgCG9CqgjjqnLIsT81AAenVaUSfHJ4aerEropkP3JBbwSopg6U34LvqxtnkaiLw0X10U7FNrfRks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YzRmk+c2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YzRmk+c2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75CQ7011647;
	Wed, 19 Feb 2025 08:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QD8O13
	TZr/vjfYIRUXduuODYq9gKUe5VIHDrmPLqdhI=; b=YzRmk+c2rpM79wOAGzU4pp
	R/DvEMeoi0WoT5iYJVnPmfJhk36tPoyOo2xt8oKzNZDSV/899+ZoNfxAeMZAxiAd
	lw6wwXi5w1IMBMCt/pRxdtA8TerwyPqwkBSQDQ4XyoYy3VwbFhV3JTfykdc056YM
	xwxCMujSEIKCsxadgQl4xVgtXHI2/QKX7UxFclhM8HT0eub+Aq63O0La82UI1efK
	lDHSQamlq+SsRqvcC2xMGqYawzik6ndkAvDolT+d48UWkm4IdJ2/D7l+gRB30yCA
	t3KHFqITJX3+sAmR0i429JS533iY3/JioJ0NTB948zyeKt2ShYI/5FWE3M7TEPlA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w5c99pge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:56:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J704PE005826;
	Wed, 19 Feb 2025 08:56:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xb4aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:56:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J8urso30737098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 08:56:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644ED5805D;
	Wed, 19 Feb 2025 08:56:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5776858052;
	Wed, 19 Feb 2025 08:56:51 +0000 (GMT)
Received: from [9.61.184.147] (unknown [9.61.184.147])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 08:56:51 +0000 (GMT)
Message-ID: <d00f7633-c54c-4abf-b36d-eb941a6dcc5c@linux.ibm.com>
Date: Wed, 19 Feb 2025 14:26:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
From: Nilay Shroff <nilay@linux.ibm.com>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <Z7R4sBoVnCMIFYsu@fedora>
 <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
 <Z7SO3lPfTWdqneqA@fedora> <20250218162953.GA16439@lst.de>
 <Z7VO-z1cZfFLYaMt@fedora>
 <c83dff74-e1d8-4f17-979d-9f5e9ca16adf@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <c83dff74-e1d8-4f17-979d-9f5e9ca16adf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TLDE3ZccjbY7StZ5HnfQyfRm-4vsVYRQ
X-Proofpoint-GUID: TLDE3ZccjbY7StZ5HnfQyfRm-4vsVYRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=879 adultscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190066



On 2/19/25 2:04 PM, Nilay Shroff wrote:
> 
> 
> On 2/19/25 8:54 AM, Ming Lei wrote:
>> On Tue, Feb 18, 2025 at 05:29:53PM +0100, Christoph Hellwig wrote:
>>> On Tue, Feb 18, 2025 at 09:45:02PM +0800, Ming Lei wrote:
>>>> IMO, this RO attributes needn't protection from q->limits_lock:
>>>>
>>>> - no lifetime issue
>>>>
>>>> - in-tree code needn't limits_lock.
>>>>
>>>> - all are scalar variable, so the attribute itself is updated atomically
>>>
>>> Except in the memory model they aren't without READ_ONCE/WRITE_ONCE.
>>
>> RW_ONCE is supposed for avoiding compiler optimization, and scalar
>> variable atomic update should be decided by hardware.
>>
>>>
>>> Given that the limits_lock is not a hot lock taking the lock is a very
>>> easy way to mark our intent.  And if we get things like thread thread
>>> sanitizer patches merged that will become essential.  Even KCSAN
>>> might object already without it.
>>
>> My main concern is that there are too many ->store()/->load() variants
>> now, but not deal if you think this way is fine, :-)
>>
> We will only have ->store_limit()/->show_limit() and ->store()/->load() in
> the next patchset as I am going to cleanup load_module() as well as get away with show_nolock() and store_nolock() methods as discussed with Christoph in 
> another thread.
> 

Sorry a typo, I meant we will only have ->store_limit()/->show_limit()
and ->store()/show() methods. Also, we'll cleanup load_module() as well
as get away with show_nolock() and store_nolock() methods in the next 
patchset as discussed with Christoph in another thread.

Thanks,
--Nilay
