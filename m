Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910592;
	b=OkqK8CVNT70Gn5Bt0uHrH5qOZTGyt/XpIcTrZS5B398zOfB47S67x/5hIFlqT7m1M3G5
	 WwvfcxEwRvTVPFwrBFJpnVk6d7/d/ZNHndj/+l15RfvhwfpxLyftplQlnQYMsk80kzfDk
	 BfM6Tl3YsL5EAhMmfeRaLVXccoY/mmDQdp8mruniYqf0mjpuhWE9K657A7SoTOc4Rq+QH
	 axElIfsfGqm8xiNmtBm9xF0zn4ngSQGzdxASwdJKJ37JyMqiORw5xuo/zMnFDHoqJasXG
	 QClPyMXAsAydSkchpGY2sqs9GnlpHXIHVfPA7NzgtVhMxExAEzsAMRZ5EpKU4u9by5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/nZzov8N+zyyuqAcE43h/bSIm3E1Cc1jzIpE1+g+dck=;
	b=rKVtHXa8YDilQWKDjWN2a3+8W581TduwcAROoytugsIPxW6eNvjQ1+J2xy4rJl+FhwV9
	 3d5tDVi2SVg8dPYOTxzL+lobsGQTb244Zyw1xVpzfMaw01XF4nj+NI5KnOaS9n1hIDO8Y
	 pPbEtCjTuteZgLscxndebTX1Zg/SGUS5SGPnYxB8BtUq4rNCUZL3/72EJBxJqPYppGtto
	 ujN6TYmPw1xcF4du079kTNLMFcPUWMUjEX72u+q9s7v3FLVoMrn8pc5WZemN/C+a8R9Bn
	 TPtkJ6BXrBUxvaVHLUMnR3qoRvPuIaYqNMV+OAcYKGVW0dKkZ9cic4/KBV0w0qvcMnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F4nAnTX+;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A17606A32F
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 20:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A17606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F4nAnTX+
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366ae57896so25174731cf.3
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2026 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910591; x=1794515391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nZzov8N+zyyuqAcE43h/bSIm3E1Cc1jzIpE1+g+dck=;
        b=F4nAnTX+kii+PCwyyE0+1CUq6xJegQw9Tm8KNoyuKGVdIP/Ko9Ng/U+c58ziik5Se9
         UUtqGZLNGD8+LVfbRtp/Nn6er98UzOlv0qPoeWxv9Nh3I8THKjTFfKaGjrpsCtTh+Qjv
         CqXTFPgAldeBlYd5Mxeh18m2WjlHgzjpBApFxVcnIDFh8CYhePDyr6YHwW4IaDbezSpg
         t2oJyRQHZliPfEgufGXaXggD561cfP6iBPdqU1zssg+TF8PA8b7TjDHVEMUvYtao4waB
         GmvCcEivjyLLWU7WVoX2mNB6pbbzQG+NpdAhScovptkBDsEEZmt5ct4uu6kSHh5hYg2w
         a8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910591; x=1794515391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nZzov8N+zyyuqAcE43h/bSIm3E1Cc1jzIpE1+g+dck=;
        b=2d1j52Y3DsfhlpbvuVyGS842HAgTQvDTZG/UvzZBsPbOeQEQRKYeO947/cn6uDE3AW
         L+31B9tkEOcSZ5SSrFeb3rJIxKdEENfjBdP93UxX1V/mygDZubR0S0oXLEdyZZukKRoh
         FXYldcexeaQcwFa0fCPFE2Va//pLyqdG0jb5IDaTilWY90Dri/akEo8Yp3z/1O7FRIK+
         6/wvjn4W0gmB5vjJyj0SmDAxGLJmApJ/b5hRNfYNu/cjDE2JaR306W3FXtxBbj7iI/GD
         M1lo3MTV33qIB5GKtZHtZSpcYQxfcEf74rUs6pM/dGyYbmn9chQNNvWlV2t0MKEXUS7D
         kMgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkpQKMzaqV/6y/W3U0IUgWbt9UjLxP3WX7wb/Gq1JMoDgDWYFguOCQqYFv22t2T4Enz+k9Vv8ffzVQ7g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hnbVGaoiyIAKDLQsK/EiG94Fq0tPv0iQOD5c7OuNeSrqQGYRj
	6oNW5LS8AhRxRzTvccjgK1YbsCCOzMBmhLp4YFvKV5ox1vPuXu5xqZOhQHEsAyED
