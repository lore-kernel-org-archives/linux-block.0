Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F8171658
	for <linux-block@vger.kernel.org>; Thu,  1 Aug 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503578; cv=none; b=XxqoCzDNXKDHavBvwuRibdkRkXmQnaHbDJ9vKJ2i+A2q6Arj6ZTlva4FwFeBKlgfV8ZNFgBlktBaEDCd2tkb54dl76qeSH06/rcK+DoWCge27uaY6wHElGWleGDbG7D7by8WVdyBn9a2NC0oqSmkfxInoybALjGGwRyP0RA78Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503578; c=relaxed/simple;
	bh=9PJe4PFNsSh5PJrX24Cp8MB8i2OIBOhFFogqr5Oyqdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOdtYxDFCyQE5P3QqTZGjOgoWlw9PTML/h576Y4Z8kmcWDK2iHGmqMiw0pKe//HBxMFezbBls6dk+2dng/OyMqfcxnG9hyfm3/6o3r/ZroXf2t+aaEES4mT98v6J68yGmIUJ+vOuEaYWgXQ7G/e0C8a5Q0rj2j/A7sEwwEMvmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XsfWNTqG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XsfWNTqG"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4714uaJR022359;
	Thu, 1 Aug 2024 09:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=T
	OvPEb4Hh1uE5Lznfg5tY4CcjJuhQGTBDU9eHB967Wo=; b=XsfWNTqGlLHrq1zTM
	kloPGCtbL3Efgj98hgh2ynoJdvywuaWeaScG4xp4OB6+DPuYC/xeq9s7tWbwiNNd
	5qUIQRrfqwt5jeFOavvlFr2krRw9RBrMOBBdKCS40rDTtvXjcKwoKEHPP3DMs3sH
	KcdulgvNDayVe/fqOBo3OsTurnb+uEbjz318499X+L7rpwQuNw6Lcqn1RUZHDrqw
	Bo7mQTW6Z84cTj2UZWUey7BzP+RF83ZFB5rdo6D8hztzt25WKDpamQEShL9XQgBT
	fOVCjqWEjcJTpPLR+s1j/z9wzvrMIcDHfOw10kSxW618mk40xVqePGCzduEQi9ib
	0zVhQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qx3cs9dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:12:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4716OXtL009233;
	Thu, 1 Aug 2024 09:12:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx38jex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:12:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4719CnHq23724586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 09:12:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B2B458062;
	Thu,  1 Aug 2024 09:12:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1CC58057;
	Thu,  1 Aug 2024 09:12:48 +0000 (GMT)
Received: from [9.179.0.4] (unknown [9.179.0.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 09:12:47 +0000 (GMT)
Message-ID: <d28b3e25-d464-4949-91fe-1752db6c5d5a@linux.ibm.com>
Date: Thu, 1 Aug 2024 14:42:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Cyril Hrubis <chrubis@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
 <ZqoelLy4Wp33YAGD@yuki>
 <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
 <914eec96-eb46-4cf1-9cbd-0e1f98059d1b@linux.ibm.com> <ZqoyDjCpaXPaU1uN@yuki>
 <55ff37a5-a6fd-4f73-affc-d432a31a8bd0@linux.ibm.com>
 <4dhpiheoz4qjgg3zq67tjnkpx36hop2gpsnd5rublsht7zegyh@nw3mtu3zl54n>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4dhpiheoz4qjgg3zq67tjnkpx36hop2gpsnd5rublsht7zegyh@nw3mtu3zl54n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PT66pIfTjFxgHd52Q0h9tsQ5cuRUEZst
X-Proofpoint-ORIG-GUID: PT66pIfTjFxgHd52Q0h9tsQ5cuRUEZst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 mlxlogscore=582 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010053



On 8/1/24 11:57, Shinichiro Kawasaki wrote:
> On Jul 31, 2024 / 19:29, Nilay Shroff wrote:
>> Hi Shinichiro,
>>
>> On 7/31/24 18:16, Cyril Hrubis wrote:
>>> Hi!
>>>>> According to www.kernel.org, the 6.9 stable branch is already EOL. Is it planned
>>>>> to backport the kernel fix to other longterm branches?
>>>> I just checked this commit 5f75e081ab5c ("loop: Disable fallocate() zero and discard
>>>> if not supported") hasn't been backported to any of the longterm stable kernel yet.
>>>> However I don't know if there's any plan to backport it on longterm stable kernel.
>>>
>>> The patch will not apply into older branches since the in kernel API did
>>> change, so I suppose that nobody will invest into rewriting the patch
>>> since it's mostly cosmetic.
>>>
>>
>> This commit 5f75e081ab5c has been backported to kernel v6.9.11 and per the above 
>> comment from Cyril, this commit shall not be backported further to any other longterm 
>> kernel.
>>
>> So is it reasonable to assume that this test would fail on kernel older than v6.9.11?
> 
> I have the same guess.
> 
>> And if this is true then how about rewriting the patch as below ?
>>
>> diff --git a/tests/loop/011 b/tests/loop/011
>> index 35eb39b..a454848 100755
>> --- a/tests/loop/011
>> +++ b/tests/loop/011
>> @@ -9,6 +9,7 @@
>>  DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
>>  
>>  requires() {
>> +       _have_kver 6 9 11
>>         _have_program mkfs.ext2
>>  }
> 
> I think this change is reasonable. Would you repost the patch?
Sure, I will send another patch.

Thanks,
--Nilay
