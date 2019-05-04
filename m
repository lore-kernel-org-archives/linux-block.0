Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C39C04AAA
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960CF206DF
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="aEli/RHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfEDSib (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:38:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35468 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDSia (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so6548128lfh.2
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9RavLGoIs/lnDK5Lu6hOyR7V69/kOZA5XlkRY8NIyQ=;
        b=aEli/RHJ/0kQtLT28mmdqbdwfQ4kVP0Ocn6go9/A66iEW33ePeTgOQcGjpHXhMsTOx
         wMLTfazjmoJr/0DILN4xRci//Zir/PATnYdDLo9Q0o6i2Nm6pcjOhhNIiv7GlHZDTMWV
         q6qBAwEbi5hABxneTtdsGMXpYRYYu0V3vZ0BzW+ppwRb0ZzX04uh8w0yzolMtZ/PLmB4
         zlbsnR+YS55wyUjxDIib0jkWg/wMpqzCNriH4VBaivpDFOHjoeYgf0Qg4ohMrSGRsMzY
         1sVAG92FtAOeusA9O0dUWyWHhhM9rRlQfEngv1CmQOQRuFF3YPzb6Toe19/oJ/BSw2TO
         1UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9RavLGoIs/lnDK5Lu6hOyR7V69/kOZA5XlkRY8NIyQ=;
        b=XRM5cqfC0xuNLsypqlVT7kjUmOtclvi9glvGXIqTwCVM5hZgqiSZBHc7Ub6nRitKW/
         wYnKwFgu3Na68MKGHT6G+KofuCque2MnWAcOWBJBUdwbHUe2TNHWaO2sJXmzvDBZ3VnI
         3jvdFh25C7xgZC2w40FoF2qqF4ZHxC38N4iwYyLl9/fCQnMVOBpmi7DGwrknMvq+0wXe
         Anb7zxPKbpcNFTQheaFNJ/GoW9UEPpaHQAUX114VRvgE5bb1izROiyTpycaPfDhHDX7W
         Diu/dhMmvvy+EzVs0LccTzZ9UEGsQrhVDUFrLoZVkZ0k/KFCsk91GECnfyEZbXpr59u7
         oIYg==
X-Gm-Message-State: APjAAAWeNbqAE7Plcjx3rLW5BkCbTPYBgv59vZmFZYkaxS0gd1P8ls4A
        //FAV2P+m+Bjy7Vyzh1BycR8nQ==
X-Google-Smtp-Source: APXvYqzJ3dlSV6eQsQZzATJQq1zPRD5tE6hnql1aWMg4ppBR7Kgyqaf4MeAyrbqGi/v9F6wemsMtbw==
X-Received: by 2002:ac2:457a:: with SMTP id k26mr5602909lfm.161.1556995108764;
        Sat, 04 May 2019 11:38:28 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:28 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 02/26] lightnvm: pblk: rollback on error during gc read
Date:   Sat,  4 May 2019 20:37:47 +0200
Message-Id: <20190504183811.18725-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

A line is left unsigned to the blocks lists in case pblk_gc_line
returns an error.

This moves the line back to be appropriate list, which can then be
picked up by the garbage collector.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-gc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 901e49951ab5..65692e6d76e6 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -358,8 +358,13 @@ static int pblk_gc_read(struct pblk *pblk)
 
 	pblk_gc_kick(pblk);
 
-	if (pblk_gc_line(pblk, line))
+	if (pblk_gc_line(pblk, line)) {
 		pblk_err(pblk, "failed to GC line %d\n", line->id);
+		/* rollback */
+		spin_lock(&gc->r_lock);
+		list_add_tail(&line->list, &gc->r_list);
+		spin_unlock(&gc->r_lock);
+	}
 
 	return 0;
 }
-- 
2.19.1

