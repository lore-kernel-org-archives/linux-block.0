Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB0C64EC4
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 16:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBOQcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBOQcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 11:32:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD23B3C4
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 08:32:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so19740822wrb.11
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BasZu6xuBIzFaNEHpZKAtYYWJSU123Xrp8iZeT0pas=;
        b=jTRMDPe9oIhjVy3qb/6BYOlCgC3/r4/9UuwevbXB9OXIasHNIPHBXJQ4axGQ5lD320
         f+V0Mnd5XgujTQMQwtrc8BIVvu/HY8UtNftH1OvZDuT+PVY8s6lH39iyF5dphFnlaTjc
         Z4W8A3ou8RVosyxmm3SanmnCwtC8IaTJQg4MamNtQQrP2z+qZV3jXfr+iVNetypr1Yz6
         B3qyV+j0FmY2HNLk1d8kJPoYeGasxtDkDxwn7DLh/2ap9129vRHWn2HYNWZR/4cYmre1
         CjyHnfaPbNVXeFVglDLkNXTMH7IRzqYlDkSMWUmEcSfDJ+jhhSHiR0PI3u6k88bTb8p+
         B1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BasZu6xuBIzFaNEHpZKAtYYWJSU123Xrp8iZeT0pas=;
        b=vy9gZwDNXYzAONLUGQbuCevTtxP+2mNOgfEBBHufHqNig7jtLZl8nb18sEpZ5FeBqH
         sOV1ZS/NmjAbs2iFLDUb7GIKUZ6ggFZrqnhTltEynGYHrGsLsqCB6NpQ4sRCED21Qr/z
         a9I+0bcmHB/8ZHqdGdrvOJtX1tOlVIrOWJh51whf8OU4sB7ICwGpL7nWVMZzqPCQimvC
         xui7s62CJw4H01IF3ZRZrpJEgf0uHjj4D+n0Ui4MO+nr6HJt/m/L4FdKF3bS93cdbJFD
         6pKTZa179ExDniKmifcxMgXFx1eqk682oBuV5AFnDOzVTdNxAEsQfonmLzT8nxSH0NGs
         oigQ==
X-Gm-Message-State: AO0yUKXHBfcMRKCGt25TLl2NiLDAyLW2EZzMoPSRGM0FXD2eRaoc199T
        QDqkfTKYbS/41iIcUctZbQWgFA==
X-Google-Smtp-Source: AK7set+O7knUzFB7PVkwwvoa4040GbIdt1Us84ObAbwwUyxSRX8/Cf8gEcopeVUbO++2/ms1jz3pUg==
X-Received: by 2002:a5d:6142:0:b0:2c3:dbe0:58b8 with SMTP id y2-20020a5d6142000000b002c3dbe058b8mr2157277wrt.41.1676478730555;
        Wed, 15 Feb 2023 08:32:10 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b002c56287bd2csm4865055wrw.114.2023.02.15.08.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:32:10 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 4/7] drbd: drbd_uuid_compare: pass a peer_device
Date:   Wed, 15 Feb 2023 17:32:01 +0100
Message-Id: <20230215163204.2856631-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
References: <20230215163204.2856631-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_receiver.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index aa896db1767d..8605b5154a7e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3226,10 +3226,11 @@ static void drbd_uuid_dump(struct drbd_device *device, char *text, u64 *uuid,
 -1096   requires proto 96
  */
 
-static int drbd_uuid_compare(struct drbd_device *const device, enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
+		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
 {
-	struct drbd_peer_device *const peer_device = first_peer_device(device);
-	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
+	struct drbd_connection *const connection = peer_device->connection;
+	struct drbd_device *device = peer_device->device;
 	u64 self, peer;
 	int i, j;
 
@@ -3465,7 +3466,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	drbd_uuid_dump(device, "peer", device->p_uuid,
 		       device->p_uuid[UI_SIZE], device->p_uuid[UI_FLAGS]);
 
-	hg = drbd_uuid_compare(device, peer_role, &rule_nr);
+	hg = drbd_uuid_compare(peer_device, peer_role, &rule_nr);
 	spin_unlock_irq(&device->ldev->md.uuid_lock);
 
 	drbd_info(device, "uuid_compare()=%d by rule %d\n", hg, rule_nr);
-- 
2.39.1

