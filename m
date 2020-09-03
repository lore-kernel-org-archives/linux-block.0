Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26723C43461
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2A820767
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgICV05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:26:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33497 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICV04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:26:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id m6so4741515wrn.0
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9iwFxPRmcaRhefYmZPIVD+jnN83NvVkHZzzTySYg6Y=;
        b=by97S0+6K7jY1XzkFk2bMtVDEBYL+5+ZD9mpS+BxnAAGEWNGJc4gnYzU8ZR4oPxvai
         RA4jEV/sfYGawrLU1yQM4Ja+fVWECferSrbrYo6c6yPD52Nh7tlLV6hdFs11SnLFvLZL
         B6FURgsxV2gvOZ4hK4YEV5MMCY2vM0TfjIL0FaSVrzCK4AiKgrCOUT3e5Tcp6n2WOC1I
         a7m+paO4VT1dhUjooX/LJH+BoMhlDTibn4hnJfvuLmKTgKOLeqFit4qz/vL4bkT7fgUl
         /5984PJsOSFsIJWnwy4NC3kP61YtwD5Q7lsN0eJBRk4mU5wVkfK4E3RCgpSyH9BnJT1O
         5Xjg==
X-Gm-Message-State: AOAM5316XSnA67Yr1Dltt3wonctW8ouNIylmqfT6OkkfbhSnjLJbGPmU
        CCQ0J95AaR6hIQspWnzKw5FxwX7qYZsfbw==
X-Google-Smtp-Source: ABdhPJwXFL7lRvlbsRy/JWHMpq7pkSKh/h1CM7920h03WjxpBJoKe6+k6qnWnBwmhyrUJmFbG3K8uQ==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr4226205wrt.23.1599168410437;
        Thu, 03 Sep 2020 14:26:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:26:49 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 3/7] nvme: make tests transport type agnostic
