Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62CC004C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00387206DF
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 15:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIIVzcXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEEPGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 11:06:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41058 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEPGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 11:06:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so411472pfc.8
        for <linux-block@vger.kernel.org>; Sun, 05 May 2019 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39jUkrNuNbxi6cazD8jS8k1hzLeABn+VYqc7t21S97k=;
        b=IIIVzcXJdpRK0xCzUSqATw6FnCwMYVud/tDi/d9V7TBujUZDWMMX3KZU4Ql0d8wlLJ
         vYc6546K8Rw6YD55GPU/lrX7iH/vfzwmAB7mzHiwf5opj2UbpC3nkEDIA2R+wc7/NVir
         DxQ72EnH5wMqGwWGJXYYNV24bnHMdagJEATCLBgF5D4uDJBdaqnj1isHoC6eserWTdGf
         AQkzPAcVqZAlCfyASb2x87ldjXokyqQMsUiCj5ZIjBjES8DQxqz/QUzk97x5LpPF6UPj
         3+qS3/rFO3hE7RXtHo+6rjA9vVg8SvAJnEAooygWpebcobkiIP/UxxXE7xo/CLunVviU
         eRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39jUkrNuNbxi6cazD8jS8k1hzLeABn+VYqc7t21S97k=;
        b=nis8HVIqqLp0Cfd6Ev9CpjuCJJOAJ3Ey4nwcmMegGrPyxcEsGioEZLFGb9vBaeeK78
         5Gp2zSpjtiDsXDnmyY49iUcdryNge2oKuwWIndTYS0jWS0zgadikS1UhUeZvUpi6O1U7
         PjJ+29NPLaYYcOR62Jphy0wtP4QvnC/1YhgDyBCR7Gc7JrkZT448Z7kyQ5zZ/3mJ4uO9
         SB8GhyKPa7cLnFm1XJdTQUs2L4lhW1VTDdhhYceUJiZKBh5kpmlMyDvBghwfg+J0kg0S
         WNVi29jlVwJW2ZUPumcO76JFZJ3bjyHLF+zzKz0RgXaxgRnbStfeFcheXdQjGVaUYHnW
         Yqdg==
X-Gm-Message-State: APjAAAUsRfhxVAekUUTuYJ91i7AUX6Q0Njwrxge1pzB6ggA34+3K1utB
        nJmHMhNOwIj850tSA/8tEHNMYbFewMk=
X-Google-Smtp-Source: APXvYqwT2zSzkRKBKbEDj4NNDi8pLecAW6KVBf0H1O4F0pYgUL0OG0537Dsr1vL6ZUl7t2Kj0dx+3w==
X-Received: by 2002:a63:1d4f:: with SMTP id d15mr24659747pgm.347.1557068802789;
        Sun, 05 May 2019 08:06:42 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e1sm10152381pfn.187.2019.05.05.08.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:06:42 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 3/3] nvme: 017: fix nvmet pass data with loop
Date:   Mon,  6 May 2019 00:06:11 +0900
Message-Id: <20190505150611.15776-4-minwoo.im.dev@gmail.com>
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
 tests/nvme/017.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/017.out b/tests/nvme/017.out
index 4b0877a..d7685f6 100644
--- a/tests/nvme/017.out
+++ b/tests/nvme/017.out
@@ -1,11 +1,11 @@
 Running nvme/017
 
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

