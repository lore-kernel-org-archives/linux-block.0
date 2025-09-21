Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B423D7E8
	for <linux-block@vger.kernel.org>; Sun, 21 Sep 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457229; cv=none; b=ikFvJ8qdSMjFt7Yg8hyiA2Lnbz8CptmC4R9DKzOANoIzcS8R6pVYNqnvnoDK8GMNlEA3Q071k8JkWf2ZH74FHVbjewZTwCqIfrFJY8N2wX0kWrxQ1W0LhZUeOKgmg10Do54wUL+DONlHX0EsDYcHOiFvdcsjCXKByqZ1pj3snUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457229; c=relaxed/simple;
	bh=P4liXE7LHLQaL6NpLXpPoO1GIMwij1KA3H5PMElluHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coOimP2GTCaLuwSkP8HDS5jZ2OSY8VI6E/vceDYFc56QkPoRczpWztc1t4Q9+dG0bmaRCP6UuH3LsPCIXjSLsH1fWflvGz+ZaEoH/QBpqCv8uO9SK2UGZwnl2Ignt3Qk7idJB9pkWkoIugxu3hZEvZSMEfxz7QozGtWvSV41qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m8xlWu32; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m8xlWu32"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KMCius028034;
	Sun, 21 Sep 2025 12:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CGs5rt
	VaU8EYFMIGuXSNrUZr5uxxUg93EiSLMrduXwk=; b=m8xlWu3247dMcE4EU2WT9Z
	Iaa7RILswjWvl1u++AUnhiyXhAnM7PG0QQpCW/hhcFIKJ+KQqxUcTE4toWVWssiZ
	rmiB3adbOObp0Y7MP0r/nz1RXp42vir9HttcweS9MKdq/1z/x+Uur9gKEFvXc6S/
	eun7XB3clJPoA5fYd5/pVFgFVLxl+O/8fJkKdLNuMNQwS3a+gy3CAu3iQ6N0yykH
	ePN8VdlV9OnN19FNQmXL1EvDV2nC5NOfzNPE1lShrPM+9hqvieG9aZxPpdS6eFgl
	aNScwjX3nnD+9hU7f7w+tu2kh+FpfsGkke9JmFWs1qINVXjs2efpgVDxgSjHp8Xw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwy5ab1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 12:19:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L8f63q030397;
	Sun, 21 Sep 2025 12:19:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a0sc9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 12:19:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LCJJBX31392304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 12:19:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D820858055;
	Sun, 21 Sep 2025 12:19:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9068758043;
	Sun, 21 Sep 2025 12:19:16 +0000 (GMT)
Received: from [9.43.45.7] (unknown [9.43.45.7])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 12:19:16 +0000 (GMT)
Message-ID: <669ded18-b383-493d-a9a2-839929a10a92@linux.ibm.com>
Date: Sun, 21 Sep 2025 17:49:14 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] tests/throtl: add a deadlock regression test
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
        shinichiro.kawasaki@wdc.com
Cc: ming.lei@redhat.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68cfed49 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=9M3hidmL0r3XWzicUpQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6-_Z8sgqJoxhB49AFCsQHWAR2Ury_V_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX8zByoMBhn/le
 +/e+pq7hqRqwQqZ5ICZoGbelizLwBS4E7arX9E6BiFI8Tcn7cbj4BFjne8cUdQdqd2aDU4F5Yze
 r+s4kIzg2O0AAwZsYR7edSYlwJRFpzbUckwLNE1eqVnbeguI/1qqNTl/3VWuIEn/nsJlOCxvazb
 7sRSB4Lq8pdxbkPwrs6VJ45cI5WiK1+a2mPvOFINanqtMCDiksKphJxdFaYgMR2HpUwRiJbdPPr
 bplY0QmtLyp4GgHjwszXvy2YlU/BgrOAiszIUp9IcP9JoMW6yxtTHrbAphgDxftJksfyR3AND1I
 tOTe4qdQA/y/LDs1Hdjf/afef1LcWNtbNBHrmZ2/DslXuBtRzVE2MzgCEeBqt0/VCJFl70e3mF7
 ASSN1iPF
X-Proofpoint-ORIG-GUID: 6-_Z8sgqJoxhB49AFCsQHWAR2Ury_V_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015



