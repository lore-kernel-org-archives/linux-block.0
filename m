Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DD1C9B60
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791059; cv=none; b=Z9uqjvHWa6PQ8a4m1m3xHGlSNv/FRvmlCgIOQvrm9mretbCEgthiIwemO/KyXvRaA0Hk8va20KE0uJv4Tu4LNH7z1y+GxghIAO4T8vepdp227OrkNeq09Ge+wxxH83FWMUM6bZkbdOYzYVONemUALnaG5WX1x5ZT90OMECev+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791059; c=relaxed/simple;
	bh=DqLhZwc+SzMy2eX1FMrrtZ4zM6AN6MyhMU3gOHgLIC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6r8juqIgfZP2V5uZ+c9r394QfjZVIzIKIUXdBDV1UBoygzAUupCugijw4ebZLOyYKDJGMrmGR8eskdqqHoZquEwv0VdD2zFbRjF3fCgRhwmx+T/dcbZd0TG8pqIHPrQ/pTX/XAlGWUVzI7n/dRmmWn4b6ZNUsV63+RpaNXeJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=STQ4phvH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="STQ4phvH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4918lgT7014805;
	Tue, 1 Oct 2024 13:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
	cDClrIPdyHnEEede/wIAY0aPrNF6OqUfHaH9T4F+rY=; b=STQ4phvHGGglmh0pp
	fc98XZ/EeHvH0bdoDypmjeNHnFxCV6b9QMMhk9FCuIaX7JkRV1Kw1Zs+ssqaV61w
	bYD9TL+MjWCn8gy2yt27G5er6Z5K6LcU9GoGf+/418kyEiO4u8/nyj4DUTmi5J+l
	zdiyFyBmUSvjMPRgheLrfHtHPpCemLbpbKEaUtUeKGvP94k9dGgnFgisfA7Ikhf5
	xfJj/3OGNtw9pvs5Tisx9qeQBtllUGP1dKAtlSxCEXnc2NWTpaaWlEofgkciKQK0
	Zyj7PjHAv8E7gPxITs18ef9h+YG7o806HVUjR4XxRljJZ+QvikYtLejihqZyuuOf
	Iu2Dg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420c5ba5vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:57:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491DvYI6007739;
	Tue, 1 Oct 2024 13:57:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420c5ba5v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:57:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491DWRW9002346;
	Tue, 1 Oct 2024 13:57:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu14cu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:57:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491DvXRo42140064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 13:57:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D3A758064;
	Tue,  1 Oct 2024 13:57:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976715805A;
	Tue,  1 Oct 2024 13:57:31 +0000 (GMT)
Received: from [9.109.198.143] (unknown [9.109.198.143])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 13:57:31 +0000 (GMT)
Message-ID: <7109d82a-4e98-48be-b9a9-1d6208874f1f@linux.ibm.com>
Date: Tue, 1 Oct 2024 19:27:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed after blktests block/001
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kzq-L468GfLKAENA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kzq-L468GfLKAENA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QDiYPbX1hSNV6-cL3un3l1TpeO0QpvS3
X-Proofpoint-ORIG-GUID: fGlGxK1Habd6qzcK5cX5A57qA-GQs3u7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010089



