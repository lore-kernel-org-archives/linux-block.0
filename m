Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489588BEA
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227938; cv=none; b=QAntwlWiDnYM6nBLRg2VlvackZB8GL8pzq9oWkgUrU4eTgifgQ9WH9gPEXDZliYLy0pga9dkhpQ3XDtW7greQp1Qx/Pc4bPpMJBzwoudoLPOGSjSgB4G6onOpd5TU4zbHdvlAOyK3doM9J9g/l0S+tWgiLi2qRgCfP4NLlts4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227938; c=relaxed/simple;
	bh=eIdEhy5XF3/YXUmf4L/NvZBodTVJDP9r1kJGFPn9g84=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=eFXQRHaxMEIHsdTdZ0fN17Ysz1gx1E+FWtni0sBj4rpeI5net/e8CNEAjaYhzUPBqPkNh4LRkjDt5hJhxBULHSqIOm26/Nlvty7AaS6ayww21Spgu7QF4xBuzhaQRnNsDypch11ouUIPdI/Um9T/76hdIzdl+s0Ggere+V5B+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OdGu/wPw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OdGu/wPw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539E3Fbn026393;
	Wed, 9 Apr 2025 19:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/D6qRnWQOWMuM6k6EZWv22otGj/c+8
	ITYJySYn8FoCA=; b=OdGu/wPwDhEunnQasA0tWZXzrbPAxEurJEfRGavN32ZyiP
	cQB6brOuDMdrBNE7wCWnH2JftbQHxHJhdAZQ0PiHpMi6fE1pPIADq3PEkX6CJJZ2
	beFVS51ODCwPJbwgZE3LrWW7AxwbpwObAxOAN0Ji5+qJeUa6Pa1vmhW4A38mhdzA
	HjPS4oF1E3zmK38WvS+qZM1QsfpG7jQ01CRd3YsJV+HTPe9HUaeVLHeTangA6B8c
	AKFGeCINgK3GrghqfL/22ThWWDbdi3RczacMBNQlRYEuYVpsU+QNCd2Zof+GTuh/
	IhXDtW8wTPCGl8/SDZzBTk1dplZcLBt9xFzJDG9Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wtaq1sy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 19:45:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539GJkKc024583;
	Wed, 9 Apr 2025 19:45:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueuthjug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 19:45:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539JjP2r15401480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 19:45:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D6E358067;
	Wed,  9 Apr 2025 19:45:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6CB158065;
	Wed,  9 Apr 2025 19:45:23 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 19:45:23 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------fEdXUNIhKNymhdG1Oxsw20z3"
Message-ID: <5c2274c0-fd82-4752-b735-32e52de2a80f@linux.ibm.com>
Date: Thu, 10 Apr 2025 01:15:22 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
 <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
 <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
 <Z_Z_Vt2Rv2UfC1qv@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_Z_Vt2Rv2UfC1qv@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q2B41HDXBQxLGlM6_S3MiAtfsqDycIJ8
X-Proofpoint-ORIG-GUID: Q2B41HDXBQxLGlM6_S3MiAtfsqDycIJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504090129

This is a multi-part message in MIME format.
--------------fEdXUNIhKNymhdG1Oxsw20z3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 7:38 PM, Ming Lei wrote:
>>>>> __blk_mq_update_nr_hw_queues is the only chance for tagset wide queues
>>>>> involved wrt. switching elevator. If elevator switching is not allowed
>>>>> when __blk_mq_update_nr_hw_queues() is started, why do we need per-set
>>>>> lock?
>>>>>
>>>> Yes if elevator switch is not allowed then we probably don't need per-set lock. 
>>>> However my question was if we were to not allow elevator switch while 
>>>> __blk_mq_update_nr_hw_queues is running then how would we implement it?
>>>
>>> It can be done easily by tag_set->srcu.
>> Ok great if that's possible! But I'm not sure how it could be done in this
>> case. I think both __blk_mq_update_nr_hw_queues and elv_iosched_store
>> run in the writer/updater context. So you may still need lock? Can you
>> please send across a (informal) patch with your idea ?
> 
> Please see the attached patch which treats elv_iosched_store() as reader.
> 
I looked trough patch and looks good. However we still have an issue 
in code paths where we acquire ->elevator_lock without first freezing 
the queue.In this case if we try allocate memory using GFP_KERNEL 
then fs_reclaim would still trigger lockdep splat. As for this case
the lock order would be,

