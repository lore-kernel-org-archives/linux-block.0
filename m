Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B78288505
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693898; cv=none; b=g//qeKIF7xd0nxn2rQTeVqmINxd+Pwb7nhnFOEcyKLLerMbbHd4LkcBVi5H43bkOYv2IfR1301JqoXyMHZcuyh9kwzQZrywaWhBXAT31/qtXozp+jjiFYykZVaCAXyG9tGXRvw8E8zFxrM4Hu6LdFsmYfvWlY6laN7HK00A7Y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693898; c=relaxed/simple;
	bh=6p66Tfl82wnAFB/0bFI7/jAL2DyRiuijr2C8ZUbgaWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7NzN6KjJSZQn80snTCz9i5/7klT+nayw1fFw2KbPRy48tnGX0xhhzMh8OKa0bMxlLKnSflOiq0cdziMkNrAiH0Zao1TTP6ZHlAO/2uwav6HHDgGwc0HuIsFpwuAe0PYEnHscLUOwjWTrH9z85iuUe9OYjq56IyR/G2okrCA16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bVreRY/8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bVreRY/8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GIJpZm019378;
	Wed, 16 Jul 2025 19:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=anD4lj
	aMLixGFctv77EcnuBcphBezbVCH0xu7Ga0+bA=; b=bVreRY/8zcosZdV/LyFgRV
	B9HN7dQmEmfa4t4bWI5PbTgovIpVn8XB/AWaAago2CKV4FxCz/jeo965V64H2GKQ
	2hVOdNbF8Ye9u93mo5H7QcLgA7/qI+9Lj6SyENEVYVjnbzlvloJxio9pckKyyx+Y
	bUU7t1eO7M30xQ2H7gl801o7dfnqXWOl7GXPeWFpukaKE+IYA4xV5wBnoP3oy3Kh
	MISwSEmiudErUre2O00DCE043+jPMs/z7u24RlmH12cqteMCYOLEV390KeNjUbK4
	pf695U6s7qDV5GbSB2W6eLNFifcqy+3QZRtxQw5NKUnjIFyLh2b/C1ydbNwaDklQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh9009th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:24:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFvou3000890;
	Wed, 16 Jul 2025 19:24:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48m8p9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:24:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GJObaD30016242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:24:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C17558054;
	Wed, 16 Jul 2025 19:24:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E171C58055;
	Wed, 16 Jul 2025 19:24:33 +0000 (GMT)
Received: from [9.43.114.106] (unknown [9.43.114.106])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 19:24:33 +0000 (GMT)
Message-ID: <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
Date: Thu, 17 Jul 2025 00:54:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
 <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHeBiu9pHZwO95vW@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0FBZEvnGRFwY2_0TnwM2kleEKXeN3gXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3NCBTYWx0ZWRfX9BX/gO6cuQwc wrUe7Y0hmtwbxq4ipU0Pg2A0+grmtyOCZTAW3MarIDuLsFsoyAoNX9xnPA2dHwIjjSsymv0dKuL NXtNecARkGH+vqOXCsMTpzU5xq5YO2Sf05rK64JzsLfKdrd/s7eyAV7Q2yZpO4xPNBjuYwXdU5e
 aKt0VBYCjACKfCzek7fl1omp8Wq0uL/vPE/jL9CtKz02cpPqVfuQ7Xa0kVR7K4bOQbX/kPdozpH 5zpuK4CwK09flQwRJ17lgrzY6yLDztODn2tqW3DT9SaDDtI0bBCpkONXofORCItrFO2wTBtM6IJ a6aEIE+1N2AiCm/+xsPANXCIRtI+95ceLETTJEnekEJ7RKiXGaq7/hZr6f/fUvdIDFncFhaIUCe
 +8bsfeJXkQ57PD+A476C5tsSn035GwWUwY+IUSb4qnio6QV3PvPJosYrkby+v8359VPsOm08
X-Proofpoint-GUID: 0FBZEvnGRFwY2_0TnwM2kleEKXeN3gXZ
X-Authority-Analysis: v=2.4 cv=C43pyRP+ c=1 sm=1 tr=0 ts=6877fc77 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=nPapJkxQ9MEoTjynnZsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160174



On 7/16/25 4:10 PM, Ming Lei wrote:
> On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/07/16 9:54, Jens Axboe 写道:
>>> unreferenced object 0xffff8882e7fbb000 (size 2048):
>>>    comm "check", pid 10460, jiffies 4324980514
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>    backtrace (crc c47e6a37):
>>>      __kvmalloc_node_noprof+0x55d/0x7a0
>>>      sbitmap_init_node+0x15a/0x6a0
>>>      kyber_init_hctx+0x316/0xb90
>>>      blk_mq_init_sched+0x416/0x580
>>>      elevator_switch+0x18b/0x630
>>>      elv_update_nr_hw_queues+0x219/0x2c0
>>>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>>>      blk_mq_update_nr_hw_queues+0x3a/0x60
>>>      find_fallback+0x510/0x540 [nbd]
>>
>> This is werid, and I check the code that it's impossible
>> blk_mq_update_nr_hw_queues() can be called from find_fallback().
> 
> Yes.
> 
>> Does kmemleak show wrong backtrace?
> 
> I tried to run blktests block/005 over nbd, but can't reproduce this
> kmemleak report after setting up the detector.

I have analyzed this bug and found the root cause:

The issue arises while we run nr_hw_queue update,  Specifically, we first
reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and 
then later invoke elevator_switch() (assuming q->elevator is not NULL). 
The elevator switch code would first exit old elevator (elevator_exit)
and then switch to new elevator. The elevator_exit loops through
each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
which releases resources allocated during ->init_hctx().

This memleak manifests when we reduce the num of h/w queues - for example,
when the initial update sets the number of queues to X, and a later update
reduces it to Y, where Y < X. In this case, we'd loose the access to old 
hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
would have already released the old hctxs. As we don't now have any reference
left to the old hctxs, we don't have any way to free the scheduler resources
(which are allocate in ->init_hctx()) and kmemleak complains about it.

Regarding reproduction, I was also not able to recreate it using block/005
but then I wrote a script using null-blk driver which updates nr_hw_queue
from X to Y (where Y < X) and I encountered this memleak. So this is not
an issue with nbd driver.

I've implemented a potential fix for the above issue and I'm unit 
testing it now. I will post a formal patch in some time.

Thanks,
--Nilay

