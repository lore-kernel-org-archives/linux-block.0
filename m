Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B32C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 04:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E8C238EC
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 04:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbhAUEF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 23:05:57 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:36960 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbhAUEAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 23:00:41 -0500
Received: by mail-pj1-f46.google.com with SMTP id g15so760378pjd.2
        for <linux-block@vger.kernel.org>; Wed, 20 Jan 2021 20:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/IeTVMjs2gsZlZJaQ3WICU3i1sauca25m6358/1xpSs=;
        b=bwlSCgQLKeddA3EeWPDcZrlryRjdB2ZC6B6+WKhoe1ZynyrlWHWeMIYG102g5qhEZl
         RlNtHEOIr1YX8MIJ7zGe4DrfY0o0TE9Vt8jgV57WHC1o6kyeHRdOENKJze0XbvbzoxYN
         /Qrw2MD/Xg+fDnGBIIswvIzK2h6WtXopPS/zuha35o8h6N8DewM6de7PlmoYbH7+vETp
         /P9qUedlKQNLqzqEsKnZ9W4JQFhPyZTWgXoX4ze7wTW/RruKPaJlltm2ezPo7q0vkMP/
         QloDBKmCMCWSityfjZL03OcSAOefXNZ+FhziZWEMoXxdy8IzzWs2UbXBAjwtdvMi6xIs
         OjPA==
X-Gm-Message-State: AOAM531wrEuKrGO23uHsafR5iSaN8N4Xn9ltsjh4Xh6dUxznCiHEQT68
        mmDp5WwBXRJYGhyKaMuh5Zg=
X-Google-Smtp-Source: ABdhPJxfRL9Isb7PXr14tCKgPwmmfBz/D/JIIQ6oGn5bJR8UTrgzbPjV4/59iy4q46YMsIrBA1kTuQ==
X-Received: by 2002:a17:90a:6643:: with SMTP id f3mr9445758pjm.33.1611201600973;
        Wed, 20 Jan 2021 20:00:00 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:b5ed:474a:81d5:2e31])
        by smtp.gmail.com with ESMTPSA id r30sm3922057pjg.43.2021.01.20.19.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 20:00:00 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH blktests] rdma: Use rdma link instead of /sys/class/infiniband/*/parent
Date:   Wed, 20 Jan 2021 19:59:54 -0800
Message-Id: <20210121035954.7245-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The approach of verifying whether or not an RDMA interface is associated
with the rdma_rxe interface by looking up its parent device is deprecated
and will be removed soon. Hence this patch that uses the rdma link command
instead.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 107 ++++++++++---------------------------
 tests/srp/rc               |   9 +---
 2 files changed, 28 insertions(+), 88 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 9d9d2b27af83..b85e31e7bce1 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -76,41 +76,9 @@ is_number() {
 	[ "$1" -eq "0$1" ] 2>/dev/null
 }
 
-# Check whether a device is an RDMA device. An example argument:
-# /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
-is_rdma_device() {
-	local d i inode1 inode2
-
-	inode1=$(stat -c %i "$1")
-	# echo "inode1 = $inode1"
-	for i in /sys/class/infiniband/*; do
-		d=/sys/class/infiniband/"$(readlink "$i")"
-		d=$(dirname "$(dirname "$d")")
-		inode2=$(stat -c %i "$d")
-		# echo "inode2 = $inode2"
-		if [ "$inode1" = "$inode2" ]; then
-			return
-		fi
-	done
-	false
-}
-
 # Lists RDMA capable network interface names, e.g. ib0 ib1.
 rdma_network_interfaces() {
-	(
-		cd /sys/class/net &&
-			for i in *; do
-				[ -e "$i" ] || continue
-				# Skip IPoIB (ARPHRD_INFINIBAND) network
-				# interfaces.
-				[ "$(<"$i"/type)" = 32 ] && continue
-				[ -L "$i/device" ] || continue
-				d=$(readlink "$i/device" 2>/dev/null)
-				if [ -n "$d" ] && is_rdma_device "$i/$d"; then
-					echo "$i"
-				fi
-			done
-	)
+	rdma link show | sed -n 's,^link[[:blank:]]*\([^/]*\)/.*,\1,p' | sort -u
 }
 
 # Check whether any stacked block device holds block device $1. If so, echo
@@ -411,47 +379,36 @@ all_primary_gids() {
 	done
 }
 
-# Check whether or not an rdma_rxe instance has been associated with network
-# interface $1.
-has_rdma_rxe() {
-	local f
-
-	for f in /sys/class/infiniband/*/parent; do
-		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
-			return 0
-		fi
-	done
-
-	return 1
+# Check whether or not an rdma_rxe or siw instance has been associated with
+# network interface $1.
+has_soft_rdma() {
+	rdma link | grep -q " netdev $1[[:blank:]]*\$"
 }
 
 # Load the rdma_rxe or siw kernel module and associate it with all network
 # interfaces.
 start_soft_rdma() {
+	local type
+
 	{
 	if [ -n "$use_siw" ]; then
 		modprobe siw || return $?
-		(
-			cd /sys/class/net &&
-				for i in *; do
-					[ -e "$i" ] || continue
-					[ -e "/sys/class/infiniband/${i}_siw" ] && continue
-					rdma link add "${i}_siw" type siw netdev "$i" ||
-						echo "Failed to bind the siw driver to $i"
-				done
-		)
+		type=siw
 	else
 		modprobe rdma_rxe || return $?
-		(
-			cd /sys/class/net &&
-				for i in *; do
-					if [ -e "$i" ] && ! has_rdma_rxe "$i"; then
-						echo "$i" > /sys/module/rdma_rxe/parameters/add ||
-							echo "Failed to bind the rdma_rxe driver to $i"
-					fi
-				done
-		)
+		type=rxe
 	fi
+	(
+		cd /sys/class/net &&
+			for i in *; do
+				[ -e "$i" ] || continue
+				[ "$i" = "lo" ] && continue
+				[ "$(<"$i/addr_len")" = 6 ] || continue
+				has_soft_rdma "$i" && continue
+				rdma link add "${i}_$type" type $type netdev "$i" ||
+				echo "Failed to bind the $type driver to $i"
+			done
+	)
 	} >>"$FULL"
 }
 
