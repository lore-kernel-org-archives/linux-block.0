Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64328A410
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292199; cv=none; b=TyDgdhKpLgR8C+e1JhHGTzI4U1yxGw3gWi2/ubUNukF1NAaZt+eB8C7BQpBPR5jVh0o5HC86Bqi16cuJ/FCys2nH4HJSWvFZbDH6CMP/JlG7qqe2JbBsMj51YeKtAMYq+GyIc1zFdypst6bHY9sFzpyYhpSNDo4RB5XMJUYiyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292199; c=relaxed/simple;
	bh=zdRIrPKzM4nkNgxX86cP5zc4WKqaNuIyM6jFdZGnsXk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=cFlDXyCjlCzRUsvER5EPV5aafaVvCDdW/nO7mpylcEuWWYMf28o/vICtOQ4Fr3LC5x3T3sfhADN4HjQWUB2gskQ2sLvMNys3R69a7GRfbo2X5TJQNvAH1mTBj3ORfzDi+bBbCMkaIU18qHu6dj+iNX6Sp0Iv1N9ISkBP5H+f3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P02lAnwC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P02lAnwC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6HZX6004797;
	Thu, 10 Apr 2025 13:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=W4qoPRBg/JY5YVreSJmyolhVZdVW/K
	HhVbPrP0Inwr8=; b=P02lAnwCLOf1tStkXxsx4hQNaj1+Ef0U6Yb3bRYuEyDXX1
	UGBcDrOPAPduSkttlQnf94cUoZAkt70r3Smf/x1YVtoYOhDBR4xBqxzoed5Y8bU2
	r0lz72NPVx4aYB1bc+NaS1PDZkrk8KOKasr/7xRnL3SmYspfbvH6Sno+KxNT7+Cz
	vWPEhH7Qd/klGTyzurn27lwRhEYQe9oE4099nF86WX6AwoJ7qVi0lwMYfYAPw8v9
	v8qn0JwuXwsWZif2eq56EysfjVWw4eeEvWJQEwHJDAdCnUXPzzPM85Krw718WEsn
	FE+KUnzeN61P8447ITBHHn2YCFhS7H2v9FJWRd8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0404w29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:36:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9BjwT013932;
	Thu, 10 Apr 2025 13:36:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunx5hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:36:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ADaR1Y29688332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 13:36:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F9465805C;
	Thu, 10 Apr 2025 13:36:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E3985805A;
	Thu, 10 Apr 2025 13:36:25 +0000 (GMT)
Received: from [9.171.89.192] (unknown [9.171.89.192])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 13:36:25 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------UJtaMfpI1NUohZq6c40yMcfB"
Message-ID: <917201e2-acac-4ab0-982e-04635806304c@linux.ibm.com>
Date: Thu, 10 Apr 2025 19:06:23 +0530
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
References: <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
 <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
 <Z_Z_Vt2Rv2UfC1qv@fedora>
 <5c2274c0-fd82-4752-b735-32e52de2a80f@linux.ibm.com>
 <Z_concavD65-DXqA@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_concavD65-DXqA@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3uMnfU_SWBLDDS7Vpo5NlD1XySQk21ke
X-Proofpoint-GUID: 3uMnfU_SWBLDDS7Vpo5NlD1XySQk21ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100097

This is a multi-part message in MIME format.
--------------UJtaMfpI1NUohZq6c40yMcfB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 7:40 AM, Ming Lei wrote:
> 
> If new NS needn't to be considered, the issue is easier to deal with updating
> nr_hw_queues, such as:
> 
> - disable scheduler in 1st iterating tag_list
> 
> - update nr_hw_queues in 2nd iterating tag_list
> 
> - restore scheduler in 3rd iterating tag_list
> 
> ->tag_list_lock is acquired & released in each iteration.
> 
> Then per-set lock isn't needed any more.
> 
Hmm still thinking...
>>>
>>> Please see the attached patch which treats elv_iosched_store() as reader.
>>>
>> I looked trough patch and looks good. However we still have an issue 
>> in code paths where we acquire ->elevator_lock without first freezing 
>> the queue.In this case if we try allocate memory using GFP_KERNEL 
>> then fs_reclaim would still trigger lockdep splat. As for this case
>> the lock order would be,
>>
>> elevator_lock -> fs_reclaim(GFP_KERNEL) -> &q->q_usage_counter(io)
> 
> That is why I call ->elevator_lock is used too much, especially it is
> depended for dealing with kobject & sysfs, which isn't needed in this way.
> 
>>
>> In fact, I tested your patch and got into the above splat. I've 
>> attached lockdep splat for your reference. So IMO, we should instead
>> try make locking order such that ->freeze_lock shall never depend on
>> ->elevator_lock. It seems one way to make that possible if we make
>> ->elevator_lock per-set. 
> 
> The attached patch is just for avoiding race between add/del disk vs.
> updating nr_hw_queues, and it should have been for covering race between
> adding/exiting request queue vs. updating nr_hw_queues.
> 
Okay understood.

