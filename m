Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1C20627F
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503685; cv=none; b=LwfpLwC8BNFdIUR8kERg1iSyX+5LYVc6scra3VHkyupUeUteNBCQg3aDIr02GH4iyBOqx1LLYp9T73zCz0xZPAnpbcGAO7J/VXQ70IesTy+OLtXe/DHtLFhX27mzPgcmaNLczKVd2zjRvbN0vzzOQ5hOXJumxonckazFvnE8MXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503685; c=relaxed/simple;
	bh=+24InzhWk0Us6nT2g6mE8gW3+EjOYv01hSYrnpDQm+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUSRAh3CsVbVjovlyXnvzFPndQd5MQ9RJzZW8dDSkHZk7JDonX7emBjxIkCPsuVV4zy/BxSLGJvodoaem4Go9/Ebd6iTP6WWFVYT4wLCAYePWujI6WAisHn7kTycK2VW00C39HdFsGWggKaOEKqy8ATbwX9wv8JaWbCkYmCET2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dxIO37Nd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dxIO37Nd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6FvQU8028295;
	Fri, 6 Dec 2024 16:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LP3VRp2FOHwpb3M1I71kz/3S4RBVAw1EYhSepgPzO
	Qo=; b=dxIO37NdOan49dBan1Cv5mMyOrYQKwOH5K7zIamGNTavDNHfkmqpggXR4
	J7J1xx8qJB1YFfi4DyTZoANkN8F9Gt+z8SPkwJO9fZSDNjN+8t1bghi3hSvjXIbR
	0B/nBV+MiIBGt5XxyJVpVUMb5ALacdjzShd5hq/EJ7G9hghjR2dzYWMr7QSN0WWr
	4MhVfmtINyX0GAe38nv5eW4Du20d+3Brm0Ldb/QnUrR9sswy376q8DTXnMkhnQOs
	3xUbKhFSEeJbJfpb0ybjZTe4B1EVBZEYgCJuJ6DEsK3xeWc46r6aptnV4a0q3sM7
	oY0gg4iJL2HGqDXYayMDbB4R2P+Gw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ax6633et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 16:47:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6Glsh8005244;
	Fri, 6 Dec 2024 16:47:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ax6633eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 16:47:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Dp3Ra006819;
	Fri, 6 Dec 2024 16:47:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jycav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 16:47:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6Gloqd48235006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 16:47:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E379820040;
	Fri,  6 Dec 2024 16:47:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D75EF20043;
	Fri,  6 Dec 2024 16:47:47 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.0.162])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 16:47:47 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, kjain101@in.ibm.com, hch@lst.de,
        axboe@kernel.dk, ritesh.list@gmail.com, ming.lei@redhat.com,
        gjoyce@linux.ibm.com
Subject: [PATCH] block: Fix potential deadlock in queue_attr_store()
Date: Fri,  6 Dec 2024 22:17:39 +0530
Message-ID: <20241206164742.526149-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J1fo3MjQi67kKOMwVT2rwplshbPQpQjK
X-Proofpoint-GUID: FyKbKwgva9rxOzIpp4VYBTJ_YAsLsaWr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060124

For storing a value to a queue attribute, the queue_attr_store function
first freezes the queue (->q_usage_counter(io)) and then acquire
->sysfs_lock. This seems not correct as the usual ordering should be to
acquire ->sysfs_lock before freezing the queue. This incorrect ordering
causes the following lockdep splat which we are able to reproduce always
simply by accessing /sys/kernel/debug file using ls command:

[   57.597146] WARNING: possible circular locking dependency detected
[   57.597154] 6.12.0-10553-gb86545e02e8c #20 Tainted: G        W
[   57.597162] ------------------------------------------------------
[   57.597168] ls/4605 is trying to acquire lock:
[   57.597176] c00000003eb56710 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x58/0xc0
[   57.597200]
               but task is already holding lock:
[   57.597207] c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
[   57.597226]
               which lock already depends on the new lock.

[   57.597233]
               the existing dependency chain (in reverse order) is:
[   57.597241]
               -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
[   57.597255]        down_write+0x6c/0x18c
[   57.597264]        start_creating+0xb4/0x24c
[   57.597274]        debugfs_create_dir+0x2c/0x1e8
[   57.597283]        blk_register_queue+0xec/0x294
[   57.597292]        add_disk_fwnode+0x2e4/0x548
[   57.597302]        brd_alloc+0x2c8/0x338
[   57.597309]        brd_init+0x100/0x178
[   57.597317]        do_one_initcall+0x88/0x3e4
[   57.597326]        kernel_init_freeable+0x3cc/0x6e0
[   57.597334]        kernel_init+0x34/0x1cc
[   57.597342]        ret_from_kernel_user_thread+0x14/0x1c
[   57.597350]
               -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
[   57.597362]        __mutex_lock+0xfc/0x12a0
[   57.597370]        blk_register_queue+0xd4/0x294
[   57.597379]        add_disk_fwnode+0x2e4/0x548
[   57.597388]        brd_alloc+0x2c8/0x338
[   57.597395]        brd_init+0x100/0x178
[   57.597402]        do_one_initcall+0x88/0x3e4
[   57.597410]        kernel_init_freeable+0x3cc/0x6e0
[   57.597418]        kernel_init+0x34/0x1cc
[   57.597426]        ret_from_kernel_user_thread+0x14/0x1c
[   57.597434]
               -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
