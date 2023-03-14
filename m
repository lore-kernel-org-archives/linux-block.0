Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E062AC7618A
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 04:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCNELO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 00:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCNELM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 00:11:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E278F522
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678767071; x=1710303071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRmjslkP/dyFGhtAFnGamOw58rUd//QCOkJl56qSdu0=;
  b=UTZMJ2ZvnVMAUyC6YHYPOTeYDu/4mQyvvHWfad6CVv2rtHr9HPLVo21+
   Nt+Qp4xXYp6k17iOGW48YhIWRtghCovRUorioWpid7kSeH1z8XETMs7Tv
   6pdtuVy8zzUn47RRAlrVb6q7hZRIybd5Tn/crqXU9+j62qVUp5lv3UgNL
   wmn4j3nQW2Qv4R23iFzgz1axeg3wSE5v4XkxOb+PWZIZ4T0mPf1bY/ekl
   bEfKluxyZpf361wsa196VBQrnVB0RpaQ32LtHAUNj9Y4iAYHjalZwXlve
   JDxPUNqLt2mKO9e3/4bt7TpguKBF9eWaRiC6grFy1/MdYgVWuvySCKd85
   w==;
X-IronPort-AV: E=Sophos;i="5.98,258,1673884800"; 
   d="scan'208";a="225349843"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 12:11:10 +0800
IronPort-SDR: aR9kTKOn+dGB2Kde5oSm5xtvOTjSoHsimixPOPwdpo+L0aMJeAmgAHHVMwxV9QT1HEkfPycTq4
 N4/D+kJkdkkn1ThMSmF27adFA/MaiaVkKIFMruHPwxipDHkrsNNB8Xrhn7CnEOtldO9RUsPxrV
 3AARgyKpDHmjdLcrHJLvjpSuRrByTzJkZBUT1m8Ykjeu510MTypGAhZtgJIiVjwzvsMfRUyE/5
 44z9QosnkP6z+sCEKk5mCTbLeirkDKK53floSChMfl6Mz0KiWWTN31GdMHkmiE0jn9N3t7HNfy
 K0Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 20:27:39 -0700
IronPort-SDR: fEM1KTs5lKpnfAUUNfUjJLfWQJXne1u8am4M/IwdbkNJH91m39oqeqivMRzowXQYwRUgq2iaPI
 OQRgNLpqij9qLv3XEMW/Uwrk8uO/ng2UBDqLKECjyB9T01HYnYsqjKhnbhEjCGFfP81m8Tl6/j
 FplQkZLVwfPPpRMTe9VfgD4l3XGNSEdk6xdsDXUdH+GKRyw+TGY/E9u9xXfQrs8U0Xk0/n7TlF
 Me/VhkPkwaYkzJ8mCoUkXf2Ait8aQ7l/KG6M8kCrz+dfGh09Yz9ZZ9XTeYzjDIwfGxbtbHhxf9
 ciY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 21:11:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbKp62yPGz1RtVq
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 21:11:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678767070; x=1681359071; bh=dRmjslkP/dyFGhtAFn
        GamOw58rUd//QCOkJl56qSdu0=; b=oWND/ViT4tOfJl79cPze597ro1+7C6f0gg
        RA6rGw0Lk5+q88yoWcqQdKmm/PR1h7TnBcl0W8RuMn6qNy8otca4mzvoRnNdX9Ia
        MyBBA+NWdz4TR70nnd3Ul7gx3bd2rsZqx4CBHEnlHAiJEyJJVpIQ600KMcQYDxSk
        rT9yq2Crwve30JpUZmngxopKyAG4sgIYcK8QO0D0xv7ek3RLjdH/MkDcVo2h4YAN
        wFu2icGlF9FwCU26TB/HbEf9a17/vcjY6n6ks/1GZgadUoEkTlTy9Ucp3QVipKea
        1rNemzdD1AOxVZmmzmAfzmtOg7OI0orLhqITGpP/z5Wa3/TGKlMQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zSFAv-onjyj7 for <linux-block@vger.kernel.org>;
        Mon, 13 Mar 2023 21:11:10 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbKp53Twgz1RtVn;
        Mon, 13 Mar 2023 21:11:09 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] block: null_blk: Fix handling of fake timeout request
Date:   Tue, 14 Mar 2023 13:11:05 +0900
Message-Id: <20230314041106.19173-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
References: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When injecting a fake timeout into the null_blk driver using
fail_io_timeout, the request timeout handler does not execute
blk_mq_complete_request(), so the complete callback is never executed
for a timedout request.

The null_blk driver also has a driver-specific fake timeout mechanism
which does not have this problem. Fix the problem with fail_io_timeout
by using the same meachanism as null_blk internal timeout feature, using
the fake_timeout field of null_blk commands.

Reported-by: Akinobu Mita <akinobu.mita@gmail.com>
Fixes: de3510e52b0a ("null_blk: fix command timeout completion handling")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 4c601ca9552a..7d95ad203c97 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1413,8 +1413,7 @@ static inline void nullb_complete_cmd(struct nullb_=
cmd *cmd)
 	case NULL_IRQ_SOFTIRQ:
 		switch (cmd->nq->dev->queue_mode) {
 		case NULL_Q_MQ:
-			if (likely(!blk_should_fake_timeout(cmd->rq->q)))
-				blk_mq_complete_request(cmd->rq);
+			blk_mq_complete_request(cmd->rq);
 			break;
 		case NULL_Q_BIO:
 			/*
@@ -1675,7 +1674,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_=
ctx *hctx,
 	cmd->rq =3D bd->rq;
 	cmd->error =3D BLK_STS_OK;
 	cmd->nq =3D nq;
-	cmd->fake_timeout =3D should_timeout_request(bd->rq);
+	cmd->fake_timeout =3D should_timeout_request(bd->rq) ||
+		blk_should_fake_timeout(bd->rq->q);
=20
 	blk_mq_start_request(bd->rq);
=20
--=20
2.39.2

