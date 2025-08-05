Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13C238C16
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396089; cv=none; b=kTJtgQUxAJKKnzzBiNaT/DHxobNWpJf+u9/RC6ioTX6Lz0ZEyUjdb3Jzkida9cK0rriuCEeM7AsWHJWfvcvoi/OHEmv5pcQv4Y89dxLSbOdcpzhLGF84NEKwiDJdl6pZBqGrI6iPjEzo7Jurv0+3Y0UW0tgiPmo1BLBDYr0+jfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396089; c=relaxed/simple;
	bh=GckglF49g73Nv2oMIy7KqH/4K/XN3CK5L+F/UQgxrQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctR6kHAs+kWc9+uMmqz5DepzBNQPei4j8y4gjZXnqRBPTllZUXu0NbpXIPo5YVHv3auyyzWY0S1DoxAAlkmkQCJ6VJTJYSfa/SFu8jg0GhsrVlc5kHH7+Hh/3jf+m3ittKTd6cFmcRfEVsnZtHl7xvYUDIjNqzRe18ITu18LqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AbUKGAlP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AbUKGAlP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575ABGki009060;
	Tue, 5 Aug 2025 12:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yoUXpQ
	ffJ6+7tGP05gvR515DdOBvA5fjXvDpWmYSEwg=; b=AbUKGAlPEaZOjvDx2HwPOF
	kmwgyXadTFzmYv4PEMJ+XflIu6NwyKaCO/TFwGu85Q1GCusmDjT+Ip+Jx38YExft
	NasxRh5w6RJKzwtC+Zzt3CyQ1SvbnL/VdLjNhB8MNoJtjxc4ujZpW8YhNKFlcERr
	1nKFqHlbD1EYI1axXLgXPhdnTm6ZeY+He8wPCsI08IINxLGDBN/09bSf2v4cSXDq
	IwEIFwM6xTBacfJ0jp632802F349gs9T/7YDHQNR2leHsp44DM0Vz3BAMagQMDBi
	1Gi6DfoKZ2xYe6SvhOHC9gLWhDdJ1vpPWrYLZBEInKEmDu6V7ZuU4oAXIqbqB8Dg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t6nw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:14:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5759nugr001596;
	Tue, 5 Aug 2025 12:14:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7kt4s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:14:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575CEKJU32965230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 12:14:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A8335805B;
	Tue,  5 Aug 2025 12:14:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6588B58058;
	Tue,  5 Aug 2025 12:14:16 +0000 (GMT)
Received: from [9.43.82.116] (unknown [9.43.82.116])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 12:14:15 +0000 (GMT)
Message-ID: <ddb67b40-f8f6-4a81-9ee7-fb9b02f45463@linux.ibm.com>
Date: Tue, 5 Aug 2025 17:44:14 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, kch@nvidia.com, shinichiro.kawasaki@wdc.com, hch@lst.de,
        ming.lei@redhat.com, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <7102df92-1326-dbe7-d0cc-95bd2e44e9ad@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7102df92-1326-dbe7-d0cc-95bd2e44e9ad@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4NiBTYWx0ZWRfX/iloCoUR6Lxn
 r8IiEKdHzIQIgCak3DlicCFwFiIadQKiFGRkE52HmvcoY093H4/L91da7vbVPJHklmnciPHPgFN
 q1AzeHH8BiZRg1fLN5kXQqWqPsNa7wkDhdIcFkVXSDjC2keqhGe66fJA5UJE6AyT5uh2Fe+idlW
 i30tDpIS+I6LISDyOvBdoV0FyKoEx2jqliXHkd4pw4vwOx8Ub87Vc8VTulc9KEc4Uc8yUVIgnzD
 LJ68CG8F/RehFlK+7vuBom/Mov0Ecco5uFFLAB1t57jZjG0QvxF7wv55owN5Lbn/1xVS9S6qf/+
 YR/K7/+f/NLEujyORwnGFNrlIRqPD+K37yR+XLUYmBgxZAyIWyiVWH8AyRh0b+wcKoGlUCXV5YZ
 D9mp45ABWwGA/EoJKbZZspJwsqmGaoOHoTr1/Frv0ucQYF1A7lGxxP/ixVj7rFGx02HIH2Za
X-Proofpoint-GUID: lS1sicqfWhGsRn6TzEuVEUbPnZAZdh-6
X-Proofpoint-ORIG-GUID: lS1sicqfWhGsRn6TzEuVEUbPnZAZdh-6
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=6891f59e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=RzLgHJC9hBVzM7MWX1UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050086



On 8/5/25 2:58 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/04 20:21, Nilay Shroff 写道:
>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>> is made to eliminate a potential deadlock introduced by the use of static
>> keys in the blk-rq-qos infrastructure, as reported by lockdep during
>> blktests block/005[1].
>>
>> The original static key approach was introduced to avoid unnecessary
>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>> blk-iolatency) is configured. While efficient, enabling a static key at
>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
>> becomes problematic if the queue is already frozen — causing a reverse
>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>> a potential deadlock.
> 
> Take a look at the report, the static key is from:
> 
> elevator_change_done
>  wbt_init
> 
> And looks like the queue is not frozen in this context, am I missing
> something?
We freeze queue from rq_qos_add() before we increment the static key.

> 
> However, wbt_init() from queue_wb_lat_store() is indeed under
> blk_mq_freeze_queue(), I understand the deadlock here, however, I'm
> still confused about the report.
> 
If you're following the report then you should notice that the thread#0
is blocked on cpu_hotplug_lock after freezing the queue or in another 
words after it acquired ->freeze_lock (as mentioned above we do freeze 
queue in rq_qos_add() first and then increment the static key). Then 
thread#1 blocks on ->fs_reclaim (after it acquired the cpu_hotplug_lock). 
And the last thread#3 in this report, waits for the queue to be unfrozen
(the queue has been frozen by thread #1). So this creates a cpu_hotplug_lock
dependency on ->freeze_lock. Hope this helps clarify your doubt.

> And for the deadlock, looks like blk-iocost and blk-iolatency, that
> rq_qos_add is called from cgroupfs path, where queue is not freezed,

We have following code paths (including blk-iocost) from where we invoke
rq_qos_xxx() APIs with queue already frozen:

ioc_qos_write()
 -> blkg_conf_open_bdev_frozen() => freezes queue
 -> blk_iocost_init()
   -> rq_qos_add()  => again freezes queue 
    -> static_branch_inc()  => acquires cpu_hotplug_lock

queue_wb_lat_store()  => freezes queue
 -> wbt_init()
  -> rq_qos_add()  => again freezes queue 
    -> static_branch_inc  => acquires cpu_hotplug_lock

__del_gendisk()  => freezes queue 
  -> rq_qos_exit()   
    -> static_branch_dec() => acquires cpu_hotplug_lock

ioc_qos_write()
 -> blkg_conf_open_bdev_frozen() => freezes queue
 -> blk_iocost_init()
  -> rq_qos_del() 

We have to ideally decrement the static key in re_qos_del() but
that was missed. So the second patch in the series handles this 
case, albeit using atomic bitops.

> is it better to fix it from wbt, by calling rq_qos_add() first and
> set rwb->enable_state to WBT_STATE_OFF_DEFAULT in wbt_init(), later
> change this to WBT_STATE_ON_DEFAULT while queue is freezed.
> 
Hmm, as shown above other than wbt_init, we do have multiple code
paths from where we call rq_qos_xxx() APIs. So it's not the 
only wbt path which we need to handle.

Thanks,
--Nilay

