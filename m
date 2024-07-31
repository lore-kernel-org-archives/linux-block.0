Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EB1B29CF
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434378; cv=none; b=AJZwwZAPRV+OoNHUdtPHViPKWsBINO39EHnP2ovVCe9xy8l6Q96mjE5zNY9WoLc4Xlxlw2EYXz1NXxOqysiiIzAMnxwdNH4bx1qq9sgZfY7bBUPwOlnqpB3mqaP8dKg/H7YVgWz1eO8DTCPZxSln16d/Ts7rnfPx9I3FWW8ZjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434378; c=relaxed/simple;
	bh=qD0mWbZpjX3+DHT84m0yJG+C4IswQn5By7C1QfDdqCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1kW3kJGwKERMNs6pAC+ZcAALXwXwgZfhLKnWF9w3mmLw+3TST37A5u7P1pX7E9gW80oAukT7yQdR6bmBs6TqjumqwfAXj0XST8mfVvPansblJICHXARr2jDol1UzKCPsIgqX+XWWUrbCYDbjhUv4JFhZiBMu34cTeJMl1E4+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B4VtPwfh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B4VtPwfh"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VCWRAx019456;
	Wed, 31 Jul 2024 13:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=q
	aPOQjASUUsL+Aa5UQX96GDaW7qKcFLicZkEOgT1LWo=; b=B4VtPwfhwFBNfqkwd
	RLMFz3jm3NHfwWMVSJmCT/ktj+gFQf8nifJIXTQ92Jj7U2j2GDQuClDxSLEfijI6
	i7k+T1iES30/B29+ppasTiUEB9vfVf76feevzAcbpjTy3aeSHKTj9gdiBhlxdxjy
	H2kqxjBIZcKnIY1TpyDOYkkDaKB8ezX8sRfTCgmhgKRZ6YFeCfmeW/24XoDspQE0
	eTvqTtc0DYVa016Ke1w0WIJyTgjKAbbubErga8TgM5SnWtPeAlWndBuv0CWRAhQA
	kMkV/Gtyh8qao6sUugSDadkunzUsydP6ilPeS23X3+qVpVrvgtkRwb8qhwFE4m61
	yyq0w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qnbx880m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 13:59:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VB74VS029103;
	Wed, 31 Jul 2024 13:59:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm0uy6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 13:59:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VDxTKn35258878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 13:59:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B1858065;
	Wed, 31 Jul 2024 13:59:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F15A458062;
	Wed, 31 Jul 2024 13:59:25 +0000 (GMT)
Received: from [9.171.15.87] (unknown [9.171.15.87])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 13:59:25 +0000 (GMT)
Message-ID: <55ff37a5-a6fd-4f73-affc-d432a31a8bd0@linux.ibm.com>
Date: Wed, 31 Jul 2024 19:29:24 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
 <ZqoelLy4Wp33YAGD@yuki>
 <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
 <914eec96-eb46-4cf1-9cbd-0e1f98059d1b@linux.ibm.com> <ZqoyDjCpaXPaU1uN@yuki>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZqoyDjCpaXPaU1uN@yuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7W9LtJsz2BsDbAgLjOMetqQy06p5GaMg
X-Proofpoint-ORIG-GUID: 7W9LtJsz2BsDbAgLjOMetqQy06p5GaMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxlogscore=701
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407310100

Hi Shinichiro,

On 7/31/24 18:16, Cyril Hrubis wrote:
> Hi!
>>> According to www.kernel.org, the 6.9 stable branch is already EOL. Is it planned
>>> to backport the kernel fix to other longterm branches?
>> I just checked this commit 5f75e081ab5c ("loop: Disable fallocate() zero and discard
>> if not supported") hasn't been backported to any of the longterm stable kernel yet.
>> However I don't know if there's any plan to backport it on longterm stable kernel.
> 
> The patch will not apply into older branches since the in kernel API did
> change, so I suppose that nobody will invest into rewriting the patch
> since it's mostly cosmetic.
> 

This commit 5f75e081ab5c has been backported to kernel v6.9.11 and per the above 
comment from Cyril, this commit shall not be backported further to any other longterm 
kernel.

So is it reasonable to assume that this test would fail on kernel older than v6.9.11? 
And if this is true then how about rewriting the patch as below ?

diff --git a/tests/loop/011 b/tests/loop/011
index 35eb39b..a454848 100755
--- a/tests/loop/011
+++ b/tests/loop/011
@@ -9,6 +9,7 @@
 DESCRIPTION="Make sure unsupported backing file fallocate does not fill dmesg with errors"
 
 requires() {
+       _have_kver 6 9 11
        _have_program mkfs.ext2
 }


Thanks,
--Nilay

