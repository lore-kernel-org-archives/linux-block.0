Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6DA246BB9
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765546856; cv=none; b=fmhuvcJ0KTYHGsjTT1O49IgEgyMnlljn1Yzioo8n0ulhoFjhBWtAaBvKUvQGfysYz2/rKCg49Usz78NateVDRO9lV8ysC+eA2CV0zu98MjP4COZWOD0GsQW+o0iP7DKcKTT7NVNbNiAyGdpAWoUiDnbaAgxZ9LONjBppOXyuGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765546856; c=relaxed/simple;
	bh=97VBkObzg+xwrWwNhzLuhDftLPF+DNnuOJuzlrZ18h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dv37qtT72MQNUh5Rdc14C6JQtLhNA3kA59hXD9S/N2lR4Suu9IzlKYDZpIcb8RdYA7ose33EK80G3jBsbSSovlm/h5L7b5fp8k41Mwz8+CCECkIa0OrkJo+2jeG383gcwRRRiH684AdYQBYc52aOQUQwSMTLvEBL6IHcJcqk4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n2Xdhl3j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n2Xdhl3j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCD0u7p031277;
	Fri, 12 Dec 2025 13:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KWMxK+
	u4t5liq+1PPvHRUU/2lwA1gIEbdsXQybpMFZw=; b=n2Xdhl3jI+BGoAAqH0oEff
	4QFSKDDXFn55eT2uMwEZmwEk51P7x5p95AORM4JTdb1hb9KF8JpsdKNYwwKIvExy
	z9w7T0UQ5D3cI8bpXWEbm3pdm7pLIM88XtISS+GXavCcUo8Ih8j+TgvqSW68QKXs
	O4soAqLzDCb+zGDC/Ge0NrDxHMPPH3jUOELU9vC1stj0r7JvibdaNK0qyEeUIMnc
	SHMOjpKB7y3LFvE9gisP9EkSELl4cgVlg5przXK0yPrVMyGgQB0e57bv1IAnwz1+
	ZJSyAnMtmGMoiAKSt0YH1Wpr+RCO6OzuI4R2yaIXUbfWwt2KIRi606Rl2JWvw6LA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cdj97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 13:40:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCAt9mX012907;
	Fri, 12 Dec 2025 13:40:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0akc2pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 13:40:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BCDeY7p46203196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 13:40:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16DED5805A;
	Fri, 12 Dec 2025 13:40:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126555805F;
	Fri, 12 Dec 2025 13:40:31 +0000 (GMT)
Received: from [9.111.55.66] (unknown [9.111.55.66])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Dec 2025 13:40:30 +0000 (GMT)
Message-ID: <2a0b6bc7-3118-4f3e-b390-003cb40b11da@linux.ibm.com>
Date: Fri, 12 Dec 2025 19:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix race between wbt_enable_default and IO
 submission
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai@fnnas.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Guangwu Zhang <guazhang@redhat.com>
References: <20251210091001.236296-1-ming.lei@redhat.com>
 <52b5f2a4-e5e1-4917-8620-490fde89cfe7@fnnas.com> <aTvIdnk3Pl-L-4s_@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aTvIdnk3Pl-L-4s_@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a6xm4jF2I0JGmY_Hzpqd_BEz9XTguNJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX9epj1mE4sxMD
 gPQ+oaqmS6ZORLYmOVN0MlXvRW9NS8lHyTicusxH80OecHfMnH3HjfluLO7umykvRpqf0gyradf
 DoIEuVywxSe3ycqVyNko+TKsLDUWT6yMw0CxsCg8RHrqyD+skZe97uzRNjaSjWXpw+iUxLPneLg
 b234gLznO2vBrp56nACiXZBJr0ybua7kviy7iSvSDp+Rw0S0A6eEmfrAMXIB2uPqGQxZl/f880k
 XX1kY3msn6ssqWmE9SavvGnn3ADTsP2VNyf785hsGNbde14ZhWsHqrftUgJIOpdK0bp0uBkAs4Q
 kA91dcU8yndSvkT8ydnTrPcPXkFwaYICBshxtC315vtozEpbA1d7bRvsNOV6m/v9/GmAbfSzqQw
 W+Wr0zqCJoSqB+9uHvugeVS499Jbyw==
X-Proofpoint-GUID: a6xm4jF2I0JGmY_Hzpqd_BEz9XTguNJ2
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693c1b54 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=pDO9CBGVjsimcxoKXZoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020



