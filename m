Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF367ECAAD2
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 08:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiH2IgT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiH2IgT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 04:36:19 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DA2DA94
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2022 01:36:17 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id bv25so2190291wrb.10
        for <linux-block@vger.kernel.org>; Mon, 29 Aug 2022 01:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0ZQbSIsprE03487lAD31MmeAFY1RsNZL8nmax2eWXLA=;
        b=KHACR6U6IWu5ojqOB6UGVRcBplCwhmaEcO+1w/55yMtkugn95KYwxM7euHENB/K1Cy
         7GRvAkvu1zaO5OHr3LcpHGbkqtEThFZGl+sxX7WDYOf1Oh1lSdpEfulVtEkTdj5SKlff
         NYP21rfIVuEZuktmUJwfgayT7fW6Yz+cpeG/BzVukIAX+UkYm9jTGRrAf87dsaX8EoPn
         +onqe9IIyRH7RNl18yywPLiUssU2xAI4eXuM1/NHDiMvl4KaUOx71yP7SnxJWOkGHvvN
         q2stEtPKysZybjyK6HbjnRBoIPEoxEDKiSBJhtX5ga8M5NtGHAIqEBF/LZKlqe/L8uY9
         rK1A==
X-Gm-Message-State: ACgBeo37SXEZnP1wLO2UpCHYFhyTcN/eWZlLyqJXJAyy1K1ZiBtQf3OS
        /GvVhVflPu/EsHnYzWDj0K8=
X-Google-Smtp-Source: AA6agR5/20gTWtc8lQJooG49YIjcQRyLGZnAyvagYX+Lc5zfuiiCSx/QZyE2RqJNyhyiFVCvuyqRIw==
X-Received: by 2002:a5d:47c9:0:b0:225:5a4f:8f82 with SMTP id o9-20020a5d47c9000000b002255a4f8f82mr5977615wrc.0.1661762176435;
        Mon, 29 Aug 2022 01:36:16 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0021e13efa17esm6553341wro.70.2022.08.29.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 01:36:15 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH blktests] nvme: add dh module requirement for tests that involve dh groups
Date:   Mon, 29 Aug 2022 11:36:14 +0300
Message-Id: <20220829083614.874878-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/043 | 1 +
 tests/nvme/044 | 1 +
 tests/nvme/045 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/nvme/043 b/tests/nvme/043
index 381ae755f140..87273e5b414d 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -16,6 +16,7 @@ requires() {
 	_have_kernel_option NVME_TARGET_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_have_driver dh_generic
 }
 
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 046553198ce3..13019659b951 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -16,6 +16,7 @@ requires() {
 	_have_kernel_option NVME_TARGET_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_have_driver dh_generic
 }
 
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index b60f18fc9f87..264f21053921 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -16,6 +16,7 @@ requires() {
 	_have_kernel_option NVME_TARGET_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
+	_have_driver dh_generic
 }
 
 
-- 
2.34.1

