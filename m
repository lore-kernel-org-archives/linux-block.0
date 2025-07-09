Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CA272E7C
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064424; cv=none; b=GTW3c1tk6AL/LUHFG2ZDozB9Y2rHo4+HuQ4vsK+rzxJnExCgxPEHsV9yyFFySVFiykPCTnOORLC4X2b1G9pMvB61N6tven51Knlgittb1XMs8gVKq4takGzc+lyhtWCbSyHSIiJdFBriQFrFKeM+GX1tPFIwxXRbarNmc+XSPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064424; c=relaxed/simple;
	bh=hYvJmm2ljkiKTr8tphQb4PgwwK8O/9xlw5al7PsFe/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1v5XeeWJZtMffJlNuDSWkkR002CSGCkEKxR2PlkpN8M0EBD9kcAqPdM/X702AEukum7KyYuXcQ9BYvyUzKcIIJS69ZWjEXw9SiuBicylAuEopO1CtXVo9BdNFE/yVpyd/hmnCKTelVdh6SwYK1gyy8TA/I+ljL6pnIao6OecAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bY+mYr4F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bY+mYr4F"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5695kkw9002270;
	Wed, 9 Jul 2025 12:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V9RwVH
	0h7wiDtJ6YdqDGKR7X9y7KMYYKNNYTNOxpZJA=; b=bY+mYr4F6g5WUglgroS8SC
	KKJ2X+7MuaH9eXEX5oSQ9QjoClbeAlH8hgxeRMrW9XzE6o1neR1WCfcudNdQaRId
	8l3TT4ffYMs6I+ccbZvfnuXpf2prNU4jE/qVxJDEPycQ2qwKCI4wMTDsRsbf5HAw
	1RseL4XiqsjN7WQLdbpuWbwfSay+Jccw3zZJJusCItho00yJiMIOGsb5k0EUe7RW
	CM9SSmXf1MxG8ItnUZTLpeMEiNTGWCveN9rl4r89yWvxyyZa6aTS+Jrnpy2dszGw
	dW7odPyrrRPq0hlfS+ppeMsj2xXgyiwVm1ic3NP90LDnxRcanvj4Mlq8Ldz867Uw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur764k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 12:28:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569Ae77M025593;
	Wed, 9 Jul 2025 12:28:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcp85a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 12:28:29 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569CSTxb26084036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 12:28:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 421CB5805B;
	Wed,  9 Jul 2025 12:28:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158625804B;
	Wed,  9 Jul 2025 12:28:27 +0000 (GMT)
Received: from [9.61.96.139] (unknown [9.61.96.139])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 12:28:26 +0000 (GMT)
Message-ID: <bf9115cc-1c26-4ef7-8263-ebae72b3e4d1@linux.ibm.com>
Date: Wed, 9 Jul 2025 17:58:25 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nbd: fix lockdep deadlock warning
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com,
        Yu Kuai <yukuai3@huawei.com>
References: <20250709111744.2353050-1-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250709111744.2353050-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMCBTYWx0ZWRfX7lgi89uWOrHy C1WCUvuZjXskXeAmyARLCTPMA+0t0Hdh9UA5rO+1ut99Urq4qoFZPqPSJulpaibYSwrs9dqReWa vBDl5bO9lM9ymunV05CU89bUE73WPVuJnyhG/9ocD9XQm+1pDiZivtuMPn6R6mWTftzTJhX6Ig/
 Jbyqg5TZf671FECVqumdlhsikMa0UcyiQTTpcDNWKvOZafMHFNqTDbVV/1JU+IzBZWwDSpY+W5K iKfxvC2wYpgswuVjh2Fenn7SUPKqkzzf4eYyLb0du0ThkwTFJTD0DbYXN9Fmnv3HZLvXQ6S7S6J 7qXuYr4CZ8xKo8XVVXqvFPgygHEIoc4B5I5YOSCkAy4WsPQYCMoQ+d/mA7c8u0YZo6Y9Bji5toy
 hrq2yyVF9QFa4/+B8KUWPlwIsfr7Y7cex9Iu3RWGFXrb+PPKcjSI1ivLG0DU6MRtjijc8nT1
X-Proofpoint-GUID: HiuyTBNLCMV6OIhymhg8i26-a4MXR8zy
X-Proofpoint-ORIG-GUID: HiuyTBNLCMV6OIhymhg8i26-a4MXR8zy
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686e606e cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=1h-QdZdglX19nnZ2m5oA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=974 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090110