[   57.597446]        __mutex_lock+0xfc/0x12a0
[   57.597454]        queue_attr_store+0x9c/0x110
[   57.597462]        sysfs_kf_write+0x70/0xb0
[   57.597471]        kernfs_fop_write_iter+0x1b0/0x2ac
[   57.597480]        vfs_write+0x3dc/0x6e8
[   57.597488]        ksys_write+0x84/0x140
[   57.597495]        system_call_exception+0x130/0x360
[   57.597504]        system_call_common+0x160/0x2c4
[   57.597516]
               -> #2 (&q->q_usage_counter(io)#21){++++}-{0:0}:
[   57.597530]        __submit_bio+0x5ec/0x828
[   57.597538]        submit_bio_noacct_nocheck+0x1e4/0x4f0
[   57.597547]        iomap_readahead+0x2a0/0x448
[   57.597556]        xfs_vm_readahead+0x28/0x3c
[   57.597564]        read_pages+0x88/0x41c
[   57.597571]        page_cache_ra_unbounded+0x1ac/0x2d8
[   57.597580]        filemap_get_pages+0x188/0x984
[   57.597588]        filemap_read+0x13c/0x4bc
[   57.597596]        xfs_file_buffered_read+0x88/0x17c
[   57.597605]        xfs_file_read_iter+0xac/0x158
[   57.597614]        vfs_read+0x2d4/0x3b4
[   57.597622]        ksys_read+0x84/0x144
[   57.597629]        system_call_exception+0x130/0x360
[   57.597637]        system_call_common+0x160/0x2c4
[   57.597647]
               -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
[   57.597661]        down_read+0x6c/0x220
[   57.597669]        filemap_fault+0x870/0x100c
[   57.597677]        xfs_filemap_fault+0xc4/0x18c
[   57.597684]        __do_fault+0x64/0x164
[   57.597693]        __handle_mm_fault+0x1274/0x1dac
[   57.597702]        handle_mm_fault+0x248/0x484
[   57.597711]        ___do_page_fault+0x428/0xc0c
[   57.597719]        hash__do_page_fault+0x30/0x68
[   57.597727]        do_hash_fault+0x90/0x35c
[   57.597736]        data_access_common_virt+0x210/0x220
[   57.597745]        _copy_from_user+0xf8/0x19c
[   57.597754]        sel_write_load+0x178/0xd54
[   57.597762]        vfs_write+0x108/0x6e8
[   57.597769]        ksys_write+0x84/0x140
[   57.597777]        system_call_exception+0x130/0x360
[   57.597785]        system_call_common+0x160/0x2c4
[   57.597794]
               -> #0 (&mm->mmap_lock){++++}-{4:4}:
[   57.597806]        __lock_acquire+0x17cc/0x2330
[   57.597814]        lock_acquire+0x138/0x400
[   57.597822]        __might_fault+0x7c/0xc0
[   57.597830]        filldir64+0xe8/0x390
[   57.597839]        dcache_readdir+0x80/0x2d4
[   57.597846]        iterate_dir+0xd8/0x1d4
[   57.597855]        sys_getdents64+0x88/0x2d4
[   57.597864]        system_call_exception+0x130/0x360
[   57.597872]        system_call_common+0x160/0x2c4
[   57.597881]
               other info that might help us debug this:

[   57.597888] Chain exists of:
                 &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#3

[   57.597905]  Possible unsafe locking scenario:

[   57.597911]        CPU0                    CPU1
[   57.597917]        ----                    ----
[   57.597922]   rlock(&sb->s_type->i_mutex_key#3);
[   57.597932]                                lock(&q->debugfs_mutex);
[   57.597940]                                lock(&sb->s_type->i_mutex_key#3);
[   57.597950]   rlock(&mm->mmap_lock);
[   57.597958]
                *** DEADLOCK ***

[   57.597965] 2 locks held by ls/4605:
[   57.597971]  #0: c0000000137c12f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0xcc/0x154
[   57.597989]  #1: c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4

Prevent the above lockdep warning by acquiring ->sysfs_lock before
freezing the queue while storing a queue attribute in queue_attr_store
function.

Reported-by: kjain101@in.ibm.com
Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
Tested-by: kjain101@in.ibm.com
Cc: hch@lst.de
Cc: axboe@kernel.dk
Cc: ritesh.list@gmail.com
Cc: ming.lei@redhat.com
Cc: gjoyce@linux.ibm.com
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4241aea84161..f648b112782f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -706,11 +706,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	if (entry->load_module)
 		entry->load_module(disk, page, length);
 
-	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
+	blk_mq_freeze_queue(q);
 	res = entry->store(disk, page, length);
-	mutex_unlock(&q->sysfs_lock);
 	blk_mq_unfreeze_queue(q);
+	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
 
-- 
2.45.2