Date:   Thu,  3 Sep 2020 14:26:30 -0700
Message-Id: <20200903212634.503227-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass in nvme_trtype to common routines that can
support multiple transport types.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  4 ++--
 tests/nvme/003 |  4 ++--
 tests/nvme/004 |  6 +++---
 tests/nvme/005 |  8 ++++----
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  8 ++++----
 tests/nvme/009 |  8 ++++----
 tests/nvme/010 |  8 ++++----
 tests/nvme/011 |  8 ++++----
 tests/nvme/012 |  8 ++++----
 tests/nvme/013 |  8 ++++----
 tests/nvme/014 |  8 ++++----
 tests/nvme/015 |  8 ++++----
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  8 ++++----
 tests/nvme/019 |  8 ++++----
 tests/nvme/020 |  8 ++++----
 tests/nvme/021 |  8 ++++----
 tests/nvme/022 |  8 ++++----
 tests/nvme/023 |  8 ++++----
 tests/nvme/024 |  8 ++++----
 tests/nvme/025 |  8 ++++----
 tests/nvme/026 |  8 ++++----
 tests/nvme/027 |  8 ++++----
 tests/nvme/028 | 10 +++++-----
 tests/nvme/029 |  8 ++++----
 tests/nvme/030 |  2 +-
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------
 31 files changed, 131 insertions(+), 106 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 92779e8d28ca..955f68da026a 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -21,7 +21,7 @@ test() {
 
 	local iterations=1000
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
@@ -31,7 +31,7 @@ test() {
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
-	_nvme_discover loop | _filter_discovery
+	_nvme_discover "${nvme_trtype}" | _filter_discovery
 
 	for ((i = iterations - 1; i >= 0; i--)); do
 		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
diff --git a/tests/nvme/003 b/tests/nvme/003
index 83d1b2ff9cb0..654ff776f6f9 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -21,7 +21,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	local loop_dev
 	loop_dev="$(losetup -f)"
@@ -29,7 +29,7 @@ test() {
 	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys loop nqn.2014-08.org.nvmexpress.discovery
+	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
 
 	# This is ugly but checking for the absence of error messages is ...
 	sleep 10
diff --git a/tests/nvme/004 b/tests/nvme/004
index 1a3eedd634cf..0a62e3448e7b 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -22,7 +22,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	truncate -s 1G "$TMPDIR/img"
 
@@ -33,10 +33,10 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys loop blktests-subsystem-1
+	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 708e37766e0e..e97287a96a4e 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -22,7 +22,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	truncate -s 1G "$TMPDIR/img"
 
@@ -33,16 +33,16 @@ test() {
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
 
-	_nvme_connect_subsys loop blktests-subsystem-1
+	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 
 	udevadm settle
 
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
-	_nvme_disconnect_ctrl ${nvmedev}
+	_nvme_disconnect_ctrl "${nvmedev}"
 	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/006 b/tests/nvme/006
index 3f47613d52d2..8fe95461e6cc 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -29,7 +29,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
diff --git a/tests/nvme/007 b/tests/nvme/007
index 0902745a4ab2..e712026ba373 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -28,7 +28,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 177a1f27dcd6..cb36442bda18 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -31,18 +31,18 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	udevadm settle
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 621eec668926..6abca757b4e6 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -27,18 +27,18 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	udevadm settle
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index 3a629469014f..903da818b5ac 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -31,18 +31,18 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index 068090a0f42d..4060e6278d44 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -29,18 +29,18 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index 4cab4c1891a9..dd8bceca5373 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -35,12 +35,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -54,7 +54,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index b646f08be26a..059d608a892f 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,12 +32,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -51,7 +51,7 @@ test() {
 
 	umount "${mount_dir}" > /dev/null 2>&1
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index 979f77009209..192322862072 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -44,7 +44,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index ecd23b206e25..353445ad31b9 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -41,7 +41,7 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index a2b22adfc6b9..f829dedf7baa 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -30,7 +30,7 @@ test() {
 		_create_nvmet_ns "${subsys_nqn}" "${i}" "${loop_dev}"
 	done
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
 	_nvme_discover loop | _filter_discovery
diff --git a/tests/nvme/017 b/tests/nvme/017
index 7ec146ec7414..e552af17ccb9 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -33,7 +33,7 @@ test() {
 		_create_nvmet_ns "${subsys_name}" "${i}" "${file_path}"
 	done
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
 	_nvme_discover loop | _filter_discovery
diff --git a/tests/nvme/018 b/tests/nvme/018
index 9b5abefd39d2..73703a286ff8 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -46,7 +46,7 @@ test() {
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 5bc68e4514f9..8ccfface176e 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -33,18 +33,18 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index 32f7490b0796..7861d47513e5 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -29,18 +29,18 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	_nvme_disconnect_subsys ${subsys_name}
+	_nvme_disconnect_subsys "${subsys_name}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index c10c09277cff..52d14f0490b1 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index f7286ef008e0..111dec92f791 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 0b93fe95954b..31f77ff07055 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -44,7 +44,7 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 174fdc74a4e1..5a30b08b9d8e 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -28,19 +28,19 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 7f90a57861bd..b7903d6ad8f2 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index 5af08b753fe9..721d486bc7de 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -41,7 +41,7 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index 445f4fc65306..6be7d0492d37 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -28,19 +28,19 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index 70f6462bb9f3..2d89c8fa35de 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -28,19 +28,19 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
+	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index 873e54e7e43a..0bface97ccd5 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -64,12 +64,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop ${subsys_name}
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -81,7 +81,7 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	_nvme_disconnect_subsys ${subsys_name} >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_subsystem "${subsys_name}"
diff --git a/tests/nvme/030 b/tests/nvme/030
index 7156cad7b657..91c042ab6b0b 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -37,7 +37,7 @@ test() {
 
     _setup_nvmet
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7053553cb837..3faa4c171cc8 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -36,12 +36,12 @@ test() {
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
-		_nvme_connect_subsys loop "${subsys}$i"
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index db19d50131e9..875127d85876 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -6,6 +6,9 @@
 
 . common/rc
 
+def_traddr="127.0.0.1"
+def_adrfam="ipv4"
+def_trsvcid="4420"
 nvme_trtype=${nvme_trtype:-"loop"}
 
 _nvme_requires() {
@@ -62,8 +65,8 @@ _cleanup_nvmet() {
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
-			echo "WARNING: Test did not clean up loop device: ${dev}"
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
+			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
@@ -87,14 +90,20 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -r nvme-loop 2>/dev/null
+	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
+	fi
 	modprobe -r nvmet 2>/dev/null
 }
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
 	modprobe nvmet
-	modprobe nvme-loop
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		modprobe nvmet-"${nvme_trtype}"
+	fi
+	modprobe nvme-"${nvme_trtype}"
 }
 
 _nvme_disconnect_ctrl() {
@@ -112,20 +121,33 @@ _nvme_disconnect_subsys() {
 _nvme_connect_subsys() {
 	local trtype="$1"
 	local subsysnqn="$2"
+	local traddr="${3:-$def_traddr}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if [[ "${trtype}" != "loop" ]]; then
+		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+	fi
 	nvme connect "${ARGS[@]}"
 }
 
 _nvme_discover() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local trsvcid="${3:-$def_trsvcid}"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	if [[ "${trtype}" != "loop" ]]; then
+		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+	fi
 	nvme discover "${ARGS[@]}"
 }
 
 _create_nvmet_port() {
 	local trtype="$1"
+	local traddr="${2:-$def_traddr}"
+	local adrfam="${3:-$def_adrfam}"
+	local trsvcid="${4:-$def_trsvcid}"
 
 	local port
 	for ((port = 0; ; port++)); do
@@ -136,6 +158,9 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
+	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
+	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
 
 	echo "${port}"
 }
@@ -207,13 +232,13 @@ _remove_nvmet_subsystem_from_port() {
 	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
 
-_find_nvme_loop_dev() {
+_find_nvme_dev() {
 	local dev
 	local transport
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
+		if [[ "$transport" == "${nvme_trtype}" ]]; then
 			echo "$dev"
 			for ((i = 0; i < 10; i++)); do
 				if [[ -e /sys/block/$dev/uuid &&
@@ -233,6 +258,6 @@ _filter_discovery() {
 }
 
 _discovery_genctr() {
-	_nvme_discover loop |
+	_nvme_discover "${nvme_trtype}" |
 		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
 }
-- 
2.25.1

