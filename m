Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AFA1A5B8B
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586771; cv=none; b=Jlu6uI5+9ltsJrillEsGtIZInJ6PHXTJ8z0juxmPsCbe1vUTgeiqQCf9SZVWUmLYKip9tkG0mO3sJF3XMndEqEVJFO9Ld5kfJBpzaYLRrrnJ6JM0qMFgzN+o7qOuT7QwaTDtHTtCkrClGBMZgtmqTC5q+ndfWBLB3m0ooDIL4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586771; c=relaxed/simple;
	bh=Q3/OBl6KM5q7UecaeO1L/Ole196Fr5DMlB1FDIGdaX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUOQBhr7FjP/aW2Ozo2onYxv/cuYdIQrN4YeWVOZoBYgWKF+8Fia/p1ra+gAgRUGZsWovSSnGoienw7KHXkH12HD1HXasVRtdtt5rwWrc+RBcYsb5SJJWM7vqG9h+LpAuwqOlvRg9mPPSR027ZPVU2+mDCwcF3oFyEsAU7J7FTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RizJj9CJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RizJj9CJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RBnClX023535;
	Mon, 27 Oct 2025 17:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lOSsHZ
	YW0YE2HA65APEdLXnIJIYhMVhZ0qSnwI+quIY=; b=RizJj9CJDr3SCMRLmjIUSU
	DuJ+SkjJ7J7541jupw3ULc/+y4UyKHBMhyc+6XRAXiV50HI3cb54aZn5xBktmlRc
	y5NsAlTw0RvBqnGCqTYkg3BqxX2Eggw9hLWbtcvVUT83pWINcOGxqJBTmMttDRMF
	Q8yzRfKoQYVQmkunXi9oH2XEfZy7WHbPizbmbAyJfdWBnVefK1xaHD/4eH2TtMxE
	XjxXugQA8pxRA5PDUpOiEHq0mjKQCDRxu8ubvYbO5vIG1qRvMzfp+I+VQLJORj9D
	jH1N8bQpTzPUjBp5YXCXXhwDwmKynoxIzGpH4ZdrCHY24mqhn9G+pH56AKoL6x1w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p71yyma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:38:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFvGwA006852;
	Mon, 27 Oct 2025 17:38:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk0xh1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 17:38:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RHcIL032178882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:38:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F4558052;
	Mon, 27 Oct 2025 17:38:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 994D258056;
	Mon, 27 Oct 2025 17:38:15 +0000 (GMT)
Received: from [9.61.186.32] (unknown [9.61.186.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 17:38:15 +0000 (GMT)
Message-ID: <29e11529-aa37-47e1-a5c4-20fa100ae6cc@linux.ibm.com>
Date: Mon, 27 Oct 2025 23:08:13 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: introduce alloc_sched_data and free_sched_data
 elevator methods
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
        axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
        gjoyce@ibm.com
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-3-nilay@linux.ibm.com> <aPhgAMxgG2q0DKcv@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aPhgAMxgG2q0DKcv@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QqCOeGq5SstesrIMbAOOCTF16A9731yU
X-Proofpoint-ORIG-GUID: QqCOeGq5SstesrIMbAOOCTF16A9731yU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXxO0aTTHoaybm
 I5V24x2/MS2QE7rbU39SMcCPlWoOyyvV6rO/mHv4p0D3/4npb3AvJkj83lb+rprexWv1L2s925I
 jAG9YAFlwNgG/q6nQghxhXLuxJ3WoMj4j7uspdC8sOSmb8i2GtpvS8q1h64GkyAD8xkchMBrAd5
 nwaW+B5tsVlTzMXUXZicSw/ITRj7zHpnbuWTakzj27pTs2iDz8dbx9li8mz+ZNSWPX+Zlfs36In
 0defeZo8miZnja0FbJKxE6potAxCJQbylOVLbUOW+I2eLzkPDB4y+vVnBx2OZboE5srpgSBzzlT
 9/G3ZsKesm5vBpl0IVbzFdtDEnA6lMjRccyQk8lrad3+F+DjWzlA480KSaDQ9SZyt7Sx1YpumDP
 GsBIxdbdb/+IKlwQ7Tum1qXbiuIQSA==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=68ffae0b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lGi17nrTRAu6aISeRfYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

Hi Ming,

On 10/22/25 10:09 AM, Ming Lei wrote:
> On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
>> The recent lockdep splat [1] highlights a potential deadlock risk
>> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
>> mutex. The trace shows that the issue occurs when the Kyber scheduler
>> allocates dynamic memory for its elevator data during initialization.
>>
>> To address this, introduce two new elevator operation callbacks:
>> ->alloc_sched_data and ->free_sched_data.
> 
> This way looks good.
> 
>>
>> When an elevator implements these methods, they are invoked during
>> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
>> This allows safe allocation and deallocation of per-elevator data
> 
> This per-elevator data should be very similar with `struct elevator_tags`
> from block layer viewpoint: both have same lifetime, and follow same
> allocation constraint(per-cpu lock).
> 
> Can we abstract elevator data structure to cover both? Then I guess the
> code should be more readable & maintainable, what do you think of this way?
> 
> One easiest way could be to add 'void *data' into `struct elevator_tags`,
> just the naming of `elevator_tags` is not generic enough, but might not
> a big deal.
> 
I realized that struct elevator_tags is already a member of struct elevator_queue,
and we also have a separate void *elevator_data member within the same structure.

So, adding void *data directly into struct elevator_tags may not be ideal, as it
would mix two logically distinct resources under a misleading name. Instead, we
can abstract both — void *elevator_data and struct elevator_tags — into a new
structure named struct elevator_resources. For instance:

struct elevator_resources {
    void *data;
    struct elevator_tags *et;
};

struct elv_change_ctx {
	const char *name;
	bool no_uevent;
	struct elevator_queue *old;
	struct elevator_queue *new;
	struct elevator_type *type;
	struct elevator_resources res;
};

I've just sent out PATCHv3 with the above change. Please review and let me know
if this approach looks good to you.

Thanks,
--Nilay 

