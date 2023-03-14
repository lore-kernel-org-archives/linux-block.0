Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C16C74A44
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 04:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCNELP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 00:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjCNELM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 00:11:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10178FBC5
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678767071; x=1710303071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oo6LRSZ/MwpJ6ztvXZ9FoKMpk6/TPO+x4HbUUuvBG9A=;
  b=gDmGQp6kErosyAmzhrWrjUmlVMNUML/eZSXA58/55XxxVPX0FXs6G1Ab
   nXxcFFxyUSw5NvD06Wxqn5Wj1BfEDY9BGxfL8+gTydexyWwjrHUHiKb24
   GiVtEJdo1fIe130y9WpozHs01qIyOatsIszkW9oPn7DBkli/DpvUKdSWv
   BulLn8ytNQwF0EVn4US/1/04tLoNCDQ1RTqgby6gfVocFPp3YkTiQyGn3
   fEAYuRwiIF7aYpHhv/RiCP4KQNIA6utBcnTjulXtJ3DXECTbmy2umvnno
   RL62i2MXZQOYazXbOlPm3b6m15yWw2HB6kt4NFNWKvPxPAE5ltz9Pot1u
   w==;
X-IronPort-AV: E=Sophos;i="5.98,258,1673884800"; 
   d="scan'208";a="225349845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 12:11:11 +0800
IronPort-SDR: 7geGWFc4Sr5gFsbtIeQB34Wmux0YZL6tro8y3u1AKS1Gzxae10B29+yzswjuz4f00OcepxCZPy
 Tfte6vCi2YbbiPEQFeND5hZpYdGRhv0rStRDhwy8vFoiBumwXXA60T5N/5R4pj2kOQxkaOu4xO
 gS8cDH5e6N1/eK8AjRY50yZGrYHrqY/qi8sEplGy/Tr8OBWRZk848Y9p4V6sgBp2u3lWH911xu
 BVK7dQIjPUCc88YQpkOntYAOo7b4D1ocarxez+9Fqz6Dm+FLEgTZLAyziE3Y7Byt0Seyj0YyEg
 Yxg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 20:27:39 -0700
IronPort-SDR: pnleP11yQn9oNPeHeTSH4K0hHZ12GK8pvK3XQQ2KQZhA0YQ2TFG5DT/I83eqGvYp2ljIqPoLBW
 UaFidaNc9y03DrZbb5FPYdW5WUH6K2mvOB7NuYPMNwItzZxt6obBmXfwAAXYFcsxFQxtS2/Vhn
 sB+LtsDPsAB2g8sABSGVJD1C5gx9gcqlWy233pVCRmB/c8AS3sxeyKcmtMeAgrAjo7dpGdMveU
 7KZZFBuMRv/HmMeeZN4yFU8uMsoXt33WeiU23fhVc7OtNs5UWegIQAwphmybVHLrgVymc+wwDt
 MfA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 21:11:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbKp72GRMz1RtVq
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 21:11:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678767070; x=1681359071; bh=Oo6LRSZ/MwpJ6ztvXZ
        9FoKMpk6/TPO+x4HbUUuvBG9A=; b=k7QhX3ROvk+hg9avf7GIDFMdmWsFE2rSn5
        1EyIpeeEBM58xl5L0xourE4/AfdDosvd6vbBN8OCxJcb375mU1+/Uw/OHJzMVQs7
        /l9NMjRHSTF24WRioADbdFL5lS8CjFs6Y3ddvK9jFWlJ8RBuY8jAOyPcvHPJftJQ
        UxXiBW5ZX9dXPqsMdhH2ZnMPuMLk/4JoRjp04gbRoKVoF17gYKQZSy5+gSQGR/gz
        gnJd1nZ1Fx1QQXOe4/HXeANcbT4U71WqEcFZroAwj01qODVzW7COAOACnDFDAs0M
        7nxLJeMVqCg2jDEaq0a96lBn7+BYPtRtsOk4WDSbKdBFlECPMOAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W3ckqLmyKLIt for <linux-block@vger.kernel.org>;
        Mon, 13 Mar 2023 21:11:10 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbKp62Hqkz1RtVm;
        Mon, 13 Mar 2023 21:11:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/2] block: null_blk: cleanup null_queue_rq()
Date:   Tue, 14 Mar 2023 13:11:06 +0900
Message-Id: <20230314041106.19173-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
References: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a local struct request pointer variable to avoid having to
dereference struct blk_mq_queue_data multiple times. While at it, also
fix the function argument indentation and remove a useless "else" after
a return.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/block/null_blk/main.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 7d95ad203c97..9e6b032c8ecc 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1657,12 +1657,13 @@ static enum blk_eh_timer_return null_timeout_rq(s=
truct request *rq)
 }
=20
 static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
+				  const struct blk_mq_queue_data *bd)
 {
-	struct nullb_cmd *cmd =3D blk_mq_rq_to_pdu(bd->rq);
+	struct request *rq =3D bd->rq;
+	struct nullb_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
 	struct nullb_queue *nq =3D hctx->driver_data;
-	sector_t nr_sectors =3D blk_rq_sectors(bd->rq);
-	sector_t sector =3D blk_rq_pos(bd->rq);
+	sector_t nr_sectors =3D blk_rq_sectors(rq);
+	sector_t sector =3D blk_rq_pos(rq);
 	const bool is_poll =3D hctx->type =3D=3D HCTX_TYPE_POLL;
=20
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
@@ -1671,15 +1672,15 @@ static blk_status_t null_queue_rq(struct blk_mq_h=
w_ctx *hctx,
 		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		cmd->timer.function =3D null_cmd_timer_expired;
 	}
-	cmd->rq =3D bd->rq;
+	cmd->rq =3D rq;
 	cmd->error =3D BLK_STS_OK;
 	cmd->nq =3D nq;
-	cmd->fake_timeout =3D should_timeout_request(bd->rq) ||
-		blk_should_fake_timeout(bd->rq->q);
+	cmd->fake_timeout =3D should_timeout_request(rq) ||
+		blk_should_fake_timeout(rq->q);
=20
-	blk_mq_start_request(bd->rq);
+	blk_mq_start_request(rq);
=20
-	if (should_requeue_request(bd->rq)) {
+	if (should_requeue_request(rq)) {
 		/*
 		 * Alternate between hitting the core BUSY path, and the
 		 * driver driven requeue path
@@ -1687,22 +1688,20 @@ static blk_status_t null_queue_rq(struct blk_mq_h=
w_ctx *hctx,
 		nq->requeue_selection++;
 		if (nq->requeue_selection & 1)
 			return BLK_STS_RESOURCE;
-		else {
-			blk_mq_requeue_request(bd->rq, true);
-			return BLK_STS_OK;
-		}
+		blk_mq_requeue_request(rq, true);
+		return BLK_STS_OK;
 	}
=20
 	if (is_poll) {
 		spin_lock(&nq->poll_lock);
-		list_add_tail(&bd->rq->queuelist, &nq->poll_list);
+		list_add_tail(&rq->queuelist, &nq->poll_list);
 		spin_unlock(&nq->poll_lock);
 		return BLK_STS_OK;
 	}
 	if (cmd->fake_timeout)
 		return BLK_STS_OK;
=20
-	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
+	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
 }
=20
 static void cleanup_queue(struct nullb_queue *nq)
--=20
2.39.2

