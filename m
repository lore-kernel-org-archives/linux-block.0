Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70AEC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945992063F
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gy9s7EnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406379AbfFKUC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:02:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61749 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405168AbfFKUC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 16:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560283349; x=1591819349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yeuk03emhL+SdqUWcwHbKoWFC2k0G1Yb8U5chcQBn2g=;
  b=gy9s7EnYhxQWODMzDgZzQWlr668HPqtiMy52Y/T+f5pKF+UDme36EwWS
   z8OFUldrhfzm8ai5kNR8g1UYCnn/BzuaOddIHz2pasE6fbRMQvJzQmRWc
   TdNn+AnRAsEoJiCwAOzPNGaid4TOYkkVEp3SkKPpSLHVOrvoNbn3cG4tK
   o5A+u2k0LreUE4OKfEdIO1P1rgURvqSVfytS+yS6O7wX3RVmYsn3wwrhK
   +Mda5t3Vxh68LZldWxrIqbmRXnRGy6/uD4cXg9Ru9qQ5Gw+j01ylCQyWU
   XvVPgPGyWga8wRXjvUD01nIjfWY3qeprOSyFKjmsTK9MQ7+qJOnVLSlan
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,362,1557158400"; 
   d="scan'208";a="115255369"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 04:02:14 +0800
IronPort-SDR: 9oRHg5Ak6swScuz42xVgEmjwrbTFLTxchzOr+xe87Ub2NdypuBEGaKHR6hdne06wp3OilZWPZW
 9Xpac9SCY/pS3rjxrwL0RNNfcCwQ03MRgYXcZQHsMrfjRA6U8Vb8/fgt0dGRaJs659s5FE8bu9
 IANniNMQnBQfNZdyaR9doph5RYwrtjJ8WgicQr4QjwSGYTRhslHgkY9uSx86jp6UsqZv9X4Um0
 TZ3YEdGzDYQH4zzrXMvIggt83TZr37PHJC3sNQJzFp2oKWC8qL6Ve2DtxOh7K005DbT0mjN2z0
 E9zCaupDJqdnZFgbouLGfgBi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jun 2019 12:39:22 -0700
IronPort-SDR: 4fNNjf8XfuAx1X5RSbbb6YSPVGmcwNluHHQKj0BCHA6AY79ueJFYJINlMxWM6ZLikCs2D5+OEH
 lIk+wEvKc+2LgUDCiSDxOxCdKXoaMb2kkMXFu//Zkom4e0YtXjkWGCNiQZ0zSh9wiOnB1JYbSj
 GMBCF7ISmRdtDRRoHJjlacqdlVj20J5LDKuiN9XuuI3AfxgBdROW6VxjiE52IjiAV+ENJoSgMK
 hohOHK/gay4JaJIK/suqXNHtx/TSbKO0uFmapG4UQ4E2c4FnWy09UakbjGFzKvenHk8unHo0Zv
 B24=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jun 2019 13:02:13 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/2] block: improve print_req_error()
Date:   Tue, 11 Jun 2019 13:02:08 -0700
Message-Id: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch-series is based on the initial patch posted by 
Christoph Hellwig <hch@lst.de>. I've added one more patch to improve
further print message.

While debugging the driver and block layer this print message is very
handy.

Please consider this for 5.3.

-Chaitanya

Following is the sample error message with forced REQ_OP_WRITE failure
from null_blk:-

blk_update_request: I/O error, dev nullb0, sector 0 op 0x1:(write) flags 0x8800 phys_seg 1 prio class 0


Chaitanya Kulkarni (1):
  block: add more debug data to print_req_err

Christoph Hellwig (1):
  block: improve print_req_error

 block/blk-core.c | 67 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 7 deletions(-)

-- 
2.19.1