On 7/9/25 4:47 PM, Ming Lei wrote:
> nbd grabs device lock nbd->config_lock for updating nr_hw_queues, this
> ways cause the following lock dependency:
> 
> -> #2 (&disk->open_mutex){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>        mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>        __del_gendisk+0x132/0xac6 block/genhd.c:706
>        del_gendisk+0xf6/0x19a block/genhd.c:819
>        nbd_dev_remove+0x3c/0xf2 drivers/block/nbd.c:268
>        nbd_dev_remove_work+0x1c/0x26 drivers/block/nbd.c:284
>        process_one_work+0x96a/0x1f32 kernel/workqueue.c:3238
>        process_scheduled_works kernel/workqueue.c:3321 [inline]
>        worker_thread+0x5ce/0xde8 kernel/workqueue.c:3402
>        kthread+0x39c/0x7d4 kernel/kthread.c:464
>        ret_from_fork_kernel+0x2a/0xbb2 arch/riscv/kernel/process.c:214
>        ret_from_fork_kernel_asm+0x16/0x18 arch/riscv/kernel/entry.S:327
> 
> -> #1 (&set->update_nr_hwq_lock){++++}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        down_write+0x9c/0x19a kernel/locking/rwsem.c:1577
>        blk_mq_update_nr_hw_queues+0x3e/0xb86 block/blk-mq.c:5041
>        nbd_start_device+0x140/0xb2c drivers/block/nbd.c:1476
>        nbd_genl_connect+0xae0/0x1b24 drivers/block/nbd.c:2201
>        genl_family_rcv_msg_doit+0x206/0x2e6 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x514/0x78e net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x206/0x3be net/netlink/af_netlink.c:2534
>        genl_rcv+0x36/0x4c net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x4f0/0x82c net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x85e/0xdd6 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:712 [inline]
>        __sock_sendmsg+0xcc/0x160 net/socket.c:727
>        ____sys_sendmsg+0x63e/0x79c net/socket.c:2566
>        ___sys_sendmsg+0x144/0x1e6 net/socket.c:2620
>        __sys_sendmsg+0x188/0x246 net/socket.c:2652
>        __do_sys_sendmsg net/socket.c:2657 [inline]
>        __se_sys_sendmsg net/socket.c:2655 [inline]
>        __riscv_sys_sendmsg+0x70/0xa2 net/socket.c:2655
>        syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
>        do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
>        handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
> 
> -> #0 (&nbd->config_lock){+.+.}-{4:4}:
>        check_noncircular+0x132/0x146 kernel/locking/lockdep.c:2178
>        check_prev_add kernel/locking/lockdep.c:3168 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>        validate_chain kernel/locking/lockdep.c:3911 [inline]
>        __lock_acquire+0x12b2/0x24ea kernel/locking/lockdep.c:5240
>        lock_acquire kernel/locking/lockdep.c:5871 [inline]
>        lock_acquire+0x1ac/0x448 kernel/locking/lockdep.c:5828
>        __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>        __mutex_lock+0x166/0x1292 kernel/locking/mutex.c:747
>        mutex_lock_nested+0x14/0x1c kernel/locking/mutex.c:799
>        refcount_dec_and_mutex_lock+0x60/0xd8 lib/refcount.c:118
>        nbd_config_put+0x3a/0x610 drivers/block/nbd.c:1423
>        nbd_release+0x94/0x15c drivers/block/nbd.c:1735
>        blkdev_put_whole+0xac/0xee block/bdev.c:721
>        bdev_release+0x3fe/0x600 block/bdev.c:1144
>        blkdev_release+0x1a/0x26 block/fops.c:684
>        __fput+0x382/0xa8c fs/file_table.c:465
>        ____fput+0x1c/0x26 fs/file_table.c:493
>        task_work_run+0x16a/0x25e kernel/task_work.c:227
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        exit_to_user_mode_loop+0x118/0x134 kernel/entry/common.c:114
>        exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>        syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>        do_trap_ecall_u+0x3f0/0x530 arch/riscv/kernel/traps.c:355
>        handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197
> 
> Also it isn't necessary to require nbd->config_lock, because
> blk_mq_update_nr_hw_queues() does grab tagset lock for sync everything.
> 
> Fixes the issue by releasing ->config_lock & retry in case of concurrent
> updating nr_hw_queues.
> 
> Fixes: 98e68f67020c ("block: prevent adding/deleting disk during updating nr_hw_queues")
> Reported-by: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6855034f.a00a0220.137b3.0031.GAE@google.com
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

