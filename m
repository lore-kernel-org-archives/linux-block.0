Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F409125D0
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601255; cv=none; b=r9zcdOWP4r61uZwbbU1AcPedzpU91kdeDQpPWPeX8d3E8k/KZeaZVQ9fSu2aBFD3+K3Hn5T4+raI5j23kDe1Odhrt2j/hHj/37dX4hj1nZ1Ip0LKaI0S0bhfAPIFuvYIRql0/Jb+Yo34Gzj/QUB0JzDoczhgppEmJs4auubrlx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601255; c=relaxed/simple;
	bh=47M08HRGZUhh1JXLYHmI0eJdwi30hPOpANGHar5pxd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YkSF+pnY0Yn1FRyIqty2ARs4kePgEQx7LyN2tJyLASConTGYuzQacFE2JMC2gGJgS9ducBsga0QSFKRfyArlXCvx7haBVDxy+aTLXsAcXEE68AUr0ntrgIHcEPD0EI+ke1GRnLrtoAgSG0cZkFG3WWbfaqA/Av3xNxxZHCQ0TUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QxBb3QhC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QxBb3QhC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1BmvKa017399;
	Mon, 1 Dec 2025 15:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x2wr+i
	Kd3wRkEcvZaKtr3wLgyNcqHuDNCT0WkpacneA=; b=QxBb3QhCb4obOk2FS3e+xb
	3p45ZRvpIc23yQlzRlK9mqLWgbOADiGshnDvQXqdKdAtYk1/7I5RnEdO2PzVUuWc
	3gqYnO1JfhjLAxb9hCzfB+bW87FGIgBa3xGe7VY+3ql2DLL5vN74P5ZbCO3IyvHR
	Mc2U2sFdk/Skgx1G/7xZ326dcibkTipQ1t7j8/fJiO22wCxtsjjOp5jEs6LnsHkA
	genoHQOTxYjoATwGVd2QC0AWMU7ZUCm5WNmKxTjD/DeWwVV3Td7EDaC6Nrq3MM/G
	/0QMDSuDll0OBWfj1m1lcnvaUpS4gI2eyJKFR3Uhsvr4kJxjyvwMxucccqpMBRAA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg57kpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 15:00:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1DT03c003834;
	Mon, 1 Dec 2025 15:00:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjeugd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 15:00:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1F0YMu12059336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 15:00:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E9325806C;
	Mon,  1 Dec 2025 15:00:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 846F958069;
	Mon,  1 Dec 2025 15:00:32 +0000 (GMT)
Received: from [9.61.57.8] (unknown [9.61.57.8])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 15:00:32 +0000 (GMT)
Message-ID: <3c088265-f6d8-4a91-b6a0-972d45afa056@linux.ibm.com>
Date: Mon, 1 Dec 2025 20:30:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] blk-wbt: fix incorrect lock order for
 rq_qos_mutex and freeze queue
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com, bvanassche@acm.org
References: <20251201083415.2407888-1-yukuai@fnnas.com>
 <20251201083415.2407888-9-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251201083415.2407888-9-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lOyJ1Y-l7JsryiwI0JZHie_mJ8DWIEKd
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692dad94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l1MhgeGgEi9kavSdeVUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX/c6XQJMN4cbp
 hyl1yJn2URT9EsScCCtEYEwFYR5gRI6+ymEMwvdGv0UJxV894VjP/gbNFlXVb3qAQ0Qkt6xkphm
 /Mgg8j4+hl3kAHXNbw8XsRwKlE71jw1uvC900i0KFtzicDnzLaOWiQCKu0TP95aWy0wQABN0Lx8
 DsRumEBm3p7w/U5B5Sm4ioS/KjXwv1mB1rxiBqBHx8J9OEln9I5tY9T1Qz1aUT8xl/Ef2NWMyyI
 Apj5F7lyWPf6mk4RPjVktU15DBawVTi7qGoURQB7UZnq4KI2ItAPEe2uQOot6+YowPZ+13MOWmm
 /5g0RKCSjcti1lL+bly2pF2VJRPMOCX426BBlYz4iTsN1AUbTOVlsgNQOa6WaxXoW7xp/2X5yvC
 3QOy5eNr08M6uDgmOhqu/2JTt2NSJg==
X-Proofpoint-GUID: lOyJ1Y-l7JsryiwI0JZHie_mJ8DWIEKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020