X-Gm-Gg: AYBFou3OhhH48VJQEjCeaN8KkCQ8b4kGfYWbd2o4IG+XcR6DJvorIIH6++Z7Q9EamR2
	0eJVFjNKVA7t8ePMjcZZe/aPYuGyEGpaRlIF5osv0wqNqRzMoiwMGRhbapKwU9GAGfhoPcYIgo7
	rjW/5Ase0eCyniG7vTbMkpwc4qzEsjFuTe7t6KTvq363JiQa6UOhbxSoSd5jqBZKva1Xrd90fBx
	PErhGVeUpTDkGLYUE11x3mVQil+oe/F7nBSrmmD8hHGZqr8bUz1NQsLOLNrrMDe4WOtMijSsel5
	EoICiMt7EOLysycB8js4HNfaBhxtFA2z3710t4QifTK6LQKMKFaDqwT8IhSgkR0mh8LHm6OnAay
	2L/GD50BVgBeEpPQ9WbcC16vpwOrwQH3byyDahyLIz8hMXpgmtT3JQMG+v16IZZGMJTb+qLl1ZV
	UQH9JMKuh+C6T0JBbzshh7oHnZjW4f/GYSTKTso+Rlr/GB5zLiTdLHjlmmt9lFcO7AzT357EUUp
	khnGETVvo2ON1LAgmek3A2nuOu4HNIYps4btR6o/PlVBOUvSDAqSn2OAkfq9sqIcpqlwNTDQK8z
	VMFU4FWIZ+3ul+xaJx7ltEjY76c0WjYELbehFZuq9KiY1XGpdyY0zivLf0A=
X-Received: by 2002:ac8:5ad6:0:b0:536:6488:e7e4 with SMTP id d75a77b69052e-54e12fa003emr7137181cf.13.1793910590737;
        Thu, 05 Nov 2026 12:29:50 -0800 (PST)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e27502132sm1987361cf.28.2026.11.05.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:29:50 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [BUG] RDMA/rtrs-clt: KASAN use-after-free in rtrs_clt_query
Date: Thu,  5 Nov 2026 15:28:43 -0500
Message-ID: <20261105202939.3104321-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in rtrs_clt_query

on commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d (2026-11-03)

The reproducer triggers this report. It uses the supported RTRS path disconnect
and RNBD force unmap_device sysfs interfaces.

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/5409f0d93ab7414fcb6d97ac799fe28f

For context, I previously reported a related but distinct RTRS client
use-after-free in the same subsystem:
Link: https://lore.kernel.org/linux-rdma/20260921033339.1320291-1-shuangpeng.kernel@gmail.com/

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

==================================================================
BUG: KASAN: slab-use-after-free in rtrs_clt_query (drivers/infiniband/ulp/rtrs/rtrs-clt.c:59 drivers/infiniband/ulp/rtrs/rtrs-clt.c:3140)
Read of size 4 at addr ffff88810228d2f8 by task kworker/1:0/24

Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: rtrs_client_wq rtrs_clt_reconnect_work
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
rtrs_clt_query (drivers/infiniband/ulp/rtrs/rtrs-clt.c:59 drivers/infiniband/ulp/rtrs/rtrs-clt.c:3140)
rnbd_clt_link_ev (drivers/block/rnbd/rnbd-clt.c:691 drivers/block/rnbd/rnbd-clt.c:731)
init_path (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2161 drivers/infiniband/ulp/rtrs/rtrs-clt.c:2677)
rtrs_clt_reconnect_work (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2709)
process_scheduled_works (kernel/workqueue.c:3495 kernel/workqueue.c:3578)
worker_thread (kernel/workqueue.c:3659)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
</TASK>

Allocated by task 306 on cpu 1 at 11.590323s:
kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:409 mm/kasan/common.c:426)
alloc_path (include/linux/slab.h:991 include/linux/slab.h:1312 drivers/infiniband/ulp/rtrs/rtrs-clt.c:1540)
rtrs_clt_open (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2871)
rnbd_clt_map_device (drivers/block/rnbd/rnbd-clt.c:1288 drivers/block/rnbd/rnbd-clt.c:1571)
rnbd_clt_map_device_store (drivers/block/rnbd/rnbd-clt-sysfs.c:612)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Freed by task 306 on cpu 1 at 47.089348s:
kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:264 mm/kasan/common.c:296)
kfree (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:6630 mm/slub.c:6923)
kobject_put (lib/kobject.c:689 lib/kobject.c:720 include/linux/kref.h:65 lib/kobject.c:737)
rtrs_clt_close (drivers/infiniband/ulp/rtrs/rtrs-clt.c:2940)
free_sess (drivers/block/rnbd/rnbd-clt.c:770 drivers/block/rnbd/rnbd-clt.c:786)
rnbd_clt_put_dev (drivers/block/rnbd/rnbd-clt.c:49 drivers/block/rnbd/rnbd-clt.c:62)
rnbd_clt_unmap_device (drivers/block/rnbd/rnbd-clt.c:1723)
rnbd_clt_unmap_dev_store (drivers/block/rnbd/rnbd-clt-sysfs.c:334)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Last potentially related work creation:
kasan_save_stack (mm/kasan/common.c:57)
kasan_record_aux_stack (mm/kasan/generic.c:556)
insert_work (kernel/workqueue.c:2356)
__queue_work (kernel/workqueue.c:2546)
queue_work_on (kernel/workqueue.c:2599)
rtrs_clt_close_conns (include/linux/workqueue.h:700 drivers/infiniband/ulp/rtrs/rtrs-clt.c:1963)
rtrs_clt_disconnect_store (drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c:259)
kernfs_fop_write_iter (fs/kernfs/file.c:345)
vfs_write (fs/read_write.c:595 fs/read_write.c:687)
ksys_write (fs/read_write.c:739)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

The buggy address belongs to the object at ffff88810228d000
which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 760 bytes inside of
freed 2048-byte region [ffff88810228d000, ffff88810228d800)

Best,
Shuangpeng
