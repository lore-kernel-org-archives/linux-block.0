Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECF35CBC3
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825929; cv=none; b=jGdi/9CrCnRC6iBuknuEoO71zLLgaagxvQKHrdo6EJkZpadiaNbOVgBvGrbvvkuyYUSV+1HwoeFcZKgxDKduvTIEBT5Jvx6TdLovIajahK6JksPH2oSbZJ5L1OpLTHcTycSWxVtLrRsLKLeTmN4VG6Wp3GnCdtJ0rXsfmTmgQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825929; c=relaxed/simple;
	bh=Y6e/eCfvQGBEEkdB9zIuugcIE4hbVc77QyCSGQIK8k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI4fhpbNEwCiN8R5ii56npTGYAYrov6TcrN/FvD2diedpJmMdL3iTAqsC1g9Dj3DRUb22lAlqjF8o4AIrRIAYluYJyC0k/8WmHNZH+cG/N7hgfLJ41tn3tqOV/AP12BevgYREOztBuZo9qr30KQciDewehTUb9O1ImWLN+SzjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fq3ISk47; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DIwGu2Pi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fq3ISk47";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DIwGu2Pi"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5UeEf3795545
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 06:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TXJH+kCot1mDQ/XXpZpurKH5KBj+DptFtIRpapZ8BN0=; b=Fq3ISk47skZQpqAU
	BJ7vLdInZuI2jcvmsKlica7bYhn9HtE8EsP9H9ktrCqYiCakd2zeozzXnQHbuwme
	Wno8f4XH8A+dh7U5/zAWkrxiY4xLCqX2epwfe0KUEk1TpiR4IwqdyDeCHjURKkkr
	c1HXC2MGNpeHqAH9hNKDdn+thTccRQeaBazn5gCwMNsH1Uwnu02MzpyVaxFzTvgW
	cKOVHiqdwvf8mFHGlrPNNE8JGYppzzzs9dnYFAG8NmBFKWTd/l4NzWmaKTPqRmtm
	E++0B+b6wva8rcKmnJ7SJtOgEGZcAhaziww7IPfc8rZHLnfP0sqsAT5CvMEEVCZ3
	CZexbw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ssudj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 06:18:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso94767005ad.3
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778825925; x=1779430725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXJH+kCot1mDQ/XXpZpurKH5KBj+DptFtIRpapZ8BN0=;
        b=DIwGu2Pic4U0OaC4EepPej276hyj0+8xLzC7GM0lpoVttCijiYZ2L4PO9kj6eC5VI4
         V49u7IK99Knxx8pyRCcDjdyRyGgICcqq7l++WtRsnjWg9mmY2ZfIIhfb5ZdlmXcXnYAR
         lH8W6eAh9uAnu2hmmoymWE3+bZRgggRzo3EUSZbk0jFdd82nHnLi0bkNb+OCjT/fO4PZ
         /ZeRL88j8OGPY49aRcK7Kue/eRHDghTcPwwdnZalkGtKuZriuK4vAupYxZKVZwM9aimr
         7Lec6ZS6loBxv1/O8mo1btE/WtSZxHY6WxCOwhP7AwgjZfes0+L1yxWSsNKO3HwdFsQ8
         606w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778825925; x=1779430725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXJH+kCot1mDQ/XXpZpurKH5KBj+DptFtIRpapZ8BN0=;
        b=gfiyR8Ot4CBGQDM9oYSNhmnWUv5EAL723SUXLJfgdZYeSOWZVgeE86ZWHXYPy8Ff0G
         M+hVy3HtpaMEk8qqvnTievDuai6Btcv0gOpKirv72uAWzLdvJHdfjbvGzMaTZ2iBnTGK
         rKbDjo6GlHCAgX2/iAAFrYeGSuF5lQgqHGs+rQwp/SLwLKdtQLw3rsjFkI+vXd7OUDFE
         oS6kDm2EkVYlXQk4Gm9OK9H9awZVSX2LuXewVBfpG7RQYjeZ9SvsoGBbx+p757QBWLBh
         M2X5Ov2S2D1yk4/dzNWPIOZKMKDRmIiHCCczWM7ugXz/ilcql+S9BfvKbljTHmPC3dD6
         11vA==
