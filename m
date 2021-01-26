Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D670C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15ED420658
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 21:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbhAZV5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:57:00 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:36551 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbhAZEqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 23:46:12 -0500
Received: by mail-pj1-f45.google.com with SMTP id gx1so1512198pjb.1
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 20:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOJhjIXZR1Jsa52riSrSvcFbAvopbqZ3kEUCBOV1k0Y=;
        b=OX6fobZzf7uj74n5F2JeiN/hLC8+kAeQUsno7LL1kgLgDbT+Z0LVxgU+mz6ywyluff
         bFdrpnhv8kUMh8wJ5hNq7rX35Z+3sm2lpwXUpy1TaCfum0mLA6NYEuosWmdAqCuGvL2f
         20m/GncoWEU3ysCpYT4L8kH03LhK9VwtHfzLfWXHAGfRV6nI2z6oHAZCnngxGptVVi4/
         RAzRitsbxE2B8S1iNpyYeG7h7zBpukhMMjH7XGKEHZadJEvKG7OVY66MJBjR8baOB5a6
         oknZw5YQFkoKe01AxEXlIecRsSV9yxDDratyjQ6MOlHLt0e8Crz456/XSIFUR7UsETbE
         BqGQ==
X-Gm-Message-State: AOAM5323kGK0ytPXhix8zTKqj7sX2s4md6rjumiwPYgTFZWr6htV7ouD
        h/wvnr/T3qEAaozhtsC/fYPxmtFExcE=
X-Google-Smtp-Source: ABdhPJybeEkkmUHkZAvI9v8JS6q1TqVbcTAxukB9JnF72LN12lH53dVRpFofJ7EVcTZ95ZjLea3diQ==
X-Received: by 2002:a17:90a:5991:: with SMTP id l17mr3914232pji.187.1611636331401;
        Mon, 25 Jan 2021 20:45:31 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:f18a:1f6a:44e7:7404])
        by smtp.gmail.com with ESMTPSA id m1sm866857pjz.16.2021.01.25.20.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:45:30 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH blktests 3/3] rdma: Use rdma link instead of /sys/class/infiniband/*/parent
Date:   Mon, 25 Jan 2021 20:45:19 -0800
Message-Id: <20210126044519.6366-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126044519.6366-1-bvanassche@acm.org>
References: <20210126044519.6366-1-bvanassche@acm.org>
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
 common/multipath-over-rdma | 111 +++++++++++--------------------------
 tests/srp/rc               |   9 +--
 2 files changed, 32 insertions(+), 88 deletions(-)

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
diff --git a/tests/srp/rc b/tests/srp/rc
index 700cd71ea155..07378fab2f2c 100755
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
