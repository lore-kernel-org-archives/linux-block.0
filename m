Return-Path: <SRS0=PDkS=23=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F85C2D0D1
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 10:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1406C2072E
	for <linux-block@archiver.kernel.org>; Mon,  6 Jan 2020 10:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvE/ckqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFKhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:37:47 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43976 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAFKhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 05:37:46 -0500
Received: by mail-ed1-f45.google.com with SMTP id dc19so46986200edb.10
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2020 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4BadsxmgCZIRtcL/pBAoBP5vBouLHiMhovHL2ji+PcQ=;
        b=QvE/ckqklBRDh/M7fWVtNjqb/LCheA0OKvKy2CzGi23tFgf+0RmXPXIsARzQdMfzPV
         wPPX7rH6rAuvn2JyraCxik+iyxevDlQb1QXDrjdsDyg1hdplkMdHN8GBJK4tadrbGvWJ
         i6iRWbHVOlH8U6KhcKFWDLqvRurhFjFg19AMXZ3mqlpJf2mj4YE7N0dVUNLaKhtJDJHX
         6/sY73DX5L4SQpNvUF7HJ2Q6XkzaNF9GbJQTgKBe9LZS9qKuG9KT/gbS5WA6zOsedHpT
         OwYRS0LS9+BeOMZViVs5/ZeMmkISdxfv0S67mH9VtoVDgdovdXgG5xFGCEiKgYiHyySH
         Adsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4BadsxmgCZIRtcL/pBAoBP5vBouLHiMhovHL2ji+PcQ=;
        b=gSX3C8TDQZQrQK3Fhgg/W5YQj8R872NFwfzSonCLkQqqRSaP3WFhRY05hA9IeejATK
         y2D2K0H4I+Ow4Z1fntrJxjdHH0kOgcjYSbL0NYhj+l43mf2LRBCcQzuxJqlIVJ/A8qfw
         QIFIaVWwjj58unhjJq165Exd6+olCfxopUnspEgrYcDp8xJ4kDrl+7t3C+MMsyQ77FuY
         vYN1ix9EvfGZHcaJz+IpOmkCdilyr8ERkqDTGfshVHvpA4rZyE0I8VLHQveiNSosprls
         r4lCE3e7UmTjmC2q1Le6ZnSprjNrL51MWQrS7iTYStjgeDhEVAeoqjlBz8OPXl1X1Q3Q
         /Tsw==
X-Gm-Message-State: APjAAAXCMthxT5tCPy8v27/nwrxbmNExDDTkUdOAfiAEVTnZX8pT7eXa
        Yq9a+wwqC+OGBLTJJAdcFf94VdkZ
X-Google-Smtp-Source: APXvYqycaZ1P+M9YGlgD7vkzkG1+DLspGQGadd1bNQFPWPCL2ccWk8pCh8G1UqBDLduiB6YX6/nAzg==
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr106344614ejb.308.1578307064989;
        Mon, 06 Jan 2020 02:37:44 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:443c:bea1:ffb8:40f])
        by smtp.gmail.com with ESMTPSA id u21sm7609436edv.43.2020.01.06.02.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 02:37:44 -0800 (PST)
From:   jgq516@gmail.com
X-Google-Original-From: guoqing.jiang@cloud.ionos.com
To:     axboe@kernel.dk, corbet@lwn.net
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] docs: block/biovecs: update the location of bio.c
Date:   Mon,  6 Jan 2020 11:37:35 +0100
Message-Id: <20200106103735.10327-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Replace fs with block since bio.c had been moved to block folder.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/block/biovecs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovecs.rst
index 86fa66c87172..ad303a2569d3 100644
--- a/Documentation/block/biovecs.rst
+++ b/Documentation/block/biovecs.rst
@@ -47,7 +47,7 @@ Having a real iterator, and making biovecs immutable, has a number of
 advantages:
 
  * Before, iterating over bios was very awkward when you weren't processing
-   exactly one bvec at a time - for example, bio_copy_data() in fs/bio.c,
+   exactly one bvec at a time - for example, bio_copy_data() in block/bio.c,
    which copies the contents of one bio into another. Because the biovecs
    wouldn't necessarily be the same size, the old code was tricky convoluted -
    it had to walk two different bios at the same time, keeping both bi_idx and
-- 
2.17.1

