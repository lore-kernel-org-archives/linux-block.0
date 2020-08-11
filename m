Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF0DC433E4
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBACC206DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKVBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:01:16 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:36149 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHKVBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 17:01:15 -0400
Received: by mail-pf1-f175.google.com with SMTP id m8so8278987pfh.3
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 14:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tQe9TzFSzp924C10rfbzh+cSEn+WNgbe/z0aeO76DU=;
        b=YIZVrSO2dH9a2fZy7Z6t5b2qKila8m9PwXxJNq6xZmoDAmHuFKm43hy58lVvRvFJti
         a9rK0gHzTspdQRCfpw0/mjpUSgPwSWBFzyd9NqD6R5UCtVpSwFr9zLK8S/+5U4BR0aXg
         6NZ6WXCgRUBXNQAm6KJGRjvs82J5ylXtRFeovPbtLi8vJUVV4JXgIC7Z1F2zdGlACizL
         jqEdxQe5ewbCO8Z78BeVfCCtRQ8fYdSPcUPVXqsdlyNCtTQKBMs6yilUZinYEEaPCWZD
         HJVZRTYugQIRh3jblo3WsS0K9qnFoZ8wl8M5AF4Aveq9SNl6ErvSRvdPZzLrSYkQMNJR
         0hvw==
X-Gm-Message-State: AOAM530ZeOwtM6CskfI3ZMl/reGILFbe/ByfMX036SsAya9vHPMKtKJh
        6wu5GuVOHGWvxsU2siKydpM=
X-Google-Smtp-Source: ABdhPJz0IVfqtwXq/pYkI3RFdFDyCJD5oNq5jI4lmtPWYBfIHC9/BQ3wpGyFzuwGenv6U5BYQvrB0A==
X-Received: by 2002:a63:ec04:: with SMTP id j4mr2261308pgh.393.1597179675107;
        Tue, 11 Aug 2020 14:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
        by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:01:14 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 5/7] nvme: support nvme-tcp when runinng tests
Date:   Tue, 11 Aug 2020 14:01:00 -0700
Message-Id: <20200811210102.194287-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
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

