Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9F3612F4
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931047; cv=none; b=uiEBU2aHxBBrx4H9283hj5QV0a+QKGDZNbdRAq10w9HlX4igSjy4F2IgDbqY5Gcls6tB9B5cdiFh2/SQxllvcC3C71H4rzF7l4P+XpLeogynxCXwPvzeHK8C0k0sNnnhHMivtU5gJRaZ9X+7oM7Q00BGIlMmqtzf+CF19ND5zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931047; c=relaxed/simple;
	bh=tm9HtQv9s5WdJZozM0+Wk8Qqbh4UPG0pE1x3tcV2CgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0gUz29jWJphez0R5r5BC5e7KfOHzI+b1+/XPemcHvMHXms8L/rC6LwnJ4XkzVQFQ5zK7KNYohHgHfFRPaQG7ndcwaDadSZPrmx4o9FU1w1MYPi4WIZWd6UTNSfJGSTNZ+BX7IpHCOj9v1uMg3Ine6lxRtgAun2MYGgqr570uqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqA/75uI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqA/75uI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787931041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bnB8nmoFMTfQQCF2/LvBxOX4ud/kuLuzvSdUVFbQV8=;
	b=VqA/75uIqt1dg8Sus83DQRM2/isV4r2SIRlEXnVkng1VjbrmsNhHn6/n1z6/IMEKy5d8/J
	l3ryfzgR0Scfs+CuhlvJfrd++jaV7tAvfiW68e8/rqy7tbXOcJKbGOiSzcO34kZlWobMCA
	8pwcAj4mI6J6NPnHCBd8YHd6QdjMrtM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-FNFS_BnJNEqsjiqIKCEWaQ-1; Fri,
 28 Aug 2026 11:30:40 -0400
X-MC-Unique: FNFS_BnJNEqsjiqIKCEWaQ-1
X-Mimecast-MFC-AGG-ID: FNFS_BnJNEqsjiqIKCEWaQ_1787931037
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6A991828A86;
	Fri, 28 Aug 2026 15:30:37 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.80.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0919218005B1;
	Fri, 28 Aug 2026 15:30:35 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [blktests v3 2/2] nvme/070: Test multipath and marginal ports
Date: Fri, 28 Aug 2026 11:30:29 -0400
Message-ID: <20260828153029.853768-3-jtaubepe@redhat.com>
In-Reply-To: <20260828153029.853768-1-jtaubepe@redhat.com>
References: <20260828153029.853768-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add tests/nvme/070 to test various multipath and marginal port
scenarios, while confirming the port useage and state. This test is
intended to emulate receiving an FPIN event in a multipath environment.

Co-authored-by: John Menehgini <jmeneghi@redhat.com>
Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
---
V1 -> V2:
 - Add John's tags
 - Add _rport_check_use_opt
 - Add _rport_is_not_in_use to allow for checking with a timeout
 - Add _rport_num_in_use - Wrap lines over 80col
 - Add timeout functionality to _rport_is_marginal, is_online,
     in_use.
 - Fix path state setup to have one optimized and one non-optimized port
     for each host
 - Fix test_set_all_marginal to correctly check non-numa iopolicy
 - Remove _rport_check_opt as it was redundant
 - Rename _rport_optimized to _rport_is_optimized
 - Skip test if /sys/class/fcloop/ctl/set_marginal_rport does not exist
 - Use grep --quiet instead of grep -q
 - Use local -a for arrays
V2 -> V3:
 - Add tests for inaccessable paths
 - Fix fio not exiting
 - Move generic code to common/nvme
---
 common/nvme        | 247 ++++++++++++++++++++++++
 tests/nvme/070     | 454 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  49 +++++
 3 files changed, 750 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

diff --git a/common/nvme b/common/nvme
index a6d6b28..da1124a 100644
--- a/common/nvme
+++ b/common/nvme
@@ -16,6 +16,7 @@ def_local_wwnn="0x10001100aa000001"
 def_local_wwpn="0x20001100aa000001"
 def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
 def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+export def_check_timeout=10
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 export def_nsid="1"
@@ -209,6 +210,252 @@ _cleanup_blkdev() {
 	rm -f "$(_nvme_def_file_path)"
 }
 
