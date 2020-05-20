Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169B5C433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF602065F
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETQwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 12:52:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40313 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETQwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 12:52:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id x2so1833444pfx.7
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 09:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHy6dzJShAsBSfKMCNdl4v0+6ff2utTjPCI7FIyPRMo=;
        b=hxUDAylDobBGUjhI71zf1SJpqQCIMX9XsAXlbdw2GXIx+piz2PdleQFjpQ0wlMwb+w
         2IFO+AIYMsqq6WHDJ/wB2equPVegdzguRcATv8goIq3ITXhWqenf3pXMOnOLiRgfHf6n
         G86U0ouEOiSbTz7PvkcxYbtSUYPrKoWlNDG+RgprcJSWfGu96BhJMGrSdakCN9Z3LbZc
         g05YeQp/xwFrkmqJ64z2yMkN0kzhUUu1VfoHH4WP+5XLPEnW6CXU5lyTsq0ifusukISX
         K1cX/eZzx6F2cKQOsgtbS3t7+aKqSBac8ptsM1WqOGUqpFgTgz9ibkCo3IebixbHZlm6
         9BRw==
X-Gm-Message-State: AOAM531Ek0Jmt2GRLVZXexBSEZOU12pWUdK3JxtPzGOg+Mc6PwJ/hoF+
        HOFtTzEeHuNbHP0IyxGM/3Y=
X-Google-Smtp-Source: ABdhPJxuCgEiF8HNagLjtK2xau+9+AR1f4KMZeh9d4wSMZhcOT+16DqEnPCcU48FhsHMcah4gKZ6aQ==
X-Received: by 2002:a05:6a00:1494:: with SMTP id v20mr5293792pfu.150.1589993567717;
        Wed, 20 May 2020 09:52:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:c031:e55:f9a8:4282])
        by smtp.gmail.com with ESMTPSA id w199sm2563885pfc.68.2020.05.20.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:52:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests] Restore support for running tests without prior test results
Date:   Wed, 20 May 2020 09:52:41 -0700
Message-Id: <20200520165241.24798-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes the following runtime error:

./check: line 245: LAST_TEST_RUN: unbound variable

Fixes: 203b5723a28e ("Show last run for skipped tests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 check | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 0a4e539a5cd9..5151d01995ac 100755
--- a/check
+++ b/check
@@ -240,9 +240,15 @@ _output_last_test_run() {
 }
 
 _output_test_run() {
+	local param_count
 	if [[ -t 1 ]]; then
 		# Move the cursor back up to the status.
-		tput cuu $((${#LAST_TEST_RUN[@]} + 1))
+		if [ -n "${LAST_TEST_RUN+set}" ]; then
+			param_count=${#LAST_TEST_RUN[@]}
+		else
+			param_count=0
+		fi
+		tput cuu $((param_count + 1))
 	fi
 
 	local status=${TEST_RUN["status"]}
