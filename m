Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C017C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 02:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0926160FBF
	for <linux-block@archiver.kernel.org>; Mon, 11 Oct 2021 02:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhJKCrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Oct 2021 22:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJKCrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Oct 2021 22:47:18 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F016C061570;
        Sun, 10 Oct 2021 19:45:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x8so10256405plv.8;
        Sun, 10 Oct 2021 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mAotbMl3KaTUP/0ZTOkObNmPxfcYn3kxOVtDQVB4Sc=;
        b=OGftsYgpEXlnfW/tx60Ejrq/7M7DHlxqt+dlWV1nHuLJS/3KMDBn5CN78YE+vE8P5i
         M6DdoKEZ1KpjeAuCvxxo23tk7GO9fPNYwLtCF/yotm+wGco1YaOIB4xBZdwXhIpab72d
         qnz4iGS535Vx2q8KFL3aciuJ3PT/JltxFYlUy4xDsJBJwbV/BpLz9H8gTC7FJiRC+Vbl
         syPXUuvdB3OsPZzo7Tk7CIIHKm4AKlzsHxyxFmdl0no5PsNyDIDWWsFop6fc1lORCUKY
         yY0HZHVJzYkmUwSSbaffeZWNTR1ImWCkSP3uEKvbUBvrvgmXDNHqvMKgvYtrp++VUm8e
         zZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mAotbMl3KaTUP/0ZTOkObNmPxfcYn3kxOVtDQVB4Sc=;
        b=xI7M2XCMLLZzlcry0CsUQyVtUolnPy0D11s6u3P6+mLxbCq7bPH32FcN2w6bFiG3MD
         M3S6aWhGBz+pfNhKaHEze5KGWvTb0KqZ4+CwpW1e1IJWSZ0B76FqSzBCRxkmTSjmjJRe
         +nBbzxoJRvskgOXDAHUec83SU5ufO35RyyOlSRz1jkLxzO8qBUvSWyug/R3VE/DpqpIJ
         tbc+WOShy9zSRcYXgQMrkYoGQ4FcAvFjQxEvr2Rv4SgU18avKk0XuFUbFl2TFlweFYJH
         3z88lp3o/LGUx8Z93gSogSgxeIHJk0QcPXSl7pJvLRHTpc0T+J/1VEBWqw9nVnGQTy8r
         GW0Q==
X-Gm-Message-State: AOAM530azvIkVrmTcWYbk5Vq6vxOOZKhk05otamYTdOtv87Qc6YDYg14
        vuSnLgTqMRgHkZlHfOKsV9mr4PXhD/AXww==
X-Google-Smtp-Source: ABdhPJzW8SZ0cPIkCJN1Z+TVmytZRRRADvPvKD+GiemmfsBZpX2ip1x37mqK3fBvhaNVh9BG9mW6EA==
X-Received: by 2002:a17:90a:8b8d:: with SMTP id z13mr28080267pjn.214.1633920318629;
        Sun, 10 Oct 2021 19:45:18 -0700 (PDT)
Received: from localhost.localdomain ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id h4sm17554297pjm.14.2021.10.10.19.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Oct 2021 19:45:18 -0700 (PDT)
From:   "Yan, Zheng" <ukernel@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, paskripkin@gmail.com,
        "Yan, Zheng" <yanzheng03@kuaishou.com>
Subject: [PATCH v2] block: nbd: fix sanity check for first_minor
Date:   Mon, 11 Oct 2021 10:45:09 +0800
Message-Id: <20211011024509.2012-1-ukernel@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "Yan, Zheng" <yanzheng03@kuaishou.com>

Device's minor is a 20-bits number, max value is 0xfffff.

Fixes: b1a811633f ("block: nbd: add sanity check for first_minor").
Signed-off-by: "Yan, Zheng" <yanzheng03@kuaishou.com>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1183f7872b71..118039d35468 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1750,10 +1750,10 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 
 	/* Too big first_minor can cause duplicate creation of
 	 * sysfs files/links, since first_minor will be truncated to
-	 * byte in __device_add_disk().
+	 * 20-bits number in __device_add_disk().
 	 */
 	disk->first_minor = index << part_shift;
-	if (disk->first_minor > 0xff) {
+	if (disk->first_minor > MINORMASK) {
 		err = -EINVAL;
 		goto out_free_idr;
 	}
-- 
2.12.2

