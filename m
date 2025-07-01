Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBBE1F239B;
	Tue,  1 Jul 2025 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751345820; cv=none; b=oS2XdBXN4wOrLMcg5KXsuv+ScTQnMToHk3Q43ONeAnj8ZLB76dBcqCrT9t9DmwlncKgyIk3RqB1Lw0erWs4VTcrjVnZbcakOliEHQ3vqO4V/CD1tmagKZWQ3vYy2QSpoyk1tYDYjBA35Lc5lgjCOX7J5qrx67PNQ6BK2N/PIHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751345820; c=relaxed/simple;
	bh=CyTTALPDGzJEGx5kejZTHaonS/g8TKbNMC/M4WYeEqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3tMPjeV5lq1MjVubftH4g91LGyASYqBP+28mqFaDXNukdmtTuQnjcz1qY54juPGkLajeX+JWViUPRNNlPHh7Fei2s9806/73aBkaGXXf6jOL3L5VgylDecJ2i3taT9cAfgErvB6a9Axe4NZ+nAWPbiox1j72hQ2ZW91u9t65ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tE6q0Y9V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tE6q0Y9V"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UIJWoN032170;
	Tue, 1 Jul 2025 04:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kn1okj
	zMk2tUg9ap6GcxCIUXgyEWvR3Gb8Bma63x9OM=; b=tE6q0Y9VGQnQHTUwT+eN/Y
	DEZLu9RPoAx5ZkvB892uaS2nH+P1XPQQJhEyBoK9fho/2IPm04VsRUbMcnqKw+i6
	pmnosSfY0JtVdOPCjgxqItWMCXEZ04uvUtWrKeknazdU0pKxTXMuHYUNQYXWfs2V
	O5NwEZfTQwFKh8gWmmAZWQCVWtJGqKrxL2qhfEZOzAazg11dR3Vfz5NbRLUqh0cI
	XOIMHNGl5pqb5JkvhYTls4gjy5QZSnUueW+qfLQ1sGShK5u0mzQ5MUvTIvOWpZY3
	YGL2t5xuG20cmjZmKjse/jYkDm+GUgCHrZ5WThuMx8lQXQKYtrKhrDYHrTCrMz6Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82fn1fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 04:56:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5613dEG8011840;
	Tue, 1 Jul 2025 04:56:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7ms0hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 04:56:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5614uYhC30737016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Jul 2025 04:56:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9847C5805E;
	Tue,  1 Jul 2025 04:56:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D310358050;
	Tue,  1 Jul 2025 04:56:37 +0000 (GMT)
Received: from [9.109.198.197] (unknown [9.109.198.197])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Jul 2025 04:56:37 +0000 (GMT)
Message-ID: <a1f5b332-d3c5-4a38-b450-014b14f99ef1@linux.ibm.com>
Date: Tue, 1 Jul 2025 10:26:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related to modifying the readahead
 attribute
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
References: <20250625195450.1172740-1-bvanassche@acm.org>
 <1816437d-240a-4834-bef9-c9c4a66bee0a@linux.ibm.com>
 <ca4c60c9-c5df-4a82-8045-54ed9c0ba9be@acm.org>
 <7e4ff7e0-b2e0-4e2d-92a4-65b3d695c5e1@linux.ibm.com>
 <344a0eef-6942-455a-9fb2-f80fd72d4668@acm.org>
 <6a9bf05f-f315-417a-b328-6a243de3568e@linux.ibm.com>
 <765d62a8-bb5d-4f1d-8996-afc005bc2d1d@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <765d62a8-bb5d-4f1d-8996-afc005bc2d1d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pVddDtzalOO302lR97EAfuVgCOOubmyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAyMSBTYWx0ZWRfX/OmAX9StZZ1O vkIeDheibgdbmukOAWP+HneOTkwY3SvUhPkcGgR27xJ4Dby8X5aVAjytnF7XrOmCehFzgyB+v7A uZpGDZQWnMO1ETUOYDu3HWtli9bV2msSkHsLd7oKjgB2/BMSw3e+LDIOwgpjMdBb9+2y6zOBFkY
 X+cAQFCmXI8lz/JN33MI/Is9DgjOgX613Xdxnb4Ja1+N2V2RF6nOkR+DvRKvN3XS7Qu6jTXByyS PMmMjXevZhHOU8DT0lzHORPYEDNkz49D36vnysLe/PXaHs+9XSWLKNYvlLIZShyFj7qWsiC81Tr ud1cXrBTmyKVw3MrsIDXvKTb3Dm0LSnqP9pemnAxkp72DsGceGGXVvxBRHGq9ysPcDWGYDZIZLa
 nprKU4xuEfBJcTC3+cvq/96opYlhBWV+wkkGBiHDw5FhtykFIahRNV+UOgKemoEoqlogDn9T
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68636a88 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=lWPI-tUN4iWXceEnCj0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pVddDtzalOO302lR97EAfuVgCOOubmyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010021



On 6/30/25 8:58 PM, Bart Van Assche wrote:
> On 6/30/25 3:41 AM, Nilay Shroff wrote:
>> Looking at your earlier dmsetup command:
>> # dmsetup table mpatha
>> 0 65536 multipath 1 queue_if_no_path 1 alua 1 1 service-time 0 1 2 8:32 1 1
>>
>> In the above rule, the option queue_if_no_path seems bit odd (unless used
>> with timeout). Can't we add module param queue_if_no_path_timeout_secs=<N>
>> while loading dm-multipath and thus avoid hanging the queue I/O indefinitely
>> when all paths of a multipath device is lost? IMO, queue_if_no_path without
>> timeout may make sense when we know that the paths will eventually recover
>> and that applications should simply wait.
> 
> I refuse to modify the tests that trigger the deadlock because:
> 1. The deadlock is a REGRESSION. Regressions are not tolerated in the
>    Linux kernel and should be fixed instead of arguing about whether or
>    not the use case should be modified.
> 2. The test that triggers the deadlock is not new. It is almost ten
>    years old and the deadlock reported at the start of this email thread
>    is the first deadlock in the block layer triggered by that test.
> 3. queue_if_no_path is widely used to avoid I/O errors if all paths are
>    temporarily unavailable and if it is not known how long it will take
>    to restore a path. queue_if_no_path can e.g. be used to prevent I/O
>    errors if a technician mistakenly pulls the wrong cable(s) in a data
>    center.
> 4. Unnecessary blk_mq_freeze_queue()/blk_mq_unfreeze_queue() pairs slow
>    down the workflows that trigger these kernel function calls. Hence,
>    if blk_mq_freeze_queue() and blk_mq_unfreeze_queue() are called
>    unnecessarily, the calls to these functions should be removed.

Yes agreed.. Your above points makes sense. As this is REGRESSION we
must fix this. I am convinced that the readahead attribute is not used
in IO hotpath so in that sense your patch is valid, no issues with that.
However my only concern was about other sysfs attributes which needs 
queue freeze and that's legitimate as those attributes are used in IO 
hotpath. But I just saw that you proposed some idea about addressing 
those other sysfs attributes, so lets discuss this on that thread.

Meanwhile, I'd review your patch.

Thanks,
--Nilay


