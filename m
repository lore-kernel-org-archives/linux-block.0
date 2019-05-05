Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B241C004C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 15:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBA0208C2
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 15:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQHZPxK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfEEPGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 11:06:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45184 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEEPGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 11:06:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so5347962pfi.12
        for <linux-block@vger.kernel.org>; Sun, 05 May 2019 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87Uhsh3a4DNaNiKT6JXl9gZu0JBq9ja45nO8OBV1tis=;
        b=sQHZPxK0rPR+MxLdU5upB12j6aAVHKtbVoMa8ANKZuVbEIXanLK9nFA4AXZB/mLXbj
         xYqO2n04zWiRB4228dZ+Ei+WzRDPlJyfFQVhcZ8hlBS051rBw28nEac3L7RUPHyXTOiX
         MtIZcOG3le0uU8XHLHEiFiwWkqZ+7H/9hVe0SgEzEMwuGRTry2gvfbUMTzcNASSFf3eY
         hw2b9gkeTERMwTBD8ls1xtihhDRDhoZpdDg8wgF+mVq//p44oSzIN3cmpIs6YbUezb9Y
         XDmhdeEdFQvdTS2o2dl05wV9Vgacy0C1zb+UdlKvU1p4mDd57TFweptAD8A+oDv9hyY1
         EHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87Uhsh3a4DNaNiKT6JXl9gZu0JBq9ja45nO8OBV1tis=;
        b=fmpgr7uxuwR/R2lm5QMQHUiXe4qpn6ZpQxLnOOuVOxaWVxMlN4GcDFY+p7iY75smWt
         w379IS9PLybsx2V/bPNQ5mnQ//N/Feq/ReAjbHrb9j90kF/eGnlnkGNCJRakGXmEsWWg
         Z3uN93k8puRfxFQs7UzgCbBXKYRJ+e1Ifemv03n8wDm8shjg3TOQbupkVwGpjildcvlZ
         1g/1tcfcxjQBx+QA3B9pHWuzPU3j/QvqjY1wW1r2dixn8p6HWM6cV26ajB1u6skcIOQd
         /wVJaQFjqG5V2npo7tA2DVY4v2sM9V+wzxUBogTH/tzpnCVbunsg2LUA28Yp0ghx6bM0
         EpKA==
X-Gm-Message-State: APjAAAUMSWOHia1qxr/QV7Q+XA0+YQ2ZeQQlf6Mi1L0uUf8SVvrO39CS
        MTytwtBFzmamMTGZnxbRgYw=
X-Google-Smtp-Source: APXvYqwEVMp6MZhQ8Dmhd28pn9gS6I6e+8YS51rUqhbOTgZShjlETjlpjdDuw56nGmchg6E6ZY7Cvg==
X-Received: by 2002:a63:441c:: with SMTP id r28mr6958073pga.255.1557068799900;
        Sun, 05 May 2019 08:06:39 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e1sm10152381pfn.187.2019.05.05.08.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:06:39 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 2/3] nvme: 016: fix nvmet pass data with loop
Date:   Mon,  6 May 2019 00:06:10 +0900
Message-Id: <20190505150611.15776-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following commit has affected the result of genctr and treq field
printed:

genctr would increment two times per a subsystem due to
  Commit b662a078 ("nvmet: enable Discovery Controller AENs")

treq field would be printed out to support TP 8005:
  nvmet driver:
    Commit 9b95d2fb ("nvmet: expose support for fabrics SQ flow control
                      disable in treq")
  nvme-cli:
    Commit 2cf370c3 ("fabrics: support fabrics sq flow control disable")

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 tests/nvme/016.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/016.out b/tests/nvme/016.out
index 59bd293..8599066 100644
--- a/tests/nvme/016.out
+++ b/tests/nvme/016.out
@@ -1,11 +1,11 @@
 Running nvme/016
 
-Discovery Log Number of Records 1, Generation counter 1
+Discovery Log Number of Records 1, Generation counter 2
 =====Discovery Log Entry 0======
 trtype:  loop
 adrfam:  pci
 subtype: nvme subsystem
-treq:    not specified
+treq:    not specified, sq flow control disable supported
 portid:  X
 trsvcid: 
 subnqn:  blktests-subsystem-1
-- 
2.7.4