> If re-order can be done, that is definitely good, but...
Yeah so I tried re-ordering locks so that we first grab q->elevator_lock 
and then ->freeze_lock. As we know there's a challenge with re-arranging
the lock order in __blk_mq_update_nr_hw_queues, but I managed to rectify 
the lock order. I added one more tag_list iterator where we first acquire
->elevator lock and then in the next tag_list iterator we acquire 
->freeze_lock. I have also updated this lock order at other call sites.

Then as we have already discussed, there's also another challenge re-arranging
the lock order in del_gendisk, however, I managed to mitigate that by moving 
elevator_exit and elv_unregister_queue (from blk_unregister_queue)  just after
we delete queue tag set (or in another words when remove the queue from the 
tag-list) in del_gendisk. So that means that we could now safely invoke 
elv_unregister_queue and elevator_exit from  del_gendisk without needing to
acquire ->elevator_lock.

For reference, I attached a (informal) patch. Yes I know this patch would not
fix all splats. But at-least we would stop observing splat related to 
->frezze_lock dependency on ->elevator_lcok. 

> 
>>
>>>>>
>>>>> Actually freeze lock is already held for nvme before calling
>>>>> blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
>>>>> frozen for updating nr_hw_queues, so the above order may not match
>>>>> with the existed code.
>>>>>
>>>>> Do we need to consider nvme or blk_mq_update_nr_hw_queues now?
>>>>>
>>>> I think we should consider (may be in different patch) updating
>>>> nvme_quiesce_io_queues and nvme_unquiesce_io_queues and remove
>>>> its dependency on ->tag_list_lock.
>>>
>>> If we need to take nvme into account, the above lock order doesn't work,
>>> because nvme freezes queue before calling blk_mq_update_nr_hw_queues(),
>>> and elevator lock still depends on freeze lock.
>>>
>>> If it needn't to be considered, per-set lock becomes necessary.
>> IMO, in addition to nvme_quiesce_io_queues and nvme_unquiesce_io_queues
>> we shall also update nvme pci, rdma and tcp drivers so that those 
>> drivers neither freeze queue prior to invoking blk_mq_update_nr_hw_queues
>> nor unfreeze queue after blk_mq_update_nr_hw_queues returns. I see that
>> nvme loop and fc don't freeze queue prior to invoking blk_mq_update_nr_hw_queues.
> 
> This way you cause new deadlock or new trouble if you reply on freeze in
> blk_mq_update_nr_hw_queues():
> 
>  ->tag_list_lock
>  	freeze_lock
> 
> If timeout or io failure happens during the above freeze_lock, timeout
> handler can not move on because new blk_mq_update_nr_hw_queues() can't
> grab the lock.
> 
> Either deadlock or device has to been removed.
> 
With this new attached patch do you still foresee this issue? Yes this patch 
doesn't change anything with nvme driver, but later we may update nvme driver
so that nvme driver doesn't require freezing queue before invoking blk_mq_
update_nr_hw_queues. I think this is requires so that we follow the same lock
order in all call paths wrt ->elevator_lock and ->freeze_lock.

>>> As I mentioned, blk_mq_update_nr_hw_queues() still can come, which is one
>>> host wide event, so either lock or srcu sync is needed.
>> Yes agreed, I see that blk_mq_update_nr_hw_queues can run in parallel 
>> with del_gendisk or blk_unregister_queue.
> 
> Then the per-set lock is required in both add/del disk, then how to re-order
> freeze_lock & elevator lock in del_gendisk()? 
> 
> And there is same risk with the one in blk_mq_update_nr_hw_queues().
> 
Yes please see above as I explained how we could potentially avoid lock order 
issue in del_gendisk.
> 
> Another ways is to make sure that ->elevator_lock isn't required for dealing
> with kobject/debugfs thing, which needs to refactor elevator code.
> 
> Such as, ->elevator_lock is grabbed in debugfs handler, removing sched debugfs
> actually need to drain reader, that is deadlock too.
> 
I do agree. But I think lets first focus on cutting dependency of ->freeze_lock 
on ->elevator_lock. Once we get past it we may address other. 

