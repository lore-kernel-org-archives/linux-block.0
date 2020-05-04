Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2326C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6052075E
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="V4banS6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEDN3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 09:29:36 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:45964 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEDN3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 09:29:36 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 88FDA2E146B;
        Mon,  4 May 2020 16:29:33 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id I1XY7HP5b5-TXXG417C;
        Mon, 04 May 2020 16:29:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588598973; bh=C/AXuDO5e4aQmVSLTTHoTqT3ftuz0AKcd7baVzpRAuM=;
        h=Message-ID:References:Date:To:From:Subject:In-Reply-To;
        b=V4banS6tP1Dp2BHTnVDf9p6HMz5T9bT13R8OqDBAg4D0DZhisl/m0tb3VOMEJEIDS
         pE2Pg1If2f1uwV5kRlookI0D8mywgM6Au/3ArC50MpHOfXEb49G2XcEfnifR7dBx3d
         YDc5zLnWKSnplB2Fd9+8sjb2pcgR50kc9dlWSnyo=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id vrQGc0NzBw-TWYeoIkx;
        Mon, 04 May 2020 16:29:32 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH 2/4] block/part_stat: use __this_cpu_add() instead of access
 by smp_processor_id()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Date:   Mon, 04 May 2020 16:29:32 +0300
Message-ID: <158859897252.19836.5614675872684760741.stgit@buzz>
In-Reply-To: <158859896942.19836.15240144203131230746.stgit@buzz>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most architectures have fast path to access percpu for current cpu.
Required preempt_disable() is provided by part_stat_lock().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/part_stat.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 755a01f0fd61..a0ddeff3798e 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -36,6 +36,9 @@
 	res;								\
 })
 
+#define __part_stat_add(part, field, addnd)				\
+	__this_cpu_add((part)->dkstats->field, addnd)
+
 static inline void part_stat_set_all(struct hd_struct *part, int value)
 {
 	int i;
@@ -64,6 +67,9 @@ static inline void free_part_stats(struct hd_struct *part)
 #define part_stat_get_cpu(part, field, cpu)	part_stat_get(part, field)
 #define part_stat_read(part, field)		part_stat_get(part, field)
 
+#define __part_stat_add(part, field, addnd)				\
+	(part_stat_get(part, field) += (addnd))
+
 static inline void part_stat_set_all(struct hd_struct *part, int value)
 {
 	memset(&part->dkstats, value, sizeof(struct disk_stats));
@@ -85,9 +91,6 @@ static inline void free_part_stats(struct hd_struct *part)
 	 part_stat_read(part, field[STAT_WRITE]) +			\
 	 part_stat_read(part, field[STAT_DISCARD]))
 
-#define __part_stat_add(part, field, addnd)				\
-	(part_stat_get(part, field) += (addnd))
-
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
 	if ((part)->partno)						\