X-Forwarded-Encrypted: i=1; AFNElJ/DRGvfi/h9pvQKqur67fI7PXtJ9DHyWG71H85nj13Sr94SLnMR0E2zc8hcvFmpz+3+qjp0D8z3kY3RNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUuFQ3a4sZK+Fax19DNKUWMOwVupLVISCgjhsfSG2aFBZ8YnM
	FI8DD1rSUT8/UEMsBrGnjX7r6DHq1rH6CcKibkrh1wCddoH/+kFin3r11T7+NurBAKlMqLs74QG
	lkM4Dq4tsoK2WZi5XqD8Jw1gMBFAXT4SpUrAJJFnkqDRG5NcD37AthTHu+ldT3ev3YQ==
X-Gm-Gg: Acq92OEb1mGSb5Un/7jf62OmfPVuYucASb4KXaMdRf2qP1nquOb/+5AlOgYMlxzZXXu
	yTsEOqQA6QqqiRjre4zCwcN/FLJNw8IzKBNP/tgWPDfs5V4bJKqWyZqD4DSmnWu/lKbJlwJykB/
	B42OkuV4CLHKUriYz4CQ8nWwARjsqisS4Q0gPXMhKT38kga+laKPvkYGXzX8e93EhUh846s5RtS
	TBTJiXTegdEn00Zst9XTC8DrYpczdAuRkMbSgsEduftBqhXXjnHWZubqkcy5k1aNkXhHidCRLrX
	8M2l03XlayKhFXQno7GQoJwWJ0PhNvzeim0RlIHBgZvu5Cz3TYkz5/P+HEDAWNmLlBaA6bSxr8Y
	NOoZVihIrMp4CXaNC223Z1I1byJB4TvtnxBLi1gUgTc8yhW6d5d0EKIlSdYey2djeJc5ulbcgeA
	YHs+QhERJC5kKT9YA=
X-Received: by 2002:a17:903:3c4c:b0:2bd:83e1:5613 with SMTP id d9443c01a7336-2bd83e157a2mr23657725ad.20.1778825925321;
        Thu, 14 May 2026 23:18:45 -0700 (PDT)
X-Received: by 2002:a17:903:3c4c:b0:2bd:83e1:5613 with SMTP id d9443c01a7336-2bd83e157a2mr23657415ad.20.1778825924781;
        Thu, 14 May 2026 23:18:44 -0700 (PDT)
Received: from [10.249.31.163] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600b4sm48730865ad.28.2026.05.14.23.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 23:18:44 -0700 (PDT)
Message-ID: <6611f3ea-b70f-45c7-9332-235647643a49@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:18:40 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: flush plug in schedule_preempt_disabled() to
 prevent deadlock
To: Ming Lei <tom.leiming@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michael Wu <michael@allwinnertech.com>,
        Thomas Gleixner <tglx@kernel.org>
References: <20260512085939.1107372-1-tom.leiming@gmail.com>
 <20260512120431.GC1889694@noisy.programming.kicks-ass.net>
 <20260512124021.GA2214256@noisy.programming.kicks-ass.net>
 <agNLCof3zO5-QAo9@fedora> <agNgdIMacaG-41vj@slm.duckdns.org>
 <agPcx_vuO3ZYbAy1@fedora>
 <20260513073039.GG1889694@noisy.programming.kicks-ass.net>
 <agQxg-pBzF8rp1Ii@fedora>
Content-Language: en-US
From: Xiaosen <xiaosen.he@oss.qualcomm.com>
In-Reply-To: <agQxg-pBzF8rp1Ii@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA2MCBTYWx0ZWRfXzvZbJoL7TmKi
 3t8W7lsxjxYX5fCvXsLi0sI4B3JceBWIHp6IORVX3bs1o36nHAuKxOt6H9RSP2bSk8Ko/W1LVmy
 S2rf/X7sbLRTH2o81OXohmN59ldmRIPqOzqqSxcZ9d2UqjDyVVfUycI+odBR9UpUL1PuhaecKUa
 UXHMqfSATWQdQeeKnrtQM8e3OgJFEWFEdtGG1R7lcOsZO3sZJfM1hBA+MoDwCGmWOkFozDBeXEe
 lHED7xlE3Qq71SBk1FRvrB1TT1ZRbBt4hVpNiBM6UIwe0N3m68qSdU3sms3tXQuFx5uvS3M+gLR
 OhneBbDJYQnmbT4eE0HpEidJAyQ2AXRcYRVcRQs7yTqAm95+LlLP4ABkTv8yohrcrBRnsUqn9cT
 dTb36JuFeApFmyT7ivJ15okCHL0J5+H8WMTQgFx7XrTINvmVYOzui+X1xNnTpt5qkhtIHBBOCiy
 cy58ZG6kmsIU1Ef+RPA==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a06bac6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=6Ujbnq6iAAAA:8 a=EUspDBNiAAAA:8
 a=srUJ046Ut8OOLMdfYg8A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=-sNzveBoo8RYOSiOai2t:22
