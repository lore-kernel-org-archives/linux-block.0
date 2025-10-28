Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604C220F21
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627092; cv=none; b=ZyDIde9PulP1xmXW2YIKyvKUmug98MsP03af9TkpS7xNuyK7b0vkTSoF8JgXdUEFScVHEYAaKzXW31LbDeehjmjICrROcFpr9xagxx3M5ctvPVENgRCWAI9YGu+4KAKpYjrdxco3NbQLi0vHjOpVpGIkAa5fF591w81og5wOuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627092; c=relaxed/simple;
	bh=yAcC7eqTwtAiecz5VeM664MAJayRuURxH9K60lD9+PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/XR2U9lEjoiV4zIMUF0YxbV+jhM3i8RWUw1fI4RJ5MOyChpHubMsbN5/KwT4zGuv5dOylaE9bvLcwfcCkwbf+Vr3mQQ3he+xLbcb+UvtR+PndpNo34lRBXfUDkITg4d9y3cxddJB+nhh6okS3iPU9yaoqRxS7ie697BiJNdEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzIkDii3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzIkDii3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S3KCkl020972;
	Tue, 28 Oct 2025 04:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wigA2y
	CjR/j0fnCFeoEgr9d1AItBnJGJYLSbre7x2QE=; b=pzIkDii3ep5UDio+1eps7X
	1e/TPGS402mobeb+7lAStRc8rKQV9eacAMc0PpqlDLSmWEJQSL/QE8/2qbr5lqpa
	2mNZGrAO63S7B+jYBH7YrOsQyj/+s0rXgtHjVJRkqnNzOvynaIg9Eiq5Dg8zi8tQ
	z57lM13c+NPfRRb/GIZy3lmiP/rPIrXkbc7q2o+4nSguYnVBrx0XiMrgQdpldHSG
	6x8R3WJq/YiGcJa+LXcQBkSbzZ9pBdQL1vS8NLpoXy5xwvjgI+PkMQOVoMzSL3J5
	xSt+ot0vQ82hxCo1xUwW5eSfB4SFpAMG5i/WPprnbx1Aq1MzQG8NGe6xDTJaZnAg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys211t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:51:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S4i1fu009379;
	Tue, 28 Oct 2025 04:51:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j0ujy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:51:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S4pHUt27853544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 04:51:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D7658067;
	Tue, 28 Oct 2025 04:51:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9C3A58052;
	Tue, 28 Oct 2025 04:51:14 +0000 (GMT)
Received: from [9.109.198.245] (unknown [9.109.198.245])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 04:51:14 +0000 (GMT)
Message-ID: <1448de6a-f86f-4d23-9e30-b1368e5cec57@linux.ibm.com>
Date: Tue, 28 Oct 2025 10:21:13 +0530
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
 <29e11529-aa37-47e1-a5c4-20fa100ae6cc@linux.ibm.com>
 <aQAt2rOO4dgkW10o@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aQAt2rOO4dgkW10o@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wM2EvabJu82kcJmPCZL8a7GhE_NNAKbc
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=69004bc6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hhZ8n0MlffzBx2DurcYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX3s+liPOGz80E
 O8lDwz94r/7RbJ90e0Z2QE/w8LSZ/WZDtZG9ezYlpt08n7QJl1DDWmQQ/YnavdP+o7upp6PMYar
 6iuv225LC4SUWnfr42lwOQppyA3Mb50Cyyea8Ah4v9dY1yAcshCYBCCCn1F9Qewr7WqIwW68wuJ
 Tfw6xaEsof0WlVgBRvZBCEmyzEuhS9lSbJbEHrUlG/Ct5POy/Vd4abJSyES2Q8iLtAoRPTcxhPl
 ul/aBUaaeSm5DPJht6EqqxXtjcTjfxMRkOC8UO8FcsNKSru+eyhVYT2YXIKZ0oU7NEf8cSfF31v
 uTDaTXXGLjd8rIiwiEDKS1YOrpGJjM8Nom6RXpFM+rLtw0ctADqJE8QzpsTvDlWzFfN0YIqK12A
 PF+o81GmQnhS8pyXOuO0rAwNN3PQjQ==
X-Proofpoint-GUID: wM2EvabJu82kcJmPCZL8a7GhE_NNAKbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010



On 10/28/25 8:13 AM, Ming Lei wrote:
> On Mon, Oct 27, 2025 at 11:08:13PM +0530, Nilay Shroff wrote:
>> Hi Ming,
>>
>> On 10/22/25 10:09 AM, Ming Lei wrote:
>>> On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
>>>> The recent lockdep splat [1] highlights a potential deadlock risk
>>>> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
>>>> mutex. The trace shows that the issue occurs when the Kyber scheduler
>>>> allocates dynamic memory for its elevator data during initialization.
>>>>
>>>> To address this, introduce two new elevator operation callbacks:
>>>> ->alloc_sched_data and ->free_sched_data.
>>>
>>> This way looks good.
>>>
>>>>
>>>> When an elevator implements these methods, they are invoked during
>>>> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
>>>> This allows safe allocation and deallocation of per-elevator data
>>>
>>> This per-elevator data should be very similar with `struct elevator_tags`
>>> from block layer viewpoint: both have same lifetime, and follow same
>>> allocation constraint(per-cpu lock).
>>>
>>> Can we abstract elevator data structure to cover both? Then I guess the
>>> code should be more readable & maintainable, what do you think of this way?
>>>
>>> One easiest way could be to add 'void *data' into `struct elevator_tags`,
>>> just the naming of `elevator_tags` is not generic enough, but might not
>>> a big deal.
>>>
>> I realized that struct elevator_tags is already a member of struct elevator_queue,
>> and we also have a separate void *elevator_data member within the same structure.
>>
>> So, adding void *data directly into struct elevator_tags may not be ideal, as it
>> would mix two logically distinct resources under a misleading name. Instead, we
>> can abstract both — void *elevator_data and struct elevator_tags — into a new
>> structure named struct elevator_resources. For instance:
>>
>> struct elevator_resources {
>>     void *data;
>>     struct elevator_tags *et;
>> };
>>
>> struct elv_change_ctx {
>> 	const char *name;
>> 	bool no_uevent;
>> 	struct elevator_queue *old;
>> 	struct elevator_queue *new;
>> 	struct elevator_type *type;
>> 	struct elevator_resources res;
>> };
>>
>> I've just sent out PATCHv3 with the above change. Please review and let me know
>> if this approach looks good to you.
> 
> It is fine to add `struct elevator_resources` for further abstraction, but
> you need to abstract related methods too, otherwise the patch 3 still becomes
> hard to follow: the existing blk_mq_free_sched_tags can be renamed to
> blk_mq_free_sched_resource first, then you can call blk_mq_free_sched_data()
> from blk_mq_free_sched_resource() inside only, instead of calling it
> following every blk_mq_free_sched_tags().
> 
> Same with blk_mq_alloc_sched_tags_batch()/blk_mq_free_sched_tags_batch(),
> you can make universal blk_mq_alloc_sched_res_batch/blk_mq_free_sched_res_batch()
> to cover both tags & schedule data, and it is easier to extend in future too.
> 
Okay that makes sense.. I will restructure code and prepare a new patchset.

Thanks,
--Nilay
