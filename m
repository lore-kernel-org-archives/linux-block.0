Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1F8C3F68F
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570322084E
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mGQQgiT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBODTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:19:53 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53493 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBODTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 22:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581736796; x=1613272796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xsR2n8HMtbr40xX/TMWrxT2gDLYItZq16GnQP4LAQIY=;
  b=mGQQgiT99Hhlem59mTG31HEXDn2SwHfiQ/Y/hVAFJY1Y+6YKzsty/JHS
   +yF+sh9XeHy4UecjZx25xIjpeRjCDzfhuWAqVPdhU7EEVS4TjQWyIxRa4
   YBKE97tiGDF7cjeE8VcdrtQhA/FQ1UrONp5ZQVZf9RHwAwDG+77sE4Vh7
   KaehsaUlxJlx94vtLlRpJWEtjfwAMG8Ai2jsWHAlTeKNu4Pdj2d79DEkx
   z59HxIcJayo5VXNo2f9gzyJBBHoi6X+6oqUgIH0Dazv+VWSJvsCatwKsM
   btRxFWVva2+yDLcY8VovD+LGHpRLkZm9didEvpiXMCwLtF70Khr+Xf5FM
   Q==;
IronPort-SDR: iPzfSBcZPHhQwC5mEV3T9GmAOyhZ3uOjdsfw+Lfyv+S25WIZ4yhk7FRa/n47UeNW9lbLf73coz
 urX7hjIjaFwFmm0sELRKrvi0D7z0t7UE3s98G0iKF/E9Szi7cs+U2vwGFV6qYfNq26HgkFP85W
 6Fv7lluQFp0W23vsqMmIfrvnk/2p7SmBjQQjOXml9MS6OXu+nuiyQ4vYZ3Kg1CdQtxhIrB01mj
 j8VT1E6wRU0Ryp1pUYGET4qL6NmMsvZCv0AWdnKvkVhqYRa7pbeD41P9t9Rfu9ejVnYvjvm0av
 Q60=
X-IronPort-AV: E=Sophos;i="5.70,443,1574092800"; 
   d="scan'208,223";a="231731625"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 11:19:56 +0800
IronPort-SDR: 57vRl+x7ovFsXO5lFYalPo6zm4mH6XBXO8SSbQk76ineS5d3/llUzEfq4b4/WMJjMC9P9Z0BpN
 r2a3mVbkKCBAsWjUQ0cinLisRx5WtAhsfcS+D8WGwi9MEDwDXIM2cfwbmfbWsmSHAZ+02qVQ12
 1I9Cm0SdW0aQmi1mMnkzaesKLU1lyk/Qh0ky7eVBOAukCn6/PrJ3dIpmLZwQ3S5xYbQNzz2yMt
 lM0/P7gNhhW0xX0ZToN/lLDzQdpjmXgfk0Dhq4GIFtrTldKyz6rrRP/bKWb7pbA8TTf1eVMnQA
 b/ch7fuxJumVGJS81eG0Tuef
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 19:12:36 -0800
IronPort-SDR: i9yYuSV5gKvHo4vb49OFeN+UQWKcz6+M9hhNacXghv4OkJKuqjMyDvGww333p4OOXiz3ulcbIG
 B0f+/J8mz69mUweP0FdR+uWnnbNe5ATwAcVzMsQJXsLM32SWmNHQbqNUa1c0JJbv+uEQpUssaQ
 NB+s6H2Ez4zPDfy735Wq4+xgjRvKaCux2HO8oNjoMUFgfqM1FoQ2vFNDAwjgEVTqMbd4MW6UOu
 pplTk1jtPrKZQnxM/5NuLDxRfzrwSXpN8p8u7PVxmJSvXnroGafoemPkwRtKOomH8RQrh02oqA
 oLg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 19:19:52 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     adobriyan@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: initialize cmd->error before use
Date:   Fri, 14 Feb 2020 19:19:50 -0800
Message-Id: <20200215031950.6688-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From : Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>

null_blk driver supports bio and request mode. For each mode when
processing a new request initialize cmd->error to BLK_STS_OK so that in 
the completion function it will indicate success by default instead of
using previously recorded error if any.

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Simple test log :-

1. Without Patch :- 
 # dd if=/dev/zero of=/dev/nullb0 bs=4k count=4096
 4096+0 records in
 4096+0 records out
 16777216 bytes (17 MB) copied, 0.262258 s, 64.0 MB/s
 # dmesg  -c 
1.1 Now write again to generate an error :-
 # dd if=/dev/zero of=/dev/nullb0 bs=4k count=4096
 4096+0 records in
 4096+0 records out
 16777216 bytes (17 MB) copied, 0.283751 s, 59.1 MB/s
 # dmesg  -c 
 [  600.946406] print_req_error: 3512 callbacks suppressed
 [   600.946409] blk_update_request: I/O error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  600.947701] buffer_io_error: 4086 callbacks suppressed
 [  600.947703] Buffer I/O error on dev nullb0, logical block 0, lost async page write
 [  600.949694] blk_update_request: I/O error, dev nullb0, sector 8 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.952283] Buffer I/O error on dev nullb0, logical block 1, lost async page write
 [  600.954002] Buffer I/O error on dev nullb0, logical block 2, lost async page write
 [  600.955722] Buffer I/O error on dev nullb0, logical block 3, lost async page write
 [  600.957472] Buffer I/O error on dev nullb0, logical block 4, lost async page write
 [  600.959228] Buffer I/O error on dev nullb0, logical block 5, lost async page write
 [  600.960622] Buffer I/O error on dev nullb0, logical block 6, lost async page write
 [  600.961587] Buffer I/O error on dev nullb0, logical block 7, lost async page write
 [  600.962529] Buffer I/O error on dev nullb0, logical block 8, lost async page write
 [  600.963473] Buffer I/O error on dev nullb0, logical block 9, lost async page write
 [  600.964574] blk_update_request: I/O error, dev nullb0, sector 256 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.966079] blk_update_request: I/O error, dev nullb0, sector 504 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.967897] blk_update_request: I/O error, dev nullb0, sector 752 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.969464] blk_update_request: I/O error, dev nullb0, sector 1000 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.972423] blk_update_request: I/O error, dev nullb0, sector 1248 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.975262] blk_update_request: I/O error, dev nullb0, sector 1496 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.977683] blk_update_request: I/O error, dev nullb0, sector 1744 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  600.979164] blk_update_request: I/O error, dev nullb0, sector 1992 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 # dd of=/dev/null if=/dev/nullb0 bs=4k count=100
 100+0 records in
 100+0 records out
 409600 bytes (410 kB) copied, 0.00286957 s, 143 MB/s
 # dmesg  -c 
 
