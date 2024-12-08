Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53311E86E
	for <linux-block@vger.kernel.org>; Sun,  8 Dec 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733652695; cv=none; b=MsBiTEwn9Yo0hMEiuGSSc16jaUYWO8y0nf5TI1xpWqfEX5QyNAunbnmM5A4ZchFO1utbLIQjva9cOWym/8mzXtPQsm3rgj9jzUVjwZfrRNttADRUfsne/87xpqj2uLw44bF+ETXlgA7ePzFtXwBdod6fXuupPMWxTTE+14Dl3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733652695; c=relaxed/simple;
	bh=s17J3iR6byEFPeMBNZScsCPpRTa9AjhpF4BVkPJNt4A=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=JbiVraBDra/kwyrUrGssJWd8p0f+QzcDM07BtTh1c8DoWzbvs4y8Y2WfCSeD8QA+4DPqNYOJaJoP2ZjNNFKG+M89rF+PpkdEt+Z5/+zdBCdSkf7p93FOO+vq7udo5rEHuZDTk4pSFcab/b6j5ieXQ6jHVpnMncTTbpblyVsXWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b4MWVYTH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b4MWVYTH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B82ODrM023350;
	Sun, 8 Dec 2024 10:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=11AGSBRSQ1eIbPBGuUV/oIFJyb4fQD
	ZA4zz0cIjehcA=; b=b4MWVYTHHoi/y5ujurpptwcOjp2OY0yHDkfyUF9J7AYSDe
	wmA+gaqD6BCSuaf9jbkjzT5V/xh3gxOpZi6YZz4v2lftlJoxgTzNP2F0/tBHhA6o
	yJC4pbRg9Tg3JTQBEBivCcTniH+9M28yo8vmdDlI4NSzlQrQkb/0F/5Fn0mF5mJq
	p/98gXW+55uLuYI5Yfx2gZwx1Z94MolB0fjY5lXAxZ9HNGu0kHsJMms97oqc/d9N
	RdPW5PypO8q0qpZUj0238PtvOG1c6BPP5MF1HxnH9hruUrn41t6pEhJkwo3pCF55
	/oO8yHGZU724A0wDDzj9xnEd2fv9GdpmBTWaMrLA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38cgru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 10:11:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B8ABPF5021067;
	Sun, 8 Dec 2024 10:11:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38cgrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 10:11:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8A2c2a032734;
	Sun, 8 Dec 2024 10:11:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps1s6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 10:11:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B8ABMfb26870478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Dec 2024 10:11:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A043658059;
	Sun,  8 Dec 2024 10:11:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DB5458043;
	Sun,  8 Dec 2024 10:11:20 +0000 (GMT)
Received: from [9.179.1.228] (unknown [9.179.1.228])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  8 Dec 2024 10:11:19 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------RzhIOEZvCoPdGLfY3BrbS1uM"
Message-ID: <42c6f7bd-c429-4879-9f9f-21a7b706d936@linux.ibm.com>
Date: Sun, 8 Dec 2024 15:41:18 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix potential deadlock in queue_attr_store()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kjain101@in.ibm.com, hch@lst.de,
        axboe@kernel.dk, ritesh.list@gmail.com, gjoyce@linux.ibm.com
References: <20241206164742.526149-1-nilay@linux.ibm.com>
 <CAFj5m9Ke8+EHKQBs_Nk6hqd=LGXtk4mUxZUN5==ZcCjnZSBwHw@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9Ke8+EHKQBs_Nk6hqd=LGXtk4mUxZUN5==ZcCjnZSBwHw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y7TmyyFMlIkHA0GlSZKSUHRuI1DVoa8n
X-Proofpoint-ORIG-GUID: WTmrPMsdBptw7KngoquETQuc2jOJ3Us-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412080083

