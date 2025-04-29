Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4A176ADB
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924379; cv=none; b=Ssry+IUDKn/2V5XWA9ls74uo8TC8gaZRf1tiEeZ9cz8G80NONu6j5mQGleMZtU+8SUve2iIfoR8QHW+g053wsti2biSp1+geCfqRGxLCXspBPqUsrpMspHR7QLTuijLckg6Le3WcMTEYzGZJPJeCSxAEf6JNkO6ey4pAGo2jIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924379; c=relaxed/simple;
	bh=/IRNEEroPYUJ5JxYmq7JWr/7en4WIq7oP5weSGm1/H0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=iZTwbPatcZbZt/5g9O9bnNe6wGa4LeWT+4goSg51cUIthj/9vLD8LTtpCBsCq+Bh9M8ao81VKCJH/k4Ogi4cVHQNSrlRSxxn6w+WZgSxH7/zgqMdIIMfaw40p4ouTbV/co8L//GyUHWYDS0qjp03i/7aKiZLK5r3VGE6hTGq7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J0iEVpod; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J0iEVpod"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4ETBa028303;
	Tue, 29 Apr 2025 10:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YMWA67Le9KuhR1Iga+YWZKzEeO8lH6
	5BgPqOEI4ynbQ=; b=J0iEVpodgF7JJT65OZp/DRXCaJ7rljZHgpYQYLdNj/OVll
	sqy+kIEIj5NwZNGJaLq7Mk/tJfEeHBtO8kMgUP/3HzC1u0M2P/pVOFIGqeAr85An
	/AXGDjtxx6Kvbiy2NuqnYwjQ7/0FF1wkBFI6UiQRxhF3YysJEZQv3mG2Bw6W90GW
	iJ45jgba1uORjfxEPIUFHieSky8WfVUltCv1Pr+pnjpYT+hiTETktXtx1twCRe0n
	k3YLfStmJQvMa9NVLEi2Hi3uAVEiyFiic5kZJ4V71mPNvAy+BOX+GIb0bn+e+GFf
	SJF4AsLIpmlZK5ef3ZgkjZzKtgU2YxEmKj+nIrNA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8maq67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 10:59:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T9npoZ001799;
	Tue, 29 Apr 2025 10:59:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamjrey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 10:59:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TAxRku23462416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 10:59:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8083B58057;
	Tue, 29 Apr 2025 10:59:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 090BD58058;
	Tue, 29 Apr 2025 10:59:25 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 10:59:24 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------GfeCCR9rVbh37mSeacAOVs4h"
Message-ID: <e99c8ed8-bfcb-4a4d-aff7-c78506eddc09@linux.ibm.com>
Date: Tue, 29 Apr 2025 16:29:23 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-21-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-21-ming.lei@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AGdbPbhh0o7txVJ7ovbFFYo49UUkrkjo
X-Proofpoint-GUID: AGdbPbhh0o7txVJ7ovbFFYo49UUkrkjo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3OSBTYWx0ZWRfX0oHiSN1zx8p8 ZSN4wHVc1c8LbMPuApbgGYNCajx1EWryo9slJPqkwEQtQEprnxobbB+SCyLMFNEM/RvOirFtX4x PC5owQKpsqmSFKKeHLXyTKEejRQiOXmN0OKAHfNPZ0QsQq8Zt1W3XIa3oXU3VpY8yGxEZsiuOcB
 rbQh3x48rlrgwQSaG9JtT/oAOZx0bW0MsN04dQces8hXG0Mzcjqu8f3TKzcjcajVAxizJbdeRvS JYHVhlRWWkzYzOwDVtUeYlW9DH8A9Day/8SUyVp9V8EsJ3G8QdPPjUj/VFasqSMRvha6ieH3PXA Hlz6jjP4TwzGab+yFf5zSmkhVZBgeEmxITuCMXwaO3SkHT7wm+oW1tCiKTro7xWVCp6dy191DH9
 VEcDyiJhLojEc+j2YTvTjzu9X1D42QSdR+F93i28KXcroTdbP+wKzDZdTPxxlVFg8yhbuYzr
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=6810b111 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=20KFwNOVAAAA:8 a=2TbT4rxsWXxQCPEQxaEA:9 a=QEXdDO2ut3YA:10
 a=5Jx9-Y2v2kv5ytP36eQA:9 a=B2y7HmGcmWMA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290079

This is a multi-part message in MIME format.
--------------GfeCCR9rVbh37mSeacAOVs4h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/25 8:51 PM, Ming Lei wrote:
> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
> wbt_enable_default() can't be called with queue frozen, otherwise the
> following lockdep warning is triggered:
> 
> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> 	#2 (fs_reclaim){+.+.}-{0:0}:
> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
> 
> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
> call it from elevator_change_done().
> 
> Meantime add disk->rqos_state_mutex for covering wbt state change, which
> matches the purpose more than ->elevator_lock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

