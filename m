Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400F1D61BB
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095527; cv=none; b=B5mXpxB99FOKDcI83fYVYFV629x2fRKh6FhzVBWImbz2So2WCqleOtXoM5XsMxNmeC2RejHxdETBY77/hpIpQUDRxs+Aa6jq21m17WKL1s4bKtioXklSX4qcFy/LcvJd+0eA89kTF+17We8xdvs4OTYB5sE99Sh6Pbj4MeBjpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095527; c=relaxed/simple;
	bh=69d7RGDNfx1skyoiY3LDogq1EbbMV3Lxru1XDbEk8Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJg1/o5czjtmlhMSzmQyAivVSh7pOubzxu9f57XFv1UezYyANqdwCwl+72A6LDcOjT9BhL7Gr5l3v7ECZnAX4ao4tbgqMmxaDkzQ+IicEKJz/JZbAgi6BYqp3yfLBmEqfwL/ZygPYZpw1goGZfYDgY7XRULnW0o7+2UynYnngkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=saPA2fYX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="saPA2fYX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541A3vvD000686;
	Thu, 1 May 2025 10:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4hVQZw
	fJYZeP0+qLbHjhypSQJ6fyyfb/efCylUP1MIU=; b=saPA2fYX4+GAe0d3Ic5MRS
	pSoIsKppqJ1kevs+OnZyVjsMHpLBk9o/ukp6+8sCxLABLemDWvf2UQK4FaQTKUZp
	n+lGf9aGv95Szi2pfAHZussie71/4aoVBGHgsjzCeOaC9c7U/sq5bCm6QJDhZmpy
	+erfnRU60uCdlprgp7es0/iU9nVcWrf8eosdZiJx8/6KTlGXsVVs+EQRjBpSOmUI
	ULBQCRQhinLET0NAA730aln7MszvgOLJ3twp2yrRAkP3fmsxfLVN09X4CWGUD/Ly
	pCiLBQxkpt1tpU4fGnM3aHT5t7kA/UeToGJTcPLgCKJ84cDNHHaoCeeqJCW8qKuw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46c6vjg2qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:31:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 541AQ5m8001880;
	Thu, 1 May 2025 10:31:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamv9sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:31:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 541AVvda25756398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 10:31:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CA758056;
	Thu,  1 May 2025 10:31:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1232E58052;
	Thu,  1 May 2025 10:31:55 +0000 (GMT)
Received: from [9.43.8.50] (unknown [9.43.8.50])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 10:31:54 +0000 (GMT)
Message-ID: <2ab75f7d-ac00-405a-8c28-6aabffa937eb@linux.ibm.com>
Date: Thu, 1 May 2025 16:01:53 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/24] block: remove elevator queue's type check in
 elv_attr_show/store()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-18-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250430043529.1950194-18-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3NyBTYWx0ZWRfX7+N+Q3XTtbdj lZaM9y4sbFOjf6sM855wiyjq3xFlHmwLzWOGZ2pplTdgMvWfY4nKq6zyOQTt+3JJAEbbmLwwjPM ea/EtEzY6DiV8x7LFuSH+lFlAt+/gBoL3WG57m+NRjCX0Ec24I4BrwSsUASAdjtwHc/hh5f07WT
 mqsQSnuMzbmVvyiJf8zD9qYoO64bPI1NFrL4p9gkEBrYgakA8t3MpIdDWJPe/d34nY5xyxR1Yzt GL8HmRDKHdBIy8X1S3tj7kJtpEgEhJcEbY7TMGPpli/TnrSfT9CDhnYWTKOHG0rJ5yBtxTIwvTi ZVGo+CLq56qQ4xUmQfaj5P9dI7PuudeKSszdJ0WCI9G+gg/ZYJV0BrKdUtF07N7GNDZfPGUG0VR
 itQ68oyGAtiBx43sSHbuZkDIKK/IqOYRyR/mS2z73UXt5I19ZAsRLBNg35sZCbTsp/BJzsQs
X-Authority-Analysis: v=2.4 cv=GI8IEvNK c=1 sm=1 tr=0 ts=68134d9f cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=LWOdSK4r3EOMzDvpZzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pfBzS3BCsxAho2xlTcs51JsU1XSsTpsY
X-Proofpoint-ORIG-GUID: pfBzS3BCsxAho2xlTcs51JsU1XSsTpsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=855 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010077



On 4/30/25 10:05 AM, Ming Lei wrote:
> elevatore queue's type is assigned since its allocation, and never
> get cleared until it is released.
> 
> So its ->type is always not NULL, remove the unnecessary check.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
