Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8324CA9EBB
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B28F2166E
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p1qenOjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJXJSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:18:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60348 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389968AbfJXJSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 05:18:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O9EGD4124318;
        Thu, 24 Oct 2019 09:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=yy6Ej6bPbdHRge8pNzmgMQ209TF9qUpEHaA+06l93BU=;
 b=p1qenOjyH1nY9gzrnbudCnLlZZtFelLwnsqRGAfgPg6IwhQsa73JhhBw4P3RUuVhxR7B
 93iEcs4HSb+tV8oCbEqNFUGaKKfqrngh/tStGyo0T2qVxfmcyN5liCjC+myLGMc+W9MQ
 JN+z46w+Yqfn3Bny67Wvv4HJLbZwkSPuyGfDjlViiJZTO9TLNGGwxilZ/KMy9zStUf3w
 KopWiqn9nu5QN5wBRs1rIMbkFNatF6zUEUj7HDfAX+UKw3uNAzoBb0m0rv1kdNwpr7pD
 XsK9U+mxzx2Avs7Nidv4oLLayszBHoyb+Cz2tHt/0y8lhTsGQqMu4ZCs2/KG1RhGGUuS 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vqswttf8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 09:18:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O9Ifxc100650;
        Thu, 24 Oct 2019 09:18:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vtjkj3b18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 09:18:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9IOiJ016235;
        Thu, 24 Oct 2019 09:18:24 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 02:18:24 -0700
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC 0/2] io_uring: examine request result only after completion
Date:   Thu, 24 Oct 2019 02:18:06 -0700
Message-Id: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240090
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Running an fio test consistenly crashes the kernel with the trace included
below.  The root cause seems to be the code in __io_submit_sqe() that
checks the result of a request for -EAGAIN in polled mode, without
ensuring first that the request has completed:

	if (ctx->flags & IORING_SETUP_IOPOLL) {
		if (req->result == -EAGAIN)
			return -EAGAIN;

The request will be immediately resubmitted in io_sq_wq_submit_work(),
potentially before the the fisrt submission has completed.  This creates
a race where the original completion may set REQ_F_IOPOLL_COMPLETED in
a freed submission request, overwriting the poisoned bits, casusing the
panic below.

	do {
		ret = __io_submit_sqe(ctx, req, s, false);
		/*
		 * We can get EAGAIN for polled IO even though
		 * we're forcing a sync submission from here,
		 * since we can't wait for request slots on the
		 * block side.
		 */
		if (ret != -EAGAIN)
			break;
		cond_resched();
	} while (1);

The suggested fix is to move a submitted request to the poll list
unconditionally in polled mode.  The request can then be retried if
necessary once the original submission has indeed completed.

This bug raises an issue however since REQ_F_IOPOLL_COMPLETED is set
in io_complete_rw_iopoll() from interrupt context.  NVMe polled queues
however are not supposed to generate interrupts so it is not clear what
is the reason for this apparent inconsitency.

fio job
-------
[global]
filename=/dev/nvme0n1
rw=randread
bs=4k
size=4G
direct=1
time_based=1
runtime=60
randrepeat=1
gtod_reduce=1

fio test
--------
fio nvme.fio --readonly --ioengine=io_uring --iodepth 1024 --fixedbufs --hipri --numjobs=8

panic trace
-----------
[  450.395076] BUG io_kiocb (Not tainted): Poison overwritten
[  450.537797] -----------------------------------------------------------------------------
[  450.537799] INFO: 0x00000000cb333e0b-0x00000000cb333e0b. First byte 0x7b instead of 0x6b
[  450.656496] RIP: 0010:blkdev_bio_end_io+0x71/0xe0
[  450.772066] INFO: Allocated in io_submit_sqe+0x84/0x3d0 age=555 cpu=9 pid=3665
[  450.772070]  __slab_alloc+0x40/0x62
[  450.868914] Code: 75 3c 0f b6 43 32 4c 8b 2b 84 c0 75 0a 48 8b 73 08 49 01 75 08 eb 0b 0f b6 f8 e8 aa 9c 0e 00 48 63 f0 48 8b 03 31 d2 4c 89 ef <ff> 50 10 f6 43 14 01 74 32 48 8d 7b 18 e8 0d 56 0e 00 eb 27 48 8b
[  450.925197]  kmem_cache_alloc+0xa3/0x260
[  450.925198]  io_submit_sqe+0x84/0x3d0
[  451.011642] RSP: 0018:ffffc90006908e28 EFLAGS: 00010046
[  451.053353]  io_ring_submit+0xd5/0x150
[  451.053355]  __x64_sys_io_uring_enter+0x14e/0x290

Bijan Mottahedeh (2):
  io_uring: create io_queue_async() function
  io_uring: examine request result only after completion

 fs/io_uring.c | 122 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 89 insertions(+), 33 deletions(-)

-- 
1.8.3.1