1.2 Read from the device and expect an error :- 
 # dd of=/dev/null if=/dev/nullb0 bs=4k count=100
 dd: error reading ‘/dev/nullb0’: Input/output error
 92+0 records in
 92+0 records out
 376832 bytes (377 kB) copied, 0.0127975 s, 29.4 MB/s
 # dmesg  -c 
 [  633.362252] print_req_error: 3540 callbacks suppressed
 [  633.362261] blk_update_request: I/O error, dev nullb0, sector 984 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
 [  633.363834] blk_update_request: I/O error, dev nullb0, sector 992 op 0x0:(READ) flags 0x84700 phys_seg 23 prio class 0
 [  633.365366] blk_update_request: I/O error, dev nullb0, sector 1240 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
 [  633.365449] blk_update_request: I/O error, dev nullb0, sector 736 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
 [  633.368981] buffer_io_error: 4087 callbacks suppressed
 [  633.368983] Buffer I/O error on dev nullb0, logical block 92, async page read

2. With patch :-
 # dd if=/dev/zero of=/dev/nullb0 bs=4k count=4096
 4096+0 records in
 4096+0 records out
 16777216 bytes (17 MB) copied, 0.270187 s, 62.1 MB/s
 # dmesg  -c 

2.1 Now write again to generate an error :-
 # dd if=/dev/zero of=/dev/nullb0 bs=4k count=4096
 4096+0 records in
 4096+0 records out
 16777216 bytes (17 MB) copied, 0.464682 s, 36.1 MB/s
 # dmesg  -c 
 [  696.630879] blk_update_request: I/O error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  696.632550] Buffer I/O error on dev nullb0, logical block 0, lost async page write
 [  696.633733] blk_update_request: I/O error, dev nullb0, sector 8 op 0x1:(WRITE) flags 0x800 phys_seg 23 prio class 0
 [  696.636239] Buffer I/O error on dev nullb0, logical block 1, lost async page write
 [  696.637996] Buffer I/O error on dev nullb0, logical block 2, lost async page write
 [  696.639718] Buffer I/O error on dev nullb0, logical block 3, lost async page write
 [  696.641455] Buffer I/O error on dev nullb0, logical block 4, lost async page write
 [  696.643151] Buffer I/O error on dev nullb0, logical block 5, lost async page write
 [  696.644821] Buffer I/O error on dev nullb0, logical block 6, lost async page write
 [  696.645827] Buffer I/O error on dev nullb0, logical block 7, lost async page write
 [  696.646828] Buffer I/O error on dev nullb0, logical block 8, lost async page write
 [  696.647843] Buffer I/O error on dev nullb0, logical block 9, lost async page write
 [  696.649017] blk_update_request: I/O error, dev nullb0, sector 192 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  696.650580] blk_update_request: I/O error, dev nullb0, sector 200 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  696.652030] blk_update_request: I/O error, dev nullb0, sector 208 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  696.653491] blk_update_request: I/O error, dev nullb0, sector 216 op 0x1:(WRITE) flags 0x800 phys_seg 23 prio class 0
 [  696.656347] blk_update_request: I/O error, dev nullb0, sector 400 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  696.658912] blk_update_request: I/O error, dev nullb0, sector 408 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
 [  696.661490] blk_update_request: I/O error, dev nullb0, sector 416 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
 [  696.665040] blk_update_request: I/O error, dev nullb0, sector 664 op 0x1:(WRITE) flags 0x4800 phys_seg 31 prio class 0
2.2 Read from the device with no error :- 
 # dd of=/dev/null if=/dev/nullb0 bs=4k count=100
 100+0 records in
 100+0 records out
 409600 bytes (410 kB) copied, 0.00504116 s, 81.3 MB/s
 # dmesg  -c 
 # dmesg  -c
2.3 Read from the device with no error :- 
 # dd of=/dev/null if=/dev/nullb0 bs=4k count=100
 100+0 records in
 100+0 records out
 409600 bytes (410 kB) copied, 0.00435289 s, 94.1 MB/s
 # dmesg  -c

---
 drivers/block/null_blk_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 16510795e377..3bf9c05f9825 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -606,6 +606,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 		cmd = &nq->cmds[tag];
 		cmd->tag = tag;
 		cmd->nq = nq;
+		cmd->error = BLK_STS_OK;
 		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
 			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
 				     HRTIMER_MODE_REL);
@@ -1385,6 +1386,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->timer.function = null_cmd_timer_expired;
 	}
 	cmd->rq = bd->rq;
+	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 
 	blk_mq_start_request(bd->rq);
-- 
2.22.1