On 9/18/25 2:23 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While I'm looking at another deadlock issue for blk-throtl, it's found
> during test that lockdep is reporting another issue quite eazy, I'm
> adding regerssion test for now, if anyone is interested. Otherwise, I'll
> go back for this after I finish the problem at hand later.
> 
> BTW, maybe we can support to test for scsi_debug instead of null_blk for
> all the throtl tests.
> 
> Kernel log with patch:
> 
> [  233.277591] run blktests throtl/004 at 2025-09-18 08:40:41
> [  233.933598] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
> [  234.034150] scsi 0:0:0:0: Power-on or device reset occurred
> [  237.418408]
> [  237.419010] ======================================================
> [  237.420951] WARNING: possible circular locking dependency detected
> [  237.422523] 6.17.0-rc3-00124-ga12c2658ced0 #1665 Not tainted
> [  237.423760] ------------------------------------------------------
> [  237.425088] check/1334 is trying to acquire lock:
> [  237.426111] ff1100011d9d0678 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0x53/0x180
> [  237.427995]
> [  237.427995] but task is already holding lock:
> [  237.429254] ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gendisk+0xba/0x110
> [  237.431193]
> [  237.431193] which lock already depends on the new lock.
> [  237.431193]
> [  237.432940]
> [  237.432940] the existing dependency chain (in reverse order) is:
> [  237.434550]
> [  237.434550] -> #2 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
> [  237.435946]        blk_queue_enter+0x40b/0x470
> [  237.436620]        blkg_conf_prep+0x7b/0x3c0
> [  237.437261]        tg_set_limit+0x10a/0x3e0
> [  237.437905]        cgroup_file_write+0xc6/0x420
> [  237.438596]        kernfs_fop_write_iter+0x189/0x280
> [  237.439334]        vfs_write+0x256/0x490
> [  237.439934]        ksys_write+0x83/0x190
> [  237.440533]        __x64_sys_write+0x21/0x30
> [  237.441172]        x64_sys_call+0x4608/0x4630
> [  237.441833]        do_syscall_64+0xdb/0x6b0
> [  237.442460]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  237.443283]
> [  237.443283] -> #1 (&q->rq_qos_mutex){+.+.}-{4:4}:
> [  237.444201]        __mutex_lock+0xd8/0xf50
> [  237.444823]        mutex_lock_nested+0x2b/0x40
> [  237.445491]        wbt_init+0x17e/0x280
> [  237.446068]        wbt_enable_default+0xe9/0x140
> [  237.446768]        blk_register_queue+0x1da/0x2e0
> [  237.447477]        __add_disk+0x38c/0x5d0
> [  237.448079]        add_disk_fwnode+0x89/0x250
> [  237.448741]        device_add_disk+0x18/0x30
> [  237.449394]        virtblk_probe+0x13a3/0x1800
> [  237.450073]        virtio_dev_probe+0x389/0x610
> [  237.450648]        really_probe+0x136/0x620
> [  237.451141]        __driver_probe_device+0xb3/0x230
> [  237.451719]        driver_probe_device+0x2f/0xe0
> [  237.452267]        __driver_attach+0x158/0x250
> [  237.452802]        bus_for_each_dev+0xa9/0x130
> [  237.453330]        driver_attach+0x26/0x40
> [  237.453824]        bus_add_driver+0x178/0x3d0
> [  237.454342]        driver_register+0x7d/0x1c0
> [  237.454862]        __register_virtio_driver+0x2c/0x60
> [  237.455468]        virtio_blk_init+0x6f/0xe0
> [  237.455982]        do_one_initcall+0x94/0x540
> [  237.456507]        kernel_init_freeable+0x56a/0x7b0
> [  237.457086]        kernel_init+0x2b/0x270
> [  237.457566]        ret_from_fork+0x268/0x4c0
> [  237.458078]        ret_from_fork_asm+0x1a/0x30
> [  237.458602]
> [  237.458602] -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
> [  237.459304]        __lock_acquire+0x1835/0x2940
> [  237.459840]        lock_acquire+0xf9/0x450
> [  237.460323]        __mutex_lock+0xd8/0xf50
> [  237.460813]        mutex_lock_nested+0x2b/0x40
> [  237.461332]        blk_unregister_queue+0x53/0x180
> [  237.461905]        __del_gendisk+0x226/0x690
> [  237.462421]        del_gendisk+0xba/0x110
> [  237.462903]        sd_remove+0x49/0xb0 [sd_mod]
> [  237.463457]        device_remove+0x87/0xb0
> [  237.463939]        device_release_driver_internal+0x11e/0x230
> [  237.464607]        device_release_driver+0x1a/0x30
> [  237.465162]        bus_remove_device+0x14d/0x220
> [  237.465700]        device_del+0x1e1/0x5a0
> [  237.466167]        __scsi_remove_device+0x1ff/0x2f0
> [  237.466735]        scsi_remove_device+0x37/0x60
> [  237.467260]        sdev_store_delete+0x77/0x100
> [  237.467789]        dev_attr_store+0x1f/0x40
> [  237.468277]        sysfs_kf_write+0x65/0x90
> [  237.468766]        kernfs_fop_write_iter+0x189/0x280
> [  237.469339]        vfs_write+0x256/0x490
> [  237.469800]        ksys_write+0x83/0x190
> [  237.470266]        __x64_sys_write+0x21/0x30
> [  237.470767]        x64_sys_call+0x4608/0x4630
> [  237.471276]        do_syscall_64+0xdb/0x6b0
> [  237.471766]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  237.472404]
> [  237.472404] other info that might help us debug this:
> [  237.472404]
> [  237.473304] Chain exists of:
> [  237.473304]   &q->sysfs_lock --> &q->rq_qos_mutex --> &q->q_usage_counter(queue)#3
> [  237.473304]

I think we should acquire ->freeze_lock first followed by ->rq_qos_mutex.
For reference, please see blkg_conf_open_bdev_frozen().

Thanks,
--Nilay

