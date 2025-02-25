Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D71917D0
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490118; cv=none; b=P8dq9tY3jibzZPp602T9GhM7oUvlU9OogaQXfWkQ7M9R8PPN1/ekFvmrqTJOTn2/IQqsROuQx4kiidcgNP8WiEuotJcq1IG0XtxxEek3oblH5vkbne3uZ/61HG8Itr8sYvBffpwA7ktrMjRQf/fr7V1CocYx7aB8t0l4jMG3Z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490118; c=relaxed/simple;
	bh=o8qgVeFBxwU4DsPWC6jsR1++kBlYMG7H4Ai0OYV7aNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNmoBPbVDwAQ7gwEHf4gvXm0A36Yi1e66auFgzx2nT4i59cpd2eUdUm3pJkAGkd4pyUt2/IKEhwCPRDEmjV7ef40S4gn1o5Ytp5YhaZFMsnwxdG95EqnNpeWwFBo48N5BUInNLCyS9oa5rG/IPEvvPw0qsYyIMWKe/QIvMptQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJCsJu0M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJCsJu0M"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PBSLJC013099;
	Tue, 25 Feb 2025 13:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CCeIG1
	6zALeikKjiyFX/OOBzbnVC5wwtfhU3wpwBqus=; b=kJCsJu0MdttvlrGNifv0vk
	ZZlZy0zBQiUhruabKYn6WLTmZxM8GhBNgtQCPyQAAGh0/dYFvOGp4x7299tSKEJZ
	zgY6YXikr0aM9EMs+MxT8NbW6tatZCd0MBKyVB0CvMQsD4E4TCbH9bYyEuDRuoTv
	RywyTwigvCUFOAyZC0kVw6pSQGFPUOJyS/hub3fNag+11D/5UFGmUQZFj6ufIOXG
	G/8JbOVyYbLEaOreSNXzFcj3NIxwsicvAZeGd3HxEnZqQG1JPkAaUBDAHd6YMV3i
	TeT8PkcL9uQ7VyGbQi520e1jI3uu+TVWQ0yVOlSDyZbE0x/ahj8KB8JFboJM/8yg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4511wabg42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:28:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAPNB2026354;
	Tue, 25 Feb 2025 13:28:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnd2j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:28:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDSNq633030734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:28:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F2945805B;
	Tue, 25 Feb 2025 13:28:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 915C558055;
	Tue, 25 Feb 2025 13:28:20 +0000 (GMT)
Received: from [9.61.156.112] (unknown [9.61.156.112])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:28:20 +0000 (GMT)
Message-ID: <dd93c10c-d947-48f9-8e19-e7ea5b19eb3d@linux.ibm.com>
Date: Tue, 25 Feb 2025 18:58:18 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 4/7] block: Introduce a dedicated lock for protecting
 queue elevator updates
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-5-nilay@linux.ibm.com> <20250224163356.GB5560@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250224163356.GB5560@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UhoqRu4frmSY_HTGD47jUNv2pJkvPh3M
X-Proofpoint-ORIG-GUID: UhoqRu4frmSY_HTGD47jUNv2pJkvPh3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=742 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250090



On 2/24/25 10:03 PM, Christoph Hellwig wrote:
> There's weird upper case for the first character after block.  I know
> some subsystems like this, but in general try to at least be consistent
> for the series.
> 
>> +	/*
>> +	 * attributes which require some form of locking
>> +	 * other than q->sysfs_lock
> 
> Make that a proper sentence:
> 
> 	 * Attributes which require some form of locking
> 	 * other than q->sysfs_lock.
> 
>> +	/*
>> +	 * protects elevator switch/update
>> +	 */
> 
> Also make this a full sentence, and mention which fields this protects.
> 
> Otherwise looks good.

Okay, I'll incorporate above comments in the next patchset.

Thanks,
--Nilay
