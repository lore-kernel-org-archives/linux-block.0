Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD68C433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 02:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKXCMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXCMN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 21:12:13 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C638EB46
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669255932; x=1700791932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JLcdxYHxDcejgFCJxBpssRfq7aEvGfZP6LWir8N+Kkk=;
  b=mFi2FVTVlQr+mekHwLcGhK6FFatFxG3cfRTmFpQcDKGV8CLtABp1OIHI
   P1VwMW5yR6twF3QjDmuKiukQleNafR7fcgt7E+6diLuipb/rDz1yo5yEQ
   g+qR//hCZ91OR7e6FNXDYsuODBO9o0qrvXVT98VJX6Qk7LQgIR+05mB7v
   DdGf6ltHLV9yqgsHh0mcM0ApAOFubaHMXAp3BHkSJYPX00HqIRBGe1oM/
   Pfao7TgdQQ9gsmSqxeGG1i2fMiA1MUqdXQ/iD/DKrThEtl+X6uGc2IFav
   H6P0FmEMAv4vmcTX3Mq4r6f/wDAUlK35XcEcCoNiuuTz3EPnfanuObEJ+
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="217347976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 10:12:12 +0800
IronPort-SDR: EvGPbLk8AVkXfC38pgu5OeIuGJxMs6J7zms7qjiWJ3n+XcuhrGMu3x9eN0JIE43LyKopHTIG3n
 H8Q0ufpPaB1iiKsey6wQ+adrvODmi7eUY8kfMIp06eN+Dbz26Bwhf0Jf8f3xf/Sk3gHTjB4ZRm
 1ErKKaSegEkwuJQGt8WQwghVvvN0W0o0uKHnzwaW/JP6Ndrd13xl8O1Ck4KRdb7oRS4sxBNso4
 YxS+VA/+uEy6/UHZUwFmQGYL574B5+jPA5fT1i3snai4OlnuwZ2aX7f17F7cJZxDpYur8PjmV3
 9DU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:25:14 -0800
IronPort-SDR: QaRRHNe4SNBscvUXwu4Q7QNfMc34MUIY5u0qHzyVfctaLopAQ4mGeX6eAazmbCYZxmHsMC8VxE
 1Mh1HtCWluMIusM+pjZ/WPy/+3W1ZjFeJ/LgS19MSd8SIfplfuHcyREiKr08SMkDzgNt977Pf9
 X6KtTOnvJemAzKHZo3HdNygf6F5SEe3DMzMBVT4/hhlW2mLRhpZLnV5TEzciKJ82OyckW94n4t
 4g4H+ZFmlsjyCUvav5Sa2yNe0Ag7BLtnF5IXl65AKoWTplmLs++NiDuj2RQ/X9j6a+wVljrN3v
 uyg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 18:12:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHhMc0DfVz1RvTr
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:12:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1669255931; x=1671847932; bh=JLcdxYHxDcejgFCJxB
        pssRfq7aEvGfZP6LWir8N+Kkk=; b=cUOqtxhpUDX9ubkTMUHm8OSbFWQV5MmWib
        2A5AoLB9ERQObpF6uo5PHbZFehFi2Jhbl95k2Ur5IHV3HDg8i0xe3zxheo4HkNw2
        zAMsb/lWQ9goadTzO/wQZ0JpdJvXoZInNUPJh8q1jdfkU9bO3hIRM8p9k4ehpjXp
        00JK1inBAmgXtx7TImU1ria6UyMprpiSUc+dok9igfOjCiC77XoUgcHPD2Hx1VoF
        aHJvyke5gW7Dt2pT1SOM38eJQhmfUegJB3sFNQhrjra1ysPYjvOsyidfAg1lglck
        1VlGE4GG9+6dT1nJ1hSN/K07W1sCF7F1oPOqDN+EWiBE5UzVQklA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JbXU09qhzOuY for <linux-block@vger.kernel.org>;
        Wed, 23 Nov 2022 18:12:11 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHhMb0qXRz1RvTp;
        Wed, 23 Nov 2022 18:12:10 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] block: mq-deadline: Fix dd_finish_request() for zoned devices
Date:   Thu, 24 Nov 2022 11:12:07 +0900
Message-Id: <20221124021208.242541-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
References: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dd_finish_request() tests if the per prio fifo_list is not empty to
determine if request dispatching must be restarted for handling blocked
write requests to zoned devices with a call to
blk_mq_sched_mark_restart_hctx(). While simple, this implementation has
2 problems:

1) Only the priority level of the completed request is considered.
   However, writes to a zone may be blocked due to other writes to the
   same zone using a different priority level. While this is unlikely to
   happen in practice, as writing a zone with different IO priorirites
   does not make sense, nothing in the code prevents this from
   happening.
2) The use of list_empty() is dangerous as dd_finish_request() does not
   take dd->lock and may run concurrently with the insert and dispatch
   code.

Fix these 2 problems by testing the write fifo list of all priority
levels using the new helper dd_has_write_work(), and by testing each
fifo list using list_empty_careful().

Fixes: c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/mq-deadline.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5639921dfa92..36374481cb87 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -789,6 +789,18 @@ static void dd_prepare_request(struct request *rq)
 	rq->elv.priv[0] =3D NULL;
 }
=20
+static bool dd_has_write_work(struct blk_mq_hw_ctx *hctx)
+{
+	struct deadline_data *dd =3D hctx->queue->elevator->elevator_data;
+	enum dd_prio p;
+
+	for (p =3D 0; p <=3D DD_PRIO_MAX; p++)
+		if (!list_empty_careful(&dd->per_prio[p].fifo_list[DD_WRITE]))
+			return true;
+
+	return false;
+}
+
 /*
  * Callback from inside blk_mq_free_request().
  *
@@ -828,9 +840,10 @@ static void dd_finish_request(struct request *rq)
=20
 		spin_lock_irqsave(&dd->zone_lock, flags);
 		blk_req_zone_write_unlock(rq);
-		if (!list_empty(&per_prio->fifo_list[DD_WRITE]))
-			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
 		spin_unlock_irqrestore(&dd->zone_lock, flags);
+
+		if (dd_has_write_work(rq->mq_hctx))
+			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
 	}
 }
=20
--=20
2.38.1