elevator_lock -> fs_reclaim(GFP_KERNEL) -> &q->q_usage_counter(io)

In fact, I tested your patch and got into the above splat. I've 
attached lockdep splat for your reference. So IMO, we should instead
try make locking order such that ->freeze_lock shall never depend on
->elevator_lock. It seems one way to make that possible if we make
->elevator_lock per-set. 

>>>
>>> Actually freeze lock is already held for nvme before calling
>>> blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
>>> frozen for updating nr_hw_queues, so the above order may not match
>>> with the existed code.
>>>
>>> Do we need to consider nvme or blk_mq_update_nr_hw_queues now?
>>>
>> I think we should consider (may be in different patch) updating
>> nvme_quiesce_io_queues and nvme_unquiesce_io_queues and remove
>> its dependency on ->tag_list_lock.
> 
> If we need to take nvme into account, the above lock order doesn't work,
> because nvme freezes queue before calling blk_mq_update_nr_hw_queues(),
> and elevator lock still depends on freeze lock.
> 
> If it needn't to be considered, per-set lock becomes necessary.
IMO, in addition to nvme_quiesce_io_queues and nvme_unquiesce_io_queues
we shall also update nvme pci, rdma and tcp drivers so that those 
drivers neither freeze queue prior to invoking blk_mq_update_nr_hw_queues
nor unfreeze queue after blk_mq_update_nr_hw_queues returns. I see that
nvme loop and fc don't freeze queue prior to invoking blk_mq_update_nr_hw_queues.

>>>>
>>>> So now ->freeze_lock should not depend on ->elevator_lock and that shall
>>>> help avoid few of the recent lockdep splats reported with fs_reclaim.
>>>> What do you think?
>>>
>>> Yes, reordering ->freeze_lock and ->elevator_lock may avoid many fs_reclaim
>>> related splat.
>>>
>>> However, in del_gendisk(), freeze_lock is still held before calling
>>> elevator_exit() and blk_unregister_queue(), and looks not easy to reorder.
>>
>> Yes agreed, however elevator_exit() called from del_gendisk() or 
>> elv_unregister_queue() called from blk_unregister_queue() are called 
>> after we unregister the queue. And if queue has been already unregistered
>> while invoking elevator_exit or del_gensidk then ideally we don't need to
>> acquire ->elevator_lock. The same is true for elevator_exit() called 
>> from add_disk_fwnode(). So IMO, we should update these paths to avoid 
>> acquiring ->elevator_lock.
> 
> As I mentioned, blk_mq_update_nr_hw_queues() still can come, which is one
> host wide event, so either lock or srcu sync is needed.
Yes agreed, I see that blk_mq_update_nr_hw_queues can run in parallel 
with del_gendisk or blk_unregister_queue.

Thanks,
--Nilay
--------------fEdXUNIhKNymhdG1Oxsw20z3
Content-Type: text/plain; charset=UTF-8; name="lockdep_splat.txt"
Content-Disposition: attachment; filename="lockdep_splat.txt"
Content-Transfer-Encoding: base64

