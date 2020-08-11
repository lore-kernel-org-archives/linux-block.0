Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E5AC433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CC4206DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHKVBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:01:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46994 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgHKVBS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 17:01:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id p8so7273026pgn.13
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 14:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHRa+YkmLQcTpMTxlPvWnCrn2hDL5XCMaLx+f7rGfws=;
        b=CT+vfXgBXHX2Q7QQUJXcsKyt849ljOBKkam8UIxS5kUtiCfD6dnfBTqBzkZu+yeyQy
         T4S9sn56oXAM5UFxjI/upNQ05HYbPlYtMu6/G12gr9V0Ja4FBtEYKad3i2tcVeqxqQvp
         Ivr3miKuPIeGnUzdICt787O5Lha/sUB8NujydoW5yNrtXl6EiXIcXk/d62SnvYG9Z52Y
         sRgcuGlcJIG91ooQg5en4FpSp6hq/1/BqBWsypw/jLB9krKRI25/1BJYt9oPU2EnTJO3
         LvpY3Isvq0s3RCtdKnkXHBrShm1KMwm3i+DQ3RpyFaaYeVS66sZwBNBr2YOi6YkSYoCD
         l28A==
X-Gm-Message-State: AOAM530IZq0ebr9xpLY13BD9u45K97Y8VaB190NXNWpA3Vz6eNV9f7zS
        OnNROqmV2jLcME3DtXDRFJo=
X-Google-Smtp-Source: ABdhPJxwUjksoyjNiZXFmx16nWf/elaBbdLSb3p2YNFGJYWBKigmQzttycUYNOleemLlb8mxtDN8Pg==
X-Received: by 2002:a65:534c:: with SMTP id w12mr2233622pgr.156.1597179677399;
        Tue, 11 Aug 2020 14:01:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
        by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:01:16 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 6/7] common: move module_unload to common
Date:   Tue, 11 Aug 2020 14:01:01 -0700
Message-Id: <20200811210102.194287-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It creates a dependency between multipath-over-rdma
and test/nvmeof/rc which is not a natural home
for it. Move it to common helpers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/rc          | 13 +++++++++++++
 tests/nvmeof-mp/rc | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/common/rc b/common/rc
index 7f02103dc786..cdc0150ea5ea 100644
--- a/common/rc
+++ b/common/rc
@@ -291,3 +291,16 @@ _filter_xfs_io_error() {
 _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
+
+# Arguments: module to unload ($1) and retry count ($2).
+unload_module() {
+	local i m=$1 rc=${2:-1}
+
+	[ ! -e "/sys/module/$m" ] && return 0
+	for ((i=rc;i>0;i--)); do
+		modprobe -r "$m"
+		[ ! -e "/sys/module/$m" ] && return 0
+		sleep .1
+	done
+	return 1
+}
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index e446db297ba1..829b26624b7f 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -145,19 +145,6 @@ remove_mpath_devs() {
 	} &>> "$FULL"
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 start_nvme_client() {
 	modprobe nvme-core dyndbg=+pmf &&
 		modprobe nvme dyndbg=+pmf &&
-- 
2.25.1

