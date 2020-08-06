Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C3C433E4
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845FB221E3
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHFTPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:15:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41872 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 15:15:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id f10so3336803plj.8
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 12:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQg0QW5Ii5wVrkyjrYOAVjHAU5a8a/Cp+IYFCQV4S8g=;
        b=NOw2kvtY9xcXu7y4PJ5MEVq7iebFbYbpQuEJY2IOCgJ+TV27Nn9NWYBiXfeZ3kdzG3
         DDv23+Y15lgBQ729B3gxR9b8TiihuOa89ouCRc/wEBsrzEiZGRTpPJVa4TlqftuVNMTw
         dG23Du0VP6vjC/GmkNDq08oQHjdQbviMCy66OESKv8V6DmvbCNxzg7H0ov57buTtBp/a
         dJ67NSxpEkG0zRUB2ozQ8x0ObuaH06gpDkecRmZ2ALmfCrlGVDbbaCJIaQ4zmiz2AOzd
         1JOKTCHCKMpkRn7pNRpzmpDis9n/ADSLACk8edulgTGYszTP/0ZnHaK3lB69fleVtXhi
         H0FA==
X-Gm-Message-State: AOAM530biaLSOO2UYLJf9XTyxX2RLvKjWSayV2w1Rtl8vQxtLLOuqxmj
        Ji+YRUOVBYoeYVisEy6an1Q=
X-Google-Smtp-Source: ABdhPJxpKsWTAykfSJ0wzqMbrpgSPDXpwHBHIA/FIMsyOECQU+LDMn/kUKmdUMP/fDjvNhnD6Ap8RQ==
X-Received: by 2002:a17:90a:fca:: with SMTP id 68mr9362904pjz.12.1596741330403;
        Thu, 06 Aug 2020 12:15:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:15:29 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module unload
Date:   Thu,  6 Aug 2020 12:15:17 -0700
Message-Id: <20200806191518.593880-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to retry module unload for rdma_rxe
and siw. This also creates a dependency on
tests/nvmeof/rc which prevents it from using in
other test subsystems.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/multipath-over-rdma | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 676d2837fb06..e54b2a96153c 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -457,7 +457,7 @@ stop_soft_rdma() {
 				fi
 			done
 	)
-	if ! unload_module rdma_rxe 10; then
+	if ! modprobe -r rdma_rxe; then
 		echo "Unloading rdma_rxe failed"
 		return 1
 	fi
@@ -469,7 +469,7 @@ stop_soft_rdma() {
 					echo "Failed to unbind the siw driver from ${i%_siw}"
 			done
 	)
-	if ! unload_module siw 10; then
+	if ! modprobe -r siw; then
 		echo "Unloading siw failed"
 		return 1
 	fi
-- 
2.25.1