This commit ffa1e7ada456 ("block: Make request_queue lockdep splats show up 
earlier") has now opened up pandora's box of lockdep splats :) 
Anyways it's good that we could now catch these issues early on. In general,
I feel that now this change would show up early on the issues where ->freeze_lock
depends on any other locks. 

Thanks,
--Nilay
--------------UJtaMfpI1NUohZq6c40yMcfB
Content-Type: text/x-patch; charset=UTF-8; name="fix_elv_lock_order.diff"
Content-Disposition: attachment; filename="fix_elv_lock_order.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1jZ3JvdXAuYyBiL2Jsb2NrL2Jsay1jZ3JvdXAuYwpp
bmRleCA1OTA1ZjI3NzA1N2IuLjNhNDEwN2YzNTUwYSAxMDA2NDQKLS0tIGEvYmxvY2svYmxr
LWNncm91cC5jCisrKyBiL2Jsb2NrL2Jsay1jZ3JvdXAuYwpAQCAtODQ1LDkgKzg0NSw5IEBA
IHVuc2lnbmVkIGxvbmcgX19tdXN0X2NoZWNrIGJsa2dfY29uZl9vcGVuX2JkZXZfZnJvemVu
KHN0cnVjdCBibGtnX2NvbmZfY3R4ICpjdHgpCiAJICovCiAJbXV0ZXhfdW5sb2NrKCZjdHgt
PmJkZXYtPmJkX3F1ZXVlLT5ycV9xb3NfbXV0ZXgpOwogCi0JbWVtZmxhZ3MgPSBibGtfbXFf
ZnJlZXplX3F1ZXVlKGN0eC0+YmRldi0+YmRfcXVldWUpOwogCW11dGV4X2xvY2soJmN0eC0+
YmRldi0+YmRfcXVldWUtPmVsZXZhdG9yX2xvY2spOwogCW11dGV4X2xvY2soJmN0eC0+YmRl
di0+YmRfcXVldWUtPnJxX3Fvc19tdXRleCk7CisJbWVtZmxhZ3MgPSBibGtfbXFfZnJlZXpl
X3F1ZXVlKGN0eC0+YmRldi0+YmRfcXVldWUpOwogCiAJcmV0dXJuIG1lbWZsYWdzOwogfQpA
QCAtMTAxNyw5ICsxMDE3LDkgQEAgdm9pZCBibGtnX2NvbmZfZXhpdF9mcm96ZW4oc3RydWN0
IGJsa2dfY29uZl9jdHggKmN0eCwgdW5zaWduZWQgbG9uZyBtZW1mbGFncykKIAlpZiAoY3R4
LT5iZGV2KSB7CiAJCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxID0gY3R4LT5iZGV2LT5iZF9x
dWV1ZTsKIAorCQlibGtfbXFfdW5mcmVlemVfcXVldWUocSwgbWVtZmxhZ3MpOwogCQlibGtn
X2NvbmZfZXhpdChjdHgpOwogCQltdXRleF91bmxvY2soJnEtPmVsZXZhdG9yX2xvY2spOwot
CQlibGtfbXFfdW5mcmVlemVfcXVldWUocSwgbWVtZmxhZ3MpOwogCX0KIH0KIApkaWZmIC0t
Z2l0IGEvYmxvY2svYmxrLW1xLmMgYi9ibG9jay9ibGstbXEuYwppbmRleCBjMjY5N2RiNTkx
MDkuLmUzYWNlNmI1YTFlMSAxMDA2NDQKLS0tIGEvYmxvY2svYmxrLW1xLmMKKysrIGIvYmxv
Y2svYmxrLW1xLmMKQEAgLTQwOTQsOCArNDA5NCw2IEBAIHN0YXRpYyB2b2lkIGJsa19tcV9t
YXBfc3dxdWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKIAlzdHJ1Y3QgYmxrX21xX2N0
eCAqY3R4OwogCXN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0ID0gcS0+dGFnX3NldDsKIAot
CW11dGV4X2xvY2soJnEtPmVsZXZhdG9yX2xvY2spOwotCiAJcXVldWVfZm9yX2VhY2hfaHdf
Y3R4KHEsIGhjdHgsIGkpIHsKIAkJY3B1bWFza19jbGVhcihoY3R4LT5jcHVtYXNrKTsKIAkJ
aGN0eC0+bnJfY3R4ID0gMDsKQEAgLTQyMDAsOCArNDE5OCw2IEBAIHN0YXRpYyB2b2lkIGJs
a19tcV9tYXBfc3dxdWV1ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKIAkJaGN0eC0+bmV4
dF9jcHUgPSBibGtfbXFfZmlyc3RfbWFwcGVkX2NwdShoY3R4KTsKIAkJaGN0eC0+bmV4dF9j
cHVfYmF0Y2ggPSBCTEtfTVFfQ1BVX1dPUktfQkFUQ0g7CiAJfQotCi0JbXV0ZXhfdW5sb2Nr
KCZxLT5lbGV2YXRvcl9sb2NrKTsKIH0KIAogLyoKQEAgLTQ1MDUsMTYgKzQ1MDEsOSBAQCBz
dGF0aWMgdm9pZCBfX2Jsa19tcV9yZWFsbG9jX2h3X2N0eHMoc3RydWN0IGJsa19tcV90YWdf
c2V0ICpzZXQsCiB9CiAKIHN0YXRpYyB2b2lkIGJsa19tcV9yZWFsbG9jX2h3X2N0eHMoc3Ry
dWN0IGJsa19tcV90YWdfc2V0ICpzZXQsCi0JCQkJICAgc3RydWN0IHJlcXVlc3RfcXVldWUg
KnEsIGJvb2wgbG9jaykKKwkJCQkJc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCiB7Ci0JaWYg
KGxvY2spIHsKLQkJLyogcHJvdGVjdCBhZ2FpbnN0IHN3aXRjaGluZyBpbyBzY2hlZHVsZXIg
ICovCi0JCW11dGV4X2xvY2soJnEtPmVsZXZhdG9yX2xvY2spOwotCQlfX2Jsa19tcV9yZWFs
bG9jX2h3X2N0eHMoc2V0LCBxKTsKLQkJbXV0ZXhfdW5sb2NrKCZxLT5lbGV2YXRvcl9sb2Nr
KTsKLQl9IGVsc2UgewotCQlfX2Jsa19tcV9yZWFsbG9jX2h3X2N0eHMoc2V0LCBxKTsKLQl9
CisJX19ibGtfbXFfcmVhbGxvY19od19jdHhzKHNldCwgcSk7CiAKIAkvKiB1bnJlZ2lzdGVy
IGNwdWhwIGNhbGxiYWNrcyBmb3IgZXhpdGVkIGhjdHhzICovCiAJYmxrX21xX3JlbW92ZV9o
d19xdWV1ZXNfY3B1aHAocSk7CkBAIC00NTQ2LDcgKzQ1MzUsOCBAQCBpbnQgYmxrX21xX2lu
aXRfYWxsb2NhdGVkX3F1ZXVlKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LAogCiAJeGFf
aW5pdCgmcS0+aGN0eF90YWJsZSk7CiAKLQlibGtfbXFfcmVhbGxvY19od19jdHhzKHNldCwg
cSwgZmFsc2UpOworCWJsa19tcV9yZWFsbG9jX2h3X2N0eHMoc2V0LCBxKTsKKwogCWlmICgh
cS0+bnJfaHdfcXVldWVzKQogCQlnb3RvIGVycl9oY3R4czsKIApAQCAtNDU2NCw3ICs0NTU0
LDExIEBAIGludCBibGtfbXFfaW5pdF9hbGxvY2F0ZWRfcXVldWUoc3RydWN0IGJsa19tcV90
YWdfc2V0ICpzZXQsCiAKIAlibGtfbXFfaW5pdF9jcHVfcXVldWVzKHEsIHNldC0+bnJfaHdf
cXVldWVzKTsKIAlibGtfbXFfYWRkX3F1ZXVlX3RhZ19zZXQoc2V0LCBxKTsKKworCW11dGV4
X2xvY2soJnEtPmVsZXZhdG9yX2xvY2spOwogCWJsa19tcV9tYXBfc3dxdWV1ZShxKTsKKwlt
dXRleF91bmxvY2soJnEtPmVsZXZhdG9yX2xvY2spOworCiAJcmV0dXJuIDA7CiAKIGVycl9o
Y3R4czoKQEAgLTQ5NDcsMTIgKzQ5NDEsOSBAQCBzdGF0aWMgYm9vbCBibGtfbXFfZWx2X3N3
aXRjaF9ub25lKHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsCiAJaWYgKCFxZSkKIAkJcmV0dXJu
IGZhbHNlOwogCi0JLyogQWNjZXNzaW5nIHEtPmVsZXZhdG9yIG5lZWRzIHByb3RlY3Rpb24g
ZnJvbSAtPmVsZXZhdG9yX2xvY2suICovCi0JbXV0ZXhfbG9jaygmcS0+ZWxldmF0b3JfbG9j
ayk7Ci0KIAlpZiAoIXEtPmVsZXZhdG9yKSB7CiAJCWtmcmVlKHFlKTsKLQkJZ290byB1bmxv
Y2s7CisJCXJldHVybiB0cnVlOwogCX0KIAogCUlOSVRfTElTVF9IRUFEKCZxZS0+bm9kZSk7
CkBAIC00OTYyLDggKzQ5NTMsNiBAQCBzdGF0aWMgYm9vbCBibGtfbXFfZWx2X3N3aXRjaF9u
b25lKHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsCiAJX19lbGV2YXRvcl9nZXQocWUtPnR5cGUp
OwogCWxpc3RfYWRkKCZxZS0+bm9kZSwgaGVhZCk7CiAJZWxldmF0b3JfZGlzYWJsZShxKTsK
LXVubG9jazoKLQltdXRleF91bmxvY2soJnEtPmVsZXZhdG9yX2xvY2spOwogCiAJcmV0dXJu
IHRydWU7CiB9CkBAIC00OTkzLDExICs0OTgyLDkgQEAgc3RhdGljIHZvaWQgYmxrX21xX2Vs
dl9zd2l0Y2hfYmFjayhzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkLAogCWxpc3RfZGVsKCZxZS0+
bm9kZSk7CiAJa2ZyZWUocWUpOwogCi0JbXV0ZXhfbG9jaygmcS0+ZWxldmF0b3JfbG9jayk7
CiAJZWxldmF0b3Jfc3dpdGNoKHEsIHQpOwogCS8qIGRyb3AgdGhlIHJlZmVyZW5jZSBhY3F1
aXJlZCBpbiBibGtfbXFfZWx2X3N3aXRjaF9ub25lICovCiAJZWxldmF0b3JfcHV0KHQpOwot
CW11dGV4X3VubG9jaygmcS0+ZWxldmF0b3JfbG9jayk7CiB9CiAKIHN0YXRpYyB2b2lkIF9f
YmxrX21xX3VwZGF0ZV9ucl9od19xdWV1ZXMoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQs
CkBAIC01MDE4LDYgKzUwMDUsOSBAQCBzdGF0aWMgdm9pZCBfX2Jsa19tcV91cGRhdGVfbnJf
aHdfcXVldWVzKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LAogCWlmIChzZXQtPm5yX21h
cHMgPT0gMSAmJiBucl9od19xdWV1ZXMgPT0gc2V0LT5ucl9od19xdWV1ZXMpCiAJCXJldHVy
bjsKIAorCWxpc3RfZm9yX2VhY2hfZW50cnkocSwgJnNldC0+dGFnX2xpc3QsIHRhZ19zZXRf
bGlzdCkKKwkJbXV0ZXhfbG9jaygmcS0+ZWxldmF0b3JfbG9jayk7CisKIAltZW1mbGFncyA9
IG1lbWFsbG9jX25vaW9fc2F2ZSgpOwogCWxpc3RfZm9yX2VhY2hfZW50cnkocSwgJnNldC0+
dGFnX2xpc3QsIHRhZ19zZXRfbGlzdCkKIAkJYmxrX21xX2ZyZWV6ZV9xdWV1ZV9ub21lbXNh
dmUocSk7CkBAIC01MDQyLDcgKzUwMzIsNyBAQCBzdGF0aWMgdm9pZCBfX2Jsa19tcV91cGRh
dGVfbnJfaHdfcXVldWVzKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LAogZmFsbGJhY2s6
CiAJYmxrX21xX3VwZGF0ZV9xdWV1ZV9tYXAoc2V0KTsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5
KHEsICZzZXQtPnRhZ19saXN0LCB0YWdfc2V0X2xpc3QpIHsKLQkJYmxrX21xX3JlYWxsb2Nf
aHdfY3R4cyhzZXQsIHEsIHRydWUpOworCQlibGtfbXFfcmVhbGxvY19od19jdHhzKHNldCwg
cSk7CiAKIAkJaWYgKHEtPm5yX2h3X3F1ZXVlcyAhPSBzZXQtPm5yX2h3X3F1ZXVlcykgewog
CQkJaW50IGkgPSBwcmV2X25yX2h3X3F1ZXVlczsKQEAgLTUwNzIsNiArNTA2Miw5IEBAIHN0
YXRpYyB2b2lkIF9fYmxrX21xX3VwZGF0ZV9ucl9od19xdWV1ZXMoc3RydWN0IGJsa19tcV90
YWdfc2V0ICpzZXQsCiAJCWJsa19tcV91bmZyZWV6ZV9xdWV1ZV9ub21lbXJlc3RvcmUocSk7
CiAJbWVtYWxsb2Nfbm9pb19yZXN0b3JlKG1lbWZsYWdzKTsKIAorCWxpc3RfZm9yX2VhY2hf
ZW50cnkocSwgJnNldC0+dGFnX2xpc3QsIHRhZ19zZXRfbGlzdCkKKwkJbXV0ZXhfdW5sb2Nr
KCZxLT5lbGV2YXRvcl9sb2NrKTsKKwogCS8qIEZyZWUgdGhlIGV4Y2VzcyB0YWdzIHdoZW4g
bnJfaHdfcXVldWVzIHNocmluay4gKi8KIAlmb3IgKGkgPSBzZXQtPm5yX2h3X3F1ZXVlczsg
aSA8IHByZXZfbnJfaHdfcXVldWVzOyBpKyspCiAJCV9fYmxrX21xX2ZyZWVfbWFwX2FuZF9y
cXMoc2V0LCBpKTsKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1zeXNmcy5jIGIvYmxvY2svYmxr
LXN5c2ZzLmMKaW5kZXggYTI4ODI3NTFmMGQyLi44YTU4ZGI3ZDcyNTQgMTAwNjQ0Ci0tLSBh
L2Jsb2NrL2Jsay1zeXNmcy5jCisrKyBiL2Jsb2NrL2Jsay1zeXNmcy5jCkBAIC03NiwxNiAr
NzYsMTYgQEAgcXVldWVfcmVxdWVzdHNfc3RvcmUoc3RydWN0IGdlbmRpc2sgKmRpc2ssIGNv
bnN0IGNoYXIgKnBhZ2UsIHNpemVfdCBjb3VudCkKIAlpZiAocmV0IDwgMCkKIAkJcmV0dXJu
IHJldDsKIAotCW1lbWZsYWdzID0gYmxrX21xX2ZyZWV6ZV9xdWV1ZShxKTsKIAltdXRleF9s
b2NrKCZxLT5lbGV2YXRvcl9sb2NrKTsKKwltZW1mbGFncyA9IGJsa19tcV9mcmVlemVfcXVl
dWUocSk7CiAJaWYgKG5yIDwgQkxLREVWX01JTl9SUSkKIAkJbnIgPSBCTEtERVZfTUlOX1JR
OwogCiAJZXJyID0gYmxrX21xX3VwZGF0ZV9ucl9yZXF1ZXN0cyhkaXNrLT5xdWV1ZSwgbnIp
OwogCWlmIChlcnIpCiAJCXJldCA9IGVycjsKLQltdXRleF91bmxvY2soJnEtPmVsZXZhdG9y
X2xvY2spOwogCWJsa19tcV91bmZyZWV6ZV9xdWV1ZShxLCBtZW1mbGFncyk7CisJbXV0ZXhf
dW5sb2NrKCZxLT5lbGV2YXRvcl9sb2NrKTsKIAlyZXR1cm4gcmV0OwogfQogCkBAIC05NDks
MTAgKzk0OSw2IEBAIHZvaWQgYmxrX3VucmVnaXN0ZXJfcXVldWUoc3RydWN0IGdlbmRpc2sg
KmRpc2spCiAJCWJsa19tcV9zeXNmc191bnJlZ2lzdGVyKGRpc2spOwogCWJsa19jcnlwdG9f
c3lzZnNfdW5yZWdpc3RlcihkaXNrKTsKIAotCW11dGV4X2xvY2soJnEtPmVsZXZhdG9yX2xv
Y2spOwotCWVsdl91bnJlZ2lzdGVyX3F1ZXVlKHEpOwotCW11dGV4X3VubG9jaygmcS0+ZWxl
dmF0b3JfbG9jayk7Ci0KIAltdXRleF9sb2NrKCZxLT5zeXNmc19sb2NrKTsKIAlkaXNrX3Vu
cmVnaXN0ZXJfaW5kZXBlbmRlbnRfYWNjZXNzX3JhbmdlcyhkaXNrKTsKIAltdXRleF91bmxv
Y2soJnEtPnN5c2ZzX2xvY2spOwpkaWZmIC0tZ2l0IGEvYmxvY2svZWxldmF0b3IuYyBiL2Js
b2NrL2VsZXZhdG9yLmMKaW5kZXggYjRkMDgwMjZiMDJjLi4zNzBjNGUzOWZlOTAgMTAwNjQ0
Ci0tLSBhL2Jsb2NrL2VsZXZhdG9yLmMKKysrIGIvYmxvY2svZWxldmF0b3IuYwpAQCAtNDgx
LDggKzQ4MSw2IEBAIHZvaWQgZWx2X3VucmVnaXN0ZXJfcXVldWUoc3RydWN0IHJlcXVlc3Rf
cXVldWUgKnEpCiB7CiAJc3RydWN0IGVsZXZhdG9yX3F1ZXVlICplID0gcS0+ZWxldmF0b3I7
CiAKLQlsb2NrZGVwX2Fzc2VydF9oZWxkKCZxLT5lbGV2YXRvcl9sb2NrKTsKLQogCWlmIChl
ICYmIHRlc3RfYW5kX2NsZWFyX2JpdChFTEVWQVRPUl9GTEFHX1JFR0lTVEVSRUQsICZlLT5m
bGFncykpIHsKIAkJa29iamVjdF91ZXZlbnQoJmUtPmtvYmosIEtPQkpfUkVNT1ZFKTsKIAkJ
a29iamVjdF9kZWwoJmUtPmtvYmopOwpAQCAtNzMxLDEzICs3MjksMTMgQEAgc3NpemVfdCBl
bHZfaW9zY2hlZF9zdG9yZShzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgY29uc3QgY2hhciAqYnVm
LAogCiAJZWx2X2lvc2NoZWRfbG9hZF9tb2R1bGUobmFtZSk7CiAKLQltZW1mbGFncyA9IGJs
a19tcV9mcmVlemVfcXVldWUocSk7CiAJbXV0ZXhfbG9jaygmcS0+ZWxldmF0b3JfbG9jayk7
CisJbWVtZmxhZ3MgPSBibGtfbXFfZnJlZXplX3F1ZXVlKHEpOwogCXJldCA9IGVsZXZhdG9y
X2NoYW5nZShxLCBuYW1lKTsKIAlpZiAoIXJldCkKIAkJcmV0ID0gY291bnQ7Ci0JbXV0ZXhf
dW5sb2NrKCZxLT5lbGV2YXRvcl9sb2NrKTsKIAlibGtfbXFfdW5mcmVlemVfcXVldWUocSwg
bWVtZmxhZ3MpOworCW11dGV4X3VubG9jaygmcS0+ZWxldmF0b3JfbG9jayk7CiAJcmV0dXJu
IHJldDsKIH0KIApkaWZmIC0tZ2l0IGEvYmxvY2svZ2VuaGQuYyBiL2Jsb2NrL2dlbmhkLmMK
aW5kZXggYzJiZDg2Y2QwOWRlLi41OTdiZDk0Yjk0NDIgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2dl
bmhkLmMKKysrIGIvYmxvY2svZ2VuaGQuYwpAQCAtNzQ0LDExICs3NDQsNiBAQCB2b2lkIGRl
bF9nZW5kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogCQlibGtfbXFfY2FuY2VsX3dvcmtf
c3luYyhxKTsKIAogCWJsa19tcV9xdWllc2NlX3F1ZXVlKHEpOwotCWlmIChxLT5lbGV2YXRv
cikgewotCQltdXRleF9sb2NrKCZxLT5lbGV2YXRvcl9sb2NrKTsKLQkJZWxldmF0b3JfZXhp
dChxKTsKLQkJbXV0ZXhfdW5sb2NrKCZxLT5lbGV2YXRvcl9sb2NrKTsKLQl9CiAJcnFfcW9z
X2V4aXQocSk7CiAJYmxrX21xX3VucXVpZXNjZV9xdWV1ZShxKTsKIApAQCAtNzYxLDYgKzc1
NiwxMCBAQCB2b2lkIGRlbF9nZW5kaXNrKHN0cnVjdCBnZW5kaXNrICpkaXNrKQogCWVsc2Ug
aWYgKHF1ZXVlX2lzX21xKHEpKQogCQlibGtfbXFfZXhpdF9xdWV1ZShxKTsKIAorCWlmIChx
LT5lbGV2YXRvcikgeworCQllbHZfdW5yZWdpc3Rlcl9xdWV1ZShxKTsKKwkJZWxldmF0b3Jf
ZXhpdChxKTsKKwl9CiAJaWYgKHN0YXJ0X2RyYWluKQogCQlibGtfdW5mcmVlemVfcmVsZWFz
ZV9sb2NrKHEpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IGNjMjMwMzUxNDhiNC4uOTYzMDc3ODEy
ODU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCkBAIC0yODQwLDcgKzI4NDAsMTIgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBudm1lX2NvcmVfcXVpcmtfZW50cnkgY29yZV9xdWlya3NbXSA9IHsKIAkJLnF1
aXJrcyA9IE5WTUVfUVVJUktfREVMQVlfQkVGT1JFX0NIS19SRFkgfAogCQkJICBOVk1FX1FV
SVJLX05PX0RFRVBFU1RfUFMgfAogCQkJICBOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VCTlFO
LAotCX0KKwl9LAorCXsKKwkJLnZpZCA9IDB4MTQ0ZCwKKwkJLmZyID0gIkROQThETkE4IiwK
KwkJLnF1aXJrcyA9IE5WTUVfUVVJUktfU0lOR0xFX1BPUlQsCisJfSwKIH07CiAKIC8qIG1h
dGNoIGlzIG51bGwtdGVybWluYXRlZCBidXQgaWRzdHIgaXMgc3BhY2UtcGFkZGVkLiAqLwpA
QCAtMzMzOCw2ICszMzQzLDkgQEAgc3RhdGljIGludCBudm1lX2luaXRfaWRlbnRpZnkoc3Ry
dWN0IG52bWVfY3RybCAqY3RybCkKIAkJCQljdHJsLT5xdWlya3MgfD0gY29yZV9xdWlya3Nb
aV0ucXVpcmtzOwogCQl9CiAKKwkJaWYgKGN0cmwtPnF1aXJrcyAmIE5WTUVfUVVJUktfU0lO
R0xFX1BPUlQpCisJCQlpZC0+Y21pYyA9IDA7CisKIAkJcmV0ID0gbnZtZV9pbml0X3N1YnN5
c3RlbShjdHJsLCBpZCk7CiAJCWlmIChyZXQpCiAJCQlnb3RvIG91dF9mcmVlOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hvc3QvbnZt
ZS5oCmluZGV4IDUxZTA3ODY0MjEyNy4uYzNmYzgxOGEyNWRlIDEwMDY0NAotLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9udm1lLmgKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCkBA
IC0xNzgsNiArMTc4LDExIEBAIGVudW0gbnZtZV9xdWlya3MgewogCSAqIEFsaWduIGRtYSBw
b29sIHNlZ21lbnQgc2l6ZSB0byA1MTIgYnl0ZXMKIAkgKi8KIAlOVk1FX1FVSVJLX0RNQVBP
T0xfQUxJR05fNTEyCQk9ICgxIDw8IDIyKSwKKworCS8qCisJICogQXNzdW1lIHNpbmdsZSBw
b3J0IGRpc2sgZXZlbiBpZiBpdCBhZHZlcnRpc2UgbXVsdGkgcG9ydAorCSAqLworCU5WTUVf
UVVJUktfU0lOR0xFX1BPUlQJCQk9ICgxIDw8IDIzKSwKIH07CiAKIC8qCg==

--------------UJtaMfpI1NUohZq6c40yMcfB--

