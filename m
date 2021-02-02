Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA0C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9FC64E94
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhBBFci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:32:38 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26499 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhBBFcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243955; x=1643779955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LyeFeoshqjgI2rNYAGq0Im5Ns+zauYn+vP0jM5YnlNY=;
  b=SMyvCvFE7Ty/dCdsNCdlGcW+Y6njUx1j4ub7XKGsM1fuLCy64TTKfLFM
   HhzjOsQWVaEZGXCnL9hXQhk75hO/6az/20SjAi04zP5uC/KfWsWLP4n+I
   5A9XJQQ5r/A7i0PRhAKkrcnVnnkElJyiCa8Ic7+qTrVm96saxgQ1I75ZN
   nE5gvPEaRdwzM9pdRXehUJoTb0MWGiXAR99I9oafYCzPK4/52dqMFJS9a
   NJJ22GvRF7wTbBdtfgDkC/8CoOiGLvI+UQ/c9C2HsrMESSlc11F4U+T6i
   w2eW4iUXfqkcTuNs7b4gbv4fkufwGuXgKlQrFYoiSDDsuQnZfLNIS9d7F
   A==;
IronPort-SDR: nY8rvhWT0oGzlerd0zPIf4fnfuVEyOwByMCHnNMvtRJxz59NB2thAX18kbTBGMBnTqQ+aUgQGt
 5tzreLc6K/fnF3cVeml0grc8RBYAR/Tgmh/tkhykrTwvG6dFgl635oJeobfYsdpSrO9UZ0fsBl
 Boluw43bl9Het8znkWYuM8colRqr8IT6wIQuu3hCAUrPyRWvk2+YKVWhseq0+cmO3oxqYbavXw
 MDi5Qqzw0SzvAc27nW5Z57uKBMs2iALjyUQexnL4JMLBmt/soNtL+/XY7a/PPtwQjFvTebfwVS
 v4s=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160066381"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:26:45 +0800
IronPort-SDR: ZKei8qLMMz1bjOZSyKMoluIfRiLyvhrw7oDlmfYr9OtvBkjCIYgrFk1dcNkQKzQO/xbAQXhupP
 22Nz+P8n+68AO2pvXyKuc2ZkfMXxSMVTblLra4lnmeZXSk2oDMLZquUmgyb8sdo+fFy9wP/oWJ
 sEF2w7rkg2/u4J21w3aQFRw7PKIVq4yoT2/m7fHM/4kQF1bjoXQUFpKiEpCaz/MRYWnk8jL0qJ
 Q6B38PktqmdcUtwRnlDzL+EsgVCaYd00BvDupr+Rxxe09aqqHoSfd8hMH3CRx0wrGR2npzsga1
 4IrTHrho8+3++kdYmMcq6koW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:08:53 -0800
IronPort-SDR: 0UYPYdsDr63rqvEu2+LgsgDTpJCr8bvzuMHdsu/GvXD5vaSRzRSXzRhRlLCWYDv2NGGIIgA7Rb
 NtgdBtL3eEfhas4E98fF4WR+cJXhCYwmUbzIYhLYoSynO6gzEkD98PdvbLiJmGzPWYP5XlBzKC
 9DFIqHaVCl0kymljw/5bYIkweveIa+EtEOFjC4vOK+THLt4HqTmBIk3duzhy/YoqT9Lj8AUEU1
 QqrdGjByyb6Gkqq2D72xl4wgTxoNXpOPlyaFRm8w/bUDpOEBDsO3SyG9jaqjbg5Sqis84vL769
 +u4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:26:44 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH 6/7] null_blk: allow disacrd on non-membacked mode
Date:   Mon,  1 Feb 2021 21:25:35 -0800
Message-Id: <20210202052544.4108-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

null blk driver supports REQ_OP_DISACRD in membacked mode. When testing
special requests having REQ_OP_DISCARD support is helpful to validate
the special request path when mixed with read-write.

Consider module parameter when setting the queue discard flag when
device is not memory backed.

This is needed to test the tracepoint related to REQ_OP_DISCARD.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
# modprobe  -r null_blk
# gitlog -7 
4ac4d49e1028 (HEAD -> for-next) null_blk: add module param queue bounce limit
468e3617dae8 null_blk: allow disacrd on non-membacked mode
bdc96efe9681 block: get rid of the trace rq insert wrapper
73bf523a7ce4 blktrace: fix blk_rq_merge documentation
6016632555da blktrace: fix blk_rq_issue documentation
58b5d7103a94 blktrace: add blk_fill_rwbs documentation comment
534f321f57dd block: remove superfluous param in blk_fill_rwbs()

