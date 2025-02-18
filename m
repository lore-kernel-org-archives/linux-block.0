Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67490265CDB
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884281; cv=none; b=kbC/EkoWchQe7ADwP/PSBPWofWvOds/ok9wi8XXe9ixRj7v+i1I1ghsaYeaFWs0y64Dxo0WtesiJa0ASshFkSzMUOK5uwYxcFAU+sBhYLOLPqUhLzHWDhkmUC73F5FPzk/VEUy3mx5N3cR0fVlal/HSKNmCIvADchGEYNMb0AkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884281; c=relaxed/simple;
	bh=xfteWKljloI+CxF+huQRoxtFjhql0mqjLBfFJK2FDPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkmiLfrelA/mv93LQdayL/bahSTf0D1Jwu3ecwJsUwANbApWFwDZMIRHQ7/rU4XcoEKAzKLvdTMf1KjqmQ6BEbKjapa5EI+yO21x2WB2yOeeqdh0GIViqAlhGn355rBKagaBIqGJa1QAqf0eQQc0stblDcNBUYUZU/FvnwXccMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g0h1TK45; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g0h1TK45"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5EiJL018972;
	Tue, 18 Feb 2025 13:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U7Hg0t
	waKGzjDrmyTlEQD5At+xaS5j6ixkEc1HA0XQI=; b=g0h1TK45Ok+x6oUgIQnGjr
	zk/yw9M+HSgG9yLzB/M/UDCXhGrqvESFbPoZZcm1UA+2uHTDuxgcMpb64wWQmTMS
	Z+v2Ted0GSO8S9KSPLtAbiFeO6cpXs1aNtnlL2cLVv/aUawMg1L+1gcznNnQt7KU
	gSDM3pINgkEajerEL0z8q6kuFAzN9kCGTK5Tgo90TP4EwE1TcmpELXo0oJ4bRQ+f
	ECOGEcu+GKJhH3kuBLwHvYUIh1KAWF1JhmhioFXZo71ZCLyL2/Q16L5inIZOdvjy
	+5mK3pX4Qd/z/zyc6gRXWt9LFQ+cjKn17aXGLOCpUu7mL9XCsFrHOArqzNj9E33A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44v7xucw9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 13:11:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IAua1A029576;
	Tue, 18 Feb 2025 13:11:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44v9mmm1yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 13:11:11 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IDBAWs30671220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:11:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D573658063;
	Tue, 18 Feb 2025 13:11:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C090D5804B;
	Tue, 18 Feb 2025 13:11:08 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 13:11:08 +0000 (GMT)
Message-ID: <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
Date: Tue, 18 Feb 2025 18:41:06 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <Z7R4sBoVnCMIFYsu@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z7R4sBoVnCMIFYsu@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2jf5A7rnOrP3GaWEBjba_O3pg61Rwa0Q
X-Proofpoint-GUID: 2jf5A7rnOrP3GaWEBjba_O3pg61Rwa0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_05,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=780 mlxscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180100



On 2/18/25 5:40 PM, Ming Lei wrote:
> On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
>> There're few sysfs attributes in block layer which don't really need
>> acquiring q->sysfs_lock while accessing it. The reason being, writing
>> a value to such attributes are either atomic or could be easily
>> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
>> are inherently protected with sysfs/kernfs internal locking.
>>
>> So this change help segregate all existing sysfs attributes for which 
>> we could avoid acquiring q->sysfs_lock. We group all such attributes,
>> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
>> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
>> method (show_nolock/store_nolock) is assigned to attributes using these 
>> new macros. The show_nolock/store_nolock run without holding q->sysfs_
>> lock.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
> 
> ...
> 
>>  
>> +#define QUEUE_RO_ENTRY_NOLOCK(_prefix, _name)			\
>> +static struct queue_sysfs_entry _prefix##_entry = {		\
>> +	.attr		= {.name = _name, .mode = 0644 },	\
>> +	.show_nolock	= _prefix##_show,			\
>> +}
>> +
>> +#define QUEUE_RW_ENTRY_NOLOCK(_prefix, _name)			\
>> +static struct queue_sysfs_entry _prefix##_entry = {		\
>> +	.attr		= {.name = _name, .mode = 0644 },	\
>> +	.show_nolock	= _prefix##_show,			\
>> +	.store_nolock	= _prefix##_store,			\
>> +}
>> +
>>  #define QUEUE_RW_ENTRY(_prefix, _name)			\
>>  static struct queue_sysfs_entry _prefix##_entry = {	\
>>  	.attr	= { .name = _name, .mode = 0644 },	\
>> @@ -446,7 +470,7 @@ QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
>>  QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
>>  QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
>>  QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
>> -QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
>> +QUEUE_RO_ENTRY_NOLOCK(queue_discard_zeroes_data, "discard_zeroes_data");
> 
> I think all QUEUE_RO_ENTRY needn't sysfs_lock, why do you just convert
> part of them?
> 
I think we have few read-only attributes which still need protection
using q->limits_lock. So if you refer 2nd patch in the series then you'd
find it. In this patch we group only attributes which don't require any
locking and grouped them under show_nolock/store_nolock.

Thanks,
--Nilay


