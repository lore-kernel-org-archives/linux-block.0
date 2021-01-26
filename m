Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFADC433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B313620658
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbhAZV45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:56:57 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:53689 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbhAZEqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 23:46:11 -0500
Received: by mail-pj1-f44.google.com with SMTP id p15so1318759pjv.3
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 20:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5g6yHoMv0Ymp4ePlhY9X33nPnf/x+/NS92uKkd7RO/E=;
        b=m7NVvxcwdUc7DREZDo0ZuV+oPL7CMqyr+L3MWkf8GxRi4u1tGlZEEhtGIcPA0sCYkG
         fyFFfjSecHUbVrVy7MqPnToVQ4+kTLSUIcpcLfjiGPU0PNfKFcxDKQBZnMmtzsbK5J4s
         NHx+/n5WYpI/Pya60FbklOzSC9G/IEPL6ZW7FgUmZvDlv12N/ZWXIJ54WsqZeeL4AqWY
         GMRpYVHcSHOo2i11M9oMFFQp5t2D3cAhU0LCW4pm35WVmQdd9NNLP64WY8Qj0/BY/xea
         H35Z+LPlACBrfJ0GDrLu8auA+fr5MX8MypM80cSN63PuOPN4yEsu8TIviorzp3FQ0YlK
         YQ+A==
X-Gm-Message-State: AOAM532BiU7iMAYE+qpXX3tW1j60wvBJOL/2tO+CTzqAZSmbMADTY9I7
        76KlwTk3k4pspQjD4YfENao=
X-Google-Smtp-Source: ABdhPJxd++VLQj+Lhi0VynM+pFxgq+G1rEaZjyf9pLwSvsfxRBC6SPrSHoUP+TaKp9M2qULk2S0Vmw==
X-Received: by 2002:a17:90a:590c:: with SMTP id k12mr3978307pji.233.1611636329778;
        Mon, 25 Jan 2021 20:45:29 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:f18a:1f6a:44e7:7404])
        by smtp.gmail.com with ESMTPSA id m1sm866857pjz.16.2021.01.25.20.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:45:28 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 2/3] tests/srp/rc: Improve reliability of stop_lio_srpt()
Date:   Mon, 25 Jan 2021 20:45:18 -0800
Message-Id: <20210126044519.6366-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126044519.6366-1-bvanassche@acm.org>
References: <20210126044519.6366-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the 'np' directory if it exists. Unload the iscsi_target_mod kernel
module if it has been loaded.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/srp/rc | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 1f665a28db66..700cd71ea155 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -545,34 +545,21 @@ stop_lio_srpt() {
 		fi
 	done
 
-	if [ -e /sys/kernel/config/target/srpt ]; then
-		(
-			cd /sys/kernel/config/target/srpt && (
-				for d in */*/acls/*/*/lun*; do [ -L "$d" ] && rm "$d"; done
-				for d in */*/acls/*/lun*; do [ -d "$d" ] && rmdir "$d"; done
-				for d in */*/acls/*; do [ -d "$d" ] && rmdir "$d"; done
-				for d in */*/lun/lun*/*; do [ -L "$d" ] && rm "$d"; done
-				for d in */*/lun/lun*; do [ -d "$d" ] && rmdir "$d"; done
-				for d in */*; do [ -e "$d/lun" ] && rmdir "$d"; done
-				for d in *; do [ -e "$d/fabric_statistics" ] && rmdir "$d"; done
-				true
-			) &&
-				cd .. &&
-				for ((i=0;i<10;i++)); do
-					rmdir srpt
-					[ -e srpt ] || break
-					sleep .1
-				done &&
-				[ ! -e srpt ] &&
-				unload_module ib_srpt 10
-		) || return $?
-	fi
-
-	rmdir /sys/kernel/config/target/core/*/* >&/dev/null
-	rmdir /sys/kernel/config/target/core/* >&/dev/null
-
-	for m in ib_srpt target_core_pscsi target_core_iblock target_core_file \
-			 target_core_stgt target_core_user target_core_mod
+	rmdir /sys/kernel/config/target/*/*/*/np/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/*/*/np >&/dev/null
+	rm -f /sys/kernel/config/target/*/*/*/acls/*/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/*/*/acls/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/*/*/acls/* >&/dev/null
+	rm -f /sys/kernel/config/target/*/*/*/lun/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/*/*/lun/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/*/*/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/*/* >&/dev/null
+	rmdir /sys/kernel/config/target/* >&/dev/null
+
+	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
+			 target_core_file target_core_stgt target_core_user \
+			 target_core_mod
 	do
 		unload_module $m 10 || return $?
 	done
