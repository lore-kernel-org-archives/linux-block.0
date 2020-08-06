Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD93C433E3
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AB92224D
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgHFTPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:15:30 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:56294 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHFTP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 15:15:29 -0400
Received: by mail-pj1-f45.google.com with SMTP id 2so7345462pjx.5
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 12:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6rPl/XQAx312kYBDl1D3OvoqQvb50hFc5fzpRw9mLU=;
        b=q7B4WtcvktJNIa/jg2UDGIhj927G+KxzpXIYCFgPkiIGpDYbWTmKJ/H05Sw9HuSFMB
         4BKENulcX94r99lkAa+q32MKKbPofBd7NXwgtavFAB9GPlwGHoErX3+KO5gMIjg5MHx5
         uWFHor8mAOTy/KkRoZ33hcSyGfo0+0Y5ldBc78ml4ztaZrOTvG+o4LHes4Oql4APPnyG
         5CvE2emeRUkYECEaUAPUdOOMgDOmZjFhF6JduN2mBv4hkpsU3cDkme3/zkjFUtZE8AtG
         DAD7AE2Q+8rMTLJ37vLnR0fngnUZG5EKx1kItHMDczrrjD4q2qMtlglTzWSy5j39HgHE
         U1zg==
X-Gm-Message-State: AOAM532RBwhk35grI2uIjWtTawpXYT76nL/zxbbudh6e830WnJ/Tyw3W
        J4ijS7cf0AW9X6rfNV+7dsc=
X-Google-Smtp-Source: ABdhPJxx1Gzq5Y58oYCHXns8Ubqh9zuEiQhgOOdlCkCivBLSnydc7oGr6mq1NZ0HRu6qeIiNAx7Pvw==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id mw13mr10252988pjb.159.1596741328976;
        Thu, 06 Aug 2020 12:15:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:15:28 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
Date:   Thu,  6 Aug 2020 12:15:16 -0700
Message-Id: <20200806191518.593880-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

run with: nvme_trtype=tcp ./check test/nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a2cb0c0add93..69ab7d2f3964 100644
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