This is a multi-part message in MIME format.
--------------RzhIOEZvCoPdGLfY3BrbS1uM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/7/24 08:47, Ming Lei wrote:
> On Sat, Dec 7, 2024 at 12:48 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> For storing a value to a queue attribute, the queue_attr_store function
>> first freezes the queue (->q_usage_counter(io)) and then acquire
>> ->sysfs_lock. This seems not correct as the usual ordering should be to
>> acquire ->sysfs_lock before freezing the queue. This incorrect ordering
>> causes the following lockdep splat which we are able to reproduce always
>> simply by accessing /sys/kernel/debug file using ls command:
>>
>> [   57.597146] WARNING: possible circular locking dependency detected
>> [   57.597154] 6.12.0-10553-gb86545e02e8c #20 Tainted: G        W
>> [   57.597162] ------------------------------------------------------
>> [   57.597168] ls/4605 is trying to acquire lock:
>> [   57.597176] c00000003eb56710 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x58/0xc0
>> [   57.597200]
>>                but task is already holding lock:
>> [   57.597207] c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
>> [   57.597226]
>>                which lock already depends on the new lock.
>>
>> [   57.597233]
>>                the existing dependency chain (in reverse order) is:
>> [   57.597241]
>>                -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
>> [   57.597255]        down_write+0x6c/0x18c
>> [   57.597264]        start_creating+0xb4/0x24c
>> [   57.597274]        debugfs_create_dir+0x2c/0x1e8
>> [   57.597283]        blk_register_queue+0xec/0x294
>> [   57.597292]        add_disk_fwnode+0x2e4/0x548
>> [   57.597302]        brd_alloc+0x2c8/0x338
>> [   57.597309]        brd_init+0x100/0x178
>> [   57.597317]        do_one_initcall+0x88/0x3e4
>> [   57.597326]        kernel_init_freeable+0x3cc/0x6e0
>> [   57.597334]        kernel_init+0x34/0x1cc
>> [   57.597342]        ret_from_kernel_user_thread+0x14/0x1c
>> [   57.597350]
>>                -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
>> [   57.597362]        __mutex_lock+0xfc/0x12a0
>> [   57.597370]        blk_register_queue+0xd4/0x294
>> [   57.597379]        add_disk_fwnode+0x2e4/0x548
>> [   57.597388]        brd_alloc+0x2c8/0x338
>> [   57.597395]        brd_init+0x100/0x178
>> [   57.597402]        do_one_initcall+0x88/0x3e4
>> [   57.597410]        kernel_init_freeable+0x3cc/0x6e0
>> [   57.597418]        kernel_init+0x34/0x1cc
>> [   57.597426]        ret_from_kernel_user_thread+0x14/0x1c
>> [   57.597434]
>>                -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
>> [   57.597446]        __mutex_lock+0xfc/0x12a0
>> [   57.597454]        queue_attr_store+0x9c/0x110
>> [   57.597462]        sysfs_kf_write+0x70/0xb0
>> [   57.597471]        kernfs_fop_write_iter+0x1b0/0x2ac
>> [   57.597480]        vfs_write+0x3dc/0x6e8
>> [   57.597488]        ksys_write+0x84/0x140
>> [   57.597495]        system_call_exception+0x130/0x360
>> [   57.597504]        system_call_common+0x160/0x2c4
>> [   57.597516]
>>                -> #2 (&q->q_usage_counter(io)#21){++++}-{0:0}:
>> [   57.597530]        __submit_bio+0x5ec/0x828
>> [   57.597538]        submit_bio_noacct_nocheck+0x1e4/0x4f0
>> [   57.597547]        iomap_readahead+0x2a0/0x448
>> [   57.597556]        xfs_vm_readahead+0x28/0x3c
>> [   57.597564]        read_pages+0x88/0x41c
>> [   57.597571]        page_cache_ra_unbounded+0x1ac/0x2d8
>> [   57.597580]        filemap_get_pages+0x188/0x984
>> [   57.597588]        filemap_read+0x13c/0x4bc
>> [   57.597596]        xfs_file_buffered_read+0x88/0x17c
>> [   57.597605]        xfs_file_read_iter+0xac/0x158
>> [   57.597614]        vfs_read+0x2d4/0x3b4
>> [   57.597622]        ksys_read+0x84/0x144
>> [   57.597629]        system_call_exception+0x130/0x360
>> [   57.597637]        system_call_common+0x160/0x2c4
>> [   57.597647]
>>                -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
>> [   57.597661]        down_read+0x6c/0x220
>> [   57.597669]        filemap_fault+0x870/0x100c
>> [   57.597677]        xfs_filemap_fault+0xc4/0x18c
>> [   57.597684]        __do_fault+0x64/0x164
>> [   57.597693]        __handle_mm_fault+0x1274/0x1dac
>> [   57.597702]        handle_mm_fault+0x248/0x484
>> [   57.597711]        ___do_page_fault+0x428/0xc0c
>> [   57.597719]        hash__do_page_fault+0x30/0x68
>> [   57.597727]        do_hash_fault+0x90/0x35c
>> [   57.597736]        data_access_common_virt+0x210/0x220
>> [   57.597745]        _copy_from_user+0xf8/0x19c
>> [   57.597754]        sel_write_load+0x178/0xd54
>> [   57.597762]        vfs_write+0x108/0x6e8
>> [   57.597769]        ksys_write+0x84/0x140
>> [   57.597777]        system_call_exception+0x130/0x360
>> [   57.597785]        system_call_common+0x160/0x2c4
>> [   57.597794]
>>                -> #0 (&mm->mmap_lock){++++}-{4:4}:
>> [   57.597806]        __lock_acquire+0x17cc/0x2330
>> [   57.597814]        lock_acquire+0x138/0x400
>> [   57.597822]        __might_fault+0x7c/0xc0
>> [   57.597830]        filldir64+0xe8/0x390
>> [   57.597839]        dcache_readdir+0x80/0x2d4
>> [   57.597846]        iterate_dir+0xd8/0x1d4
>> [   57.597855]        sys_getdents64+0x88/0x2d4
>> [   57.597864]        system_call_exception+0x130/0x360
>> [   57.597872]        system_call_common+0x160/0x2c4
>> [   57.597881]
>>                other info that might help us debug this:
>>
>> [   57.597888] Chain exists of:
>>                  &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#3
>>
>> [   57.597905]  Possible unsafe locking scenario:
>>
>> [   57.597911]        CPU0                    CPU1
>> [   57.597917]        ----                    ----
>> [   57.597922]   rlock(&sb->s_type->i_mutex_key#3);
>> [   57.597932]                                lock(&q->debugfs_mutex);
>> [   57.597940]                                lock(&sb->s_type->i_mutex_key#3);
>> [   57.597950]   rlock(&mm->mmap_lock);
>> [   57.597958]
>>                 *** DEADLOCK ***
>>
>> [   57.597965] 2 locks held by ls/4605:
>> [   57.597971]  #0: c0000000137c12f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0xcc/0x154
>> [   57.597989]  #1: c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
>>
>> Prevent the above lockdep warning by acquiring ->sysfs_lock before
>> freezing the queue while storing a queue attribute in queue_attr_store
>> function.
>>
>> Reported-by: kjain101@in.ibm.com
>> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
>> Tested-by: kjain101@in.ibm.com
>> Cc: hch@lst.de
>> Cc: axboe@kernel.dk
>> Cc: ritesh.list@gmail.com
>> Cc: ming.lei@redhat.com
>> Cc: gjoyce@linux.ibm.com
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>  block/blk-sysfs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 4241aea84161..f648b112782f 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -706,11 +706,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>>         if (entry->load_module)
>>                 entry->load_module(disk, page, length);
>>
>> -       blk_mq_freeze_queue(q);
>>         mutex_lock(&q->sysfs_lock);
>> +       blk_mq_freeze_queue(q);
>>         res = entry->store(disk, page, length);
>> -       mutex_unlock(&q->sysfs_lock);
>>         blk_mq_unfreeze_queue(q);
>> +       mutex_unlock(&q->sysfs_lock);
>>         return res;
> 
> We freeze queue first in __blk_mq_update_nr_hw_queues() in which
> q->sysfs_lock is acquired after the freezing.
> 
> So this simple fix may trigger a new ABBA warning.
> 
Oops! yes I agree. 

How about (in addition to the current patch) updating __blk_mq_update_nr_hw_queues()
so that we acquire q->sysfs_lock before freezing the queue? In fact, I tried it (and
ensured that __blk_mq_update_nr_hw_queues() is triggered so that lockdep can track lock 
state and its dependencies) and that appears to be working good - no more lockdep 
warning. For reference attached the diff, in case, you want to have a look. Please let
me know. 

Thanks,
--Nilay
--------------RzhIOEZvCoPdGLfY3BrbS1uM
Content-Type: text/x-patch; charset=UTF-8; name="blk-lockdep.diff"
Content-Disposition: attachment; filename="blk-lockdep.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS1zeXNmcy5jIGIvYmxvY2svYmxrLW1xLXN5c2Zz
LmMKaW5kZXggMTU2ZTliYjA3YWJmLi5jZDVlYTZlYWE3NmIgMTAwNjQ0Ci0tLSBhL2Jsb2Nr
L2Jsay1tcS1zeXNmcy5jCisrKyBiL2Jsb2NrL2Jsay1tcS1zeXNmcy5jCkBAIC0yNzUsMTUg
KzI3NSwxMyBAQCB2b2lkIGJsa19tcV9zeXNmc191bnJlZ2lzdGVyX2hjdHhzKHN0cnVjdCBy
ZXF1ZXN0X3F1ZXVlICpxKQogICAgICAgIHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4Owog
ICAgICAgIHVuc2lnbmVkIGxvbmcgaTsKIAotICAgICAgIG11dGV4X2xvY2soJnEtPnN5c2Zz
X2Rpcl9sb2NrKTsKKyAgICAgICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZxLT5zeXNmc19kaXJf
bG9jayk7CisKICAgICAgICBpZiAoIXEtPm1xX3N5c2ZzX2luaXRfZG9uZSkKLSAgICAgICAg
ICAgICAgIGdvdG8gdW5sb2NrOworICAgICAgICAgICAgICAgcmV0dXJuOwogCiAgICAgICAg
cXVldWVfZm9yX2VhY2hfaHdfY3R4KHEsIGhjdHgsIGkpCiAgICAgICAgICAgICAgICBibGtf
bXFfdW5yZWdpc3Rlcl9oY3R4KGhjdHgpOwotCi11bmxvY2s6Ci0gICAgICAgbXV0ZXhfdW5s
b2NrKCZxLT5zeXNmc19kaXJfbG9jayk7CiB9CiAKIGludCBibGtfbXFfc3lzZnNfcmVnaXN0
ZXJfaGN0eHMoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCkBAIC0yOTIsOSArMjkwLDEwIEBA
IGludCBibGtfbXFfc3lzZnNfcmVnaXN0ZXJfaGN0eHMoc3RydWN0IHJlcXVlc3RfcXVldWUg
KnEpCiAgICAgICAgdW5zaWduZWQgbG9uZyBpOwogICAgICAgIGludCByZXQgPSAwOwogCi0g
ICAgICAgbXV0ZXhfbG9jaygmcS0+c3lzZnNfZGlyX2xvY2spOworICAgICAgIGxvY2tkZXBf
YXNzZXJ0X2hlbGQoJnEtPnN5c2ZzX2Rpcl9sb2NrKTsKKwogICAgICAgIGlmICghcS0+bXFf
c3lzZnNfaW5pdF9kb25lKQotICAgICAgICAgICAgICAgZ290byB1bmxvY2s7CisgICAgICAg
ICAgICAgICByZXR1cm4gcmV0OwogCiAgICAgICAgcXVldWVfZm9yX2VhY2hfaHdfY3R4KHEs
IGhjdHgsIGkpIHsKICAgICAgICAgICAgICAgIHJldCA9IGJsa19tcV9yZWdpc3Rlcl9oY3R4
KGhjdHgpOwpAQCAtMzAyLDggKzMwMSw1IEBAIGludCBibGtfbXFfc3lzZnNfcmVnaXN0ZXJf
aGN0eHMoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCiAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOwogICAgICAgIH0KIAotdW5sb2NrOgotICAgICAgIG11dGV4X3VubG9jaygmcS0+
c3lzZnNfZGlyX2xvY2spOwotCiAgICAgICAgcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBh
L2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmMKaW5kZXggNDI0MjM5YzA3NWUyLi4y
MTg0ZGZmYzczZmMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay1tcS5jCisrKyBiL2Jsb2NrL2Js
ay1tcS5jCkBAIC00MzgwLDggKzQzODAsOSBAQCBzdGF0aWMgdm9pZCBibGtfbXFfcmVhbGxv
Y19od19jdHhzKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LAogICAgICAgIHN0cnVjdCBi
bGtfbXFfaHdfY3R4ICpoY3R4OwogICAgICAgIHVuc2lnbmVkIGxvbmcgaSwgajsKIAorICAg
ICAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJnEtPnN5c2ZzX2xvY2spOworCiAgICAgICAgLyog
cHJvdGVjdCBhZ2FpbnN0IHN3aXRjaGluZyBpbyBzY2hlZHVsZXIgICovCi0gICAgICAgbXV0
ZXhfbG9jaygmcS0+c3lzZnNfbG9jayk7CiAgICAgICAgZm9yIChpID0gMDsgaSA8IHNldC0+
bnJfaHdfcXVldWVzOyBpKyspIHsKICAgICAgICAgICAgICAgIGludCBvbGRfbm9kZTsKICAg
ICAgICAgICAgICAgIGludCBub2RlID0gYmxrX21xX2dldF9oY3R4X25vZGUoc2V0LCBpKTsK
QEAgLTQ0MTQsNyArNDQxNSw2IEBAIHN0YXRpYyB2b2lkIGJsa19tcV9yZWFsbG9jX2h3X2N0
eHMoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQsCiAKICAgICAgICB4YV9mb3JfZWFjaF9z
dGFydCgmcS0+aGN0eF90YWJsZSwgaiwgaGN0eCwgaikKICAgICAgICAgICAgICAgIGJsa19t
cV9leGl0X2hjdHgocSwgc2V0LCBoY3R4LCBqKTsKLSAgICAgICBtdXRleF91bmxvY2soJnEt
PnN5c2ZzX2xvY2spOwogfQogCiBpbnQgYmxrX21xX2luaXRfYWxsb2NhdGVkX3F1ZXVlKHN0
cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0LApAQCAtNDQ0MCwxMCArNDQ0MCwxNCBAQCBpbnQg
YmxrX21xX2luaXRfYWxsb2NhdGVkX3F1ZXVlKHN0cnVjdCBibGtfbXFfdGFnX3NldCAqc2V0
LAogCiAgICAgICAgeGFfaW5pdCgmcS0+aGN0eF90YWJsZSk7CiAKKyAgICAgICBtdXRleF9s
b2NrKCZxLT5zeXNmc19sb2NrKTsKKwogICAgICAgIGJsa19tcV9yZWFsbG9jX2h3X2N0eHMo
c2V0LCBxKTsKICAgICAgICBpZiAoIXEtPm5yX2h3X3F1ZXVlcykKICAgICAgICAgICAgICAg
IGdvdG8gZXJyX2hjdHhzOwogCisgICAgICAgbXV0ZXhfdW5sb2NrKCZxLT5zeXNmc19sb2Nr
KTsKKwogICAgICAgIElOSVRfV09SSygmcS0+dGltZW91dF93b3JrLCBibGtfbXFfdGltZW91
dF93b3JrKTsKICAgICAgICBibGtfcXVldWVfcnFfdGltZW91dChxLCBzZXQtPnRpbWVvdXQg
PyBzZXQtPnRpbWVvdXQgOiAzMCAqIEhaKTsKIApAQCAtNDQ2Miw2ICs0NDY2LDcgQEAgaW50
IGJsa19tcV9pbml0X2FsbG9jYXRlZF9xdWV1ZShzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNl
dCwKICAgICAgICByZXR1cm4gMDsKIAogZXJyX2hjdHhzOgorICAgICAgIG11dGV4X3VubG9j
aygmcS0+c3lzZnNfbG9jayk7CiAgICAgICAgYmxrX21xX3JlbGVhc2UocSk7CiBlcnJfZXhp
dDoKICAgICAgICBxLT5tcV9vcHMgPSBOVUxMOwpAQCAtNDg0MiwxMiArNDg0NywxMiBAQCBz
dGF0aWMgYm9vbCBibGtfbXFfZWx2X3N3aXRjaF9ub25lKHN0cnVjdCBsaXN0X2hlYWQgKmhl
YWQsCiAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7CiAKICAgICAgICAvKiBxLT5lbGV2
YXRvciBuZWVkcyBwcm90ZWN0aW9uIGZyb20gLT5zeXNmc19sb2NrICovCi0gICAgICAgbXV0
ZXhfbG9jaygmcS0+c3lzZnNfbG9jayk7CisgICAgICAgbG9ja2RlcF9hc3NlcnRfaGVsZCgm
cS0+c3lzZnNfbG9jayk7CiAKICAgICAgICAvKiB0aGUgY2hlY2sgaGFzIHRvIGJlIGRvbmUg
d2l0aCBob2xkaW5nIHN5c2ZzX2xvY2sgKi8KICAgICAgICBpZiAoIXEtPmVsZXZhdG9yKSB7
CiAgICAgICAgICAgICAgICBrZnJlZShxZSk7Ci0gICAgICAgICAgICAgICBnb3RvIHVubG9j
azsKKyAgICAgICAgICAgICAgIGdvdG8gb3V0OwogICAgICAgIH0KIAogICAgICAgIElOSVRf
TElTVF9IRUFEKCZxZS0+bm9kZSk7CkBAIC00ODU3LDkgKzQ4NjIsNyBAQCBzdGF0aWMgYm9v
bCBibGtfbXFfZWx2X3N3aXRjaF9ub25lKHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsCiAgICAg
ICAgX19lbGV2YXRvcl9nZXQocWUtPnR5cGUpOwogICAgICAgIGxpc3RfYWRkKCZxZS0+bm9k
ZSwgaGVhZCk7CiAgICAgICAgZWxldmF0b3JfZGlzYWJsZShxKTsKLXVubG9jazoKLSAgICAg
ICBtdXRleF91bmxvY2soJnEtPnN5c2ZzX2xvY2spOwotCitvdXQ6CiAgICAgICAgcmV0dXJu
IHRydWU7CiB9CiAKQEAgLTQ4ODgsMTEgKzQ4OTEsOSBAQCBzdGF0aWMgdm9pZCBibGtfbXFf
ZWx2X3N3aXRjaF9iYWNrKHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQsCiAgICAgICAgbGlzdF9k
ZWwoJnFlLT5ub2RlKTsKICAgICAgICBrZnJlZShxZSk7CiAKLSAgICAgICBtdXRleF9sb2Nr
KCZxLT5zeXNmc19sb2NrKTsKICAgICAgICBlbGV2YXRvcl9zd2l0Y2gocSwgdCk7CiAgICAg
ICAgLyogZHJvcCB0aGUgcmVmZXJlbmNlIGFjcXVpcmVkIGluIGJsa19tcV9lbHZfc3dpdGNo
X25vbmUgKi8KICAgICAgICBlbGV2YXRvcl9wdXQodCk7Ci0gICAgICAgbXV0ZXhfdW5sb2Nr
KCZxLT5zeXNmc19sb2NrKTsKIH0KIAogc3RhdGljIHZvaWQgX19ibGtfbXFfdXBkYXRlX25y
X2h3X3F1ZXVlcyhzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNldCwKQEAgLTQ5MTIsOCArNDkx
MywxMSBAQCBzdGF0aWMgdm9pZCBfX2Jsa19tcV91cGRhdGVfbnJfaHdfcXVldWVzKHN0cnVj
dCBibGtfbXFfdGFnX3NldCAqc2V0LAogICAgICAgIGlmIChzZXQtPm5yX21hcHMgPT0gMSAm
JiBucl9od19xdWV1ZXMgPT0gc2V0LT5ucl9od19xdWV1ZXMpCiAgICAgICAgICAgICAgICBy
ZXR1cm47CiAKLSAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHEsICZzZXQtPnRhZ19saXN0
LCB0YWdfc2V0X2xpc3QpCisgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmc2V0LT50
YWdfbGlzdCwgdGFnX3NldF9saXN0KSB7CisgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZx
LT5zeXNmc19kaXJfbG9jayk7CisgICAgICAgICAgICAgICBtdXRleF9sb2NrKCZxLT5zeXNm
c19sb2NrKTsKICAgICAgICAgICAgICAgIGJsa19tcV9mcmVlemVfcXVldWUocSk7CisgICAg
ICAgfQogICAgICAgIC8qCiAgICAgICAgICogU3dpdGNoIElPIHNjaGVkdWxlciB0byAnbm9u
ZScsIGNsZWFuaW5nIHVwIHRoZSBkYXRhIGFzc29jaWF0ZWQKICAgICAgICAgKiB3aXRoIHRo
ZSBwcmV2aW91cyBzY2hlZHVsZXIuIFdlIHdpbGwgc3dpdGNoIGJhY2sgb25jZSB3ZSBhcmUg
ZG9uZQpAQCAtNDk2OSw4ICs0OTczLDExIEBAIHN0YXRpYyB2b2lkIF9fYmxrX21xX3VwZGF0
ZV9ucl9od19xdWV1ZXMoc3RydWN0IGJsa19tcV90YWdfc2V0ICpzZXQsCiAgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeShxLCAmc2V0LT50YWdfbGlzdCwgdGFnX3NldF9saXN0KQogICAg
ICAgICAgICAgICAgYmxrX21xX2Vsdl9zd2l0Y2hfYmFjaygmaGVhZCwgcSk7CiAKLSAgICAg
ICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHEsICZzZXQtPnRhZ19saXN0LCB0YWdfc2V0X2xpc3Qp
CisgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmc2V0LT50YWdfbGlzdCwgdGFnX3Nl
dF9saXN0KSB7CiAgICAgICAgICAgICAgICBibGtfbXFfdW5mcmVlemVfcXVldWUocSk7Cisg
ICAgICAgICAgICAgICBtdXRleF91bmxvY2soJnEtPnN5c2ZzX2xvY2spOworICAgICAgICAg
ICAgICAgbXV0ZXhfdW5sb2NrKCZxLT5zeXNmc19kaXJfbG9jayk7CisgICAgICAgfQogCiAg
ICAgICAgLyogRnJlZSB0aGUgZXhjZXNzIHRhZ3Mgd2hlbiBucl9od19xdWV1ZXMgc2hyaW5r
LiAqLwogICAgICAgIGZvciAoaSA9IHNldC0+bnJfaHdfcXVldWVzOyBpIDwgcHJldl9ucl9o
d19xdWV1ZXM7IGkrKykK

--------------RzhIOEZvCoPdGLfY3BrbS1uM--

