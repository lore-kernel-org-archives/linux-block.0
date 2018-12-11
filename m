Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB1C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0A20880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="eOQjDB8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLKTRL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35751 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeLKTRL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so14064996ljb.2
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJB3xXv8lTFhwUBdJmWs7QY5xPeCzp6Ka4N9v4YQmKI=;
        b=eOQjDB8Ngw8dV3qrDXwVv/kEng7X+goyPCyNIOs6DJyD0hXLTZ0hJt50G8hu6tTkma
         14UbaeRW48TUZQQchxrZ5+80Dbgzg0xQEKaJytHoIuh/Pg61Xc98vOi0a072YReesIzp
         c6v/aBDkAsB2KIPXKP1paHdHxfmjD8pljXF2XaYNrcHMPSW/iPsVuQujYhT+yNSnhfMr
         g19c8kucE0tZmpal0eHTp1fW1953UpgGLTMQ1I2InE0wjw4u2JSIUpoEZZx2LqWrYbhd
         jcJhPhMTkhu9S9Dehvo4PF1N1PKckcT8XUtzTH2XdCon7uYk2u+xiSIwzpN3BR9Mikuq
         z5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJB3xXv8lTFhwUBdJmWs7QY5xPeCzp6Ka4N9v4YQmKI=;
        b=c4Zw0Da2/S1mXQU2QoxgeiTOomAGXcf9zqVB7HMo/CnPKHU5hn/iJ1duzUiee3hM6i
         tC5AtHfQzdFheBdPCIzsWHjxQE7sDrReHQusqAr3yrq6qM09UDlDzI2NKkYEHE4OaejI
         XhZ56Cxp3SJH7ap3Rjd53zE+JuwzlKYTRQqVOTwZwj1QsKYB36XtdJ5HE32e13evYxZX
         0h2o3RxWSTqrlHS4QfUkwH0MJP+sroB1T2Up0LnBn8S9vhWgTEkmMap1Gdiksng/WUuw
         +oEMMxk9UlRyXzGJuY6B65njqHylkG0uesuj0DE/5frwl487gLcKkJVW4lMKCYhlnXDK
         +//w==
X-Gm-Message-State: AA+aEWZjpaKFOuL2EKlP1C+Bksg+XV/28N/KwsEEAE3z+kQX2eS8M/a5
        6aMvT9ML+l3UjVDBJqOZLAWHzg==
X-Google-Smtp-Source: AFSGD/X/+Hc0BMCzrXpJJ6+ghgf41LULRGx3VcZvD137G8a1ZjxjwSNlOnmrTLLXu7GkvArmCPcZWg==
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr10546667lji.113.1544555829130;
        Tue, 11 Dec 2018 11:17:09 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:08 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 08/21] lightnvm: pblk: remove unused macro
Date:   Tue, 11 Dec 2018 20:16:14 +0100
Message-Id: <20181211191627.15542-9-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

ADDR_POOL_SIZE is not used anymore, so remove the macro.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f083130d9920..3219f335fce9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -207,9 +207,6 @@ static int pblk_rwb_init(struct pblk *pblk)
 	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
-/* Minimum pages needed within a lun */
-#define ADDR_POOL_SIZE 64
-
 static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo *geo,
 			     struct nvm_addrf_12 *dst)
 {
-- 
2.17.1

