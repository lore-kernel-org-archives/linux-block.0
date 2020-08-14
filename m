Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60952C433E1
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A01120791
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgHNGSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:18:49 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39019 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNGSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:18:49 -0400
Received: by mail-wr1-f44.google.com with SMTP id a5so7324380wrm.6
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fkvwug/VO+u7rU47Q5KeM31qbswJBkBpuvEWIweLbLE=;
        b=feyVXf/nhGmhBDU8lIerAnBm5dhOqWue+5QMCuibTMqwzU4puHitzC+CLgTyNW7Nrg
         61FSNpgEt4U6p/RQVptrSGkfxwDVIfop+Wqn/FrTrUbWqQbsxUoX1GtwWGyWtgD/K3/B
         NTt6pP96NOylXljJRyOU8Csn6D/yNjMFSyMqvIGHQkTt/notuAiJaxJLnRLj2lTW3kgZ
         cLhZWOxRJ8v6zTlqxb4QbNn3CXUYF8Dr8E4fTpW2wg3kPk2GPP0cN6vAKdJQGcILEjB7
         9soDYvh7+2++vmTvKS2sJ9aVJ7VcNJnArkCykDb/MSGOWTcX9VLiFUzDp7sm3AssLOTz
         YPoA==
X-Gm-Message-State: AOAM533w06GzDvEkbFT6uUilCbG/2/cNDXUfGJKfltmV5NSvwIPdcYd0
        t3fhApxTPDzfzRKwj42i7+0ucoE6Q0amuA==
X-Google-Smtp-Source: ABdhPJzh+p2rJPZXyETcVugnSNR99EGJ34rWwyZXkl7amLOpQ0WGTd4OEpu/Is1JAghTMJy0PwnAvQ==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr1201235wrw.365.1597385928029;
        Thu, 13 Aug 2020 23:18:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id l21sm12278131wmj.25.2020.08.13.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:18:47 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 5/7] nvme: support nvme-tcp when runinng tests
Date:   Thu, 13 Aug 2020 23:18:13 -0700
Message-Id: <20200814061815.536540-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

run with: nvme_trtype=tcp ./check nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 306a12440c20..3e97801bbb30 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1