WyAgMzk5LjExMjE0NV0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09ClsgIDM5OS4xMTIxNTNdIFdBUk5JTkc6IHBvc3NpYmxlIGNpcmN1
bGFyIGxvY2tpbmcgZGVwZW5kZW5jeSBkZXRlY3RlZApbICAzOTkuMTEyMTYwXSA2LjE1LjAt
cmMxKyAjMTU5IE5vdCB0YWludGVkClsgIDM5OS4xMTIxNjddIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpbICAzOTkuMTEyMTc0XSBi
YXNoLzU4OTEgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoKWyAgMzk5LjExMjE4MV0gYzAw
MDAwMDBiYzIzMzRmOCAoJnEtPmVsZXZhdG9yX2xvY2speysuKy59LXs0OjR9LCBhdDogZWx2
X2lvc2NoZWRfc3RvcmUrMHgxMWMvMHg1ZDQKWyAgMzk5LjExMjIwNV0KWyAgMzk5LjExMjIw
NV0gYnV0IHRhc2sgaXMgYWxyZWFkeSBob2xkaW5nIGxvY2s6ClsgIDM5OS4xMTIyMTFdIGMw
MDAwMDAwYmMyMzJmZDggKCZxLT5xX3VzYWdlX2NvdW50ZXIoaW8pIzIwKXsrKysrfS17MDow
fSwgYXQ6IGJsa19tcV9mcmVlemVfcXVldWVfbm9tZW1zYXZlKzB4MjgvMHg0MApbICAzOTku
MTEyMjMxXQpbICAzOTkuMTEyMjMxXSB3aGljaCBsb2NrIGFscmVhZHkgZGVwZW5kcyBvbiB0
aGUgbmV3IGxvY2suClsgIDM5OS4xMTIyMzFdClsgIDM5OS4xMTIyMzldClsgIDM5OS4xMTIy
MzldIHRoZSBleGlzdGluZyBkZXBlbmRlbmN5IGNoYWluIChpbiByZXZlcnNlIG9yZGVyKSBp
czoKWyAgMzk5LjExMjI0Nl0KWyAgMzk5LjExMjI0Nl0gLT4gIzIgKCZxLT5xX3VzYWdlX2Nv
dW50ZXIoaW8pIzIwKXsrKysrfS17MDowfToKWyAgMzk5LjExMjI2MF0gICAgICAgIGJsa19h
bGxvY19xdWV1ZSsweDNhOC8weDNlNApbICAzOTkuMTEyMjY4XSAgICAgICAgYmxrX21xX2Fs
bG9jX3F1ZXVlKzB4ODgvMHgxMWMKWyAgMzk5LjExMjI3OF0gICAgICAgIF9fYmxrX21xX2Fs
bG9jX2Rpc2srMHgzNC8weGQ4ClsgIDM5OS4xMTIyOTBdICAgICAgICBudWxsX2FkZF9kZXYr
MHgzYzgvMHg5MTQgW251bGxfYmxrXQpbICAzOTkuMTEyMzA2XSAgICAgICAgbnVsbF9pbml0
KzB4MWUwLzB4NGJjIFtudWxsX2Jsa10KWyAgMzk5LjExMjMxOV0gICAgICAgIGRvX29uZV9p
bml0Y2FsbCsweDhjLzB4NGI4ClsgIDM5OS4xMTIzNDBdICAgICAgICBkb19pbml0X21vZHVs
ZSsweDdjLzB4MmM0ClsgIDM5OS4xMTIzOTZdICAgICAgICBpbml0X21vZHVsZV9mcm9tX2Zp
bGUrMHhiNC8weDEwOApbICAzOTkuMTEyNDA1XSAgICAgICAgaWRlbXBvdGVudF9pbml0X21v
ZHVsZSsweDI2Yy8weDM2OApbICAzOTkuMTEyNDE0XSAgICAgICAgc3lzX2Zpbml0X21vZHVs
ZSsweDk4LzB4MTUwClsgIDM5OS4xMTI0MjJdICAgICAgICBzeXN0ZW1fY2FsbF9leGNlcHRp
b24rMHgxMzQvMHgzNjAKWyAgMzk5LjExMjQzMF0gICAgICAgIHN5c3RlbV9jYWxsX3ZlY3Rv
cmVkX2NvbW1vbisweDE1Yy8weDJlYwpbICAzOTkuMTEyNDQxXQpbICAzOTkuMTEyNDQxXSAt
PiAjMSAoZnNfcmVjbGFpbSl7Ky4rLn0tezA6MH06ClsgIDM5OS4xMTI0NTNdICAgICAgICBm
c19yZWNsYWltX2FjcXVpcmUrMHhlNC8weDEyMApbICAzOTkuMTEyNDYxXSAgICAgICAga21l
bV9jYWNoZV9hbGxvY19ub3Byb2YrMHg3NC8weDU3MApbICAzOTkuMTEyNDY5XSAgICAgICAg
X19rZXJuZnNfbmV3X25vZGUrMHg5OC8weDM3YwpbICAzOTkuMTEyNDc5XSAgICAgICAga2Vy
bmZzX25ld19ub2RlKzB4OTQvMHhlNApbICAzOTkuMTEyNDkwXSAgICAgICAga2VybmZzX2Ny
ZWF0ZV9kaXJfbnMrMHg0NC8weDEyMApbICAzOTkuMTEyNTAxXSAgICAgICAgc3lzZnNfY3Jl
YXRlX2Rpcl9ucysweDk0LzB4MTYwClsgIDM5OS4xMTI1MTJdICAgICAgICBrb2JqZWN0X2Fk
ZF9pbnRlcm5hbCsweGY0LzB4M2M4ClsgIDM5OS4xMTI1MjRdICAgICAgICBrb2JqZWN0X2Fk
ZCsweDcwLzB4MTBjClsgIDM5OS4xMTI1MzNdICAgICAgICBlbHZfcmVnaXN0ZXJfcXVldWUr
MHg3MC8weDE0YwpbICAzOTkuMTEyNTYyXSAgICAgICAgYmxrX3JlZ2lzdGVyX3F1ZXVlKzB4
MWQ4LzB4MmJjClsgIDM5OS4xMTI1NzVdICAgICAgICBhZGRfZGlza19md25vZGUrMHgzYjQv
MHg1ZDAKWyAgMzk5LjExMjU4OF0gICAgICAgIHNkX3Byb2JlKzB4M2JjLzB4NWI0IFtzZF9t
b2RdClsgIDM5OS4xMTI2MDFdICAgICAgICByZWFsbHlfcHJvYmUrMHgxMDQvMHg0YzQKWyAg
Mzk5LjExMjYxM10gICAgICAgIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweGI4LzB4MjAwClsg
IDM5OS4xMTI2MjNdICAgICAgICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4NTQvMHgxMjgKWyAg
Mzk5LjExMjYzMl0gICAgICAgIF9fZHJpdmVyX2F0dGFjaF9hc3luY19oZWxwZXIrMHg3Yy8w
eDE1MApbICAzOTkuMTEyNjQxXSAgICAgICAgYXN5bmNfcnVuX2VudHJ5X2ZuKzB4NjAvMHgx
YmMKWyAgMzk5LjExMjY2NV0gICAgICAgIHByb2Nlc3Nfb25lX3dvcmsrMHgyYWMvMHg3ZTQK
WyAgMzk5LjExMjY3OF0gICAgICAgIHdvcmtlcl90aHJlYWQrMHgyMzgvMHg0NjAKWyAgMzk5
LjExMjY5MV0gICAgICAgIGt0aHJlYWQrMHgxNTgvMHgxODgKWyAgMzk5LjExMjcwMF0gICAg
ICAgIHN0YXJ0X2tlcm5lbF90aHJlYWQrMHgxNC8weDE4ClsgIDM5OS4xMTI3MjJdClsgIDM5
OS4xMTI3MjJdIC0+ICMwICgmcS0+ZWxldmF0b3JfbG9jayl7Ky4rLn0tezQ6NH06ClsgIDM5
OS4xMTI3MzddICAgICAgICBfX2xvY2tfYWNxdWlyZSsweDFiZWMvMHgyYmM4ClsgIDM5OS4x
MTI3NDddICAgICAgICBsb2NrX2FjcXVpcmUrMHgxNDAvMHg0MzAKWyAgMzk5LjExMjc2MF0g
ICAgICAgIF9fbXV0ZXhfbG9jaysweGYwLzB4YjAwClsgIDM5OS4xMTI3NjldICAgICAgICBl
bHZfaW9zY2hlZF9zdG9yZSsweDExYy8weDVkNApbICAzOTkuMTEyNzgxXSAgICAgICAgcXVl
dWVfYXR0cl9zdG9yZSsweDEyYy8weDE2NApbICAzOTkuMTEyNzkyXSAgICAgICAgc3lzZnNf
a2Zfd3JpdGUrMHg3NC8weGM0ClsgIDM5OS4xMTI4MDRdICAgICAgICBrZXJuZnNfZm9wX3dy
aXRlX2l0ZXIrMHgxYTgvMHgyYTQKWyAgMzk5LjExMjgxNl0gICAgICAgIHZmc193cml0ZSsw
eDQxMC8weDU4NApbICAzOTkuMTEyODI5XSAgICAgICAga3N5c193cml0ZSsweDg0LzB4MTQw
ClsgIDM5OS4xMTI4NDFdICAgICAgICBzeXN0ZW1fY2FsbF9leGNlcHRpb24rMHgxMzQvMHgz
NjAKWyAgMzk5LjExMjg1MV0gICAgICAgIHN5c3RlbV9jYWxsX3ZlY3RvcmVkX2NvbW1vbisw
eDE1Yy8weDJlYwpbICAzOTkuMTEyODYzXQpbICAzOTkuMTEyODYzXSBvdGhlciBpbmZvIHRo
YXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOgpbICAzOTkuMTEyODYzXQpbICAzOTkuMTEy
ODc0XSBDaGFpbiBleGlzdHMgb2Y6ClsgIDM5OS4xMTI4NzRdICAgJnEtPmVsZXZhdG9yX2xv
Y2sgLS0+IGZzX3JlY2xhaW0gLS0+ICZxLT5xX3VzYWdlX2NvdW50ZXIoaW8pIzIwClsgIDM5
OS4xMTI4NzRdClsgIDM5OS4xMTI4OTZdICBQb3NzaWJsZSB1bnNhZmUgbG9ja2luZyBzY2Vu
YXJpbzoKWyAgMzk5LjExMjg5Nl0KWyAgMzk5LjExMjkwNV0gICAgICAgIENQVTAgICAgICAg
ICAgICAgICAgICAgIENQVTEKWyAgMzk5LjExMjkyOF0gICAgICAgIC0tLS0gICAgICAgICAg
ICAgICAgICAgIC0tLS0KWyAgMzk5LjExMjkzNl0gICBsb2NrKCZxLT5xX3VzYWdlX2NvdW50
ZXIoaW8pIzIwKTsKWyAgMzk5LjExMjk1NF0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxvY2soZnNfcmVjbGFpbSk7ClsgIDM5OS4xMTI5NjddICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsb2NrKCZxLT5xX3VzYWdlX2NvdW50ZXIoaW8pIzIwKTsKWyAgMzk5
LjExMjk4N10gICBsb2NrKCZxLT5lbGV2YXRvcl9sb2NrKTsKWyAgMzk5LjExMjk5OF0KWyAg
Mzk5LjExMjk5OF0gICoqKiBERUFETE9DSyAqKioKWyAgMzk5LjExMjk5OF0KWyAgMzk5LjEx
MzAxMF0gNSBsb2NrcyBoZWxkIGJ5IGJhc2gvNTg5MToKWyAgMzk5LjExMzAxN10gICMwOiBj
MDAwMDAwMDA5Zjg3NDAwIChzYl93cml0ZXJzIzMpey4rLit9LXswOjB9LCBhdDoga3N5c193
cml0ZSsweDg0LzB4MTQwClsgIDM5OS4xMTMwNDJdICAjMTogYzAwMDAwMDAwOTdjZmE4OCAo
Jm9mLT5tdXRleCMyKXsrLisufS17NDo0fSwgYXQ6IGtlcm5mc19mb3Bfd3JpdGVfaXRlcisw
eDE2NC8weDJhNApbICAzOTkuMTEzMDY0XSAgIzI6IGMwMDAwMDAwYmE0NjM0ZjggKGtuLT5h
Y3RpdmUjNTcpey4rLit9LXswOjB9LCBhdDoga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MTcw
LzB4MmE0ClsgIDM5OS4xMTMwODNdICAjMzogYzAwMDAwMDBiYzIzMmZkOCAoJnEtPnFfdXNh
Z2VfY291bnRlcihpbykjMjApeysrKyt9LXswOjB9LCBhdDogYmxrX21xX2ZyZWV6ZV9xdWV1
ZV9ub21lbXNhdmUrMHgyOC8weDQwClsgIDM5OS4xMTMxMDJdICAjNDogYzAwMDAwMDBiYzIz
MzAxMCAoJnEtPnFfdXNhZ2VfY291bnRlcihxdWV1ZSkjMjEpeysuKy59LXswOjB9LCBhdDog
YmxrX21xX2ZyZWV6ZV9xdWV1ZV9ub21lbXNhdmUrMHgyOC8weDQwClsgIDM5OS4xMTMxMjBd
ClsgIDM5OS4xMTMxMjBdIHN0YWNrIGJhY2t0cmFjZToKWyAgMzk5LjExMzEyNl0gQ1BVOiAy
NCBVSUQ6IDAgUElEOiA1ODkxIENvbW06IGJhc2ggS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRl
ZCA2LjE1LjAtcmMxKyAjMTU5IFZPTFVOVEFSWQpbICAzOTkuMTEzMTMwXSBIYXJkd2FyZSBu
YW1lOiBJQk0sOTA0My1NUlggUE9XRVIxMCAoYXJjaGl0ZWN0ZWQpIDB4ODAwMjAwIDB4ZjAw
MDAwNiBvZjpJQk0sRlcxMDYwLjAwIChOTTEwNjBfMDI4KSBodjpwaHlwIHBTZXJpZXMKWyAg
Mzk5LjExMzEzMl0gQ2FsbCBUcmFjZToKWyAgMzk5LjExMzEzM10gW2MwMDAwMDAwODJiZDc1
ODBdIFtjMDAwMDAwMDAxMWI2OWY4XSBkdW1wX3N0YWNrX2x2bCsweDEwOC8weDE4YyAodW5y
ZWxpYWJsZSkKWyAgMzk5LjExMzE0MV0gW2MwMDAwMDAwODJiZDc1YjBdIFtjMDAwMDAwMDAw
MjI1MTJjXSBwcmludF9jaXJjdWxhcl9idWcrMHg0NDgvMHg2MDQKWyAgMzk5LjExMzE0Nl0g
W2MwMDAwMDAwODJiZDc2NjBdIFtjMDAwMDAwMDAwMjI1NTM0XSBjaGVja19ub25jaXJjdWxh
cisweDI0Yy8weDI2YwpbICAzOTkuMTEzMTUwXSBbYzAwMDAwMDA4MmJkNzczMF0gW2MwMDAw
MDAwMDAyMmI5OThdIF9fbG9ja19hY3F1aXJlKzB4MWJlYy8weDJiYzgKWyAgMzk5LjExMzE1
NV0gW2MwMDAwMDAwODJiZDc4NjBdIFtjMDAwMDAwMDAwMjI4ZDIwXSBsb2NrX2FjcXVpcmUr
MHgxNDAvMHg0MzAKWyAgMzk5LjExMzE1OV0gW2MwMDAwMDAwODJiZDc5NjBdIFtjMDAwMDAw
MDAxMWY3NmU4XSBfX211dGV4X2xvY2srMHhmMC8weGIwMApbICAzOTkuMTEzMTYzXSBbYzAw
MDAwMDA4MmJkN2E5MF0gW2MwMDAwMDAwMDA5MGE1NThdIGVsdl9pb3NjaGVkX3N0b3JlKzB4
MTFjLzB4NWQ0ClsgIDM5OS4xMTMxNjldIFtjMDAwMDAwMDgyYmQ3YjUwXSBbYzAwMDAwMDAw
MDkxMmQyMF0gcXVldWVfYXR0cl9zdG9yZSsweDEyYy8weDE2NApbICAzOTkuMTEzMTc0XSBb
YzAwMDAwMDA4MmJkN2M2MF0gW2MwMDAwMDAwMDA3ZDkxMTRdIHN5c2ZzX2tmX3dyaXRlKzB4
NzQvMHhjNApbICAzOTkuMTEzMTc5XSBbYzAwMDAwMDA4MmJkN2NhMF0gW2MwMDAwMDAwMDA3
ZDViNjBdIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDFhOC8weDJhNApbICAzOTkuMTEzMTg1
XSBbYzAwMDAwMDA4MmJkN2NmMF0gW2MwMDAwMDAwMDA2YjM4NmNdIHZmc193cml0ZSsweDQx
MC8weDU4NApbICAzOTkuMTEzMTkwXSBbYzAwMDAwMDA4MmJkN2RjMF0gW2MwMDAwMDAwMDA2
YjNkMThdIGtzeXNfd3JpdGUrMHg4NC8weDE0MApbICAzOTkuMTEzMTk2XSBbYzAwMDAwMDA4
MmJkN2UxMF0gW2MwMDAwMDAwMDAwMzE4MTRdIHN5c3RlbV9jYWxsX2V4Y2VwdGlvbisweDEz
NC8weDM2MApbICAzOTkuMTEzMTk5XSBbYzAwMDAwMDA4MmJkN2U1MF0gW2MwMDAwMDAwMDAw
MGNlZGNdIHN5c3RlbV9jYWxsX3ZlY3RvcmVkX2NvbW1vbisweDE1Yy8weDJlYwpbICAzOTku
MTEzMjA1XSAtLS0gaW50ZXJydXB0OiAzMDAwIGF0IDB4N2ZmZmIxMTNiMDM0ClsgIDM5OS4x
MTMyMDhdIE5JUDogIDAwMDA3ZmZmYjExM2IwMzQgTFI6IDAwMDA3ZmZmYjExM2IwMzQgQ1RS
OiAwMDAwMDAwMDAwMDAwMDAwClsgIDM5OS4xMTMyMTFdIFJFR1M6IGMwMDAwMDAwODJiZDdl
ODAgVFJBUDogMzAwMCAgIE5vdCB0YWludGVkICAoNi4xNS4wLXJjMSspClsgIDM5OS4xMTMy
MTNdIE1TUjogIDgwMDAwMDAwMDI4MGYwMzMgPFNGLFZFQyxWU1gsRUUsUFIsRlAsTUUsSVIs
RFIsUkksTEU+ICBDUjogNDQ0MjI0MDggIFhFUjogMDAwMDAwMDAKWyAgMzk5LjExMzIyM10g
SVJRTUFTSzogMApbICAzOTkuMTEzMjIzXSBHUFIwMDogMDAwMDAwMDAwMDAwMDAwNCAwMDAw
N2ZmZmU3OGNmMDIwIDAwMDAwMDAxMTE0ZDdlMDAgMDAwMDAwMDAwMDAwMDAwMQpbICAzOTku
MTEzMjIzXSBHUFIwNDogMDAwMDAwMDE0Y2UwM2FlMCAwMDAwMDAwMDAwMDAwMDBjIDAwMDAw
MDAwMDAwMDAwMTAgMDAwMDAwMDAwMDAwMDAwMQpbICAzOTkuMTEzMjIzXSBHUFIwODogMDAw
MDAwMDAwMDAwMDAwYiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAw
MDAwMDAwMDAwMApbICAzOTkuMTEzMjIzXSBHUFIxMjogMDAwMDAwMDAwMDAwMDAwMCAwMDAw
N2ZmZmIxMzlhYjYwIDAwMDAwMDAxNGNlZjRlZDAgMDAwMDAwMDExMTRkODdiOApbICAzOTku
MTEzMjIzXSBHUFIxNjogMDAwMDAwMDExMTRkOTRkOCAwMDAwMDAwMDIwMDAwMDAwIDAwMDAw
MDAwMDAwMDAwMDAgMDAwMDAwMDExMTNlOTA3MApbICAzOTkuMTEzMjIzXSBHUFIyMDogMDAw
MDAwMDExMTQ3YmViOCAwMDAwN2ZmZmU3OGNmMWM0IDAwMDAwMDAxMTE0N2Y4YTAgMDAwMDAw
MDExMTRkODliYwpbICAzOTkuMTEzMjIzXSBHUFIyNDogMDAwMDAwMDExMTRkOGE1MCAwMDAw
MDAwMDAwMDAwMDAwIDAwMDAwMDAxNGNlMDNhZTAgMDAwMDAwMDAwMDAwMDAwYwpbICAzOTku
MTEzMjIzXSBHUFIyODogMDAwMDAwMDAwMDAwMDAwYyAwMDAwN2ZmZmIxMjQxOGUwIDAwMDAw
MDAxNGNlMDNhZTAgMDAwMDAwMDAwMDAwMDAwYwpbICAzOTkuMTEzMjU2XSBOSVAgWzAwMDA3
ZmZmYjExM2IwMzRdIDB4N2ZmZmIxMTNiMDM0ClsgIDM5OS4xMTMyNThdIExSIFswMDAwN2Zm
ZmIxMTNiMDM0XSAweDdmZmZiMTEzYjAzNApbICAzOTkuMTEzMjYwXSAtLS0gaW50ZXJydXB0
OiAzMDAwCg==

--------------fEdXUNIhKNymhdG1Oxsw20z3--

