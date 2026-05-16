Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8D3D646A
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933335; cv=none; b=ZidAh1Wb8XXetMxVTL5XlieCvOeE8WZKkNWCEJBdaQHj8XJQjLg7wrGCDOTBbwMNg89TESnx7R61c7ej9RSthrvr4HcstutTtn3NP35/Q2nmYB/Jc/u5/ONbd7gzsWmLUaxY1cqsPxIaqOw2VzlXzm9gXOgFjMT6e2kbRSBERa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933335; c=relaxed/simple;
	bh=A5ofxDe0GaiD3N4Qj1gZm3paJnVuKzesyj8GbgzOeyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQzDx83hQt2hpJqA3WOe2KveQxWOOJDEYO01wOh58pXfuQogR7Xl63JAdlSTDfvFVVipM5rSOwoBeXG9fcfZrIB0fMhNOonrvOGJbY2DJHiSn3wwE6jceYD4eUvDLsL+d05J9on8Ivq3tvCEuQoyUv+MPaAy6N29rFpe9YW6fdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cm/Jc7HH; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cm/Jc7HH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778933334; x=1810469334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5ofxDe0GaiD3N4Qj1gZm3paJnVuKzesyj8GbgzOeyo=;
  b=cm/Jc7HHuZ/Wl2KvsARYZi2a4oyKra6c/knZplAcjAQ32r1SGNrtbyqi
   DEFoP+oDxWF3yWzHl5j2mpwdT1v+orlFNeXZ+oyPeG7fWHA8QA4+8xw++
   HzfX7b9hLI3tF3TsGjx26+7/aW13Ur7QiCqbba9WPnI2alzwlPnm9nvmI
   xzdBJhYqqfjNuJy/vNXOra3NgCUUODohReQQB3S+dQntfum4BrNDCVvk+
   4sWuLnicTM8vdSsRCcVinppg5rkOAmEfTNXMtSc1FOvYVmKTgshlyvmU7
   zMQ78rVM4GkrtYZ/0dcpl6ADQSvphgKJHNNg7p7Tc320zBCDU3n2z3WeX
   Q==;
X-CSE-ConnectionGUID: Ml88T4hFQAWFw8D8f/nQqg==
X-CSE-MsgGUID: UTp0MAODQCOXvksfVm3EMA==
X-IronPort-AV: E=Sophos;i="6.23,238,1770566400"; 
   d="scan'208";a="145562578"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2026 20:07:43 +0800
X-CSE-ConnectionGUID: caYMSuthRhWXCoqS8IBc7w==
X-CSE-MsgGUID: fSc/cV9zSgSiRxmgi2Y0tg==
IronPort-SDR: 6a085e07_K1j3VNXBc6Rcg/A6CVLKD5VAez2ZGNiKMZ4T8P8egIfJIwO
 UfwtByyVtR6hC1eKXK+UV16CsRM7wFNWD7as1pQ==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2026 05:07:34 -0700
X-CSE-ConnectionGUID: g9HcYp5qSXWPdG190uhOIg==
X-CSE-MsgGUID: kovWx0jlTXS69INnP8UQZA==
WDCIronportException: Internal
Received: from wdap-zejtyqwo0v.ad.shared (HELO shinmob.wdc.com) ([10.224.105.206])
  by uls-op-esai2-o.wdc.com with ESMTP; 16 May 2026 05:07:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 3/3] common/nvme, nvme/rc: use _set_attr() to trace attribute writes
Date: Sat, 16 May 2026 21:07:29 +0900
Message-ID: <20260516120729.113659-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
References: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit introduced the helper function _set_attr(). Use it
in common/nvme and tests/nvme/rc to trace sysfs/configfs/debugfs
attribute writes.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme   | 34 ++++++++++++++---------------
 tests/nvme/rc | 60 +++++++++++++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/common/nvme b/common/nvme
