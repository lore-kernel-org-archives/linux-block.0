Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D085C433F5
	for <linux-block@archiver.kernel.org>; Sun, 15 May 2022 20:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiEOU6m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiEOU6l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 16:58:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FF12C107
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r23so2063457wrr.2
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TRMEe/cLouPt9bGN7FdOWr+01EnoUUS94d9Z9TLQUA=;
        b=4M5OpNUdf/T8l6zgcdCNTx5WLvCYTlcrKsETceI0nEF2YBirtRZ4oVRqPHDjfgxq39
         uv29FDCRObd/JuFkByCmlRKiZaMb2s+CUX1zeDmXnxjCt/SiXMsFBTe1yac9fvOb5/tW
         +idg43Z9MSGtUs2/PVE4U1siAym3gOCEwsCWeiVW1kjo4FyskE1/SHNVDUxQoqOaYQdO
         vtSozxVvT0nZ3q0godVB79oYul2wJO7TR3PaoavVfT5BPzDqXsUBAoZ8uaQPepUduiBO
         ZT/xm4PvXa/LrkWowqRLWNWmgfIT9AuxEtfxDolJDS6aj810qxd49Cdz4/Mpd32KW8pc
         uD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TRMEe/cLouPt9bGN7FdOWr+01EnoUUS94d9Z9TLQUA=;
        b=3+xETBXBJ/Hkm/68GGjht5x/PErNyBXMINdy+ekn3ovMrRF/4l7L6eQDi36wfkLAcH
         wqAiCGh1jKridWD7OK36QaYIklZW6kIr691sxbPRZLiXem1ubIhs8UWQCOz5PXBbfjfr
         1IeRXlRAPJFDWJDH5rjnKbjp9qcC0mqlscfjWwYZlzzRl1iKROqsJ6VEbPq4U83V2BMq
         Dl9xqfnRFh+8FjWwVwKfznB2E94HCFaXVpnlHx4v3ruBLcgNEHWn1JLV/XvgMIdyWMUQ
         til/hYelQ7cGlEKeUEpTR6d9YVZfuSRrJOpgkilvh8nfwV8ncGD23EV4MPCNso+vzZy/
         hMiw==
X-Gm-Message-State: AOAM533sB02JeSt8a/TsxkS8BlECs+gMKCRfwyiHkG37w3Ij61aWPMUt
        xBdHnBwP7UnLxj52T5/EXQHbgCsIWDQtNA==
X-Google-Smtp-Source: ABdhPJw85atDjQED7e5UMraPOUd6hXNnr9QjeSIDLLV88EVjCFMKtjdhUPmcU2+v8QFAUZH4LPep+Q==
X-Received: by 2002:adf:efcb:0:b0:20d:24e:a1ce with SMTP id i11-20020adfefcb000000b0020d024ea1cemr5180848wrp.159.1652648318979;
        Sun, 15 May 2022 13:58:38 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r17-20020adfbb11000000b0020c5253d920sm8922074wrg.108.2022.05.15.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:58:38 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/5] cdrom: remove obsolete TODO list
Date:   Sun, 15 May 2022 21:58:33 +0100
Message-Id: <20220515205833.944139-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220515205833.944139-5-phil@philpotter.co.uk>
References: <20220515205833.944139-1-phil@philpotter.co.uk>
 <20220515205833.944139-2-phil@philpotter.co.uk>
 <20220515205833.944139-3-phil@philpotter.co.uk>
 <20220515205833.944139-4-phil@philpotter.co.uk>
 <20220515205833.944139-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The TODO list in drivers/cdrom/cdrom.c has a single entry containing
obsolete information, unchanged since the first git commit over 17 years
ago, and probably longer. Remove this list from the comment to prevent
confusion in future.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/cdrom/cdrom.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e43bb071fe92..416f723a2dbb 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -14,15 +14,6 @@
    actually talk to the hardware. Suggestions are welcome.
    Patches that work are more welcome though.  ;-)
 
- To Do List:
- ----------------------------------
-
- -- Modify sysctl/proc interface. I plan on having one directory per
- drive, with entries for outputing general drive information, and sysctl
- based tunable parameters such as whether the tray should auto-close for
- that drive. Suggestions (or patches) for this welcome!
-
-
  Revision History
  ----------------------------------
  1.00  Date Unknown -- David van Leeuwen <david@tm.tno.nl>
-- 
2.35.3