On 9/29/24 20:10, Yi Zhang wrote:
> Hello
> 
> The kmemleak issue was easily triggered during blktests block/001 on
> the latest linux-block/for-next,
> please help check it and let me know if you need any info/test for it, thanks.
> 
> 
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888cc28666c0 (size 32):
>   comm "modprobe", pid 11054, jiffies 4305180646
>   hex dump (first 32 bytes):
>     73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
>     64 00 a6 02 7d c0 f5 04 00 00 00 00 00 00 00 00  d...}...........
>   backtrace (crc 6250ed84):
>     [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
>     [<ffffffffb36513a6>] kstrdup+0x36/0x60
>     [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
>     [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
>     [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
>     [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
>     [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
>     [<ffffffffc36f45b8>] null_init+0x5a8/0xff0 [null_blk]
>     [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
>     [<ffffffffb30da9e8>] do_init_module+0x238/0x790
>     [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
>     [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
>     [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
>     [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
>     [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff888c82cf69c0 (size 32):
>   comm "modprobe", pid 11104, jiffies 4305186132
>   hex dump (first 32 bytes):
>     73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
>     64 00 ef 42 3d 89 fa 04 40 68 1d 36 00 ea ff ff  d..B=...@h.6....
>   backtrace (crc 46e1640c):
>     [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
>     [<ffffffffb36513a6>] kstrdup+0x36/0x60
>     [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
>     [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
>     [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
>     [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
>     [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
>     [<ffffffffc36f65b8>] 0xffffffffc36f65b8
>     [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
>     [<ffffffffb30da9e8>] do_init_module+0x238/0x790
>     [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
>     [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
>     [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
>     [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
>     [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff888c49ee9700 (size 32):
>   comm "modprobe", pid 12268, jiffies 4305219508
>   hex dump (first 32 bytes):
>     73 64 65 62 75 67 5f 71 75 65 75 65 64 5f 63 6d  sdebug_queued_cm
>     64 00 ce 89 f6 a8 04 c4 00 00 00 00 00 00 00 00  d...............
>   backtrace (crc 267cbe53):
>     [<ffffffffb378fa9b>] __kmalloc_node_track_caller_noprof+0x36b/0x440
>     [<ffffffffb36513a6>] kstrdup+0x36/0x60
>     [<ffffffffb5555d13>] kobject_set_name_vargs+0x43/0x120
>     [<ffffffffb555639b>] kobject_init_and_add+0xdb/0x160
>     [<ffffffffb378f6c4>] sysfs_slab_add+0x194/0x1f0
>     [<ffffffffb3792286>] do_kmem_cache_create+0x256/0x2c0
>     [<ffffffffb367436f>] __kmem_cache_create_args+0x20f/0x310
>     [<ffffffffc36f65b8>] 0xffffffffc36f65b8
>     [<ffffffffb2c03cec>] do_one_initcall+0x11c/0x5c0
>     [<ffffffffb30da9e8>] do_init_module+0x238/0x790
>     [<ffffffffb30de801>] init_module_from_file+0xd1/0x130
>     [<ffffffffb30deaa0>] idempotent_init_module+0x230/0x770
>     [<ffffffffb30df25e>] __x64_sys_finit_module+0xbe/0x130
>     [<ffffffffb56bba12>] do_syscall_64+0x92/0x180
>     [<ffffffffb580012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 
> 
> --
> Best Regards,
>   Yi Zhang
> 
> 
Apparently, the memory leak is detected in mm/slab code. I believe there's no issue in the 
block layer code. After further debugging I found that the fix implemented in commit 
4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immediately") caused the observed 
symptom. The fix implemented in 4ec10268ed98 caused a subtle side effect due to which while 
destroying the kmem cache, the code path would never get into sysfs_slab_release() function 
even though SLAB_SUPPORTS_SYSFS is defined and slab state is FULL. Due to this side effect, 
we would never release kobject defined for kmem cache and leak the associated memory.
    
The issue here's with the use of __is_defined() macro in kmem_cache_release(). The 
__is_defined() macro expands to __take_second_arg(arg1_or_junk 1, 0). If "arg1_or_junk" is 
defined to 1 then it expands to __take_second_arg(0, 1, 0) and returns 1. If "arg1_or_junk" 
is NOT defined to any value then it expands to __take_second_arg(... 1, 0) and returns 0.
    
In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any associated value and that 
causes __is_defined(SLAB_SUPPORTS_SYSFS) to always evaluate to 0 and hence it would never invoke 
sysfs_slab_release().

The following patch shall help fix this:

diff --git a/mm/slab.h b/mm/slab.h
index f22fb760b286..3e0a08ea4c42 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -310,7 +310,7 @@ struct kmem_cache {
 };
 
 #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
-#define SLAB_SUPPORTS_SYSFS
+#define SLAB_SUPPORTS_SYSFS 1
 void sysfs_slab_unlink(struct kmem_cache *s);
 void sysfs_slab_release(struct kmem_cache *s);
 #else

I will post the above patch in mm/slab mailing list.

Thanks,
--Nilay 
