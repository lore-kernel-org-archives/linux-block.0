Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE91B0106
	for <linux-block@vger.kernel.org>; Wed, 31 Jul 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429703; cv=none; b=D2OXlMIKohMCb9lF6xiNKsVGDOG971TZxQo0hW3p8BKrSMV58OdK18XLMnLQcX5DRcEvT+i0uxuG6LiEmDbWRDAIooxSwit+ZAe18Nov1WyI7IlBjFtK7//6lQ3Ta/bozqtnsXAKB3mkEHk9VLT37ltxIBYmJeSm/ssbl47DqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429703; c=relaxed/simple;
	bh=sRteEa73YtvhRGdjwHLPjYoJgKjapvQ9DRoboKU9azk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaBBNsYaDQwQa4m23H5sSp0U1eBuuUAITaD29MMm4pGAetTVkYmXx71709MpUPcBtgTW9pHy24OTdyzL5M6XGOv9g5bOKmbyydvUVA1l4j9gjS4EiPsV6YVbpT2P227Bc1aY58UhaZDuoowSxtJPF8TU75z0KD1pJgeuITqJcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nBQvhdXs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nBQvhdXs"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VBDiXB023693;
	Wed, 31 Jul 2024 12:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
	+TUpAzJWsWS63xgELDP3bvwHYGBBXn6EOPe3BG4ZF4=; b=nBQvhdXs8XRSgCIeY
	WrYBpBNYXMFl+lNTmSbxMMXTi06c/qbJeJLuP2Wvk612tnBuVNbufOsgkP5pO5aW
	cEiDwGe4nSEDExjGuGr9Ztyn5yEX2Q+RwHCYHnIYGKQ5CT0a1eSUI4uNZtvaHjzA
	XSh15AH42XYUCOYCk9tv4LBcBFtUjJRlcH2c/1AXYm/JzhaxVQ7uFiFoUI9E3z01
	IUYGfBUYrS4xfeyHuOewWNn3cHYOAIuUWAVyO0OsES3ktokmYIHkX28VIGanj1C8
	TagG39mggLK4PQQrHumJ1HrlFDF+uLvZIYY9i7nUWCx+xROANmXAgJppWJVDgMt4
	PQhCA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qhkf8m1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 12:41:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46VAB5UX009181;
	Wed, 31 Jul 2024 12:41:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3363q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 12:41:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46VCfXGS22872752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 12:41:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3C8258059;
	Wed, 31 Jul 2024 12:41:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DC25805D;
	Wed, 31 Jul 2024 12:41:32 +0000 (GMT)
Received: from [9.171.15.87] (unknown [9.171.15.87])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 12:41:32 +0000 (GMT)
Message-ID: <914eec96-eb46-4cf1-9cbd-0e1f98059d1b@linux.ibm.com>
Date: Wed, 31 Jul 2024 18:11:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] loop/011: skip if running on kernel older than
 v6.10
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Cyril Hrubis <chrubis@suse.cz>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
References: <20240731111804.1161524-1-nilay@linux.ibm.com>
 <ZqoelLy4Wp33YAGD@yuki>
 <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <yuz6jvqbsctjhm47fpftvfpgea3x4sbji6kdmk47e5s6hz63ig@gvbiphrvl7wk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K2r_XlYtRPEBrubZMh5dx4nS-MIPthk-
X-Proofpoint-ORIG-GUID: K2r_XlYtRPEBrubZMh5dx4nS-MIPthk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=636
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310091



On 7/31/24 17:31, Shinichiro Kawasaki wrote:
> On Jul 31, 2024 / 13:23, Cyril Hrubis wrote:
>> Hi!
>>> The loop/011 is regression test for kernel commit 5f75e081ab5c ("loop: 
>>> Disable fallocate() zero and discard if not supported") which requires 
>>> minimum kernel version 6.10. So running this test on kernel version
>>> older than v6.10 would FAIL. This patch ensures that we skip running 
>>> loop/011 if kernel version is older than v6.10.
>>
>> The patch has been backported to 6.9 stable as well.
> 
> Hi Cyril, Nilay,
> 
> According to www.kernel.org, the 6.9 stable branch is already EOL. Is it planned
> to backport the kernel fix to other longterm branches?
I just checked this commit 5f75e081ab5c ("loop: Disable fallocate() zero and discard
if not supported") hasn't been backported to any of the longterm stable kernel yet.
However I don't know if there's any plan to backport it on longterm stable kernel.

Maybe, Cyril should know about it? 

If not planned for backport on longterm stable kernel then we may consider the
proposed changes in loop/011 as-is.

Thanks,
--Nilay
