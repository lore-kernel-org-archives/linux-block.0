Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51D1C7019
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954082; cv=none; b=S3juGEckGGRNyPUT3/kGoQEpNyW8jwHi7b/zbqKceLGnvpAri4UgRzXpNcgOVDtNTg7eqREqyJwZdBlCDb4vFuP5VJxjr6Bed1gz6nHwhZg4dqmCYowYSKBrHkb1UCcR3PVkUxDHUz0dUa6sEkEepRMlvdUs8dxbcwqnFKSXwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954082; c=relaxed/simple;
	bh=J6sXxYkGOa0LMh5YfBJoGFAiS+/DkinL1LkeymLxRu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSqo1cyaGsc2uPVs0Ku2DtfqiOlOUrnfj5Cucj2nVPLSJvuXAfO3l2/7Z7t8kkxzmav24bMbUQbtjj+2/VNXRcYZrQiihesy9Rp1NOnOpWhovAj1DXr53jhTh1/EsAKRdVDpIkGh1D+svgdN/7RykhJ/cpTJHjIxI1Wps8Ns2S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rZTXunsh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rZTXunsh"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75CDH022086;
	Wed, 19 Feb 2025 08:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rKl3RV
	+kNLk69OmrQHolCiXkOVD/B7ZtKiww/+9pTcs=; b=rZTXunshgjWd06+uF0j6V3
	T2g9PNr2x/tRylBl0Z7LT4YwYYA1LCAdmDcO3QZvFQr7IuY5chYhOTsd90Qw4zPh
	HbApr26mNCKW66OVJRIVgufzdECvOOKp8h6UX0U6WPCR2SQYPoNjW61+9CdDpHRP
	zcM7Ui/YV/5DW59OFal+mSjqeDrpxpF9NY4RipGE12jzzi4P3l4EnGWyBGfRN1OG
	RZYoHzGKBowJWqZBJbOpx0IMa3t+DBvnpuYy8Ivw/bBLJvimlv/b3cfHzaLr2d5h
	Mdc0Am1243JkbUp6wxYL1t6hDgbO3S1TIvw81D5k4Tw93HV7NMrPmOjQAr2Tg0zw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wahjre0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:34:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J6o5Ns030147;
	Wed, 19 Feb 2025 08:34:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x32p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:34:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J8YPGG28836498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 08:34:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C72845805D;
	Wed, 19 Feb 2025 08:34:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9AB358067;
	Wed, 19 Feb 2025 08:34:23 +0000 (GMT)
Received: from [9.61.184.147] (unknown [9.61.184.147])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 08:34:23 +0000 (GMT)
Message-ID: <c83dff74-e1d8-4f17-979d-9f5e9ca16adf@linux.ibm.com>
Date: Wed, 19 Feb 2025 14:04:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com> <Z7R4sBoVnCMIFYsu@fedora>
 <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
 <Z7SO3lPfTWdqneqA@fedora> <20250218162953.GA16439@lst.de>
 <Z7VO-z1cZfFLYaMt@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z7VO-z1cZfFLYaMt@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w-hiVRRI2ApSR4WJ1ala02i5yZ7QfCIC
X-Proofpoint-ORIG-GUID: w-hiVRRI2ApSR4WJ1ala02i5yZ7QfCIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=849
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190066



On 2/19/25 8:54 AM, Ming Lei wrote:
> On Tue, Feb 18, 2025 at 05:29:53PM +0100, Christoph Hellwig wrote:
>> On Tue, Feb 18, 2025 at 09:45:02PM +0800, Ming Lei wrote:
>>> IMO, this RO attributes needn't protection from q->limits_lock:
>>>
>>> - no lifetime issue
>>>
>>> - in-tree code needn't limits_lock.
>>>
>>> - all are scalar variable, so the attribute itself is updated atomically
>>
>> Except in the memory model they aren't without READ_ONCE/WRITE_ONCE.
> 
> RW_ONCE is supposed for avoiding compiler optimization, and scalar
> variable atomic update should be decided by hardware.
> 
>>
>> Given that the limits_lock is not a hot lock taking the lock is a very
>> easy way to mark our intent.  And if we get things like thread thread
>> sanitizer patches merged that will become essential.  Even KCSAN
>> might object already without it.
> 
> My main concern is that there are too many ->store()/->load() variants
> now, but not deal if you think this way is fine, :-)
> 
We will only have ->store_limit()/->show_limit() and ->store()/->load() in
the next patchset as I am going to cleanup load_module() as well as get away with show_nolock() and store_nolock() methods as discussed with Christoph in 
another thread.

Thanks,
--Nilay