On 12/12/25 1:17 PM, Ming Lei wrote:
> On Fri, Dec 12, 2025 at 01:56:20PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/12/10 17:10, Ming Lei 写道:
>>> When wbt_enable_default() is moved out of queue freezing in elevator_change(),
>>> it can cause the wbt inflight counter to become negative (-1), leading to hung
>>> tasks in the writeback path. Tasks get stuck in wbt_wait() because the counter
>>> is in an inconsistent state.
>>>
>>> The issue occurs because wbt_enable_default() could race with IO submission,
>>> allowing the counter to be decremented before proper initialization. This manifests
>>> as:
>>>
>>>    rq_wait[0]:
>>>      inflight:             -1
>>>      has_waiters:        True
>>>
>>> And results in hung task warnings like:
>>>    task:kworker/u24:39 state:D stack:0 pid:14767
>>>    Call Trace:
>>>      rq_qos_wait+0xb4/0x150
>>>      wbt_wait+0xa9/0x100
>>>      __rq_qos_throttle+0x24/0x40
>>>      blk_mq_submit_bio+0x672/0x7b0
>>>      ...
>>>
>>> Fix this by:
>>>
>>> 1. Splitting wbt_enable_default() into:
>>>     - __wbt_enable_default(): Returns true if wbt_init() should be called
>>>     - wbt_enable_default(): Wrapper for existing callers (no init)
>>>     - wbt_init_enable_default(): New function that checks and inits WBT
>>>
>>> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
>>>     proper initialization during queue registration
>>>
>>> 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
>>>     disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then the
>>>     original lock warning can be avoided.
>>>
>>> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
>>>     code since it's no longer needed
>>>
>>> This ensures WBT is properly initialized before any IO can be submitted,
>>> preventing the counter from going negative.
>>>
>>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>>> Cc: Yu Kuai <yukuai3@huawei.com>
>>> Cc: Guangwu Zhang <guazhang@redhat.com>
>>> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>   block/bfq-iosched.c |  2 +-
>>>   block/blk-sysfs.c   |  2 +-
>>>   block/blk-wbt.c     | 20 ++++++++++++++++----
>>>   block/blk-wbt.h     |  5 +++++
>>>   block/elevator.c    |  4 ----
>>>   block/elevator.h    |  1 -
>>>   6 files changed, 23 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 4a8d3d96bfe4..6e54b1d3d8bc 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -7181,7 +7181,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>>>   
>>>   	blk_stat_disable_accounting(bfqd->queue);
>>>   	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
>>> -	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
>>> +	wbt_enable_default(bfqd->queue->disk);
>>>   
>>>   	kfree(bfqd);
>>>   }
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>> index 8684c57498cc..e0a70d26972b 100644
>>> --- a/block/blk-sysfs.c
>>> +++ b/block/blk-sysfs.c
>>> @@ -932,7 +932,7 @@ int blk_register_queue(struct gendisk *disk)
>>>   		elevator_set_default(q);
>>>   
>>>   	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
>>> -	wbt_enable_default(disk);
>>> +	wbt_init_enable_default(disk);
>>>   
>>>   	/* Now everything is ready and send out KOBJ_ADD uevent */
>>>   	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
>>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>>> index eb8037bae0bd..0974875f77bd 100644
>>> --- a/block/blk-wbt.c
>>> +++ b/block/blk-wbt.c
>>> @@ -699,7 +699,7 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
>>>   /*
>>>    * Enable wbt if defaults are configured that way
>>>    */
>>> -void wbt_enable_default(struct gendisk *disk)
>>> +static bool __wbt_enable_default(struct gendisk *disk)
>>>   {
>>>   	struct request_queue *q = disk->queue;
>>>   	struct rq_qos *rqos;
>>> @@ -716,19 +716,31 @@ void wbt_enable_default(struct gendisk *disk)
>>>   		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
>>>   			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
>>
>> Is this problem due to above state? Changing the state is not under queue frozen.
>> The commit message is not quite clear to me. If so, the changes looks good to me,
>> by setting the state with queue frozen.
> 
> Yes, rwb_enabled() checks the state, which can be update exactly between wbt_wait()
> (rq_qos_throttle()) and wbt_track()(rq_qos_track), then the inflight counter will
> become negative.
> 
I think above reasoning should be added in the commit message so
that makes it easy to understand the proposed change, otherwise
changes looks good to me.

Thanks,
--Nilay
 

