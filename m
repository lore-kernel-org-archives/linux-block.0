Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF1C433E3
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B84A20838
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgHNGSz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:18:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56263 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNGSz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:18:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 9so6529321wmj.5
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4OhW2rUuJwKjNaFcB34eClsm9+qjLIquHqcWEiCTCC0=;
        b=ZwL8TjwXVNS8K1spxguwNtl7RXq7NXOL10supXlgKLv7pOvWzUWHFL7tfxDN1tFPYc
         /OXwrI1Mf9bv/MaQrlyZOFvbBpWMKubaYM5XnDOIYlmeo2AfN9DA97YY6xHPh10pYAz3
         7G+FSukmpDULUOUjyEQptL7WfiqSVJfSIEhVmwSrXTvsVozGnwVnNK6suOcJ9S/da6Gx
         YKJ1mq1m5+yNSzZDQlvaWJYZhlXqw3/19vcaqn8WxpCi6faobF8djgsPOyEAVQ0GAM8b
         1loPEl6g7HPee5p+QKO1FcZhf/qdW6RhGWhtrOe+vrtChSuxFYDGZZt0JFsZKjF49VpE
         6MhA==
X-Gm-Message-State: AOAM530Z1qT3mcz+DbCuk+p+1yrV9F4n63k0cD0nBSVRkitpco12mvEz
        LPeQ8Ny9EKyFcasUy/OGEZk=
X-Google-Smtp-Source: ABdhPJxFuWPIMgqdzeQoLSZO22LFh5x90KpUs2OtVL5I2U3yepGIHVF7CmBH8ySTLVYcTr4SVKpWqQ==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr1110462wmc.155.1597385933249;
        Thu, 13 Aug 2020 23:18:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id l21sm12278131wmj.25.2020.08.13.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:18:52 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 6/7] common: move module_unload to common
Date:   Thu, 13 Aug 2020 23:18:14 -0700
Message-Id: <20200814061815.536540-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
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
diff --git a/tests/srp/rc b/tests/srp/rc
index 4013e9514767..c36515066ffb 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -320,19 +320,6 @@ remove_mpath_devs() {
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