+_subsys_rport_addr() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	cat "$RPORT"/address
+	# traddr=nn-0x2047d039ea98949e:pn-0x2048d039ea98949e,host_traddr=nn-0x200000109b9b7e4e:pn-0x100000109b9b7e4e
+}
+
+_subsys_get_port() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local port
+	local address
+
+	address=$(_subsys_rport_addr "$RPORT")
+	port=$(echo "$address" | sed -n 's/.*pn-\(.*\),.*/\1/p')
+	echo $(( port - $(_remote_wwpn 0) ))
+	# a number representing the port number, e.g. 0, 1, 2, 3
+}
+
+_rport_set_iopolicy() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local POLICY=$2 # numa queue-depth round-robin
+
+	echo "$POLICY" | sudo tee "$RPORT"/iopolicy > /dev/null
+	# Returns none
+}
+
+_rport_set_marginal() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	_setup_nvmet_port_marginal "$(_subsys_get_port "$RPORT")" "marginal"
+}
+
+_rport_set_online() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	_setup_nvmet_port_marginal "$(_subsys_get_port "$RPORT")" "live"
+}
+
+_rport_is_online_raw() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	[[ "$(cat "$RPORT"/state)" == "live" ]]
+	# Returns Success or Fail
+}
+
+_rport_is_marginal_raw() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	[[ "$(cat "$RPORT"/state)" == "marginal" ]]
+	# Returns Success or Fail
+}
+
+_rport_in_use_raw() {
+	local SUBSYS_PATH=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# there should only be one "nvme3c9n1"
+	[[ "$(cat "$SUBSYS_PATH"/nvme*/stat | awk '{print $9}')" != "0" ]]
+	# Returns exit code 0 if in use, 1 if not in use
+}
+
+_rport_is_optimized() {
+	local SUBSYS_PATH=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# there should only be one "nvme3c9n1"
+	[[ "$(cat "$SUBSYS_PATH"/nvme*/ana_state)" == "optimized" ]]
+	# Returns exit code 0 if optimized, 1 if not optimized
+}
+
+_rport_is_non_optimized() {
+	local SUBSYS_PATH=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# there should only be one "nvme3c9n1"
+	[[ "$(cat "$SUBSYS_PATH"/nvme*/ana_state)" == "non-optimized" ]]
+	# Returns exit code 0 if non-optimized, 1 if not non-optimized
+}
+
+_rport_is_inaccessible() {
+	local SUBSYS_PATH=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# there should only be one "nvme3c9n1"
+	[[ "$(cat "$SUBSYS_PATH"/nvme*/ana_state)" == "inaccessible" ]]
+	# Returns exit code 0 if inaccessible, 1 if not inaccessible
+}
+
+_rport_is_online() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i TIMEOUT="${2:-$def_check_timeout}"
+	local -i time_passed=0
+
+	for (( time_passed=0; time_passed < TIMEOUT; time_passed++ )); do
+		_rport_is_online_raw "$RPORT" && return 0 || true
+		sleep 1
+	done
+	return 1
+	# Returns Success or Fail
+}
+
+_rport_is_marginal() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i TIMEOUT="${2:-$def_check_timeout}"
+	local -i time_passed=0
+
+	for (( time_passed=0; time_passed < TIMEOUT; time_passed++ )); do
+		_rport_is_marginal_raw "$RPORT" && return 0 || true
+		sleep 1
+	done
+	return 1
+	# Returns Success or Fail
+}
+
+_rport_in_use() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i TIMEOUT="${2:-$def_check_timeout}"
+	local -i time_passed=0
+
+	for (( time_passed=0; time_passed < TIMEOUT; time_passed++ )); do
+		_rport_in_use_raw "$RPORT" && return 0 || true
+		sleep 1
+	done
+	return 1
+	# Returns exit code 0 if in use, 1 if not in use
+}
+
+_rport_not_in_use() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i TIMEOUT="${2:-$def_check_timeout}"
+	local -i time_passed=0
+
+	for (( time_passed=0; time_passed < TIMEOUT; time_passed++ )); do
+		_rport_in_use_raw "$RPORT" || return 0
+		sleep 1
+	done
+	return 1
+	# Returns exit code 0 if in not use, 1 if in use
+}
+
+_rport_num_in_use() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i num_in_use=0
+
+	# Check if one of the marginal paths is in use
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		_rport_in_use_raw "$subsys_path" || continue
+		num_in_use=$((num_in_use + 1))
+	done
+
+	echo "$num_in_use"
+	# Returns number of links in use
+}
+
+# check if link is marginal or not
+_rport_check_online() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+	local -i TIMEOUT="${3:-$def_check_timeout}"
+
+	if [[ "$STATE" == "Online" ]]; then
+		if ! _rport_is_online "$RPORT" "$TIMEOUT"; then
+			echo  FC port \("$RPORT"\) is not online, expteced online.
+			return 1
+		fi
+	else
+		if ! _rport_is_marginal "$RPORT" "$TIMEOUT"; then
+			echo FC port \("$RPORT"\) is not marginal, expteced marginal.
+			return 1
+		fi
+	fi
+	# Returns Success or Fail
+}
+
+# check if link is in use
+_rport_check_use() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+	local -i TIMEOUT="${3:-$def_check_timeout}"
+
+	if [[ "$STATE" == "Online" ]]; then
+		if ! _rport_in_use "$RPORT" "$TIMEOUT"; then
+			echo FC port on \("$RPORT"\) is not being used, expected use.
+			return 1
+		fi
+	else
+		if ! _rport_not_in_use "$RPORT" "$TIMEOUT"; then
+			echo FC port on \("$RPORT"\) is being used, expected no use.
+			return 1
+		fi
+	fi
+	# Returns Success or Fail
+}
+
+# check if all links are in the expected use state based on ana state
+_rport_check_use_opt() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i TIMEOUT="${2:-$def_check_timeout}"
+
+	# Only optimized paths will be in use
+	if _rport_is_optimized "$RPORT"; then
+		_rport_check_use "$RPORT" Online "$TIMEOUT" || return 1
+	else
+		_rport_check_use "$RPORT" Marginal "$TIMEOUT" || return 1
+	fi
+	# Returns Success or Fail
+}
+
+# check if all links are in state and use state
+_rport_check() {
+	local RPORT=$1 # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local STATE=$2 # "Online"
+	local -i TIMEOUT="${3:-$def_check_timeout}"
+
+	_rport_check_online "$RPORT" "$STATE" "$TIMEOUT" || return 1
+	_rport_check_use "$RPORT" "$STATE" "$TIMEOUT"
+	# Returns Success or Fail
+}
+
+# Check if one of the paths is in use
+_rport_check_one_use() {
+	local STATE=$1
+	local -i TIMEOUT=$2
+	shift
+	shift
+	local -a RPORTS_PATHS=("$@") #  /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -i time_passed=0
+	local -i count_in_use=0
+
+	for (( time_passed=0; time_passed < TIMEOUT; time_passed++ )); do
+		# Check if one of the online paths is in use
+		count_in_use=$(_rport_num_in_use "${RPORTS_PATHS[@]}")
+		if [ $count_in_use -eq 1 ]; then
+			return 0
+		fi
+		sleep 1
+	done
+
+	if [ $count_in_use -gt 1 ]; then
+		echo More than one FC port is being used, expected only one in use when all are "$STATE" in numa mode.
+		return 1
+	fi
+
+	echo No FC ports are being used, expected atleast one in use when all are "$STATE" in numa mode.
+	# None of the online paths were in use
+	return 1
+
+	# Returns Success or Fail
+}
+
 _cleanup_nvmet() {
 	local dev
 	local port
diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 0000000..f717eae
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,454 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 John Meneghini <jmeneghi@redhat.com>
+#
+# Test nvme-fc marginal path handling with fcloop
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme-fc marginal path handling"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_require_nvme_trtype fc
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test_set_all_online() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		_rport_set_online "$subsys_path" || return 1
+		_rport_check_online "$subsys_path" Online || return 1
+	done
+
+	if [ "$IOPOLICY" == "numa" ]; then
+		_rport_check_one_use online "${def_check_timeout}" "${RPORTS_PATHS[@]}" || return 1
+	else
+		for subsys_path in "${RPORTS_PATHS[@]}"; do
+			# Only optimized paths will be in use
+			_rport_check_use_opt "$subsys_path" || return 1
+		done
+	fi
+}
+
+test_set_one_host_marginal() {
+	local HOST=$1 # host1
+	shift
+	local -a ARGS=("$@")
+	local RPORTS_CNT="$(( $# / 2 ))"
+	local PATHS_POS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local HOSTS_POS # host1 host2
+
+	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
+		HOSTS_POS="$(( RPORTS_CNT + PATHS_POS ))"
+		if [[ "${ARGS[$HOSTS_POS]}" == "$HOST" ]]; then
+			_rport_set_marginal "${ARGS[$PATHS_POS]}" || return 1
+		fi
+	done
+
+	# check if all links are of expected state on hosts
+	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
+		HOSTS_POS="$(( RPORTS_CNT + PATHS_POS ))"
+		if [[ "${ARGS[$HOSTS_POS]}" == "$HOST" ]]; then
+			_rport_check "${ARGS[$PATHS_POS]}" "Marginal" || return 1
+		else
+			_rport_check_online "${ARGS[$PATHS_POS]}" "Online" || return 1
+			_rport_check_use_opt "${ARGS[$PATHS_POS]}" || return 1
+		fi
+	done
+}
+
+test_set_all_marginal_except_inaccesable()  {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_inaccessible "$subsys_path"; then
+			_rport_set_online "$subsys_path" || return 1
+			_rport_check_online "$subsys_path" Online || return 1
+			continue
+		fi
+		_rport_set_marginal "$subsys_path" || return 1
+		_rport_check_online "$subsys_path" Marginal || return 1
+	done
+
+	if [ "$IOPOLICY" == "numa" ]; then
+		_rport_check_one_use marginal "${def_check_timeout}" "${RPORTS_PATHS[@]}" || return 1
+	else
+		for subsys_path in "${RPORTS_PATHS[@]}"; do
+			# Only optimized paths will be in use
+			_rport_check_use_opt "$subsys_path" || return 1
+		done
+	fi
+}
+
+test_set_all_marginal() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		_rport_set_marginal "$subsys_path" || return 1
+		_rport_check_online "$subsys_path" Marginal || return 1
+	done
+
+	if [ "$IOPOLICY" == "numa" ]; then
+		_rport_check_one_use marginal "${def_check_timeout}" "${RPORTS_PATHS[@]}" || return 1
+	else
+		for subsys_path in "${RPORTS_PATHS[@]}"; do
+			# Only optimized paths will be in use
+			_rport_check_use_opt "$subsys_path" || return 1
+		done
+	fi
+}
+
+test_set_one_non_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one non-optimized online
+	# First set one non-optimized online to online then check optimized paths
+	local next_marginal=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_non_optimized "$subsys_path"; then
+			if [ $next_marginal == 1 ]; then
+				_rport_check "$subsys_path" Marginal || return 1
+				break
+			fi
+			_rport_set_online "$subsys_path" || return 1
+			_rport_check "$subsys_path" Online || return 1
+			next_marginal=1
+		fi
+	done
+	# Check optimized paths
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_optimized "$subsys_path"; then
+			# Optimized paths will not be in use
+			_rport_check "$subsys_path" Marginal || return 1
+		fi
+		if _rport_is_inaccessible "$subsys_path"; then
+			# Inaccessible paths will not be in use
+			_rport_check "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+test_set_all_non_optimized_online() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set all non-optimized online
+	local numa_in_use=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_optimized "$subsys_path"; then
+			_rport_check "$subsys_path" Marginal || return 1
+		elif _rport_is_non_optimized "$subsys_path"; then
+			_rport_set_online "$subsys_path" || return 1
+			if [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 0 ]; then
+				_rport_check "$subsys_path" Online || return 1
+				numa_in_use=1
+			elif [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 1 ]; then
+				_rport_check_online "$subsys_path" Online || return 1
+				# Only one of the online paths should be in use
+				_rport_check_use "$subsys_path" Marginal || return 1
+			else
+				_rport_check "$subsys_path" Online || return 1
+			fi
+		else
+			# Inaccessible paths will not be in use
+			_rport_check "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+set_one_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one optimized online
+	local next_marginal=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_optimized "$subsys_path"; then
+			if [ $next_marginal == 1 ]; then
+				_rport_check "$subsys_path" Marginal || return 1
+				break
+			fi
+			_rport_set_online "$subsys_path" || return 1
+			_rport_check "$subsys_path" Online || return 1
+			next_marginal=1
+		fi
+	done
+}
+
+test_set_all_non_one_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one optimized online
+	# First set one optimized online to online then check non-optimized paths
+	set_one_optimized_online "${RPORTS_PATHS[@]}" || return 1
+
+	# Check non-optimized paths
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_non_optimized "$subsys_path"; then
+			_rport_check_online "$subsys_path" Online || return 1
+			# Only optimized paths will be in use
+			# Inaccessible and non-optimized paths will not be in use
+			_rport_check_use "$subsys_path" Marginal || return 1
+		fi
+		if _rport_is_inaccessible "$subsys_path"; then
+			_rport_check "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+test_set_one_optimized_online() {
+	local -a RPORTS_PATHS=("$@") # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+
+	# Set one optimized online
+	# First set one optimized online to online then check non-optimized paths
+	set_one_optimized_online "${RPORTS_PATHS[@]}" || return 1
+
+	# Check non-optimized paths
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if ! _rport_is_optimized "$subsys_path"; then
+			# Only optimized paths will be in use
+			# Inaccessible and non-optimized paths will not be in use
+			_rport_check "$subsys_path" "Marginal" || return 1
+		fi
+	done
+}
+
+test_set_two_optimized_online() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a RPORTS_PATHS=("$@")
+
+	# Set two optimized online
+	local numa_in_use=0
+	for subsys_path in "${RPORTS_PATHS[@]}"; do
+		if _rport_is_optimized "$subsys_path"; then
+			_rport_set_online "$subsys_path" || return 1
+			if [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 0 ]; then
+				_rport_check "$subsys_path" Online || return 1
+				numa_in_use=1
+			elif [ "$IOPOLICY" == "numa" ] && [ $numa_in_use == 1 ]; then
+				_rport_check_online "$subsys_path" Online || return 1
+				# Only one of the online paths should be in use
+				_rport_check_use "$subsys_path" Marginal || return 1
+			else
+				_rport_check "$subsys_path" Online || return 1
+			fi
+		else
+			_rport_check "$subsys_path" Marginal || return 1
+		fi
+	done
+}
+
+run_test() {
+	local IOPOLICY=$1 # "numa" "queue-depth" "round-robin"
+	shift
+	local -a ARGS=("$@")
+	local RPORTS_CNT="$(( $# / 2 ))"
+	local -a RPORTS_PATHS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -a RPORTS_HOSTS # host1 host2
+	local PATHS_POS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local HOSTS_POS # host1 host2
+
+	# recrate the arrays
+	for (( PATHS_POS=0; PATHS_POS < RPORTS_CNT; PATHS_POS++ )); do
+		HOSTS_POS+="$(( RPORTS_CNT + PATHS_POS ))"
+		RPORTS_PATHS+=("${ARGS[$PATHS_POS]}")
+		RPORTS_HOSTS+=("${ARGS[$HOSTS_POS]}")
+	done
+
+
+	echo Changing FC links to online
+	# Initial check to see if FC is operational and set ports to online
+	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" \
+		&& echo "Set all online: pass" || echo "Set all online: fail"
+
+	test_set_one_host_marginal "${RPORTS_HOSTS[0]}" "${RPORTS_PATHS[@]}" \
+		"${RPORTS_HOSTS[@]}" && echo "One host marginal: pass" \
+		|| echo "One host marginal: fail"
+	test_set_all_marginal_except_inaccesable "${RPORTS_PATHS[@]}" \
+		&& echo "All marginal except inaccessible: pass" \
+		|| echo "All marginal except inaccessible: fail"
+	test_set_all_marginal "${RPORTS_PATHS[@]}" \
+		&& echo "All marginal: pass" || echo "All marginal: fail"
+
+	test_set_one_non_optimized_online "${RPORTS_PATHS[@]}" \
+		&& echo "One remote non-optimized online: pass" \
+		|| echo "One remote non-optimized online: fail"
+	test_set_all_non_optimized_online "$IOPOLICY" "${RPORTS_PATHS[@]}" \
+		&& echo "Two remote non-optimized online: pass" \
+		|| echo "Two remote non-optimized online: fail"
+
+	test_set_all_non_one_optimized_online "${RPORTS_PATHS[@]}" \
+		&& echo "Two remote non-optimized, One remote optimized: pass" \
+		|| echo "Two remote non-optimized, One remote optimized: fail"
+	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" \
+		&& echo "Set all online: pass" || echo "Set all online: fail"
+
+	test_set_all_marginal_except_inaccesable "${RPORTS_PATHS[@]}" \
+		&& echo "All marginal except inaccessible: pass" \
+		|| echo "All marginal except inaccessible: fail"
+	test_set_all_marginal "${RPORTS_PATHS[@]}" \
+		&& echo "All marginal: pass" || echo "All marginal: fail"
+
+	test_set_one_optimized_online "${RPORTS_PATHS[@]}" \
+		&& echo "One remote optimized online: pass" \
+		|| echo "One remote optimized online: fail"
+	test_set_two_optimized_online "$IOPOLICY" "${RPORTS_PATHS[@]}" \
+		&& echo "Two remote optimized online: pass" \
+		|| echo "Two remote optimized online: fail"
+	test_set_all_online "$IOPOLICY" "${RPORTS_PATHS[@]}" \
+		&& echo "All online: pass" || echo "All online: fail"
+}
+
+_nvmet_get_rport() {
+	local PORT="$1"
+
+	local dev
+	for dev in /sys/class/nvme/nvme*; do
+		grep --quiet "io" "$dev/cntrltype" || continue
+		[ -e "$dev" ] || continue
+		dev="$(basename "$dev")"
+		grep --quiet traddr="$(_fc_traddr "$PORT")" "/sys/class/nvme/$dev/address" && echo "$dev" || true
+	done
+	# nvme9
+}
+
+run_tests() {
+	local SUBSYS_PATH="$1"
+	shift
+	local -a PORTS=("$@")
+	local -a RPORTS_PATHS # /sys/devices/virtual/nvme-subsystem/nvme-subsys3/nvme9
+	local -a RPORTS_HOSTS # host1 host2
+	local rport
+
+	for port in "${PORTS[@]}"; do
+		RPORTS_HOSTS+=("$(_get_fc_host_port "$port")")
+		rport="$(_nvmet_get_rport "$port")"
+		if [ -z "$rport" ]; then
+			echo "Could not find rport for port $port"
+			return 1
+		fi
+		if [[ "$( echo "$rport" | sed -n '$=' )" -gt 1 ]]; then
+			# One traddr has multiple /sys/class/nvme/nvme devices
+			echo "Port $port has multiple rports with address"
+			grep traddr="$(_fc_traddr "$port")" /sys/class/nvme/nvme*/address
+			return 1
+		fi
+		RPORTS_PATHS+=( "${SUBSYS_PATH}/$rport")
+	done
+
+	local IOPOLICYS="numa queue-depth round-robin"
+	for IOPOLICY in $IOPOLICYS; do
+		_rport_set_iopolicy "$SUBSYS_PATH" "$IOPOLICY"
+		echo "Testing iopolicy: $IOPOLICY"
+		run_test "$IOPOLICY" "${RPORTS_PATHS[@]}" "${RPORTS_HOSTS[@]}"
+	done
+}
+
+_find_nvme_subsys() {
+	local subsys=$1
+	local subsysnqn
+	local subsys_path
+	for subsys_path in /sys/class/nvme-subsystem/nvme-subsys*; do
+		[ -e "$subsys_path" ] || continue
+		subsysnqn="$(cat "${subsys_path}/subsysnqn" 2>/dev/null)"
+		if [[ "$subsysnqn" == "$subsys" ]]; then
+			echo "$subsys_path"
+			return
+		fi
+	done
+}
+
+test() {
+	local -a ports
+	local ns
+	local fio_pid
+	local -i host1_port_cnt=0
+	local -i host2_port_cnt=0
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet 2
+
+	if [[ ! -w /sys/class/fcloop/ctl/set_marginal_rport ]]; then
+		SKIP_REASONS+=("fcloop does not support set_marginal_rport")
+		_nvmet_target_cleanup
+		return 1
+	fi
+
+	_nvmet_target_setup --ports 3
+	_nvmet_target_add_ports --host_port 1 --ports 3
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+
+	for port in "${ports[@]}"; do
+		if [[ $(_get_fc_host_port "${port}") == 0 ]]; then
+			continue
+		fi
+
+		if [ $host2_port_cnt -eq 0 ]; then
+			_setup_nvmet_port_ana "${port}" 1 "optimized"
+		fi
+		if [ $host2_port_cnt -eq 1 ]; then
+			_setup_nvmet_port_ana "${port}" 1 "non-optimized"
+		fi
+		if [ $host2_port_cnt -eq 2 ]; then
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+		fi
+
+		host2_port_cnt=$((host2_port_cnt + 1))
+	done
+
+	for port in "${ports[@]}"; do
+		if [[ $(_get_fc_host_port "${port}") != 0 ]]; then
+			continue
+		fi
+
+		if [ $host1_port_cnt -eq 0 ]; then
+			_setup_nvmet_port_ana "${port}" 1 "optimized"
+		fi
+		if [ $host1_port_cnt -eq 1 ]; then
+			_setup_nvmet_port_ana "${port}" 1 "non-optimized"
+		fi
+		if [ $host1_port_cnt -eq 2 ]; then
+			_setup_nvmet_port_ana "${port}" 1 "inaccessible"
+		fi
+
+		host1_port_cnt=$((host1_port_cnt + 1))
+	done
+
+	for port in "${ports[@]}"; do
+		_nvme_connect_subsys --port "${port}" --no-wait-ns || return 1
+	done
+
+	# start fio job
+	ns=$(_find_nvme_ns "$def_subsys_uuid")
+	echo "Starting background I/O"
+	set -m
+	_run_fio_verify_io --filename="/dev/${ns}" \
+			   --group_reporting --ramp_time=5 \
+			   --time_based --runtime=1m &> "$FULL" &
+	set +m
+	fio_pid=$!
+	sleep 10
+
+	run_tests "$(_find_nvme_subsys "${def_subsysnqn}")" "${ports[@]}"
+
+	# Stop background I/O
+	echo "Stopping background I/O"
+	{ kill  -- -"${fio_pid}"; wait; } &> /dev/null
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 0000000..e306776
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,49 @@
+Running nvme/070
+Starting background I/O
+Testing iopolicy: numa
+Changing FC links to online
+Set all online: pass
+One host marginal: pass
+All marginal except inaccessible: pass
+All marginal: pass
+One remote non-optimized online: pass
+Two remote non-optimized online: pass
+Two remote non-optimized, One remote optimized: pass
+Set all online: pass
+All marginal except inaccessible: pass
+All marginal: pass
+One remote optimized online: pass
+Two remote optimized online: pass
+All online: pass
+Testing iopolicy: queue-depth
+Changing FC links to online
+Set all online: pass
+One host marginal: pass
+All marginal except inaccessible: pass
+All marginal: pass
+One remote non-optimized online: pass
+Two remote non-optimized online: pass
+Two remote non-optimized, One remote optimized: pass
+Set all online: pass
+All marginal except inaccessible: pass
+All marginal: pass
+One remote optimized online: pass
+Two remote optimized online: pass
+All online: pass
+Testing iopolicy: round-robin
+Changing FC links to online
+Set all online: pass
+One host marginal: pass
+All marginal except inaccessible: pass
+All marginal: pass
+One remote non-optimized online: pass
+Two remote non-optimized online: pass
+Two remote non-optimized, One remote optimized: pass
+Set all online: pass
+All marginal except inaccessible: pass
+All marginal: pass
+One remote optimized online: pass
+Two remote optimized online: pass
+All online: pass
+Stopping background I/O
+Test complete
-- 
2.54.0

