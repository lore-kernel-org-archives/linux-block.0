Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A553260363
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866524; cv=none; b=PVZ9/6tX3x+/7JxcqDNehngKMgLvTv6isnFyugR2ceGtdK10QuBAj6+3RKCy2JoT2Z9mHl2VbkctBTSq1Kjj1WLPocoraxzOhhY+UHoCgvqHOS19bXPxjLnfCJSZNMR0CGHOEcC8QXdM8sxFtaS/NB1FbRhjVy1O4T+NP/J/oio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866524; c=relaxed/simple;
	bh=ALZi0DIIUxTTKUDvZEMcVIapgbQMQxRWma1IanOorV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiPaSGfDTV69xy2et8npzCkvHyKsNtYqsQQTogXaIsG91/F4pT41sdTqqezhktjTxh+qHqfykAIZd6YOBD+JixNBWeeAWEhei9npp3DnJaPZ9yok6+u0tqyw5NpiQpMIWGHskQiwFWXKKxrUkEooHQ3CQhuKfZaMgg7FWGk1ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=otMRofBp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="otMRofBp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D90SbQ026800;
	Thu, 13 Mar 2025 11:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4Qvnbx
	spKzcMNWjdJPJf1GcEHDA8uVkTx5/RgJDy0w4=; b=otMRofBpDuJkow77k659Iv
	wFhyFquPvIiqzgbMOHUoYmh2pjJBtfXyIXx83tSAuBqfQMrCOFsDNS9FX6ZTa7PB
	5MP8S6lM6k1FsyMoOc1NYamgcoXgUKxSynb6Nmc75YWlsqCthFmfqLBMMjd/xUhQ
	v1pRSmNruORSXGTJpN0RQC+3Kk1cJbsbGms8UNoN1pzyKGrb1SBm7M/YLTXhaKOX
	x/g65iDuG2fOG7w1D42bcz8bYDBDfSM2y0DizMI/jHsuFU5QfZd3uH7Db/lI4SfC
	pV3UvD69zNCw/mwHhd1Vlxmissw7DYtKCYaMQkNXfd3Hiq4SiUCUgmQ+y4T0LCag
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhepke2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:48:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D919VS007627;
	Thu, 13 Mar 2025 11:48:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr9h7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 11:48:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52DBmLMZ32965198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 11:48:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37B258056;
	Thu, 13 Mar 2025 11:48:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40FA85803F;
	Thu, 13 Mar 2025 11:48:19 +0000 (GMT)
Received: from [9.109.198.185] (unknown [9.109.198.185])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 11:48:18 +0000 (GMT)
Message-ID: <c44eabfb-847a-41fd-9b63-37b64db141f9@linux.ibm.com>
Date: Thu, 13 Mar 2025 17:18:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: protect debugfs attributes using q->elevator_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20250312102903.3584358-1-nilay@linux.ibm.com>
 <20250312141251.GA13250@lst.de>
 <9e5fd5f1-1564-4a99-aeb4-6d8d9d765db7@linux.ibm.com>
 <20250313075421.GA12286@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250313075421.GA12286@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tx77lEQmdUzUzLNWCAPD0eraLIcyjuuz
X-Proofpoint-ORIG-GUID: tx77lEQmdUzUzLNWCAPD0eraLIcyjuuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=590
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130090



On 3/13/25 1:24 PM, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 08:49:33PM +0530, Nilay Shroff wrote:
>>> really want this read system call interrupted by random signals, do
>>> we?  I guess this should be mutex_lock_killable.
>>>
>>> (and the same for the existing methods this is copy and pasted from).
>>>
>> I thought we wanted to interrupt using SIGINT (CTRL+C) in case user opens 
>> this file using cat. Maybe that's more convenient than sending SIGKILL. 
>> And yes I used mutex_lock_interruptible because for other attributes we are 
>> already using it. But if mutex_lock_killable is preferred then I'd change it
>> for all methods.
> 
> Let's leave it alone for this series.  While I think it's the wrong
> choice it's been there for a long time, so we might as well not change
> it now for unrelated reasons.
> 
Alright, then I will not replace mutex_lock_interruptible with 
mutex_lock_killable for this series. A next version of this 
series is on the way... 

Thanks,
--Nilay

