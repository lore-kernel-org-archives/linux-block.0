Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE8C34974
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5E24712
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLMOdL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:33:11 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45971 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfLMOdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 09:33:11 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so2191582iln.12
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2019 06:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drl3Eju3FzWAdVgHEQUgqm6x19DdmauK5QkwxXRH7qI=;
        b=qFogdp2103g72IypUbnESq0qcPXLrM9YfTdEwo7I9Op0/Xr2NzZ3peG/R+z+kNy2QV
         xhhKa+6bs2QTk9/LS1On6EEITEXwa0/yEfQymr910QieKBG5dlbEe2tSRyBMrgJ3PaAz
         CVRm8BlQztXhUOZQ6ckMULGpbvp6o13E+D1MpKoD/JFSSuJLfPFi55YUgiAXqyBTqIlf
         /czMaaKnWPyL1iWgmc1RiRqPsQnvNQh1DUsBiAR+MFiXoAouF0EyAIHjhrvAZ+tz+gcl
         lQXi0aJpV2WzFQ8+Cb0szORL7Lkk+/kWWwVpM9i14HFf4OUX60CDdviauzmVendigwpn
         Wi4g==
X-Gm-Message-State: APjAAAWP3vnHLiACqwkGvtztRRyygTPYhaZIR3LiH+VIlZ0oLZHxLfTn
        LLPhkDiul6W7O85BmhjU5D9XPkzZ
X-Google-Smtp-Source: APXvYqxTsyVGhP+fRyauLG511LHf1Gl0gQMgCdAXTexTDq4ZmPXcNAIO2sw1J68ROCXZ6nIHYE1SNw==
X-Received: by 2002:a92:81cb:: with SMTP id q72mr13376707ilk.275.1576247589775;
        Fri, 13 Dec 2019 06:33:09 -0800 (PST)
Received: from bvanassche-glaptop.ka.ltv ([75.104.68.105])
        by smtp.gmail.com with ESMTPSA id i79sm2785026ild.6.2019.12.13.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:33:09 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/4] common/multipath-over-rdma, tests/srp: Make it easy to use siw instead of rdma_rxe
Date:   Fri, 13 Dec 2019 09:32:31 -0500
Message-Id: <20191213143232.29899-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213143232.29899-1-bvanassche@acm.org>
References: <20191213143232.29899-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make all_primary_gids() return GIDs with zero suffix since SoftiWARP
GIDs have such a suffix. Add SoftiWARP support in start_soft_rdma() and
stop_soft_rdma(). Make do_rdma_cm_login() submit the source IP address
and scope ID to the SRP initiator driver since that information is
essential to establish an IPv6 connection between link-local addresses.
Iterate over RDMA ports instead of UMAD device nodes in log_in() since
no UMAD device node is associated with SoftiWARP ports. In start_lio_srpt(),
use the GID format to identify SoftiWARP ports since the GID suffix for
these ports is zero.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 common/multipath-over-rdma | 48 ++++++++++++++++---
 tests/srp/rc               | 98 ++++++++++++++++++++++----------------
 2 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 9f645f759d2d..40efc4b3aa2e 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -11,6 +11,7 @@ filesystem_type=ext4
 fio_aux_path=/tmp/fio-state-files
 memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
 max_ramdisk_size=$((1<<25))
+use_siw=
 ramdisk_size=$((memtotal*(1024/16)))  # in bytes
 if [ $ramdisk_size -gt $max_ramdisk_size ]; then
 	ramdisk_size=$max_ramdisk_size
