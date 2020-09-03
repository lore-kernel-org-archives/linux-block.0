Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A71C433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1107220797
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgICXyA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:54:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45823 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgICXyA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 19:54:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id x14so4903149wrl.12
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 16:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwNyTbPODwR3Q0/eLegXXd8A0YuC7dwJ2GXECJRtIhk=;
        b=K6NGXFMzyUwHvTSlys6tFJKW1XC3JnElDGwCXUL0VPwsxx/dg3dY2hXtyM0Lf75kIj
         EiOD9bt0CP/Zw9uNxEFuue1qaqJKfYq0ctMw1If2W8FfAyYrXrTYsfkUcgPvcPAV3Cvd
         JHvD6Z1Z3y6GMexLQ6uGAWg11PHsUVZHWRI0/EO4gNDcYndXYUq0hSABH/grP9qPvuHM
         Q3uPwIkCFdxpLoXW9UZ9k7LuMKGYSNmdrIxHUC8nm9vlLssZ3ORqwdEMrdBqn5boURIJ
         eRZ7hdHZt+zRTuNdA2AluFePv0eztlNVEBy5Sum8RfES2aAxVfAYBTbSW8Wj9KG5j8fK
         AuYA==
X-Gm-Message-State: AOAM532UGqQeqpLQYFv7mqc0/bgE1VG/WMsQWHbwChdffHYMVAV9iXuW
        wU3Y0fzmQ+dfHP5DB1J6wHocIxb07006fQ==
X-Google-Smtp-Source: ABdhPJzsrSqm/7x2qrpel8qz+Ew8IvlLbp10f9tu6l3tO8swj53kswOeLmoUzLjNKs0PZKWuzyu7BQ==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr4783911wrq.225.1599177234876;
        Thu, 03 Sep 2020 16:53:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:53:54 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 3/7] nvme: make tests transport type agnostic
Date:   Thu,  3 Sep 2020 16:53:33 -0700
Message-Id: <20200903235337.527880-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
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
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  2 +-
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  6 +++---
 tests/nvme/009 |  6 +++---
 tests/nvme/010 |  6 +++---
 tests/nvme/011 |  6 +++---
 tests/nvme/012 |  6 +++---
 tests/nvme/013 |  6 +++---
 tests/nvme/014 |  6 +++---
 tests/nvme/015 |  6 +++---
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  6 +++---
 tests/nvme/019 |  6 +++---
 tests/nvme/020 |  6 +++---
 tests/nvme/021 |  6 +++---
 tests/nvme/022 |  6 +++---
 tests/nvme/023 |  6 +++---
 tests/nvme/024 |  6 +++---
 tests/nvme/025 |  6 +++---
 tests/nvme/026 |  6 +++---
 tests/nvme/027 |  6 +++---
 tests/nvme/028 |  8 ++++----
 tests/nvme/029 |  6 +++---
 tests/nvme/030 |  2 +-
 tests/nvme/031 |  4 ++--
 tests/nvme/rc  | 39 ++++++++++++++++++++++++++++++++-------
 31 files changed, 110 insertions(+), 85 deletions(-)

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
index f26adebe1b3b..e97287a96a4e 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
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
 
 	udevadm settle
 
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
index 91673974ecaa..cb36442bda18 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index ec586ec08780..6abca757b4e6 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -27,12 +27,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index e8055541746a..903da818b5ac 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 7e89c8e7b38e..4060e6278d44 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 72cf93210bb9..dd8bceca5373 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -35,12 +35,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index d70bd02df666..059d608a892f 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,12 +32,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 2d83c4258f2a..192322862072 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 118a261f3845..353445ad31b9 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
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
index 2dee7d190006..73703a286ff8 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 58ee7c916f9d..8ccfface176e 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -33,12 +33,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 2615ab6b74b0..7861d47513e5 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -29,12 +29,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index 33f66c975553..52d14f0490b1 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index e223107a226b..111dec92f791 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index 190bac07dae6..31f77ff07055 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -31,12 +31,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 62c07478e8ce..5a30b08b9d8e 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index d760430518df..b7903d6ad8f2 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 40e894f89578..721d486bc7de 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 23feabf9f871..6be7d0492d37 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -28,12 +28,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index bb67249c2947..2d89c8fa35de 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -28,16 +28,16 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	if ! nvme list-subsys 2>> "$FULL" | grep -q loop; then
+	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
 	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
diff --git a/tests/nvme/029 b/tests/nvme/029
index 184a2f177d2d..0bface97ccd5 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -64,12 +64,12 @@ test() {
 
 	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	port="$(_create_nvmet_port "loop")"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 
-	_nvme_connect_subsys loop "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev="$(_find_nvme_dev)"
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
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
index e02cb3c346ee..621686abf80a 100644
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
 
 	ARGS=(-t "${trtype}")
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

