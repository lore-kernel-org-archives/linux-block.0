Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B581FAC54;
	Tue,  1 Jul 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751346560; cv=none; b=PUPY0HTN/K86EbrTuZaeBAHBRzdpoEXzK6nquoILe8H2t89e7bBZOrnSt5EEBy5jaeFm8iiT1OKKVYXQc932vSvZDB9pULe5Si2Hw4aRI2GY1BqrM4Adns6OYq24riJdJqIYO/gXPrSynvEOPx9OOUM2OmVXZBm9klbradSUxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751346560; c=relaxed/simple;
	bh=n8ySfclbH8ync3F2tgFntxjXRLB4qls3IIpnZJcGy7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpJUlxv6PHREaSnh+YeJeFiE1NQA6qjLokfdUWXiWjCPXRHmJzsYir1/C0fygYIRkxSLVdioMO7BkqsSC+CoFomyAYhWNzBqwcR+4+G+3/Vjc3MzDovWhNB7gQccVutMC7gmmfVzy4jgqOcgS8QAGOopexo5M4Ho4QTYjcb6ykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lfr7962J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lfr7962J"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UJ6fvj029135;
	Tue, 1 Jul 2025 05:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ORFclw
	7yoo3+evDcrhbwPDW5tcq2blDEX2FQZsE7inw=; b=Lfr7962JrZ9xBHVrn6Yxzc
	3F3lEwj+FZxr1L2YhNFcp6orowtYZiJ3HAmm/XE38fXgEIyKEZ4GnZRHFZbHxvJO
	V5t6YhJ1xnYxk/p66qVvsWJD2YXE9pOV3OOHJdMucPWnKDb0j3s0mvfIupPftnnI
	j+HxkaAAfXU9CiB1jwRS3hpCyUczmDBhhYwamC5X+FeqNNEYzQcl40DZ3zyXDIH6
	t6ld/H/gFnXXkwVgpCBSUydhVbAe8mjAVIQ/ctrWXmWhM8eBOaqEimU22f8PNfD1
	q7CibmbI5Crz740QURN31tB79kyGUt0hdaG1yMSZss32f94NgFFj0gRnh+4mAhjw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82fn2q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:08:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5614au2p021385;
	Tue, 1 Jul 2025 05:08:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe38u87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 05:08:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56158pqv26739330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 05:08:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA78658052;
	Tue,  1 Jul 2025 05:08:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67C3858045;
	Tue,  1 Jul 2025 05:08:49 +0000 (GMT)
Received: from [9.109.198.197] (unknown [9.109.198.197])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 05:08:49 +0000 (GMT)
Message-ID: <2160a03f-4d4b-4b38-be26-49b2946e1ae5@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:38:46 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20250626203713.2258558-1-bvanassche@acm.org>
 <20250627071702.GA992@lst.de> <d03ccb5c-f44c-40e7-9964-2e9ec67bb96f@acm.org>
 <aGMvCXklxJ_rlZOM@kbusch-mbp> <ef79ab48-f047-4f7d-a6f9-25dcc275126b@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ef79ab48-f047-4f7d-a6f9-25dcc275126b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 26ugk3mPdOMEo-tUgMUx1nV6swmknHJR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyMSBTYWx0ZWRfX6RhMN5PHE1PA W2b9Ny7sW13P0KwSjRzzxCI4lBPJ1xDrgeNK/JxFVdzpeGhBGsNgMfD3TgHurc23S/TkEH5URb/ COCMGBVReZp+vnFbAO5YDohbrTUd4U7mreHlsZxPCGHD+O1jPdwXCuwV4dajq7nDVgSABDgAdVK
 9b4gZ0zt6sT8HpdGIvW5JznkiE4duV51cr5pNi9nehEr64uJN19UPqXenY/rdAzQcJ5vEU8258R e9Ds3IPlo0MXwfxsnhUMHPdaQBgM8BBOJwegYGYRDxHzfa6+a4Oo6ajzw738SK2Q4c6XJUpkRN/ 7SpnZ1nV8qUWU0Q4jNcLGKD5DjhIdNj91WqQPTsHJ54HWEcpzhiDMyhB9BQGq6AqEP1C5/PBxyj
 4Cw7kHueQsp0kypaWdtP1YbDip9mTGOaTg3QTg/9qUyyBDXIS6VNSsnZbQfFEBwD/GraFQuc
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68636d65 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=awnCJFwb0uc6ziIXhYEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 26ugk3mPdOMEo-tUgMUx1nV6swmknHJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010021



On 7/1/25 7:20 AM, Bart Van Assche wrote:
> On 6/30/25 5:42 PM, Keith Busch wrote:
>> On Mon, Jun 30, 2025 at 03:39:18PM -0700, Bart Van Assche wrote:
>>> On 6/27/25 12:17 AM, Christoph Hellwig wrote:
>>>> Well, if there are queued never completed bios the freeze will obviously
>>>> fail.  I don't see how this freeze is special vs other freezes or other
>>>> attributes that freeze.
>>>
>>> Hi Christoph,
>>>
>>> Do you perhaps want me to remove the freeze/unfreeze calls from all
>>> sysfs store callbacks from which it is safe to remove these callbacks?
>>
>> But don't the remaining attributes that are not safe remain susceptible
>> to this deadlock?
> 
> For the remaining sysfs attributes the deadlock can be solved by
> letting the blk_mq_freeze_queue() call by the sysfs store methods time
> out if that call takes too long or by making that call interruptible by
> signals like Ctrl-C. I think its better to let functions like
> queue_requests_store() fail if an attempt to freeze a request
> queue takes longer than it should rather than to trigger a kernel
> deadlock.
> 
I think you're proposing to use blk_mq_freeze_queue_wait_timeout()
here (which puts the caller into uninterruptible sleep) and that might
be okay. However, IMO, using TASK_INTERRUPTIBLE may not be worth in
case those sysfs store methods are invoked from udev rules or 
application. But lets wait for others to chime in and suggest.

Thanks,
--Nilay
