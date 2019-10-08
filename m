Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44902C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 22:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1212F206BB
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 22:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="REliaA4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJHWj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:39:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22735 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHWj4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 18:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570574396; x=1602110396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uElll9fm9XbrCp1Xk7b+ueRL6BuDKeSfSRbTdD10YA8=;
  b=REliaA4zMKascwKJ/mwcGqK6GMMuX/Xcn+PebwdegmMx+3RZbJOQrnKf
   Q3BruZmAYMCsezuEKNgVsJcYAp9QvLeGQ/RIik4oiE6r4U6CaZ3+Riq+d
   4Id1UpxWNhSmN7HbsZ2VDZZc9nnmpAabKs0NwdvqCq5cHdM9X0fusiM48
   ocxqCdDWswGDZo/zPVZNLqJRKNT8cgytH2KPXpHNgMpNbK+Ad3iq76uVr
   iAvmkc5/gcGliKPTelog7V+riYzIJRIspBvDpq6BIHYZ0l/Panc//iqMW
   0Iiq3xwwgBx4ttBAA/qVtN4gtPlSdTPJwUXjZs3TGHrMWothTOPbPGnlW
   Q==;
IronPort-SDR: lYzOW3XeXmXCGabiLO6GCvRTMx7wui218xirkFv/VAKtCRJREHTcuPtZhPnmeATyzdkNBkaXZU
 4hIlhh6W6QvtJTREFnYaOopDbhTVKbtgQcFhqtN80oVFDM73EUwSn/ZVVfmmzWyvaOi2wp/Vcy
 tMyoqnuA4bM/55iIbkfq2PYCIqPidKKD2liwA07NQ/2gh6BMKLy8DcaiNOWY2IM9wLHuA61Dzs
 qE7GJYovp1Eq/WTqoG608Cpx9MXN4oZzydWzdQZ0y3z5pd79VoP203/QcIW0n43xpc8AXcPgvD
 dxE=
X-IronPort-AV: E=Sophos;i="5.67,272,1566835200"; 
   d="scan'208";a="120866758"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 06:39:56 +0800
IronPort-SDR: bWS1gEJz/z4b6qQjS7wg652VpfYNaf8oy7/Dyh3earDVh5XOR5gzB4Udyt/drBRjgiHY/ju2mG
 /4lTllt+lgbqZRiMSnapR3jbRFrwDNhbnhrN8/Zv1QqBw5/nxbLAzoMC7pKqfzlSrOi7flvK7+
 Oj8A/RE/mxPop6XDdul1vGDGtU3RxPAYPZlTu9Em7sBtSekFdw8eAH57RiKMl2TmT/sirDYzFL
 i6jEBfKTogiJEo96UKCRUxmjX8WG/jj79mlFGxyMb93N0cH1tHDKwh+E2X0W6H+chLNQGhFwAU
 dcHyk18+bhs+4S3nEoLB+oF6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 15:35:56 -0700
IronPort-SDR: 0rf1PCllJHWfErwM/1fOQWuDnYJVrDSUOxs3uKlWTLQ5gZ4sV8INuPcwgrf8WmjgpNebn9GMAt
 sy5PjvSx8tYTnOYP2nC/PC+4hxUeu043U8uNNbpFiW41lOcx5gFJzkQehtwqwgKNBc44peMZBr
 mc4Kl6rxYsTTwVKJOmhtY9t9/aXUlFCTye7UzPFlE9cQMfyAXebAxvf3KvexNDRC2bIoOn56T7
 vX8GSs4lZpJu9AKIH0M2AX2ScVAK3hmn0tK85ukWE5fuMHyibjWMZpdTokOdZ403usYWL5Nvi9
 RXE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 15:39:55 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH V2] block: Fix elv_support_iosched()
Date:   Wed,  9 Oct 2019 07:39:54 +0900
Message-Id: <20191008223954.6084-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A BIO based request queue does not have a tag_set, which prevent testing
for the flag BLK_MQ_F_NO_SCHED indicating that the queue does not
require an elevator. This leads to an incorrect initialization of a
default elevator in some cases such as BIO based null_blk
(queue_mode == BIO) with zoned mode enabled as the default elevator in
this case is mq-deadline instead of "none".

Fix this by testing for a NULL queue mq_ops field which indicates that
the queue is BIO based and should not have an elevator.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
Changes from V1:
* Test if q->mq_ops is NULL to identify BIO based queues

 block/elevator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5437059c9261..076ba7308e65 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -616,7 +616,8 @@ int elevator_switch_mq(struct request_queue *q,
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
+	if (!q->mq_ops ||
+	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
 		return false;
 	return true;
 }
-- 
2.21.0

