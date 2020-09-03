Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B83CC433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5FE206CA
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgICV1D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:27:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39743 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgICV1D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:27:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id a17so4689771wrn.6
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4766iF8tGytH+Vfs6i3/U2RwWmzQyiBC+bGyaYv3Kg=;
        b=FHJDAkHi0THEC29C3S2hXblf72jhTy1IUQqjKGIReqGDHtHZRuRf9R4O2zUWcfl7hr
         LmEC2d7W9UZPhrjWvvtf8o3VJOUzheb9EyGOF256stvkzpD5APljt8qhY5KZX/gtzYOD
         aVvP1KXM+YSrkD8sFHoSkGxUuG7kxDTPg+bKcr5PtG/jNYz7sbLY1C+DSqS+f72ULqja
         iS1owPKWdVq0slQFfzBeaJ3hiaIvJV4j51nYQb444hgNQXaIw2T0a4uz5poXVqWdo/vJ
         dZ2e+ohoxVjxRUY14AgXlMs7OVc8GBqHwtm4uK18fM9Th0Y9gL5jc4Q3V3fx+L7cNNzM
         uyYQ==
X-Gm-Message-State: AOAM531xBmNYStwpHGVWt4sz+afuhUNJFAfxQFwgEBNhrpwH9QixVuHp
        O+qeAK0Jb+IAJuQeBoSZmmLm+stFqezCVA==
X-Google-Smtp-Source: ABdhPJyceDLt46BagH2s8kzWgdnGx3zD4M1QfYsC13V+WDOl31FJC06yMWJ3qSl00wSvnewzuwlDlw==
X-Received: by 2002:adf:80e3:: with SMTP id 90mr4765291wrl.342.1599168419155;
        Thu, 03 Sep 2020 14:26:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:26:58 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 6/7] common: move module_unload to common
Date:   Thu,  3 Sep 2020 14:26:33 -0700
Message-Id: <20200903212634.503227-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It creates a dependency between multipath-over-rdma and test/nvmeof/rc
(and test/srp/rc) which is not a natural home for it.

Move it to common helpers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/rc          | 13 +++++++++++++
 tests/nvmeof-mp/rc | 13 -------------
 tests/srp/rc       | 13 -------------
 3 files changed, 13 insertions(+), 26 deletions(-)

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
index b95adf047a2f..d7a7c878fb19 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -149,19 +149,6 @@ remove_mpath_devs() {
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
diff --git a/tests/srp/rc b/tests/srp/rc
index 72a3bca3b44d..7fc094b8267f 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -321,19 +321,6 @@ remove_mpath_devs() {
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
 # Load the SRP initiator driver with kernel module parameters $1..$n.
 start_srp_ini() {
 	modprobe scsi_transport_srp || return $?
-- 
2.25.1

