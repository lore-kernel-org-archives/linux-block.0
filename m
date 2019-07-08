Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B75C606C2
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D78216FD
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="UD2MFF8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfGHPiw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:38:52 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:53460 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389811AbfGHPir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jul 2019 11:38:47 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 11:38:45 EDT
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 76B182E0A4B;
        Mon,  8 Jul 2019 18:31:16 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 8Wy5B9ijpR-VG4OoQWJ;
        Mon, 08 Jul 2019 18:31:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1562599876; bh=SsanFjU22Vaczlbxo5tTMnEUSVJDr7loxpQ5rI782Ss=;
        h=Message-ID:Date:To:From:Subject;
        b=UD2MFF8XPtzcSpgoHILZKUJjR02m9ycsnyi7xGMSFRvcko2Dyf/Tx9B2b08Mfi4dF
         LtiG0TauTbkK+Ax7FerlBDs5i5jwn1x3fhA2Fc4NoiqHg6TmkzZ5E6Xdcy2WTZAKJx
         Cr2S67MFUGGToQMMILHZYw8Fs0lSFqY5uiKIsR1I=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fce8:911:2fe8:4dfb])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2IqeJGbJaS-VG90sNkH;
        Mon, 08 Jul 2019 18:31:16 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] null_blk: fix handling big requests with small mbps
 limit
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Jul 2019 18:31:15 +0300
Message-ID: <156259987576.2590.3397115585587914567.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Small mbps limit actually limits size of request which could be handled,
because 'cur_bytes' never might be bigger than bandwidth limit over 20ms.
For example with mbps=4 device cannot handle requests bigger than 81 KiB.

This patch allows to start request bigger than 'cur_bytes' but stops queue
if 'cur_bytes' is negative. Bandwidth timer takes this into account.

Fixes: eff2c4f10873 ("nullb: bandwidth control")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/block/null_blk_main.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 447d635c79a2..15925b355965 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1132,6 +1132,18 @@ static void null_restart_queue_async(struct nullb *nullb)
 		blk_mq_start_stopped_hw_queues(q, true);
 }
 
+static inline bool atomic_long_sub_unless_negative(long i, atomic_long_t *v)
+{
+	long c = atomic_long_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!atomic_long_try_cmpxchg(v, &c, c - i));
+
+	return true;
+}
+
 static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 {
 	struct nullb_device *dev = cmd->nq->dev;
@@ -1144,8 +1156,8 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		if (!hrtimer_active(&nullb->bw_timer))
 			hrtimer_restart(&nullb->bw_timer);
 
-		if (atomic_long_sub_return(blk_rq_bytes(rq),
-				&nullb->cur_bytes) < 0) {
+		if (!atomic_long_sub_unless_negative(blk_rq_bytes(rq),
+						     &nullb->cur_bytes)) {
 			null_stop_queue(nullb);
 			/* race with timer */
 			if (atomic_long_read(&nullb->cur_bytes) > 0)
@@ -1244,12 +1256,14 @@ static enum hrtimer_restart nullb_bwtimer_fn(struct hrtimer *timer)
 {
 	struct nullb *nullb = container_of(timer, struct nullb, bw_timer);
 	ktime_t timer_interval = ktime_set(0, TIMER_INTERVAL);
-	unsigned int mbps = nullb->dev->mbps;
+	long budget = atomic_long_read(&nullb->cur_bytes);
+	long limit = mb_per_tick(nullb->dev->mbps);
 
-	if (atomic_long_read(&nullb->cur_bytes) == mb_per_tick(mbps))
+	if (budget == limit)
 		return HRTIMER_NORESTART;
 
-	atomic_long_set(&nullb->cur_bytes, mb_per_tick(mbps));
+	atomic_long_set(&nullb->cur_bytes, limit + min(budget, 0L));
+
 	null_restart_queue_async(nullb);
 
 	hrtimer_forward_now(&nullb->bw_timer, timer_interval);

