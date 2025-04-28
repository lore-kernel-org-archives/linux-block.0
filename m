Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8927B506
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857039; cv=none; b=DzBeCZXAWpkEYk4+akRsRFkQVobMbE/v2Km5oe1/es3DoCUJFu5QAUhoF1SdNOaEnLNi5ObT3Z1ye2+Fbjp9ck+TzfH7DLV1fZEGFW0sy7CrZuv0sedgVV99Wz8obYrHZdTQmJDpQiNZOt600EzO2VsRy7H44I3Mk+Dgn4jg6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857039; c=relaxed/simple;
	bh=2XidiJqkiZJYZB2lrSjTmCOOCY2qxF1ATVgxgtmmRtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OE9qBZwz1QVbyg9I58sB+ZfN5TMrXIUVtD9tS4LkpxX9h/AHk6thKbMkmNGNWLjeotvG/xEXOCUqE15d10ojbCbUSn/kTB1J906U52F2tyIzrJ7je0sAOjMNLyblRny65oXX6Mz4QfVxTakHig5kRY0lD8TCzldUHIVz+KL9Wgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HToHyTrm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HToHyTrm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8vRC5011968;
	Mon, 28 Apr 2025 16:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YQMI+T
	zrBkMUA3oxWIUvqqCPAVtLkvwyI7LqsIYMyCA=; b=HToHyTrmTGiOWvoVQqwfYV
	hsCU6iGv8hsT7OUCJaXXA8GqppyudE0fETDZwuB9MTtHIP4ZaryVFh9vMTo48JOR
	GkYLumoeDfAIev5VmVdlzu7hXZ+X1EKOi4RJXPq2QDThLauphwGlw1E3CMezimCt
	iwilntDO0nYsBoveMt8OxoQy8RBDjpZB84yUsyHXGLoy22cA6/pDkbMD0/8TDxGp
	C2hsGL6ieOF1ueZa0GJQj9ngj9Tf/s2uW5Hqhco0IFXTPuPQB4LDnOv/OZBW0qs2
	0ujZxvLj4MLOc+kbR+hRfJNj+KHe87l9UL1uElMYVISK8v2vLchj8G4TlA4YYlbA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469v5kmamg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:17:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SF55ZT016122;
	Mon, 28 Apr 2025 16:17:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a707bm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 16:17:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SGH6RV33882744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 16:17:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8908C58051;
	Mon, 28 Apr 2025 16:17:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D44545805A;
	Mon, 28 Apr 2025 16:17:03 +0000 (GMT)
Received: from [9.43.89.161] (unknown [9.43.89.161])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 16:17:03 +0000 (GMT)
Message-ID: <ab875b11-9591-4034-bb11-ed8a35454a75@linux.ibm.com>
Date: Mon, 28 Apr 2025 21:47:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
 <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
 <aA2WIiHJprr_bmJ5@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aA2WIiHJprr_bmJ5@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YOSMb-FGSvTS3TDWagMwwn46nxavAGI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzMiBTYWx0ZWRfX68sjcF0X/vOz nICHKk3nGwClvYoTb3nZt73Q+/42xlnLUq+0MdPsys491MHYg54y4+tMBAHlgTn7KWXwgOSWUWL rVsF3I8rz3rytPJ0jCmGb6rjejx5JPG9U+7uyrN4lVu0jbZPv6UfJtrRMbwnFs7RCZEexkZUeTJ
 EUWM52pniPbE5rUHFS75tydp1ir4rot68SEFKl9lqAAa7iALVAiopYuxzkS2jQ9rO58qzxnxtQD 9237KwX/nZpWA3taBpHOVv9QJC4KpQXxHZ0m7o26fQmbbYGRTzWDo2YH1twJhIOR6Izr2J0Lm02 CAOXCxK673MyovtzzKXqgkFgO1b4Cexew+avu5lkarVpP44Q2lvvNK4+ikGUxD8bcvYNd1NJwmX
 SbMM4EHvOHrnNVEpZZfKrCmVf1KZinjfYCArauL02MMIzS0kzLw5IWZIIv6FVkoKTKzj4RQ+
X-Proofpoint-GUID: YOSMb-FGSvTS3TDWagMwwn46nxavAGI7
X-Authority-Analysis: v=2.4 cv=DvxW+H/+ c=1 sm=1 tr=0 ts=680faa04 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=20KFwNOVAAAA:8 a=zJtk1i2aUhdcUKMgbdYA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280132



On 4/27/25 7:57 AM, Ming Lei wrote:
> On Fri, Apr 25, 2025 at 06:18:33PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/24/25 8:51 PM, Ming Lei wrote:
>>> Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
>>> path, so it can't be done if updating `nr_hw_queues` is in-progress.
>>>
>>> Take same approach with not allowing add/del disk when updating
>>> nr_hw_queues is in-progress, by grabbing read lock of
>>> set->update_nr_hwq_sema.
>>>
>>> Take the nested variant for avoiding the following false positive
>>> splat[1], and this way is correct because:
>>>
>>> - the read lock in elv_iosched_store() is not overlapped with the read lock
>>> in adding/deleting disk:
>>>
>>> - kobject attribute is only available after the kobject is added and
>>> before it is deleted
>>>
>>>   -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
>>>   -> #3 (&q->limits_lock){+.+.}-{4:4}:
>>>   -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>>>   -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
>>>   -> #0 (kn->active#103){++++}-{0:0}:
>>>
>>> Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
>>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/elevator.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/block/elevator.c b/block/elevator.c
>>> index 4400eb8fe54f..56da6ab7691a 100644
>>> --- a/block/elevator.c
>>> +++ b/block/elevator.c
>>> @@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>>  	int ret;
>>>  	unsigned int memflags;
>>>  	struct request_queue *q = disk->queue;
>>> +	struct blk_mq_tag_set *set = q->tag_set;
>>>  
>>>  	/*
>>>  	 * If the attribute needs to load a module, do it before freezing the
>>> @@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>>>  
>>>  	elv_iosched_load_module(name);
>>>  
>>> +	down_read_nested(&set->update_nr_hwq_sema, 1);
>>
>> Why do we need to add nested read lock here? The lockdep splat[1] which
>> you reported earlier is possibly due to the same reader lock being acquired
>> recursively in elv_iosched_store and then elevator_change? 
> 
> The splat isn't related with the nested read lock.
> 
> If you replace down_read_nested() with down_read(), the same splat can be
> triggered again when running `blktests block/001`.
> 
I couldn't recreate it on my setup using above blktests.

>>  
>> On another note, if we suspect possible one-depth recursion for the same 
>> class of lock then then we should use SINGLE_DEPTH_NESTING (instead of using
>> 1 here) for subclass. But still I am not clear why this lock needs nesting.
> 
> It is just one false positive, because elv_iosched_store() won't happen
> when adding disk.
> 
Yes, but how could we avoid false positive? It's probably because of commit 
ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier"). How about adding manual dependency of fs-reclaim on freeze-lock after we add 
the disk. Currently that manual dependency is added in blk_alloc_queue.

Thanks,
--Nilay

