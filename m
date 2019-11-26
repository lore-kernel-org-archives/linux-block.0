Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C8C432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 04:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B7220836
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 04:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Ifhf9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfKZEew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:34:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44428 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfKZEew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 23:34:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id e6so8296715pgi.11;
        Mon, 25 Nov 2019 20:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r4sCXiFU1twmyenJG0NM7zHY2TV0D2ORPlGj2mpnJMI=;
        b=H0Ifhf9+PF78erKiS5IqjyZop5Wkcm2Y5P85j2gnzYg2sdG13OQBPzn8X1owYpfo0b
         FlpuQK+TdOjPwcXKFKavEhvcPogyDvJdCUqjwcdXzmUwfC689m3bhapXnMIMHyjAoskM
         zwq00UsoAoeWZ2pAQ/MXarvEllXZtnUY8O4FZY5NdcCxDKSsoatj4qEOc/4mZdU7iTHT
         tAJ+HyIW180xnFmpZXVHqDJvCD+CB+ontLHpEDMAwSgf1sg0TPz7n3df5FxsvX/ar3kA
         20QuYpJzl89ONDQhxIiqx2yYe77o72A0kj1tWlEr6QrpGg77TZUVZ78ABt316NQnNgXH
         PDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r4sCXiFU1twmyenJG0NM7zHY2TV0D2ORPlGj2mpnJMI=;
        b=NS5FTDSg0P0M7r5UFT8D3u0MH06VJGtbDV7ul+iG4RdoFyblwX+CwdsruVlZ4501r1
         k7PjxAOZ8KrGP3NPVsCLoSPPTwv3LDEGFkd1sq/5A3oFCbyXSTMR5uUtU5aNDdVSnB2r
         dwzHtQthrZoeqP2pJ746N7QKz/DJLuDENjJ5IjOPLkDw/9TPfnWM3s7FY3xwfvqzFF9K
         cIN2ZwyAz+KfsQrXXaZLp8YMle+Cm7lhuBQ4zQtwr358auht1N02wem3ZL4LqthevLg7
         7kMjUrN0nlwYYkRPC4xyguW9B1lUVkkZOpxUdR9132Cd/Wef8j1fpEfDk2H/AzAWS7QB
         uHkw==
X-Gm-Message-State: APjAAAVdCFBo1MsE/40euPphH40mm3KpnhkU3A452JI1gvia/r/ne+g7
        bJFFTGw+rhRz8V+SZhYJgew=
X-Google-Smtp-Source: APXvYqy91r4SioV3aM4LfXCeaDZWLxEZmmP8CYnC/r2l1EkFlBW0Lo7+OWaTYCIGw0UmWuD7Rvwr9Q==
X-Received: by 2002:a63:5f48:: with SMTP id t69mr35260836pgb.379.1574742891103;
        Mon, 25 Nov 2019 20:34:51 -0800 (PST)
Received: from localhost.localdomain ([182.78.163.34])
        by smtp.gmail.com with ESMTPSA id x9sm10279264pgt.66.2019.11.25.20.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 20:34:50 -0800 (PST)
From:   kc27041980@gmail.com
X-Google-Original-From: KC17041980@gmail.com
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, KC27041980 <kc27041980@gmail.com>
Subject: [PATCH 1/1] block/drbd/drbd_debugfs.c: Protect &connection->kref with resource->req_lock
Date:   Tue, 26 Nov 2019 10:04:18 +0530
Message-Id: <1574742858-23131-1-git-send-email-KC17041980@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: KC27041980 <kc27041980@gmail.com>

Protect &connection->kref by moving it under resource->req_lock.

Signed-off-by: KC27041980 <kc27041980@gmail.com>
---
 drivers/block/drbd/drbd_debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index b3b9cd5..f6d75fa 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -363,11 +363,15 @@ static int in_flight_summary_show(struct seq_file *m, void *pos)
 	struct drbd_connection *connection;
 	unsigned long jif = jiffies;
 
+	spin_lock_irq(&resource->req_lock);
 	connection = first_connection(resource);
 	/* This does not happen, actually.
 	 * But be robust and prepare for future code changes. */
-	if (!connection || !kref_get_unless_zero(&connection->kref))
+	if (!connection || !kref_get_unless_zero(&connection->kref)) {
+		spin_unlock_irq(&resource->req_lock);
 		return -ESTALE;
+	}
+	spin_unlock_irq(&resource->req_lock);
 
 	/* BUMP me if you change the file format/content/presentation */
 	seq_printf(m, "v: %u\n\n", 0);
-- 
2.7.4