@@ -459,27 +416,17 @@ start_soft_rdma() {
 # unload the rdma_rxe kernel module.
 stop_soft_rdma() {
 	{
-	(
-		cd /sys/class/net &&
-			for i in *; do
-				if [ -e "$i" ] && has_rdma_rxe "$i"; then
-					{ echo "$i" > /sys/module/rdma_rxe/parameters/remove; } \
-						2>/dev/null
-				fi
-			done
-	)
+	rdma link |
+		sed -n 's,^link[[:blank:]]*\([^/]*\)/.* netdev .*,\1,p' |
+		while read -r i; do
+		      echo "$i ..."
+		      rdma link del "${i}" ||
+			      echo "Failed to unbind siw/rxe from ${i}"
+		done
 	if ! unload_module rdma_rxe 10; then
 		echo "Unloading rdma_rxe failed"
 		return 1
 	fi
-	(
-		cd /sys/class/net &&
-			for i in *_siw; do
-				[ -e "$i" ] || continue
-				rdma link del "${i}" ||
-					echo "Failed to unbind the siw driver from ${i%_siw}"
-			done
-	)
 	if ! unload_module siw 10; then
 		echo "Unloading siw failed"
 		return 1
diff --git a/tests/srp/rc b/tests/srp/rc
index 1f665a28db66..b8ac9e27a2fd 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -142,14 +142,7 @@ do_ib_cm_login() {
 }
 
 rdma_dev_to_net_dev() {
-	local b d rdma_dev=$1
-
-	b=/sys/class/infiniband/$rdma_dev/parent
-	if [ -e "$b" ]; then
-		echo "$(<"$b")"
-	else
-		echo "${rdma_dev%_siw}"
-	fi
+	rdma link show "$1/1" | sed 's/.* netdev //;s/[[:blank:]]*$//'
 }
 
 # Tell the SRP initiator to log in to an SRP target using the RDMA/CM.