While testing this patch on my machine using blktests, I stumbled upon
a lockdep splat shown below.(I could consistently recreate it):

run blktests block/005 at 2025-04-28 06:57:51

======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc2+ #174 Not tainted
------------------------------------------------------
check/8088 is trying to acquire lock:
c0000000a0c03538 (&disk->rqos_state_mutex){+.+.}-{4:4}, at: wbt_disable_default+0x9c/0x118

but task is already holding lock:
c00000005b8f6c38 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x94/0x214

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock+0x128/0xdd8
       elevator_change+0x94/0x214
       elv_iosched_store+0x14c/0x1f4
       queue_attr_store+0x194/0x1d0
       sysfs_kf_write+0xbc/0x110
       kernfs_fop_write_iter+0x264/0x384
       vfs_write+0x5b0/0x77c
       ksys_write+0xa0/0x180
       system_call_exception+0x1b0/0x4f0
       system_call_vectored_common+0x15c/0x2ec

-> #2 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       blk_alloc_queue+0x46c/0x4bc
       blk_mq_alloc_queue+0xc0/0x160
       __blk_mq_alloc_disk+0x34/0x128
       nvme_alloc_ns+0x140/0x1804 [nvme_core]
       nvme_scan_ns+0x42c/0x564 [nvme_core]
       async_run_entry_fn+0x9c/0x30c
       process_one_work+0x514/0xd38
       worker_thread+0x390/0x6dc
       kthread+0x230/0x278
       start_kernel_thread+0x14/0x18

-> #1 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x114/0x150
       __kmalloc_cache_noprof+0x70/0x5c0
       wbt_init+0x64/0x2fc
       wbt_enable_default+0x140/0x15c
       elevator_change_done+0x314/0x3a8
       elv_iosched_store+0x14c/0x1f4
       queue_attr_store+0x194/0x1d0
       sysfs_kf_write+0xbc/0x110
       kernfs_fop_write_iter+0x264/0x384
       vfs_write+0x5b0/0x77c
       ksys_write+0xa0/0x180
       system_call_exception+0x1b0/0x4f0
       system_call_vectored_common+0x15c/0x2ec

-> #0 (&disk->rqos_state_mutex){+.+.}-{4:4}:
       __lock_acquire+0x1b5c/0x29f8
       lock_acquire+0x23c/0x3f8
       __mutex_lock+0x128/0xdd8
       wbt_disable_default+0x9c/0x118
       bfq_init_queue+0x7b0/0x8c0
       blk_mq_init_sched+0x29c/0x3a8
       __elevator_change+0x3a4/0x8a4
       elevator_change+0x1a4/0x214
       elv_iosched_store+0x14c/0x1f4
       queue_attr_store+0x194/0x1d0
       sysfs_kf_write+0xbc/0x110
       kernfs_fop_write_iter+0x264/0x384
       vfs_write+0x5b0/0x77c
       ksys_write+0xa0/0x180
       system_call_exception+0x1b0/0x4f0
       system_call_vectored_common+0x15c/0x2ec

other info that might help us debug this:

