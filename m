Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED57C433E0
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 23:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC94861949
	for <linux-block@archiver.kernel.org>; Sun, 28 Mar 2021 23:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhC1XMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 19:12:48 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:36530 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhC1XMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 19:12:19 -0400
Received: by mail-pj1-f41.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so6827787pjh.1
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 16:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5WWiLJomX7i3yrkzKTngzjD7jIgrvyY0E/8sBaMa5s=;
        b=kEp4/b8z/nZqgo1P6mECvKIijJ2JTtW+CdRz09zpVzsVlrzNpt4pf4sqwHo0HPknJJ
         Uxir1/cmt9RIqxMccRthF3vsT/SdlqEos1hcleqWJ+hTGY4voqNKebCY+zSlQHXATHKM
         /ii6l4btIGa680rBQ1tzyR5EsE5zBZv7RbDgCh6Ak5CUExOchDjvZiSQI2LGlulNtIMw
         msVt5KErqp7lPigvdAhq5ndCC6jpc2mPrlA/kfAtvfVF6ExdgoNoyyBtdPPHXH52EteQ
         VpbLe7qUc9+wrlm7J19XLeEwX3/RkDTI2gx9Tp17dMPj7T2fSGd9Vip/AaKIjQdlKhOR
         xQYw==
X-Gm-Message-State: AOAM530EpsCFWdBh1m2q6kLGXXffPCjz+zwiJGabxRvvBEOm33ta4wme
        Gl4xa3J6PM7kCQdz6eXUl1k=
X-Google-Smtp-Source: ABdhPJyKIem07hauHIU8dQCjAvZtFXPaFrJiei8SyOFack2KzhTUZL3rXh4ZZyxZVhC+Uhjrct7ASw==
X-Received: by 2002:a17:902:c204:b029:e7:32fd:bc8f with SMTP id 4-20020a170902c204b02900e732fdbc8fmr12875367pll.43.1616973138814;
        Sun, 28 Mar 2021 16:12:18 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id gg22sm14305622pjb.20.2021.03.28.16.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:12:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH blktests v2] rdma: Use rdma link instead of /sys/class/infiniband/*/parent
Date:   Sun, 28 Mar 2021 16:12:10 -0700
Message-Id: <20210328231210.3707-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328231210.3707-1-bvanassche@acm.org>
References: <20210328231210.3707-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The approach of verifying whether or not an RDMA interface is associated
with the rdma_rxe interface by looking up its parent device is deprecated
and will be removed soon from the Linux kernel. Hence this patch that uses
the rdma link command instead.

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
v2: Added a _have_program check for 'rdma' as requested by Omar.
---
 common/multipath-over-rdma | 111 +++++++++++--------------------------
 tests/nvmeof-mp/rc         |   2 +-
 tests/srp/rc               |  12 +---
 3 files changed, 35 insertions(+), 90 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 9d9d2b27af83..9e68189b56fd 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -57,6 +57,9 @@ _multipathd_version_ge() {
 }
 
 get_ipv4_addr() {
+	if [ ! -e "/sys/class/net/$1" ]; then
+		echo "get_ipv4_addr(): $1 is not a network interface" 1>&2
+	fi
 	ip -4 -o addr show dev "$1" |
 		sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
 }
@@ -76,41 +79,11 @@ is_number() {
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
+	rdma link show |
+		sed -n 's/^.*[[:blank:]]netdev[[:blank:]]\+\([^[:blank:]]*\)[[:blank:]]*/\1/p' |
+		sort -u
 }
 
 # Check whether any stacked block device holds block device $1. If so, echo
@@ -411,47 +384,36 @@ all_primary_gids() {
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
 
@@ -459,27 +421,16 @@ start_soft_rdma() {
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
+		      rdma link del "${i}" || echo "Failed to remove ${i}"
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
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index ab7770f6aac0..0a12825e2c11 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -42,7 +42,7 @@ and multipathing has been enabled in the nvme_core kernel module"
 	)
 	_have_modules "${required_modules[@]}" || return
 
-	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof; do
+	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma; do
 		_have_program "$p" || return
 	done
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 700cd71ea155..2986bfd5439d 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -59,7 +59,8 @@ group_requires() {
 	)
 	_have_modules "${required_modules[@]}" || return
 
-	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset; do
+	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma \
+		 sg_reset; do
 		_have_program "$p" || return
 	done
 
@@ -142,14 +143,7 @@ do_ib_cm_login() {
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
