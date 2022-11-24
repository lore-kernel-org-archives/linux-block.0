Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9673CC43217
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 02:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXCMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKXCMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 21:12:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E207A36B
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669255933; x=1700791933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Is4yZXWODR4DzOOOB3VL10rxO1RnrVEXVSStzFEboB8=;
  b=HMzohUDp7K+gQ5eqMKOwrcHIYt+UYyWZN/OaexTJlADqMxJEFVH61jfk
   ong3sAkXYRoGnZGeXsaqP9TJRmEn7j+C2UXfS47LMmT/PBt4zmtIXEHDT
   62aIlMD4NjxVZtFLqbUvROUevUWB7cDJ7w9NxCBgVnX04kaQdNOPRbsRi
   uGUvr9BrggME3iglobbBgS1/AMFpJWIQ/GDXNzb9MYV7GJ6xLgJ3iit8z
   dlHWPY+Fg9fueg8389sIMCh202yCQtR3Hg5Iz8SbDoIEp1q74tW1DTsHa
   lD+/XyfKFpS46HqC+xI/uDlEmxBTB4SNIuOt9klWtXA7V9nXSmmUUdxzw
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="217347978"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 10:12:13 +0800
IronPort-SDR: Z1xY/bjL7ZYbV2NAHs4JbxrYI8VlQNBfOJvEE6zYc79EQgKsvq534gNFz15R3i2NqINh4mAXGM
 H11Whaxab4ZVOqlurUIXF8L2pS7GrkMV/Jz/7PNgjJKE3cUhHZYQ/j5BxtHlAoNxoHC0GErV6f
 47+rUyqlQD1aseBBfzMzmO9XfUfmA5QYIK+2vCqFuCcEWB9XhgKgT4sKLqeSEIPBtH/uMD0CHl
 vA31VeTaVNM1YflJRMYdD0RT1fvRjFyAWaD0FraA9hk9Z8+kP2OR7z3Gfqs3IIRnTG+qmFeWGQ
 iK0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:25:15 -0800
IronPort-SDR: 1+brhR/6MfxUsJs++jFO/peF9TuX1wFFHpZqUEAz3NTJz2/5o7GpZL56OGlyFn/jk1vMX1v4RD
 HXcfBx6ZMcNQAy3Me0gSSFrOE7SU5hBr/o+l3WCwHwIJncl+LwcppG1l57iDi+vuATU+eMRN/M
 zLhwsw0BeiR2edCndWJodBEtBOIrLCszxtZcQY5PZeK5wu03l4MURGJCpCN6f/6gaYuBpkQIm8
 y0pRCG0Ly6lk7+jYRrbkqH6L5om8bjHGMwLvxOajBRccaeZ2+udH9DwwlqO3LNeSEBhw0c7IPI
 hcs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 18:12:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHhMd0LWfz1RvTr
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:12:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1669255932; x=1671847933; bh=Is4yZXWODR4DzOOOB3
        VL10rxO1RnrVEXVSStzFEboB8=; b=S4d4l+p0ZX/kT3iNE57YfN1yDkU7WJNexU
        nl1OV94MC+g3SBgZTPdBqesBbVyMzOGh86L69yvFNA1yfMjoXbLbgqbodPe4hnGM
        uJFoCfyfTSZz7/gGBoAGTh/ONGHR9kL3tG1kAgG1tdzEJnO84tXBDvuEDiKSHeWq
        wb5hM+B4Isx2eEX42/tBX2uakXVpX6pWIa0HzqHtzmkgANXpCHKk8rxsOeLhBTOU
        BK/exdstqI0g6ohNVIYXjw+3dP3cZEL9PN+mxtUWDBpE0rhKOVFtpyjYP/TmVC+C
        kg2eP9Fouq2G/DF3LnOPtcpd+PfMMpCvZeQQMcWYBHCkTjZIlH1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gvbP18gQsbVJ for <linux-block@vger.kernel.org>;
        Wed, 23 Nov 2022 18:12:12 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHhMb6yyLz1RvLy;
        Wed, 23 Nov 2022 18:12:11 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] block: mq-deadline: Do not break sequential write streams to zoned HDDs
Date:   Thu, 24 Nov 2022 11:12:08 +0900
Message-Id: <20221124021208.242541-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
References: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mq-deadline ensures an in order dispatching of write requests to zoned
block devices using a per zone lock (a bit). This implies that for any
purely sequential write workload, the drive is exercised most of the
time at a maximum queue depth of one.

However, when such sequential write workload crosses a zone boundary
(when sequentially writing multiple contiguous zones), zone write
locking may prevent the last write to one zone to be issued (as the
previous write is still being executed) but allow the first write to the
following zone to be issued (as that zone is not yet being writen and
not locked). This result in an out of order delivery of the sequential
write commands to the device every time a zone boundary is crossed.

