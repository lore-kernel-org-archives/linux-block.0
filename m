Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068E158557
	for <linux-block@vger.kernel.org>; Fri, 27 Sep 2024 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419099; cv=none; b=P119khMh/JnHMAwXH419kpMbJNCgiiXtpG72zwpkl1BcKw+58DRADwcFAWzAsbnav22hfiTkj8N/GXAto3yAVfWjAq2JBuEyyn7H5CJ3KMZou2ClQHmh91dPJg4+YZfFPp7w1sJZDiv4slzEgzvyBlTR/9UnkcP0UYTwoq40ZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419099; c=relaxed/simple;
	bh=OAaZ7ME0diCBQvUUcFQenxtHARvKZJOASSBFdrMJyks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc6PbPqHFVaoe4fYj0Lp1ltxdsfaNYCQOo+GtpTjgo3o2UjrFQ2Mv9CZ/sy3Wj32iSXndsYLz3dK4AEYVXAKf/CsYuPKPRPGWDBy1jjM7eUnmKpzzD5FUI+JGZAbR4K5uUcVVWow+u+FOxA29G6uj6RXgnJSBet7vhIdwN6xsog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/HVUuZ7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/HVUuZ7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QNSujr022612;
	Fri, 27 Sep 2024 06:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
	NMbZoaoL0ngoO7SDtPbRISXTmSq86Fn24npJJRg27o=; b=C/HVUuZ7Q8kZ22B4C
	FkCIzgdV5ShLF7uidGDk9TUyq4djvWWUyrImP9t3pBjfXYPIiDC6X14oSVPe1+qc
	0bJ3zDr6EEKoUDeMB23aJ+2pFRxPj4cekFExPBxHzFYm7cSHdKNv2YYlwdy4TaPe
	LpMDnLqdkOZZF6siKHmmpqR1fY5itANJd3lnLeAbbGKxetQ4ZEGTOD01Sz6abLMl
	/olL2CgNPcPj15gam83dyBxsz7nT4osjcLcb1biEOrY2TgLUiz+3dfr6w0JmZFws
	TwoxL4MoJDagJZz4BWg6nHBlCoXIYKY060ft+RuMTNs7+h5qnWe+u03Buorj6wav
	lHENQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnatn1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 06:38:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R3cGGK005841;
	Fri, 27 Sep 2024 06:38:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapmu1jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 06:38:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48R6c4OE24052406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 06:38:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA5A58054;
	Fri, 27 Sep 2024 06:38:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 853E158062;
	Fri, 27 Sep 2024 06:38:02 +0000 (GMT)
Received: from [9.171.27.86] (unknown [9.171.27.86])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Sep 2024 06:38:02 +0000 (GMT)
Message-ID: <08bc4614-fef7-44f7-9121-fc68ca289d92@linux.ibm.com>
Date: Fri, 27 Sep 2024 12:08:00 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] nvme/{033-037}: timeout while waiting for nvme
 passthru namespace device
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.wilck@suse.com" <martin.wilck@suse.com>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240925073245.241234-1-nilay@linux.ibm.com>
 <uptdu2g3x6jwlsdew6eu3uwkmketx4z3xehzeq56gsw7eofimg@h2lnekqsbdmf>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <uptdu2g3x6jwlsdew6eu3uwkmketx4z3xehzeq56gsw7eofimg@h2lnekqsbdmf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gA7oEURVyVIm84XmNOl2B4kda-0taiIT
X-Proofpoint-ORIG-GUID: gA7oEURVyVIm84XmNOl2B4kda-0taiIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270043



On 9/27/24 07:41, Shinichiro Kawasaki wrote:
> On Sep 25, 2024 / 13:01, Nilay Shroff wrote:
>> Avoid waiting indefinitely for nvme passthru namespace block device
>> to appear. Wait for up to 5 seconds and during this time if namespace
>> device doesn't appear then bail out and FAIL the test.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>     Changes from v1:
>>         - Add a meaningful error message if test fails (Shnichiro
>>           Kawasaki)
>>         - Use sleep "1" instead of ".1" while waiting for nsdev to be
>>           created as we don't see much gain in test runtime with short 
>>           duration of sleep. This would also help further optimize
>>           the sleep logic (Shnichiro Kawasaki)
>>         - Few other trivial cleanups (Shnichiro Kawasaki)
> 
> Thanks for this v2 patch.
> 
> [...]
> 
>> diff --git a/tests/nvme/036 b/tests/nvme/036
>> index 442ffe7..a114a7c 100755
>> --- a/tests/nvme/036
>> +++ b/tests/nvme/036
>> @@ -27,6 +27,7 @@ test_device() {
>>  	_setup_nvmet
>>  
>>  	local ctrldev
>> +	local nsdev
>>  
>>  	_nvmet_passthru_target_setup
>>  	nsdev=$(_nvmet_passthru_target_connect)
> 
> I commented for v1 that "unnecsseary change" was made for nmve/036. With that
> comment, I meant that one empty line removal was unnecessary. However, you
> removed the nsdev check in nvme/036 for v2. I guess you might have misunderstood
> my comment then removed the check. I suggest to put back the nsdev check in
> nvme/036. If you agree, could you send out v3? Or I can do it when I apply this
> patch.
> 
Ah, yes I think that was misunderstanding. When I reviewed your last comment about
nvme/036, I thought you wanted to remove nsdev check just because the intention of 
the nvme/036 test was to test "reset controller" command. So in that sense, the nsdev 
check is not important. Having said that, yes keeping nsdev check may also not 
harm. So I would add that nsdev check back in nvme/036 and send out patch v3.  


> Other than that, this patch looks good to me. Let's wait and see if anyone has
> other comments.

Thanks,
--Nilay
