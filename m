Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C231FC3
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762177; cv=none; b=pc823XACRodH0NGGxDCNJmgCopWJM9sAUMbrtLQYMfL3aLO7I662sMBXtcg7UjVhnB9ujKXzKV7aEOQ2DT8qkRhWJnsJeQe7ytT60T4VylCgEcqyDtCAyX/pNETG2qroaKZ88jvPp55wmgRfaCJl6FoYcghNKwxpZFTg7xsSqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762177; c=relaxed/simple;
	bh=QdN0h9HEBvNM1aE4WyttFDwmvB7eTtxDhEgkl41+kCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swT4wmMVeqWaEnoQkvImz/LFIkxGZA4PP/HJKtmtAgGxrWbvFpUAFWo6KYxUsZ2OzVP4BfrcudXslyNfROAko6njBUa7z83yX24OkglXcoItt3Gn02WzAWXGWn6v2I4vQShlEKCTg1WsCMTiPNoNLv73/7NGM7BuMK+OliXL+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MmsQhgUM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MmsQhgUM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Ck92S009800;
	Wed, 5 Feb 2025 13:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AwI+Al
	9i3PindwHeG4EsxryVMwErH9cLhzmF5x67UIo=; b=MmsQhgUMQ0caWal0TMKcJp
	4XbGr9QUPgcqFEcSEfP5E8xXhr40HIPIe+6HYTQjSZJlsFgnzocT55HReN0qTX+O
	fY9iY6Q1Sw3yNIKC0ovDa4AIw6PI3hufqrGxjrhcAAwM0LeOjjODU2QtHUuVrkJQ
	Zmu0PTB5akSMcYByjBAF5O1jnTnoZnGFme7Su4v/p7T9PAwsLe+06cF+q9efIJAV
	6jyVKsQZUmDm7ZbORG1zCkD1xKmUOe7/i7ssLKMrtrclT0hp/P4H1eBQJPDHhMAR
	VcmY8aLDWSlgo2n34SgK6pxMVhm7+XXht9OfcKSDfZNLrwS6njoX+uXunFL6+CkQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kxtyjrqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:29:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515BuorY007150;
	Wed, 5 Feb 2025 13:29:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxays1ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 13:29:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515DTVIB17760848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 13:29:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6168158058;
	Wed,  5 Feb 2025 13:29:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D837D58059;
	Wed,  5 Feb 2025 13:29:29 +0000 (GMT)
Received: from [9.171.80.122] (unknown [9.171.80.122])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 13:29:29 +0000 (GMT)
Message-ID: <e68f1970-e31a-4ea1-8ca6-ff9d454ad906@linux.ibm.com>
Date: Wed, 5 Feb 2025 18:59:28 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250201184021.278437-1-nilay@linux.ibm.com>
 <76edbee8-9d5f-47a5-a6ae-932ff1b711b8@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <76edbee8-9d5f-47a5-a6ae-932ff1b711b8@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mz5KtQHJ2b_puqTTs6lXh52I4HWtBRtY
X-Proofpoint-ORIG-GUID: mz5KtQHJ2b_puqTTs6lXh52I4HWtBRtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=988 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050108



On 2/4/25 11:30 PM, Bart Van Assche wrote:
> On 2/1/25 10:40 AM, Nilay Shroff wrote:
>> +_have_module_not_in_use() {
> 
> The name "_have_module_not_in_use()" sounds weird to me. Wouldn't
> _module_not_in_use() be a better name?
> 
Yeah _module_not_in_use() sounds better. I will incorporate this
in the next patch.

Thanks,
--Nilay
