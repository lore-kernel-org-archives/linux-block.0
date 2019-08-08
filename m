Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7C0C32754
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3421743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfHHUFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:05:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35325 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbfHHUFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 16:05:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so2880993pgv.2
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 13:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPuTl/pW34NW20Oqtx9tQBNVNvCI52BUN4vQW8QKfe8=;
        b=m0HumNMSSfaQsHjIy/Q/tIYMiqu5H0pkTr33uXaKBdhBpXryKSHYH+CrED0mCuLxNq
         thKDC4dIi51PnyBIs7S35LZGBYiN6QLU7ls+8ZAHvSndM8cLgDHvam0u5FjNCN07+3kD
         wzeSxCJ1uqzXihgwoZyNVFMpWc9S1VBt9jmpr4P1gnTU2DnjHFJrCwG6dlST8seiB3uS
         N8qjRl+jFIqutktnEybzcjyNFQb3ySYDLCrw/4cfQPFTOHYw4NuEXV8qx+feqOCMP8rB
         wi+PjilI+r5CSwF0AyIbWUG7QnMAqk1oREuRTxypImnaizjWS/PSPwEhq68QNoAp4VKV
         pf6A==
X-Gm-Message-State: APjAAAUhwthSm0BXrOZaDL1yAu4r0YgjsuxYY3aUQ+V5G1Yt1Ulp+Ju+
        EoSpza5QCD/Ri1TLuI8NRfE=
X-Google-Smtp-Source: APXvYqwDTToc8YPZsieK/CnPh5VpdG+EXBZiBHWil6OnD6kpTcuhYrkJ1SkYrZ+1NnE5smmFxaLslw==
X-Received: by 2002:a17:90a:228b:: with SMTP id s11mr5609801pjc.23.1565294716938;
        Thu, 08 Aug 2019 13:05:16 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b6sm83307093pgq.26.2019.08.08.13.05.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:05:16 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 2/4] tests/nvmeof-mp/rc: Make simulate_network_failure_loop() more robust
Date:   Thu,  8 Aug 2019 13:05:04 -0700
Message-Id: <20190808200506.186137-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190808200506.186137-1-bvanassche@acm.org>
References: <20190808200506.186137-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid that the following is logged in the nvmeof-mp .full log files:

ls: cannot access '/sys/class/nvme/*/device/*/nvme0n1/reset_controller': No such
file or directory
tests/nvmeof-mp/rc: line 124: : No such file or directory

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nvmeof-mp/rc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 9324dd1e8e4f..7352b1628cd3 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -117,8 +117,9 @@ simulate_network_failure_loop() {
 	while [ $rc = 0 ]; do
 		sleep_until 5 ${deadline} || break
 		for d in $(held_by "$dev"); do
-			sf=$(ls -d /sys/class/nvme/*/device/*/"${d#/dev/}/reset_controller")
-			echo 1 > "$sf"
+			for sf in /sys/class/nvme/*/device/*/"${d#/dev/}/reset_controller"; do
+				[ -e "$sf" ] && echo 1 > "$sf"
+			done
 		done
 	done 2>>"$FULL"
 
-- 
2.22.0.770.g0f2c4a37fd-goog

