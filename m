Return-Path: <SRS0=e7Kt=WG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1526BC32751
	for <linux-block@archiver.kernel.org>; Sat, 10 Aug 2019 07:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE32166E
	for <linux-block@archiver.kernel.org>; Sat, 10 Aug 2019 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niQjzXtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHJHjo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:39:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33687 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfHJHjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Aug 2019 03:39:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id z17so5640438ljz.0
        for <linux-block@vger.kernel.org>; Sat, 10 Aug 2019 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AK/YMa4Udhu0TeTUabdaTm8LRtt+TVVYWot+B288Uf0=;
        b=niQjzXtgqzrHnuK8XNSSBNRpO2CR/Omb5Zr/BEJArkRu1Hu3aP7NGTrfawQAi8xjNq
         B63012N1cBSRUQoZfggC60spukhH4XFe9z+CHLd/zTBD+uWvjodx3m4yl+T5SanUEOlI
         tOwDS2cMYCMt0wSqWgvCEYrBCsMYUx5CD0ljhWRrRAUQZxXesR1EkTLV7I7uOCI4sHWN
         DVaSPJPjwJwZfjENt0rPA/MXLELO8WXSKwvm5JfHwAfYgCcOamlcbJadtdDxn5PtRW3Q
         9f64OMI57PXiPbFmETcrIgaSJpRgP3/ta/cJetbzOGcTg/PtvtZQVILvere+coTyVejG
         S7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AK/YMa4Udhu0TeTUabdaTm8LRtt+TVVYWot+B288Uf0=;
        b=cc23GhTekUAPY3Jt5v+FAantoQKQA4LYTZCjCL4vdy/XPpOFhOFlYqr2CyiV3bGFo6
         TAu7lyvt+RS7KTpw6bbklaTF/41QuYU9RDhoNdQoDOKUilTIMAIqJNC28ojUtfckKxj6
         aJXNuWCKd+Q2gYnuZnvL6HOR68GJM8214w2bBejifdmfmnMRqXKVBaEO3e7HdEwo3j4W
         hc+At5ZxdVgOXgyXBgSMsp4DTHWdHsAerfF6ccFwmXl9l7a9kypj09LZCWBgCDHi+Rjm
         pEPkdeTCKQXQbCmYWRuEu+nndtjp+fxHUgcsymiAsWo5P/urJSF60sROp2go3Wy6z4Zj
         mE3g==
X-Gm-Message-State: APjAAAWROUIEDg+yMB/+SRKqmy8ipi73JeDAXQXRmBWTlGXRNsoEWZMD
        QJpjOYC8FoGOJi+9u7veflPKUg==
X-Google-Smtp-Source: APXvYqxqSQEUfu7bZAFnqxkQX6eGcAAC0oG9UXAGDZV2DRYTYAV3Mi+sXLGdmHn8wqr9Vabz4S2gKg==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr7776491ljj.160.1565422782584;
        Sat, 10 Aug 2019 00:39:42 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id l22sm19707633ljc.4.2019.08.10.00.39.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 00:39:41 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] lightnvm: remove unused variable 'geo'
Date:   Sat, 10 Aug 2019 09:39:36 +0200
Message-Id: <20190810073936.28700-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The variable 'geo' is no longer used.

../drivers/lightnvm/pblk-read.c: In function ‘pblk_submit_read_gc’:
../drivers/lightnvm/pblk-read.c:421:18: warning: unused variable ‘geo’
 [-Wunused-variable]
  struct nvm_geo *geo = &dev->geo;
                  ^~~

Rework to remove the unused variable 'geo' and also the unused variable
'dev' that got unused when the 'geo' variable was removed.

Fixes: ba6f7da99aaf ("lightnvm: remove set but not used variables 'data_len' and 'rq_len'")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/lightnvm/pblk-read.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 0cdc48f9cfbf..8efd14e683dc 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -417,8 +417,6 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 
 int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq rqd;
 	int ret = NVM_IO_OK;
 
-- 
2.20.1

