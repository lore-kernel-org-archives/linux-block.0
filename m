Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E4F4FB
	for <linux-block@vger.kernel.org>; Fri,  2 Aug 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576750; cv=none; b=u52nzb/bYUORlAitI3bcXvn+Xlw078IsUyHlLkhEM8EBOnnfB2na1gzErWUkDfNR1wNxgWgvIBA/uJdi6lYx8xu/FPmo2hY2f5wNJSrTvDbsdf46K7ktHdRuoraTN6KkVx+QExara9lLlISuOSF+39WygDw8D8ytjUwYHbb/6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576750; c=relaxed/simple;
	bh=YKEsxTXeKx8+xnIFgaXm5tcvK1FC7UkUYnlDSYWVYkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LNsLt7ldVNGbeXLaL1j/3MNC9/NwezKYf5IwCp05ZUn4YLEgzZ6bmNN60pkGWQ2124d91OebtITwzeSMRQQdr6fMpj3/GsyiLZB0H3Y6y0REH06+eUPWW64LqWKpopayuPUWgLjxbxuHlbblOnBN+HgCx3kCH3VLhAu1lZTwyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X6m5jkpG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X6m5jkpG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4725QAlJ014022;
	Fri, 2 Aug 2024 05:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	wfyHgERp2ixvB9HfQ/my7S3LhWGhRyeP3C/zBDncEbE=; b=X6m5jkpGtvDqugC4
	071uKWuC/r+JlyYJ26N+dPOeBNHZuMgOQYSQu4p3N6IehAyZmRDjDU1KEp8mwc/R
	weGkvRHOgyuNqI0HmPCNm7mo+9Q4YvjF5V5/B4YcrY80FHUTSbHTAypk7oZ0xJo0
	vgDZg/6CtjLhb12pbpeLyTaLZErz1NOY0wZd2+Lbywf0DKmddpwRMG12iIY+0fY7
	X91AeC1/0INn372+Xr0CPybyKeXYlqsSJ/WvPmVIiTyWQc8txJAW3kxqt/EGFFDI
	uIaTC0V3hhdiT5/UhqH/t7QuLD9vWR81uMpgegxknlmS2tMjdtXkCZc3u9mKF/K+
	bQIb5g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rrfh039m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 05:32:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4723OSmQ003748;
	Fri, 2 Aug 2024 05:32:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemwda6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 05:32:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4725W71g24379986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 05:32:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55B0358043;
	Fri,  2 Aug 2024 05:32:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61C8B5805D;
	Fri,  2 Aug 2024 05:32:05 +0000 (GMT)
Received: from [9.109.198.216] (unknown [9.109.198.216])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 05:32:05 +0000 (GMT)
Message-ID: <676078d7-3312-40d9-ba76-ee9b7101f68a@linux.ibm.com>
Date: Fri, 2 Aug 2024 11:02:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] loop/011: skip if running on kernel older than
 v6.9.11
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Cc: chrubis@suse.cz, shinichiro.kawasaki@wdc.com, gjoyce@linux.ibm.com
References: <20240801092904.1258520-1-nilay@linux.ibm.com>
 <932044b9-fd7b-44aa-a5df-ff6eedfb2aeb@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <932044b9-fd7b-44aa-a5df-ff6eedfb2aeb@acm.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F2whRFKaC7QczGFYa2UQEgUwFEbE9cDv
X-Proofpoint-GUID: F2whRFKaC7QczGFYa2UQEgUwFEbE9cDv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_02,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=998 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020035



On 8/1/24 21:52, Bart Van Assche wrote:
> On 8/1/24 2:28 AM, Nilay Shroff wrote:
>> The loop/011 is regression test for commit 5f75e081ab5c ("loop: Disable
>> fallocate() zero and discard if not supported") which requires minimum
>> kernel version 6.9.11. So running this test on kernel version older than
>> v6.9.11 would FAIL. This patch ensures that we skip running loop/011 if
>> kernel version is older than v6.9.11.
>>
>> Link: https://lore.kernel.org/all/20240731111804.1161524-1-nilay@linux.ibm.com/
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>    Changes from v1:
>>      - loop/011 requires minimum kernel version 6.9.11 (Cyril, Shinichiro)
>> ---
>>   tests/loop/011 | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/loop/011 b/tests/loop/011
>> index 35eb39b..a454848 100755
>> --- a/tests/loop/011
>> +++ b/tests/loop/011
>> @@ -9,6 +9,7 @@
>>   DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
>>     requires() {
>> +    _have_kver 6 9 11
>>       _have_program mkfs.ext2
>>   }
> 
> Please add a comment in tests/loop/011 that explains why the kernel
> version check is present.
> 
OK, I will add a relevant comment and resend the patch.

Thanks,
--Nilay