On 12/1/25 2:04 PM, Yu Kuai wrote:
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index c471d11b756f..e035331a800f 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -759,7 +759,12 @@ void wbt_enable_default(struct gendisk *disk)
>  		struct rq_wb *rwb = wbt_alloc();
>  
>  		if (rwb) {
> +			unsigned int memflags;
> +
> +			memflags = blk_mq_freeze_queue(q);
>  			wbt_init(disk, rwb);
> +			blk_mq_unfreeze_queue(q, memflags);
> +

Moving ->freeze_lock out of rq_qos_add() and moving it here before
calling wbt_init() makes sense, however this change now causes
the below lockdep splat while running blktests throtl/001. Looking
at the below splat, it seems blk_throtl_init() should run under
GFP_NOIO scope.

======================================================
WARNING: possible circular locking dependency detected
6.18.0 #90 Not tainted
------------------------------------------------------
check/95765 is trying to acquire lock:
c000000002bc4c60 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_node_noprof+0x80/0x9c8

but task is already holding lock:
c000000149a6f330 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev+0x118/0x1b8

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->rq_qos_mutex){+.+.}-{4:4}:
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       __mutex_lock+0xf0/0xeb8
       wbt_init+0x110/0x1b8
       wbt_enable_default+0x140/0x198
       blk_register_queue+0x138/0x278
       __add_disk+0x2e0/0x4c4
       add_disk_fwnode+0x90/0x1f0
       sd_probe+0x2e0/0x5ec [sd_mod]
       really_probe+0x104/0x4c4
       __driver_probe_device+0xb8/0x200
       driver_probe_device+0x54/0x128
       __driver_attach_async_helper+0x7c/0x150
       async_run_entry_fn+0x60/0x1cc
       process_one_work+0x2ac/0x7e4
       worker_thread+0x238/0x460
       kthread+0x158/0x188
       start_kernel_thread+0x14/0x18

-> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       blk_alloc_queue+0x3ac/0x3e8
       blk_mq_alloc_queue+0x88/0x11c
       scsi_alloc_sdev+0x270/0x454
       scsi_probe_and_add_lun+0x2e4/0x56c
       __scsi_scan_target+0x170/0x2e8
       scsi_scan_channel+0x9c/0xe8
       scsi_scan_host_selected+0x158/0x1f8
       do_scan_async+0x2c/0x284
       async_run_entry_fn+0x60/0x1cc
       process_one_work+0x2ac/0x7e4
       worker_thread+0x238/0x460
       kthread+0x158/0x188
       start_kernel_thread+0x14/0x18

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add+0x170/0x1248
       validate_chain+0x7f0/0xba8
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       fs_reclaim_acquire+0xe0/0x120
       __kmalloc_cache_node_noprof+0x80/0x9c8
       blk_throtl_init+0x4c/0x214
       tg_set_limit+0x424/0x5a8
       cgroup_file_write+0xec/0x364
       kernfs_fop_write_iter+0x1c0/0x2b8
       vfs_write+0x45c/0x64c
       ksys_write+0x84/0x140
       system_call_exception+0x134/0x360
       system_call_vectored_common+0x15c/0x2ec

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &q->q_usage_counter(io) --> &q->rq_qos_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->rq_qos_mutex);
                               lock(&q->q_usage_counter(io));
                               lock(&q->rq_qos_mutex);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by check/95765:
 #0: c0000000b737f410 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x84/0x140
 #1: c0000000b5bb0c88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x168/0x2b8
 #2: c00000014b9cf788 (kn->active#164){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x180/0x2b8
 #3: c000000149a6f330 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev+0x118/0x1b8

stack backtrace:
CPU: 9 UID: 0 PID: 95765 Comm: check Not tainted 6.18.0-dirty #90 VOLUNTARY 
Hardware name: IBM,9008-22L POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
Call Trace:
	dump_stack_lvl+0xe8/0x150 (unreliable)
	print_circular_bug+0x248/0x2d8
	check_noncircular+0x1cc/0x1ec
	check_prev_add+0x170/0x1248
	validate_chain+0x7f0/0xba8
	__lock_acquire+0x6b4/0x103c
	lock_acquire.part.0+0xd0/0x26c
	fs_reclaim_acquire+0xe0/0x120
	__kmalloc_cache_node_noprof+0x80/0x9c8
	blk_throtl_init+0x4c/0x214
	tg_set_limit+0x424/0x5a8
	cgroup_file_write+0xec/0x364
	kernfs_fop_write_iter+0x1c0/0x2b8
	vfs_write+0x45c/0x64c
	ksys_write+0x84/0x140
	system_call_exception+0x134/0x360
	system_call_vectored_common+0x15c/0x2ec