X-Proofpoint-GUID: ZnHGHhf2AMrTl3deFsg5T1md81tNKFjx
X-Proofpoint-ORIG-GUID: ZnHGHhf2AMrTl3deFsg5T1md81tNKFjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150060

https://lore.kernel.org/lkml/20260427183848.698551-2-jstultz@google.com/
The above change can resolve the deadlock I reported before by setting
task's state to TASK_RUNNING before switching context.

There is the likely alternative fix below.
https://lore.kernel.org/lkml/20260512025635.2840817-1-jstultz@google.com/

Regards,
Xiaosen

On 5/13/2026 4:08 PM, Ming Lei wrote:
> On Wed, May 13, 2026 at 09:30:39AM +0200, Peter Zijlstra wrote:
>> On Wed, May 13, 2026 at 10:07:03AM +0800, Ming Lei wrote:
>>> On Tue, May 12, 2026 at 07:16:36AM -1000, Tejun Heo wrote:
>>>> Hello, Ming.
>>>>
>>>> On Tue, May 12, 2026 at 11:45:14PM +0800, Ming Lei wrote:
>>>>> On Tue, May 12, 2026 at 02:40:21PM +0200, Peter Zijlstra wrote:
>>>>>> On Tue, May 12, 2026 at 02:04:32PM +0200, Peter Zijlstra wrote:
>>>>>>> On Tue, May 12, 2026 at 04:59:39PM +0800, Ming Lei wrote:
>>>>>>>> On preemptible kernels, a deadlock can occur when a task with plugged IO
>>>>>>>> calls schedule_preempt_disabled():
>>>>>>>>
>>>>>>>>   schedule_preempt_disabled()
>>>>>>>>     sched_preempt_enable_no_resched()  // preemption now enabled
>>>>>>>>     schedule()                         // <-- preemption can happen here
>>>>>>>>       sched_submit_work()
>>>>>>>>         blk_flush_plug()
>>>>>>>>
>>>>>>>> After sched_preempt_enable_no_resched() re-enables preemption, the task
>>>>>>>> can be preempted (e.g., by a higher-priority RT task) before reaching
>>>>>>>> blk_flush_plug() in sched_submit_work(). Since the task's state is
>>>>>>>> already TASK_UNINTERRUPTIBLE (set by the mutex/rwsem slowpath caller),
>>>>>>>> requests in current->plug remain unflushed for an unbounded time.
>>>>>>>>
>>>>>>>> If another task depends on those plugged requests to make progress (e.g.,
>>>>>>>> to release a lock the sleeping task needs), a deadlock results:
>>>>>>>>
>>>>>>>>   - Task A (writeback worker): holds plugged IO, preempted before
>>>>>>>>     flushing, stuck on run queue behind higher-priority work
>>>>>>>>   - Task B: waiting for IO completion from Task A's plug, holds a lock
>>>>>>>>     that Task A needs to be woken up
>>>>
>>>> My memory is hazy around io_schedule but the above reads really weird to me.
>>>> A task, regardless of its current state stays on the runqueue when
>>>> preempted, so the condition is temporary. As soon as the preempted task can
>>>> get CPU, it should unwind the situation. That's not a deadlock. Is the
>>>> problem that there can be preemption-induced delay in flushing the plugs?
>>>
>>> IMO, preempting a `!TASK_RUNNING` task can be thought as effective sleep,
>>
>> No it cannot be. Preemption ignores task state.
> 
> Yeah, I get similar conclusion too with AI's assistance.
> 
> But both two reports show that the preempted task aren't switched back for
> long enough time, can you share any idea for Michael & Xiaosen to investigate
> further from scheduler side?
> 
> https://lore.kernel.org/linux-block/20260417082744.30124-1-michael@allwinnertech.com/
> 
> https://lore.kernel.org/linux-block/5660795d-87de-46f5-add4-7729a02225ef@oss.qualcomm.com/
> 
> 
> Thanks,
> Ming

