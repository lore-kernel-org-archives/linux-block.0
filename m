Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476ADC43461
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028CB20797
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgICXx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:53:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36424 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXxz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 19:53:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id z9so4483077wmk.1
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 16:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Du+i9HgkXJlhLhZnQGYzI3XIgLUDpLhD/BA4KY8VIPM=;
        b=R+JNyNxgA02ye6g5k6Q/na9DxfcwK+G06boQz6EvWZmhKXj4ZdTYDY7iMkZLgExtuK
         NAyklyz0kblc0hLedk5X9K1YqQ382rHM1TgMkhnVb8yKj+wNIKp31DGALuZ+r6mx2jNa
         Hay21rzuiPL/zWREJiqywG/aNqk5jLwGJglON01xoFGQ8zQFSANmdYvirk937PKMbX5k
         wEHtLFZIJ7aCvdK+C9hyhcDMCvmKFP+0iH/kNk5EGGg0aDb3omZ0aUuYRia8BUQTcNZb
         y4246YC36Vb7g891MkU9Y3lDJmKiqarG4naCfECODC+cWpbV8fRKsBab0pN5ES8ZNGIp
         tJPA==
X-Gm-Message-State: AOAM531+w0NkfU45kuucMKhfJ6MtrZ9RAxaYm1F+3wYJS78/ndbW+o2x
        D6J8I6DH3uLP32bQfUMf02NYBeMuUJhQMA==
X-Google-Smtp-Source: ABdhPJxv7sUxT3XR7cNiPRH5eaGxwlw8mwOWzfRzCgByq8jz/hmsYxY0oUPCN+uTtKJQWVR+Densuw==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr4373676wmf.20.1599177232115;
        Thu, 03 Sep 2020 16:53:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:53:51 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 2/7] nvme: consolidate some nvme-cli utility functions
Date:   Thu,  3 Sep 2020 16:53:32 -0700
Message-Id: <20200903235337.527880-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  2 +-
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  4 ++--
 tests/nvme/005 |  4 ++--
 tests/nvme/008 |  4 ++--
 tests/nvme/009 |  4 ++--
 tests/nvme/010 |  4 ++--
 tests/nvme/011 |  4 ++--
 tests/nvme/012 |  4 ++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 |  4 ++--
 tests/nvme/015 |  4 ++--
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  4 ++--
 tests/nvme/019 |  4 ++--
 tests/nvme/020 |  4 ++--
 tests/nvme/021 |  4 ++--
 tests/nvme/022 |  4 ++--
 tests/nvme/023 |  4 ++--
 tests/nvme/024 |  4 ++--
 tests/nvme/025 |  4 ++--
 tests/nvme/026 |  4 ++--
 tests/nvme/027 |  4 ++--
 tests/nvme/028 |  4 ++--
 tests/nvme/029 |  4 ++--
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 31 +++++++++++++++++++++++++++++--
 28 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index aaa5ec4d729a..92779e8d28ca 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover loop | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index fd696d9efe2c..83d1b2ff9cb0 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys loop nqn.2014-08.org.nvmexpress.discovery
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
@@ -42,7 +42,7 @@ test() {
 		echo "Fail"
 	fi
 
-	nvme disconnect -n nqn.2014-08.org.nvmexpress.discovery
+	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/004 b/tests/nvme/004
index b841a8d4cd87..1a3eedd634cf 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -33,14 +33,14 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys loop blktests-subsystem-1
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme disconnect -n "blktests-subsystem-1"
+	_nvme_disconnect_subsys blktests-subsystem-1
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_subsystem "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
diff --git a/tests/nvme/005 b/tests/nvme/005
index df0900b372be..f26adebe1b3b 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -33,7 +33,7 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	nvme connect -t loop -n blktests-subsystem-1
+	_nvme_connect_subsys loop blktests-subsystem-1
 
 	local nvmedev
 	nvmedev="$(_find_nvme_loop_dev)"
@@ -42,7 +42,7 @@ test() {
 
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
-	nvme disconnect -d "${nvmedev}"
+	_nvme_disconnect_ctrl "${nvmedev}"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index f19de17fefac..91673974ecaa 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 4afbe62864f6..ec586ec08780 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -30,7 +30,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -38,7 +38,7 @@ test() {
 
 	udevadm settle
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 53b97484615f..e8055541746a 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -42,7 +42,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index a54583d5c582..7e89c8e7b38e 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index 0049c3d8ceb6..72cf93210bb9 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -38,7 +38,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -54,7 +54,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 622706ec4088..d70bd02df666 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -35,7 +35,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -51,7 +51,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index 9517230253ab..2d83c4258f2a 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index 40b850974b43..118a261f3845 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index e1bad2f81461..a2b22adfc6b9 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -33,7 +33,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 2e6d649f9b65..7ec146ec7414 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme discover -t loop | _filter_discovery
+	_nvme_discover loop | _filter_discovery
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index e39613709c90..2dee7d190006 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -46,7 +46,7 @@ test() {
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 86a2a2945b35..58ee7c916f9d 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -36,7 +36,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index ccadec6a5822..2615ab6b74b0 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -32,7 +32,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	nvme disconnect -n "${subsys_name}"
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbcb9d56a350..33f66c975553 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index 452e7b3d196c..e223107a226b 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 2714571d16d9..190bac07dae6 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -34,7 +34,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -44,7 +44,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 1f87bd19ec69..62c07478e8ce 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 1b9e33351f61..d760430518df 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index 21a265a630ba..40e894f89578 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index d7d33796e122..23feabf9f871 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1643857437e8..bb67249c2947 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -31,7 +31,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -40,7 +40,7 @@ test() {
 	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
 		echo "ERROR: list-subsys"
 	fi
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index 9f437285d085..184a2f177d2d 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -67,7 +67,7 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	nvme connect -t loop -n "${subsys_name}"
+	_nvme_connect_subsys loop "${subsys_name}"
 
 	nvmedev="$(_find_nvme_loop_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
@@ -81,7 +81,7 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	nvme disconnect -n "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7e7ee7327e62..7053553cb837 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -41,8 +41,8 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		nvme connect -t loop -n "${subsys}$i"
-		nvme disconnect -n "${subsys}$i" >> "${FULL}" 2>&1
+		_nvme_connect_subsys loop "${subsys}$i"
+		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
 	done
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 320aa4b2b475..e02cb3c346ee 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -64,7 +64,7 @@ _cleanup_nvmet() {
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
 		if [[ "$transport" == "loop" ]]; then
 			echo "WARNING: Test did not clean up loop device: ${dev}"
-			nvme disconnect -d "${dev}"
+			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
 
@@ -97,6 +97,33 @@ _setup_nvmet() {
 	modprobe nvme-loop
 }
 
+_nvme_disconnect_ctrl() {
+	local ctrl="$1"
+
+	nvme disconnect -d "${ctrl}"
+}
+
+_nvme_disconnect_subsys() {
+	local subsysnqn="$1"
+
+	nvme disconnect -n "${subsysnqn}"
+}
+
+_nvme_connect_subsys() {
+	local trtype="$1"
+	local subsysnqn="$2"
+
+	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	nvme connect "${ARGS[@]}"
+}
+
+_nvme_discover() {
+	local trtype="$1"
+
+	ARGS=(-t "${trtype}")
+	nvme discover "${ARGS[@]}"
+}
+
 _create_nvmet_port() {
 	local trtype="$1"
 
@@ -206,6 +233,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	nvme discover -t loop |
+	_nvme_discover loop |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1