While such behavior does not break the sequential write constraint of
zoned block devices (and does not generate any write error), some zoned
hard-disks react badly to seeing these out of order writes, resulting in
lower write throughput.

This problem can be addressed by always dispatching the first request
of a stream of sequential write requests, regardless of the zones
targeted by these sequential writes. To do so, the function
deadline_skip_seq_writes() is introduced and used in
deadline_next_request() to select the next write command to issue if the
target device is an HDD (blk_queue_nonrot() being false).
deadline_fifo_request() is modified using the new
deadline_earlier_request() and deadline_is_seq_write() helpers to ignore
requests in the fifo list that have a preceding request in lba order
that is sequential.

With this fix, a sequential write workload executed with the following
fio command:

fio  --name=3Dseq-write --filename=3D/dev/sda --zonemode=3Dzbd --direct=3D=
1 \
     --size=3D68719476736  --ioengine=3Dlibaio --iodepth=3D32 --rw=3Dwrit=
e \
     --bs=3D65536

results in an increase from 225 MB/s to 250 MB/s of the write throughput
of an SMR HDD (11% increase).

Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/mq-deadline.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 36374481cb87..6672f1bce379 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -130,6 +130,20 @@ static u8 dd_rq_ioclass(struct request *rq)
 	return IOPRIO_PRIO_CLASS(req_get_ioprio(rq));
 }
=20
+/*
+ * get the request before `rq' in sector-sorted order
+ */
+static inline struct request *
+deadline_earlier_request(struct request *rq)
+{
+	struct rb_node *node =3D rb_prev(&rq->rb_node);
+
+	if (node)
+		return rb_entry_rq(node);
+
+	return NULL;
+}
+
 /*
  * get the request after `rq' in sector-sorted order
  */
@@ -277,6 +291,39 @@ static inline int deadline_check_fifo(struct dd_per_=
prio *per_prio,
 	return 0;
 }
=20
+/*
+ * Check if rq has a sequential request preceding it.
+ */
+static bool deadline_is_seq_writes(struct deadline_data *dd, struct requ=
est *rq)
+{
+	struct request *prev =3D deadline_earlier_request(rq);
+
+	if (!prev)
+		return false;
+
+	return blk_rq_pos(prev) + blk_rq_sectors(prev) =3D=3D blk_rq_pos(rq);
+}
+
+/*
+ * Skip all write requests that are sequential from @rq, even if we cros=
s
+ * a zone boundary.
+ */
+static struct request *deadline_skip_seq_writes(struct deadline_data *dd=
,
+						struct request *rq)
+{
+	sector_t pos =3D blk_rq_pos(rq);
+	sector_t skipped_sectors =3D 0;
+
+	while (rq) {
+		if (blk_rq_pos(rq) !=3D pos + skipped_sectors)
+			break;
+		skipped_sectors +=3D blk_rq_sectors(rq);
+		rq =3D deadline_latter_request(rq);
+	}
+
+	return rq;
+}
+
 /*
  * For the specified data direction, return the next request to
  * dispatch using arrival ordered lists.
@@ -297,11 +344,16 @@ deadline_fifo_request(struct deadline_data *dd, str=
uct dd_per_prio *per_prio,
=20
 	/*
 	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone.
+	 * an unlocked target zone. For some HDDs, breaking a sequential
+	 * write stream can lead to lower throughput, so make sure to preserve
+	 * sequential write streams, even if that stream crosses into the next
+	 * zones and these zones are unlocked.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
 	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
-		if (blk_req_can_dispatch_to_zone(rq))
+		if (blk_req_can_dispatch_to_zone(rq) &&
+		    (blk_queue_nonrot(rq->q) ||
+		     !deadline_is_seq_writes(dd, rq)))
 			goto out;
 	}
 	rq =3D NULL;
@@ -331,13 +383,19 @@ deadline_next_request(struct deadline_data *dd, str=
uct dd_per_prio *per_prio,
=20
 	/*
 	 * Look for a write request that can be dispatched, that is one with
-	 * an unlocked target zone.
+	 * an unlocked target zone. For some HDDs, breaking a sequential
+	 * write stream can lead to lower throughput, so make sure to preserve
+	 * sequential write streams, even if that stream crosses into the next
+	 * zones and these zones are unlocked.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
 	while (rq) {
 		if (blk_req_can_dispatch_to_zone(rq))
 			break;
-		rq =3D deadline_latter_request(rq);
+		if (blk_queue_nonrot(rq->q))
+			rq =3D deadline_latter_request(rq);
+		else
+			rq =3D deadline_skip_seq_writes(dd, rq);
 	}
 	spin_unlock_irqrestore(&dd->zone_lock, flags);
=20
--=20
2.38.1

