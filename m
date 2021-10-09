Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65CC433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 05:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EA960F92
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 05:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhJIFhz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 01:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhJIFhy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 01:37:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B56AC061570;
        Fri,  8 Oct 2021 22:35:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g5so4444277plg.1;
        Fri, 08 Oct 2021 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqacdlZ0cmVRSHorJWN1YVAH6yq1T0MI3rxKlNLYK9A=;
        b=QjjJaQJxOOkx4qxUiqRuksZKYDI63fhF5knUb38/AjsRY4VIRcrteMhWLdvWVU2NTP
         71sxQmUZZ4YS2yCZnhWZ1q3/pceWLJXKKK09xJOfPApbQnJeHuSoaojrG3Z6JzcKpop3
         CD+MruInKj1oSZXcvKVh3LuK8RyNam2T9o8lngtO2Sb69+CpKKDJ58j5CRL5hBnDUkBO
         iwEgngKqghiJebIhoiPRF14gTrMKmqol6BCEg25YQLCp2/BozTouQ/USyTKblivadi7Q
         44Tuk73sKScSchiYKtxxQFOmhd+3GluS3mBB9IGfqm9f/XZ1v6sXEkkrFrHPx9V2r8Jc
         5b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqacdlZ0cmVRSHorJWN1YVAH6yq1T0MI3rxKlNLYK9A=;
        b=AaKhpWRZfDO70/ffUSEItS6Ain6VD9tlyFFnvZSMIb0hLAvHRvyzPGsFjqGe0HVqf+
         biS31VUeESbqnaO9QuzDsO/tuf+z4/4LNpH8Aed5QiQ4+AXXO4/bHau25Yz91/nRX2o1
         ARzxq0B5Qa28Z9LyyDPi6eaLKmUEYkv5jHFYL3kiMdsrbc18ausqjtLKjZ+wIN7SSsVF
         xp3EE/fFecVL7WX0PKLxr9wLt5vTRcEQEuRHtQG2LoAg2DsHbCYpccVBC2pBaWv6+S4R
         2kC4GuWAjoXrQ7DT6qCAjWHddi1VPkiPUgr97zZVLXxqMgq3YQ0MDpgx2x1SztFyb7/u
         GJ9w==
X-Gm-Message-State: AOAM532Q4azZBzIketeMjgUSLbcEtANpLtPk0JxtCUbgE4V+lLPqzBPU
        05tXWEowxvEdLsnLl5uXQU1itYhjhQOdPw==
X-Google-Smtp-Source: ABdhPJw9ptxkHGA+Fi9ih0wXIc/ExRrcAg1FLFFfkg2kE5bqzpvdiFgXWd+PrBq0Wsm9GlFhHFrK8w==
X-Received: by 2002:a17:90a:6fc1:: with SMTP id e59mr10482537pjk.103.1633757757442;
        Fri, 08 Oct 2021 22:35:57 -0700 (PDT)
Received: from localhost.localdomain ([103.112.79.203])
        by smtp.gmail.com with ESMTPSA id 186sm946247pfg.20.2021.10.08.22.35.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Oct 2021 22:35:56 -0700 (PDT)
From:   "Yan, Zheng" <ukernel@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paskripkin@gmail.com,
        "Yan, Zheng" <yanzheng03@kuaishou.com>
Subject: [PATCH] block: nbd: fix sanity check for first_minor
Date:   Sat,  9 Oct 2021 13:35:40 +0800
Message-Id: <20211009053540.95100-1-ukernel@gmail.com>
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
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1183f7872b71..53cd038c96e9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1753,7 +1753,7 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	 * byte in __device_add_disk().
 	 */
 	disk->first_minor = index << part_shift;
-	if (disk->first_minor > 0xff) {
+	if (disk->first_minor > MINORMASK) {
 		err = -EINVAL;
 		goto out_free_idr;
 	}
-- 
2.12.2

