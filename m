Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CFC433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C9820659
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GrylOnjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGaVBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:01:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17945 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaVBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 17:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564606895; x=1596142895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Uc9TthtR9NnaW61L0kXW7vaDMv3lHgKYDZLVYJi5404=;
  b=GrylOnjMEN56GCaLffUkA8ojymIZQ79I+VyQ2OckgLtjJca+FOh9NHG4
   /vwtfM9AAfyg3pHXqGo/cAm2eT4rr20hLc+jWAma4dW3y9/4g8pf5lp5W
   2c0NuCKRdTO0CTz9MAshTtdG5BySLJmYElg4wwER8K3wvFHZopaqvrrIR
   D7v3FAV5DqwlbGypH55W7a4cBM0zuSSEzHkX9mygYGZ5btR2WEPD5hrmP
   gg8mVFZsc8k3dbNG+kOaM5PDOgSMwW2o7TkwRRznh3rl3X9IGYTPBQAkP
   HIAtaxnzTBgaH2QMAGYyteuWyW0yewlPHE7CLcuskYKHR5mQ/0YuJOZJ/
   w==;
IronPort-SDR: YaJUD6/VIEsevjYw0jsqVG4PiFJhobkkohVj3TPT9mvn1vHpUbSQDOH1vfrbKX6aAS262vZmbt
 13cI4PIHrspRfm/w3AsipNQPwA86Uz+Zk81kLxGAp69+cHDwnhTQIJ32xt0OCAU3itDtOs7/P4
 vGDfL5s8IwnLGpYThaReJ0vL6XZVcFg6VIcZABbO24gIgylyVG6jY6dFHz/NKT9lDU4LG0bHp6
 6RZ/RnKhz7RY9Eejje0VaIh/NtOYU5IMRn1ZrmRuPs9c022KG6saDTo1b8CIHLltv4ZWk4Ylau
 MmU=
X-IronPort-AV: E=Sophos;i="5.64,331,1559491200"; 
   d="scan'208";a="221104959"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 05:01:31 +0800
IronPort-SDR: iszyYmGP4yl5R0LNhtzM34BDmtyjOTaCW//GnYYSWQz/SRAV1PTQAvJcdnuDH0WeMhXj/Eiij7
 hol2MJa8JE6ouuN38AaZNpuskRKlgRH/+boPL/BJnGA1N5G2c2i0SeJSZ943uFmUByJGPT91fz
 xDaU2Gfj6dSQxhScW0tFEsynitXy2zVW+TX1D1UbHnhuJPrjC0kJfe0ahV5KrvPTfqWx3nmvCZ
 6q4kocNidWF/VrdV6DTDwBqF/0+ZXbJXRbYE5gVKnxQsyOJHwrnvqtpfiCiTjTlnWjGcG9klWw
 HgOdEKAwDD+FdhvagEqzb4WP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 13:59:32 -0700
IronPort-SDR: jcTMF2wgp01/wp9D91MD+1rWgcw8U4Sf2Nkhjuwc5/gKuAc42SrAjy3kCy/K/iOu+jePn/PlDD
 0kkguQjDx6rY2F7LO3TLr+4YKiHOutb8YvyX164qBUFqTFsr2YKnI0zHC+Ee7a0EyL+ClqKETr
 oQD1kN6ofx1kTUfk186PEc7aypDISDh2bCsx6kLoqiqwHc8bNRJaB3Cgs/FSGfePWBU1hm9uRl
 9qXUjC6VdZvHGKHjhuNvIlPrtINWGFD0ieI1V7IzOFDWHLWUgSXlP7dD24qZ0XpsggxMco2xAc
 eKc=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2019 14:01:31 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, dennis@kernel.org,
        hare@suse.com, damien.lemoal@wdc.com, sagi@grimberg.me,
        dennisszhou@gmail.com, jthumshirn@suse.de, osandov@fb.com,
        ming.lei@redhat.com, tj@kernel.org, bvanassche@acm.org,
        martin.petersen@oracle.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/4] block: add req op to reset all zones and flag
Date:   Wed, 31 Jul 2019 14:00:59 -0700
Message-Id: <20190731210102.3472-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch introduces a new request operation REQ_OP_ZONE_RESET_ALL.
This is useful for the applications like mkfs where it needs to reset
all the zones present on the underlying block device. As part for this
patch we also introduce new QUEUE_FLAG_ZONE_RESETALL which indicates the
queue zone reset all capability and corresponding helper macro.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blk_types.h | 2 ++
 include/linux/blkdev.h    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index feff3fe4467e..3991b580d6bd 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -282,6 +282,8 @@ enum req_opf {
 	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
+	/* reset all the zone present on the device */
+	REQ_OP_ZONE_RESET_ALL	= 8,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375dafb1c..474008bffee2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -611,6 +611,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
+#define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -630,6 +631,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
+#define blk_queue_zone_resetall(q)	\
+	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
-- 
2.17.0