Chain exists of:
  &disk->rqos_state_mutex --> &q->q_usage_counter(io)#23 --> &q->elevator_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->elevator_lock);
                               lock(&q->q_usage_counter(io)#23);
                               lock(&q->elevator_lock);
  lock(&disk->rqos_state_mutex);

 *** DEADLOCK ***

7 locks held by check/8088:
 #0: c0000000873f2400 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0xa0/0x180
 #1: c00000008c10c088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1e0/0x384
 #2: c000000085239248 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1f8/0x384
 #3: c0000000f801c190 (&set->update_nr_hwq_sema){.+.+}-{4:4}, at: elv_iosched_store+0x13c/0x1f4
 #4: c00000005b8f6718 (&q->q_usage_counter(io)#23){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
 #5: c00000005b8f6750 (&q->q_usage_counter(queue)#21){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
 #6: c00000005b8f6c38 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x94/0x214

stack backtrace:
CPU: 26 UID: 0 PID: 8088 Comm: check Kdump: loaded Not tainted 6.15.0-rc2+ #174 VOLUNTARY
Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
Call Trace:
[c0000000d7497240] [c0000000017b9888] dump_stack_lvl+0x100/0x184 (unreliable)
[c0000000d7497270] [c0000000002b546c] print_circular_bug+0x448/0x604
[c0000000d7497320] [c0000000002b5874] check_noncircular+0x24c/0x26c
[c0000000d74973f0] [c0000000002bbb78] __lock_acquire+0x1b5c/0x29f8
[c0000000d7497520] [c0000000002b915c] lock_acquire+0x23c/0x3f8
[c0000000d7497620] [c00000000181277c] __mutex_lock+0x128/0xdd8
[c0000000d7497780] [c000000000c73bf8] wbt_disable_default+0x9c/0x118
[c0000000d74977c0] [c000000000c4c2c0] bfq_init_queue+0x7b0/0x8c0
[c0000000d7497890] [c000000000bff634] blk_mq_init_sched+0x29c/0x3a8
[c0000000d7497910] [c000000000bc2a18] __elevator_change+0x3a4/0x8a4
[c0000000d74979b0] [c000000000bc30bc] elevator_change+0x1a4/0x214
[c0000000d7497a00] [c000000000bc427c] elv_iosched_store+0x14c/0x1f4
[c0000000d7497ae0] [c000000000bd07ec] queue_attr_store+0x194/0x1d0
[c0000000d7497c00] [c000000000a40f00] sysfs_kf_write+0xbc/0x110
[c0000000d7497c50] [c000000000a3cc4c] kernfs_fop_write_iter+0x264/0x384
[c0000000d7497cb0] [c0000000008bb9bc] vfs_write+0x5b0/0x77c
[c0000000d7497d90] [c0000000008bbf88] ksys_write+0xa0/0x180
[c0000000d7497df0] [c000000000039f70] system_call_exception+0x1b0/0x4f0
[c0000000d7497e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
--- interrupt: 3000 at 0x7fffa413b034
NIP:  00007fffa413b034 LR: 00007fffa413b034 CTR: 0000000000000000
REGS: c0000000d7497e80 TRAP: 3000   Not tainted  (6.15.0-rc2+)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44422408  XER: 00000000
IRQMASK: 0
GPR00: 0000000000000004 00007ffffd011260 000000010dfa7e00 0000000000000001
GPR04: 000000011c30b720 0000000000000004 0000000000000010 0000000000000001
GPR08: 0000000000000003 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 00007fffa43fab60 000000011c3adbc0 000000010dfa87b8
GPR16: 000000010dfa94d8 0000000020000000 0000000000000000 000000010deb9070
GPR20: 000000010df4beb8 00007ffffd011404 000000010df4f8a0 000000010dfa89bc
GPR24: 000000010dfa8a50 0000000000000000 000000011c30b720 0000000000000004
GPR28: 0000000000000004 00007fffa42418e0 000000011c30b720 0000000000000004
NIP [00007fffa413b034] 0x7fffa413b034
LR [00007fffa413b034] 0x7fffa413b034
--- interrupt: 3000


From the changes in this patch it appears that we have now got this
new "disk->rqos_state_mutex" which we're holding while allocating
the dynamic memory in wbt_init(). One way is to define GFP_NOIO scope
while holding this mutex but then looking further it seems that we 
don't really need to keep holding this lock in wbt_enable_default()
all the way till wbt_init returns. Probably, unlocking this mutex as
soon as we're done updating the rqos state should be sufficient. 

Similarly, in queue_wb_lat_store we may need to hold this mutex only
while we invoke wbt_set_min_lat. And I just realized that in 
queue_wb_lat_show we need to replace q->elevator_lock with 
disk->rqos_state_mutex. I have attached the above change for 
your reference. You may address this in your next patch.

Thanks,
--Nilay
--------------GfeCCR9rVbh37mSeacAOVs4h
Content-Type: text/x-patch; charset=UTF-8; name="wbt.patch"
Content-Disposition: attachment; filename="wbt.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1zeXNmcy5jIGIvYmxvY2svYmxrLXN5c2ZzLmMKaW5k
ZXggZmFmZTllOWU5N2NjLi4wMjQ4ZGM5NDM4YzMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay1z
eXNmcy5jCisrKyBiL2Jsb2NrL2Jsay1zeXNmcy5jCkBAIC01NjAsNyArNTYwLDcgQEAgc3Rh
dGljIHNzaXplX3QgcXVldWVfd2JfbGF0X3Nob3coc3RydWN0IGdlbmRpc2sgKmRpc2ssIGNo
YXIgKnBhZ2UpCiAJc3NpemVfdCByZXQ7CiAJc3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSBk
aXNrLT5xdWV1ZTsKIAotCW11dGV4X2xvY2soJnEtPmVsZXZhdG9yX2xvY2spOworCW11dGV4
X2xvY2soJmRpc2stPnJxb3Nfc3RhdGVfbXV0ZXgpOwogCWlmICghd2J0X3JxX3FvcyhxKSkg
ewogCQlyZXQgPSAtRUlOVkFMOwogCQlnb3RvIG91dDsKQEAgLTU3Myw3ICs1NzMsNyBAQCBz
dGF0aWMgc3NpemVfdCBxdWV1ZV93Yl9sYXRfc2hvdyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywg
Y2hhciAqcGFnZSkKIAogCXJldCA9IHN5c2ZzX2VtaXQocGFnZSwgIiVsbHVcbiIsIGRpdl91
NjQod2J0X2dldF9taW5fbGF0KHEpLCAxMDAwKSk7CiBvdXQ6Ci0JbXV0ZXhfdW5sb2NrKCZx
LT5lbGV2YXRvcl9sb2NrKTsKKwltdXRleF91bmxvY2soJmRpc2stPnJxb3Nfc3RhdGVfbXV0
ZXgpOwogCXJldHVybiByZXQ7CiB9CiAKQEAgLTU5Myw3ICs1OTMsNiBAQCBzdGF0aWMgc3Np
emVfdCBxdWV1ZV93Yl9sYXRfc3RvcmUoc3RydWN0IGdlbmRpc2sgKmRpc2ssIGNvbnN0IGNo
YXIgKnBhZ2UsCiAJCXJldHVybiAtRUlOVkFMOwogCiAJbWVtZmxhZ3MgPSBibGtfbXFfZnJl
ZXplX3F1ZXVlKHEpOwotCW11dGV4X2xvY2soJmRpc2stPnJxb3Nfc3RhdGVfbXV0ZXgpOwog
CiAJcnFvcyA9IHdidF9ycV9xb3MocSk7CiAJaWYgKCFycW9zKSB7CkBAIC02MTgsMTEgKzYx
NywxMiBAQCBzdGF0aWMgc3NpemVfdCBxdWV1ZV93Yl9sYXRfc3RvcmUoc3RydWN0IGdlbmRp
c2sgKmRpc2ssIGNvbnN0IGNoYXIgKnBhZ2UsCiAJICovCiAJYmxrX21xX3F1aWVzY2VfcXVl
dWUocSk7CiAKKwltdXRleF9sb2NrKCZkaXNrLT5ycW9zX3N0YXRlX211dGV4KTsKIAl3YnRf
c2V0X21pbl9sYXQocSwgdmFsKTsKKwltdXRleF91bmxvY2soJmRpc2stPnJxb3Nfc3RhdGVf
bXV0ZXgpOwogCiAJYmxrX21xX3VucXVpZXNjZV9xdWV1ZShxKTsKIG91dDoKLQltdXRleF91
bmxvY2soJmRpc2stPnJxb3Nfc3RhdGVfbXV0ZXgpOwogCWJsa19tcV91bmZyZWV6ZV9xdWV1
ZShxLCBtZW1mbGFncyk7CiAKIAlyZXR1cm4gcmV0OwpkaWZmIC0tZ2l0IGEvYmxvY2svYmxr
LXdidC5jIGIvYmxvY2svYmxrLXdidC5jCmluZGV4IGM4NTg4YmFlMWMxYi4uNzRhZTcxMzFh
ZGE5IDEwMDY0NAotLS0gYS9ibG9jay9ibGstd2J0LmMKKysrIGIvYmxvY2svYmxrLXdidC5j
CkBAIC03MTQsMTcgKzcxNCwxNyBAQCB2b2lkIHdidF9lbmFibGVfZGVmYXVsdChzdHJ1Y3Qg
Z2VuZGlzayAqZGlzaykKIAlpZiAocnFvcykgewogCQlpZiAoZW5hYmxlICYmIFJRV0IocnFv
cyktPmVuYWJsZV9zdGF0ZSA9PSBXQlRfU1RBVEVfT0ZGX0RFRkFVTFQpCiAJCQlSUVdCKHJx
b3MpLT5lbmFibGVfc3RhdGUgPSBXQlRfU1RBVEVfT05fREVGQVVMVDsKLQkJZ290byB1bmxv
Y2s7CisJCW11dGV4X3VubG9jaygmZGlzay0+cnFvc19zdGF0ZV9tdXRleCk7CisJCXJldHVy
bjsKIAl9CisJbXV0ZXhfdW5sb2NrKCZkaXNrLT5ycW9zX3N0YXRlX211dGV4KTsKIAogCS8q
IFF1ZXVlIG5vdCByZWdpc3RlcmVkPyBNYXliZSBzaHV0dGluZyBkb3duLi4uICovCiAJaWYg
KCFibGtfcXVldWVfcmVnaXN0ZXJlZChxKSkKLQkJZ290byB1bmxvY2s7CisJCXJldHVybjsK
IAogCWlmIChxdWV1ZV9pc19tcShxKSAmJiBlbmFibGUpCiAJCXdidF9pbml0KGRpc2spOwot
dW5sb2NrOgotCW11dGV4X3VubG9jaygmZGlzay0+cnFvc19zdGF0ZV9tdXRleCk7CiB9CiBF
WFBPUlRfU1lNQk9MX0dQTCh3YnRfZW5hYmxlX2RlZmF1bHQpOwogCg==

--------------GfeCCR9rVbh37mSeacAOVs4h--

