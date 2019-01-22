Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BCFC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDBE20879
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="f2VVGDA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfAVKSR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:18:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35557 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfAVKSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 05:18:16 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so19351893itp.0
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=F14VHg3Q6CcoagSvNNNrRfEviAiUaeLFCtdR36qYta8=;
        b=f2VVGDA1hSd/nJ6UptoYZXAWbwxFmQdq+WakgpQ0iTAqmZkMSHkqup6lTjcQsty5UF
         a2+wIU5cCe9jU2y05niFdZQznFlIhKDqzqvZvM/2oRzHBdtrLPsZVSOjwiARElRSAa8F
         ag7uhVTXp/xgyt/psPZQd8ZKRZLEjFHJtjHjluEwXyeI/CPrjcLiRDmssaWLMzKzc4du
         5YFeshWpL4xy7EoGwmBdDkHAOerXxbaRUpJQF1nXvSyZNyrTuH/FkeI4z36RgUFAkZfX
         D4kSlz9m376vBv7WymCmaAQ1vpDZ7LaY3+Q6K53Yte3a7t6AYE7m0+mj73BKQxyPZrI8
         hrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F14VHg3Q6CcoagSvNNNrRfEviAiUaeLFCtdR36qYta8=;
        b=pu5BcN+eGS8o2dI3ehvbwA9DLBXQm+fivSaPV5TlVr23pRh9Jkw1+9uorbg+Kv9Pv3
         nuI8CHy/NHQjMA1V7ahHVBDIOz550z39s5y5CKxRzW9bTWl8hPbvOhdGijdqBfeHOL8N
         Bg4JGYynsPeXS159pPRlmnDcl7zY076KtOkdzNHkzEl4Y5IJJAXzJjrtxcyn0NCgNNxm
         bMJz6VXMdJcJkVnSgCQB5pQRMxNqIb+W8jz4PuJSnbJKhFmW4h4QcBwFOfag4jFFcgVS
         6K86WidfK+qjARORzEVEJXrjBV4xqlGoxXoHhlVhwQpO0Rn2vyoVsvkPr1Uz5f85+fU+
         i05w==
X-Gm-Message-State: AJcUukcRHQlf7vPqIKTtV9mOM+J2u5kB0EskaC+za0ydLjYT4uQCab0U
        dIXNGer+IYAyUf8UrAvuulcM8eXIunvgRw==
X-Google-Smtp-Source: ALg8bN5RojFYpIuMNElloI1m/DbnckjegUxWZjF95Ydq8hEQPwQBu1KoZz/y/8IanNdcCgiCabg0Sg==
X-Received: by 2002:a24:7c58:: with SMTP id a85mr1775263itd.9.1548152295522;
        Tue, 22 Jan 2019 02:18:15 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 18sm7595496itk.28.2019.01.22.02.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 02:18:15 -0800 (PST)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: use vfree to free metadata on error path
Date:   Tue, 22 Jan 2019 11:17:59 +0100
Message-Id: <20190122101759.31201-1-hans@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

As chunk metadata is allocated using vmalloc, we need to free it
using vfree.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1ff165351180..1b5ff51faa63 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -141,7 +141,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 
 	ret = nvm_get_chunk_meta(dev, ppa, geo->all_chunks, meta);
 	if (ret) {
-		kfree(meta);
+		vfree(meta);
 		return ERR_PTR(-EIO);
 	}
 
-- 
2.17.1

