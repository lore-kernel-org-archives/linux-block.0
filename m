Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498278C9C
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761515; cv=none; b=AGpCySdZ4oD1EmIhIfTskKeNYPbKxD9F5tmUwpQTzPyrG4PrsuXR5Qb2o4h5Oc1+n9aU22ds1zDhQqrK/C7EdGDZ1NHKezHerEjo6qM0qi4G8yvN6bNPg8R+EJ5K0mhwf2KzmN8TeWRUiPS1HDWSOCmPMBY7WOqwOqYyFVB4R2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761515; c=relaxed/simple;
	bh=AyPFYN0Xd/1WhYmGAHrEmTC5NxPqPRQejh/v+jbGm4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq1wDUzWuov9HCEb3fvgejFEXzGE5rOzSTYP400utAa5ZBfIINFUNXc9uMCCYD8Y0oqCg9Nsf81aDznu0dPAdLMxZ9GLec+mpstEMVGgSsj035GsB5JBzoBtNQT2SpSeTesf9UzeBnQWah9ncZLPGLucwY9w37sJWaHRuCCr6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ci9Cx+JC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ci9Cx+JC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBM8El025132;
	Thu, 17 Jul 2025 14:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Ymf2r
	l8QSNNo8OO+NOD5P7k1Ib3mkY0gLvtSNyrTRE=; b=ci9Cx+JCReaV68b95qnmKQ
	NaM2apcKZ9dFkBvm5CQnviXePcazY1ltsdW3/M8/w/X+Cxr5uTXmTYcPr7AKhHwH
	TWj5/eGg6oBh/0SMi0f27BqWRm4td9/agjPDafTq+xEE+QJX+4WSctxrbbNIom1i
	pRYzxEyWigegATZvpoUX/Fy+g8dFLU+NQqVTVv+M2DfBhU23PIABa5VEEQrCcOV2
	BkrFeL6HSJcbflyeDEZ5Soa6rYjRolSt23iHhnJB8kFcKdr9EAZ5xSaV3fE7Hn7k
	rRfjeSMF4OcHrkGn4WA2Uuh5HVG6+QLAaXspTENolA32yn7sNWuGJTdmS6yBaC0Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47y07trvbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:11:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCEj8K008164;
	Thu, 17 Jul 2025 14:11:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0vpqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 14:11:34 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HEBY2s31982086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:11:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2043758055;
	Thu, 17 Jul 2025 14:11:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E599F58043;
	Thu, 17 Jul 2025 14:11:31 +0000 (GMT)
Received: from [9.79.196.226] (unknown [9.79.196.226])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Jul 2025 14:11:31 +0000 (GMT)
Message-ID: <d55c37f0-d21c-48e8-9856-1e3d08d6cde4@linux.ibm.com>
Date: Thu, 17 Jul 2025 19:41:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
 <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora>
 <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
 <aHg9oRFYjSsNvY0_@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHg9oRFYjSsNvY0_@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HNubdncCJK92KiBHg-2See0O0hcNe532
X-Proofpoint-GUID: HNubdncCJK92KiBHg-2See0O0hcNe532
X-Authority-Analysis: v=2.4 cv=d/v1yQjE c=1 sm=1 tr=0 ts=68790498 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=LDydKeUwiwxcH82PBXUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMSBTYWx0ZWRfXxjz978I3JOP7 yLtS9cocvb1unMW8J2go0OOb8HJ2x4o3F9XUX888AsHezDiDtCT7j+a/7Wk3GvtKfLxv7CGHXg2 4K7crGJR32h/SYwMDf3UEqd19i/kqUqz+a7L68eFb+vNv//OeXdZqxkpjwOeOmg1AdDDsqUjIBb
 Ay0VvEhF0A+DQbFGxfoXLlXlTaaJ7waEskUTFlcXW3FGWdoAqajhoplOB5njgxvpKbUDoBM0tu0 +q8MrKIttSwG+LcdgWgBzdn3ygw5pYDxQNe5+1fINiIzy53pDKBfA1PNuVdwPaZyWnndNXVDU1Y kR/bZQEBnjuO6ctSz+446eFhEDFa5FkQDrJP8v6BXMnL6rh71SPrpmXNTPQI0KghomErIae+LO9
 ext2E12Lku8lTbXUfzM7h4hd4udS/57hhhrI6I+f1+53+3yMYmrggs92IkaYbqP/68/4ZaiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170121



On 7/17/25 5:32 AM, Ming Lei wrote:
> On Thu, Jul 17, 2025 at 12:54:31AM +0530, Nilay Shroff wrote:
>>
>>
>> On 7/16/25 4:10 PM, Ming Lei wrote:
>>> On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/07/16 9:54, Jens Axboe 写道:
>>>>> unreferenced object 0xffff8882e7fbb000 (size 2048):
>>>>>    comm "check", pid 10460, jiffies 4324980514
>>>>>    hex dump (first 32 bytes):
>>>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>    backtrace (crc c47e6a37):
>>>>>      __kvmalloc_node_noprof+0x55d/0x7a0
>>>>>      sbitmap_init_node+0x15a/0x6a0
>>>>>      kyber_init_hctx+0x316/0xb90
>>>>>      blk_mq_init_sched+0x416/0x580
>>>>>      elevator_switch+0x18b/0x630
>>>>>      elv_update_nr_hw_queues+0x219/0x2c0
>>>>>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>>>>>      blk_mq_update_nr_hw_queues+0x3a/0x60
>>>>>      find_fallback+0x510/0x540 [nbd]
>>>>
>>>> This is werid, and I check the code that it's impossible
>>>> blk_mq_update_nr_hw_queues() can be called from find_fallback().
>>>
>>> Yes.
>>>
>>>> Does kmemleak show wrong backtrace?
>>>
>>> I tried to run blktests block/005 over nbd, but can't reproduce this
>>> kmemleak report after setting up the detector.
>>
>> I have analyzed this bug and found the root cause:
>>
>> The issue arises while we run nr_hw_queue update,  Specifically, we first
>> reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and 
>> then later invoke elevator_switch() (assuming q->elevator is not NULL). 
>> The elevator switch code would first exit old elevator (elevator_exit)
>> and then switch to new elevator. The elevator_exit loops through
>> each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
>> which releases resources allocated during ->init_hctx().
>>
>> This memleak manifests when we reduce the num of h/w queues - for example,
>> when the initial update sets the number of queues to X, and a later update
>> reduces it to Y, where Y < X. In this case, we'd loose the access to old 
>> hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
>> would have already released the old hctxs. As we don't now have any reference
>> left to the old hctxs, we don't have any way to free the scheduler resources
>> (which are allocate in ->init_hctx()) and kmemleak complains about it.
>>
>> Regarding reproduction, I was also not able to recreate it using block/005
>> but then I wrote a script using null-blk driver which updates nr_hw_queue
>> from X to Y (where Y < X) and I encountered this memleak. So this is not
>> an issue with nbd driver.
>>
>> I've implemented a potential fix for the above issue and I'm unit 
>> testing it now. I will post a formal patch in some time.
> 
> Great!
> 
> Looks it is introduced in commit 596dce110b7d ("block: simplify elevator reattachment
> for updating nr_hw_queues"), but easy to cause panic with that patchset.
> 
Yeah correct.

> One simple fix is to restore to original two-stage elevator switch, meantime saving
> elevator name in xarray for not adding boilerplate code back.

Agreed, I did implement the same and the fix is on its way...

Thanks,
--Nilay