index 565de59..44f2fe6 100644
--- a/common/nvme
+++ b/common/nvme
@@ -570,18 +570,18 @@ _create_nvmet_port() {
 		traddr=$(_fc_traddr $port)
 		adrfam="fc"
 	fi
-	echo "${trtype}" > "${portcfs}/addr_trtype"
-	echo "${traddr}" > "${portcfs}/addr_traddr"
-	echo "${adrfam}" > "${portcfs}/addr_adrfam"
+	_set_attr "${trtype}" "${portcfs}/addr_trtype"
+	_set_attr "${traddr}" "${portcfs}/addr_traddr"
+	_set_attr "${adrfam}" "${portcfs}/addr_adrfam"
 	if [[ "${adrfam}" != "fc" ]] && \
 	   [[ "${adrfam}" != "loop" ]] ; then
-		echo "${trsvcid}" > "${portcfs}/addr_trsvcid"
+		_set_attr "${trsvcid}" "${portcfs}/addr_trsvcid"
 	fi
 	if [[ "${trtype}" == "tcp" ]] && \
 		   [[ "${tls}" != "none" ]]; then
-		echo "tls1.3" > "${portcfs}/addr_tsas"
+		_set_attr "tls1.3" "${portcfs}/addr_tsas"
 		if [[ "${tls}" != "required" ]]; then
-			echo "not required" > "${portcfs}/addr_treq"
+			_set_attr "not required" "${portcfs}/addr_treq"
 		fi
 	fi
 	echo "${port}"
@@ -601,7 +601,7 @@ _setup_nvmet_port_ana() {
 		fi
 		mkdir "${anaport}"
 	fi
-	echo "${anastate}" > "${anaport}/ana_state"
+	_set_attr "${anastate}" "${anaport}/ana_state"
 }
 
 _remove_nvmet_port() {
@@ -722,19 +722,19 @@ _create_nvmet_ns() {
 	subsys_path="${NVMET_CFS}/subsystems/${subsysnqn}"
 	ns_path="${subsys_path}/namespaces/${nsid}"
 	mkdir "${ns_path}"
-	printf "%s" "${blkdev}" > "${ns_path}/device_path"
+	_set_attr "$(printf "%s" "${blkdev}")" "${ns_path}/device_path"
 	if [[ -f "${ns_path}/resv_enable" && "${resv_enable}" = true ]] ; then
-		printf 1 > "${ns_path}/resv_enable"
+		_set_attr 1 "${ns_path}/resv_enable"
 	fi
 	if [[ -n "${uuid}" ]]; then
-		printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+		_set_attr "$(printf "%s" "${uuid}")" "${ns_path}/device_uuid"
 	else
 		uuid=$(cat "${ns_path}/device_uuid")
 	fi
 	if (( grpid != 1 )); then
-		printf "%d" "${grpid}" > "${ns_path}/ana_grpid"
+		_set_attr "$(printf "%d" "${grpid}")" "${ns_path}/ana_grpid"
 	fi
-	printf 1 > "${ns_path}/enable"
+	_set_attr 1 "${ns_path}/enable"
 	echo "${uuid}"
 }
 
@@ -748,7 +748,7 @@ _setup_nvmet_ns_ana() {
 	if [[ ! -d "${ns_path}" ]]; then
 		return
 	fi
-	echo "${anagrpid}" > "${ns_path}/anagrpid"
+	_set_attr "${anagrpid}" "${ns_path}/anagrpid"
 }
 
 _create_nvmet_subsystem() {
@@ -786,7 +786,7 @@ _create_nvmet_subsystem() {
 
 	cfs_path="${NVMET_CFS}/subsystems/${subsystem}"
 	mkdir -p "${cfs_path}"
-	echo 0 > "${cfs_path}/attr_allow_any_host"
+	_set_attr 0 "${cfs_path}/attr_allow_any_host"
 	if [[ -z "${blkdev}" ]]; then
 		return 0
 	fi
@@ -825,10 +825,10 @@ _create_nvmet_host() {
 	mkdir "${host_path}"
 	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
 	if [[ "${nvmet_hostkey}" ]] ; then
-		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
+		_set_attr "${nvmet_hostkey}" "${host_path}/dhchap_key"
 	fi
 	if [[ "${nvmet_ctrlkey}" ]] ; then
-		echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
+		_set_attr "${nvmet_ctrlkey}" "${host_path}/dhchap_ctrl_key"
 	fi
 }
 
@@ -838,7 +838,7 @@ _remove_nvmet_ns() {
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
 
-	echo 0 > "${nvmet_ns_path}/enable"
+	_set_attr 0 "${nvmet_ns_path}/enable"
 	rmdir "${nvmet_ns_path}"
 }
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a8f80d8..d6496b3 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -223,12 +223,12 @@ _create_nvmet_passthru() {
 	local passthru_path="${subsys_path}/passthru"
 
 	mkdir -p "${subsys_path}"
-	echo 0 > "${subsys_path}/attr_allow_any_host"
+	_set_attr 0 "${subsys_path}/attr_allow_any_host"
 
 	_test_dev_nvme_ctrl > "${passthru_path}/device_path"
-	echo 1 > "${passthru_path}/enable"
+	_set_attr 1 "${passthru_path}/enable"
 	if [[ -f "${passthru_path}/clear_ids" ]]; then
-		echo 1 > "${passthru_path}/clear_ids"
+		_set_attr 1 "${passthru_path}/clear_ids"
 	fi
 }
 
@@ -237,7 +237,7 @@ _remove_nvmet_passhtru() {
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local passthru_path="${subsys_path}/passthru"
 
-	echo 0 > "${passthru_path}/enable"
+	_set_attr 0 "${passthru_path}/enable"
 	rm -f "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
@@ -247,8 +247,7 @@ _set_nvmet_hostkey() {
 	local nvmet_hostkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
-	echo "${nvmet_hostkey}" > \
-	     "${cfs_path}/dhchap_key"
+	_set_attr "${nvmet_hostkey}" "${cfs_path}/dhchap_key"
 }
 
 _set_nvmet_ctrlkey() {
@@ -256,8 +255,7 @@ _set_nvmet_ctrlkey() {
 	local nvmet_ctrlkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
-	echo "${nvmet_ctrlkey}" > \
-	     "${cfs_path}/dhchap_ctrl_key"
+	_set_attr "${nvmet_ctrlkey}" "${cfs_path}/dhchap_ctrl_key"
 }
 
 _set_nvmet_hash() {
@@ -265,8 +263,7 @@ _set_nvmet_hash() {
 	local nvmet_hash="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
-	echo "${nvmet_hash}" > \
-	     "${cfs_path}/dhchap_hash"
+	_set_attr "${nvmet_hash}" "${cfs_path}/dhchap_hash"
 }
 
 _set_nvmet_dhgroup() {
@@ -274,8 +271,7 @@ _set_nvmet_dhgroup() {
 	local nvmet_dhgroup="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
-	echo "${nvmet_dhgroup}" > \
-	     "${cfs_path}/dhchap_dhgroup"
+	_set_attr "${nvmet_dhgroup}" "${cfs_path}/dhchap_dhgroup"
 }
 
 _enable_nvmet_ns() {
@@ -285,7 +281,7 @@ _enable_nvmet_ns() {
 	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
 	ns_path="${cfs_path}/namespaces/${nsid}"
 
-	echo 1 > "${ns_path}/enable"
+	_set_attr 1 "${ns_path}/enable"
 }
 
 _disable_nvmet_ns() {
@@ -295,7 +291,7 @@ _disable_nvmet_ns() {
 	cfs_path="${NVMET_CFS}/subsystems/${subsysnqn}"
 	ns_path="${cfs_path}/namespaces/${nsid}"
 
-	echo 0 > "${ns_path}/enable"
+	_set_attr 0 "${ns_path}/enable"
 }
 
 _set_nvmet_ns_uuid() {
@@ -473,8 +469,10 @@ _nvme_passthru_logging_setup()
 
 _nvme_passthru_logging_cleanup()
 {
-	echo "$ctrl_dev_passthru_logging" > /sys/class/nvme/"$2"/passthru_err_log_enabled
-	echo "$ns_dev_passthru_logging" > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+	_set_attr "$ctrl_dev_passthru_logging" \
+	      /sys/class/nvme/"$2"/passthru_err_log_enabled
+	_set_attr "$ns_dev_passthru_logging" \
+	      /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
 }
 
 _nvme_err_inject_setup()
@@ -495,55 +493,55 @@ _nvme_err_inject_cleanup()
         local a
 
         for a in /sys/kernel/debug/"$1"/fault_inject/*; do
-                echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+                _set_attr "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" "${a}"
         done
 
         for a in /sys/kernel/debug/"$2"/fault_inject/*; do
-                echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+                _set_attr "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" "${a}"
         done
 }
 
 _nvme_enable_err_inject()
 {
-        echo "$2" > /sys/kernel/debug/"$1"/fault_inject/verbose
-        echo "$3" > /sys/kernel/debug/"$1"/fault_inject/probability
-        echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
-        echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
-        echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
+        _set_attr "$2" /sys/kernel/debug/"$1"/fault_inject/verbose
+        _set_attr "$3" /sys/kernel/debug/"$1"/fault_inject/probability
+        _set_attr "$4" /sys/kernel/debug/"$1"/fault_inject/dont_retry
+        _set_attr "$5" /sys/kernel/debug/"$1"/fault_inject/status
+        _set_attr "$6" /sys/kernel/debug/"$1"/fault_inject/times
 }
 
 _nvme_disable_err_inject()
 {
-        echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
-        echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
+        _set_attr 0 /sys/kernel/debug/"$1"/fault_inject/probability
+        _set_attr 0 /sys/kernel/debug/"$1"/fault_inject/times
 }
 
 _nvme_enable_passthru_admin_error_logging()
 {
-	echo on > /sys/class/nvme/"$1"/passthru_err_log_enabled
+	_set_attr on /sys/class/nvme/"$1"/passthru_err_log_enabled
 }
 
 _nvme_enable_passthru_io_error_logging()
 {
-	echo on > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+	_set_attr on /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
 }
 
 _nvme_disable_passthru_admin_error_logging()
 {
-	echo off > /sys/class/nvme/"$1"/passthru_err_log_enabled
+	_set_attr off /sys/class/nvme/"$1"/passthru_err_log_enabled
 }
 
 _nvme_disable_passthru_io_error_logging()
 {
-	echo off > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+	_set_attr off /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
 }
 
 _nvme_reset_ctrl() {
-	echo 1 > /sys/class/nvme/"$1"/reset_controller
+	_set_attr 1 /sys/class/nvme/"$1"/reset_controller
 }
 
 _nvme_delete_ctrl() {
-	echo 1 > /sys/class/nvme/"$1"/delete_controller
+	_set_attr 1 /sys/class/nvme/"$1"/delete_controller
 }
 
 # Check whether the version of the fio is greater than or equal to $1.$2.$3
-- 
2.54.0