Test to exercise module parameter vs configfs discard param, set up
nullb0 such a way that it errors out in both cases for module param
discard :-

for discard in 0 1
do 
	modprobe -r null_blk
	i=0
	echo "Module param discard ${discard}"
	modprobe null_blk nr_devices=0 discard=${discard}
	# Create dev 0 no discard 
	NULLB_DIR=config/nullb/nullb${i}
	mkdir config/nullb/nullb${i}
	echo 1 > config/nullb/nullb${i}/memory_backed
	echo 512 > config/nullb/nullb${i}/blocksize 
	echo 2048 > config/nullb/nullb${i}/size 
	echo 1 > config/nullb/nullb${i}/power
	echo -n "$nullb${i} membacked : ";
	cat /sys/kernel/config/nullb/nullb${i}/memory_backed 
	echo -n "$nullb${i} discard   : ";
	cat /sys/kernel/config/nullb/nullb${i}/discard
	# Create dev 1 with discard 
	i=1
	NULLB_DIR=config/nullb/nullb${i}
	mkdir config/nullb/nullb${i}
	echo 1 > config/nullb/nullb${i}/memory_backed
	echo 512 > config/nullb/nullb${i}/blocksize 
	echo 2048 > config/nullb/nullb${i}/size 
	echo 1 > config/nullb/nullb${i}/discard
	echo 1 > config/nullb/nullb${i}/power
	echo -n "$nullb${i} membacked : ";
	cat /sys/kernel/config/nullb/nullb${i}/memory_backed 
	echo -n "$nullb${i} discard   : ";
	cat /sys/kernel/config/nullb/nullb${i}/discard

	# should fail 
	blkdiscard -o 0 -l 1024 /dev/nullb0 
	# should pass
	blkdiscard -o 0 -l 1024 /dev/nullb1

	echo 0 > config/nullb/nullb0/power
	echo 0 > config/nullb/nullb1/power
	rmdir config/nullb/nullb*

	modprobe -r null_blk
	modprobe null_blk
	# should fail 
	blkdiscard -o 0 -l 1024 /dev/nullb0 
	modprobe -r null_blk
	modprobe null_blk discard=1
	# should pass
	blkdiscard -o 0 -l 1024 /dev/nullb0 
	modprobe -r null_blk
	echo "--------------------------"
done

modprobe -r null_blk
modprobe null_blk
blkdiscard -o 0 -l 1024 /dev/nullb0 
modprobe -r null_blk
modprobe null_blk discard=1
blkdiscard -o 0 -l 1024 /dev/nullb0 
modprobe -r null_blk

# ./discard_module_param_test.sh 
Module param discard 0
0 membacked : 1
0 discard   : 0
1 membacked : 1
1 discard   : 1
blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported
blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported
--------------------------
Module param discard 1
0 membacked : 1
0 discard   : 0
1 membacked : 1
1 discard   : 1
blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported
blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported
--------------------------
blkdiscard: /dev/nullb0: BLKDISCARD ioctl failed: Operation not supported
---
 drivers/block/null_blk/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..6e6cbb953a12 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -172,6 +172,10 @@ static bool g_shared_tag_bitmap;
 module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);
 MODULE_PARM_DESC(shared_tag_bitmap, "Use shared tag bitmap for all submission queues for blk-mq");
 
+static bool g_discard;
+module_param_named(discard, g_discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Enable queue discard (default: false)");
+
 static int g_irqmode = NULL_IRQ_SOFTIRQ;
 
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
@@ -1588,14 +1592,11 @@ static void null_del_dev(struct nullb *nullb)
 
 static void null_config_discard(struct nullb *nullb)
 {
-	if (nullb->dev->discard == false)
+	if (nullb->dev->memory_backed && nullb->dev->discard == false)
 		return;
 
-	if (!nullb->dev->memory_backed) {
-		nullb->dev->discard = false;
-		pr_info("discard option is ignored without memory backing\n");
+	if (!nullb->dev->memory_backed && !g_discard)
 		return;
-	}
 
 	if (nullb->dev->zoned) {
 		nullb->dev->discard = false;
-- 
2.22.1