@@ -389,9 +390,13 @@ function mountpoint() {
 
 # All primary RDMA GIDs
 all_primary_gids() {
-	find /sys/devices -name infiniband | while read -r p; do
-		cat "$p"/*/ports/*/gids/0
-	done | grep -v ':0000:0000:0000:0000$'
+	local gid p
+
+	for p in /sys/class/infiniband/*/ports/*/gids/0; do
+		gid="$(<"$p")"
+		[ "$gid" != 0000:0000:0000:0000:0000:0000:0000:0000 ] &&
+			echo "$gid"
+	done
 }
 
 # Check whether or not an rdma_rxe instance has been associated with network
@@ -408,24 +413,40 @@ has_rdma_rxe() {
 	return 1
 }
 
-# Load the rdma_rxe kernel module and associate it with all network interfaces.
+# Load the rdma_rxe or siw kernel module and associate it with all network
+# interfaces.
 start_soft_rdma() {
 	{
+	if [ -n "$use_siw" ]; then
+		modprobe siw || return $?
+		(
+			cd /sys/class/net &&
+				for i in *; do
+					[ -e "$i" ] || continue
+					[ -e "/sys/class/infiniband/${i}_siw" ] && continue
+					rdma link add "${i}_siw" type siw netdev "$i" ||
+						echo "Failed to bind the siw driver to $i"
+				done
+		)
+	else
 		modprobe rdma_rxe || return $?
 		(
 			cd /sys/class/net &&
 				for i in *; do
 					if [ -e "$i" ] && ! has_rdma_rxe "$i"; then
-						echo "$i" > /sys/module/rdma_rxe/parameters/add
+						echo "$i" > /sys/module/rdma_rxe/parameters/add ||
+							echo "Failed to bind the rdma_rxe driver to $i"
 					fi
 				done
 		)
+	fi
 	} >>"$FULL"
 }
 
-# Dissociate the rdma_rxe kernel module from all network interfaces and unload
-# the rdma_rxe kernel module.
+# Dissociate the rdma_rxe or siw kernel module from all network interfaces and
+# unload the rdma_rxe kernel module.
 stop_soft_rdma() {
+	{
 	(
 		cd /sys/class/net &&
 			for i in *; do
@@ -439,6 +460,19 @@ stop_soft_rdma() {
 		echo "Unloading rdma_rxe failed"
 		return 1
 	fi
+	(
+		cd /sys/class/net &&
+			for i in *_siw; do
+				[ -e "$i" ] || continue
+				rdma link del "${i}" ||
+					echo "Failed to unbind the siw driver from ${i%_siw}"
+			done
+	)
+	if ! unload_module siw 10; then
+		echo "Unloading siw failed"
+		return 1
+	fi
+	} >>"$FULL"
 }
 
 # /dev/sd... device node assigned to the scsi_debug kernel module.
diff --git a/tests/srp/rc b/tests/srp/rc
index a1bc09b496ec..2738c8f6a4e5 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -138,30 +138,51 @@ do_ib_cm_login() {
 	done
 }
 
+rdma_dev_to_net_dev() {
+	local b d rdma_dev=$1
+
+	b=/sys/class/infiniband/$rdma_dev/parent
+	if [ -e "$b" ]; then
+		echo "$(<"$b")"
+	else
+		echo "${rdma_dev%_siw}"
+	fi
+}
+
 # Tell the SRP initiator to log in to an SRP target using the RDMA/CM.
 # Arguments: $1: SRP target IOC GUID; $2: IB device to log in to; $3: additional
 # login parameters.
 do_rdma_cm_login() {
-	local a b add_param d dest dests ibdev ioc_guid pd
+	local a b c add_param d dest dests ibdev ioc_guid params
 
 	ioc_guid=$1
 	ibdev=$2
 	add_param=$3
-	pd=/sys/class/infiniband/$ibdev/parent
-	if [ -e "$pd" ]; then
-		d=$(<"$pd")
+	if d=$(rdma_dev_to_net_dev "$ibdev"); then
 		a=$(get_ipv4_addr "$(basename "$d")")
 		b=$(get_ipv6_addr "$(basename "$d")")
 	fi
 	echo "Interface $d: IPv4 $a IPv6 $b" >>"$FULL"
 	[ -n "$a$b" ] || return 1
+	b=${b}%$(<"/sys/class/net/$d/ifindex")
 	dests=()
-	[ -n "$a" ] && dests+=("${a}:${srp_rdma_cm_port}")
-	[ -n "$b" ] && dests+=("[${b}]:${srp_rdma_cm_port}")
+	for c in $a; do
+		dests+=("${c}:${srp_rdma_cm_port}")
+	done
+	for c in $b; do
+		dests+=("[${c}]:${srp_rdma_cm_port}")
+	done
 	for dest in "${dests[@]}"; do
+		src=${dest%:*}
 		for p in "/sys/class/infiniband_srp/srp-${2}-"*; do
 			[ -e "$p" ] || continue
-			srp_single_login "id_ext=$ioc_guid,ioc_guid=$ioc_guid,dest=$dest,$add_param" "$p/add_target"
+			ibdev=$(<"$p/ibdev")
+			port=$(<"$p/port")
+			gid=$(<"/sys/class/infiniband/$ibdev/ports/$port/gids/0")
+			gid=${gid//:}
+			gid_pfx=${gid:0:16}
+			params+="id_ext=$ioc_guid,initiator_ext=$gid_pfx,ioc_guid=$ioc_guid,src=$src,dest=$dest,$add_param"
+			srp_single_login "${params}" "$p/add_target"
 		done
 	done
 }
@@ -201,11 +222,11 @@ log_in() {
 	ioc_guid=$(</sys/module/ib_srpt/parameters/srpt_service_guid)
 
 	for ((i=0;i<10;i++)); do
-		for d in /sys/class/infiniband_mad/umad*; do
-			[ -e "$d" ] || continue
-			ibdev=$(<"$d/ibdev")
-			port=$(<"$d/port")
-			link_layer=$(<"/sys/class/infiniband/$ibdev/ports/$port/link_layer")
+		for p in /sys/class/infiniband/*/ports/*; do
+			[ -e "$p" ] || continue
+			port=$(basename "$p")
+			ibdev=$(basename "$(dirname "$(dirname "$p")")")
+			link_layer=$(<"$p/link_layer")
 			case $link_layer in
 				InfiniBand)
 					do_ib_cm_login   "$ioc_guid" "$ibdev" "$port" "$add_param" ||
@@ -454,34 +475,34 @@ configure_target_ports() {
 
 # Load LIO and configure the SRP target driver and LUNs.
 start_lio_srpt() {
-	local b d gid guid i ini_gids ini_guids opts p target_gids target_guids vdev
+	local b d gid i ini_ids=() opts p target_ids=() vdev
 
-	# shellcheck disable=SC2207
-	target_guids=($(all_primary_gids | sed 's/^fe80:0000:0000:0000://'))
-	# shellcheck disable=SC2207
-	target_gids=($(all_primary_gids | sed 's/^/0x/;s/://g'))
+	for gid in $(all_primary_gids); do
+		if [ "${gid#fe8}" != "$gid" ]; then
+			gid=${gid#fe80:0000:0000:0000:}
+		else
+			gid=0x${gid//:}
+		fi
+		target_ids+=("$gid")
+	done
+	echo "target_ids=${target_ids[*]}" >>"$FULL"
 	for p in /sys/class/infiniband/*/ports/*; do
 		[ -e "$p" ] || continue
-		link_layer=$(<"$p/link_layer")
-		case "$link_layer" in
-			InfiniBand)
-				guid=$(<"$p/gids/0")
-				gid=$(echo "${guid}" | sed 's/^fe8/0x000/;s/://g')
-				guid=${guid#fe80:0000:0000:0000:}
-				[ "$guid" = "0000:0000:0000:0000" ] && continue
-				ini_guids+=("$guid")
-				ini_gids+=("$gid")
-				;;
-			*)
-				d=$(<"$(dirname "$(dirname "$p")")/parent")
-				for b in $(get_ipv4_addr "$d") \
-						 $(get_ipv6_addr "$d"|expand_ipv6_addr); do
-					ini_guids+=("$b")
-					ini_gids+=("$b")
-				done
-				;;
-		esac
+		gid=$(<"$p/gids/0")
+		if [ "${gid#fe8}" != "$gid" ]; then
+			gid=${gid#fe80:0000:0000:0000:}
+			ini_ids+=("$gid")
+		else
+			gid="0x${gid//:}"
+			ini_ids+=("$gid")
+		fi
+		d=$(rdma_dev_to_net_dev "$(basename "$(dirname "$(dirname "$p")")")")
+		for b in $(get_ipv4_addr "$d") \
+				 $(get_ipv6_addr "$d"|expand_ipv6_addr); do
+			ini_ids+=("$b")
+		done
 	done
+	echo "ini_ids=${ini_ids[*]}" >>"$FULL"
 	mount_configfs || return $?
 	modprobe target_core_mod || return $?
 	modprobe target_core_iblock || return $?
@@ -519,10 +540,7 @@ start_lio_srpt() {
 			echo "${srp_rdma_cm_port}" > discovery_auth/rdma_cm_port ||
 				return $?
 		fi
-		configure_target_ports "${target_guids[@]}" -- "${ini_guids[@]}" || {
-			echo "Retrying with old port name format"
-			configure_target_ports "${target_gids[@]}" -- "${ini_gids[@]}"
-		}
+		configure_target_ports "${target_ids[@]}" -- "${ini_ids[@]}"
 	)
 }
 
