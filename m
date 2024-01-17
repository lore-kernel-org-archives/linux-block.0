Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211F11184
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479483; cv=none; b=JXkOj2hU7eesmfRwPXYCGxtihEpwUL3VT1hxF34IMpnDMg5HALLlEm6uW6raHxFJtFiSqphBxM4nadgnSrQ1hKNSRCStu7HaqJyhWpZGP3BYkINfiXPNkjpzjeUbbRBay4eehNkyTAG1B+ybBnFsCCcFB6rb50gZj+ZNaPF2xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479483; c=relaxed/simple;
	bh=Lu53RUrb3gNjEf5ASVw+dUt0DMjb0/m6Uj/HXxoa5mA=;
	h=X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=T7hwsZsqo+wMIyqwHh7fMCstOsA6kHzeABMTSDsQpCyWfPWiYTQIecrRjb9d/gibiZDhJiOQn7alqXxX2qRo/YvuwW8NROw8vY2CVLeJ9HfDNWx0gNA/ZU1yFvXRVHjaDkueUvyQ4toA5eqvb97QmsmPvrKSCfKA5QLByQlMmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W-ogcVh_1705479467;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-ogcVh_1705479467)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:17:52 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com
Cc: chaitanyak@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvme/{rc,002,016,017,030,031}: introduce --resv_enable argument
Date: Wed, 17 Jan 2024 16:17:41 +0800
Message-ID: <20240117081742.93941-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117081742.93941-1-kanie@linux.alibaba.com>
References: <20240117081742.93941-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional argument --resv_enable to _nvmet_target_setup() and
propagate it to _create_nvmet_subsystem() and _create_nvmet_ns().

One can call functions with --resv_enable to enable reservation
feature on a specific namespace.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tests/nvme/002 |   3 +-
 tests/nvme/016 |   7 +++-
 tests/nvme/017 |  10 +++--
 tests/nvme/030 |   6 ++-
 tests/nvme/031 |   3 +-
 tests/nvme/rc  | 100 +++++++++++++++++++++++++++++++++++++++++--------
 6 files changed, 104 insertions(+), 25 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 6b84848..37c719b 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -30,7 +30,8 @@ test() {
 	local genctr=1
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "blktests-subsystem-$i" "${loop_dev}"
+		_create_nvmet_subsystem --subsysnqn "blktests-subsystem-$i" \
+					--blkdev "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index 908abbd..ba700d1 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -25,10 +25,13 @@ test() {
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "${loop_dev}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${loop_dev}"
+		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
+				 --nsid "${i}" \
+				 --blkdev "${loop_dev}"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/017 b/tests/nvme/017
index c8d9b32..d9fbd38 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -25,12 +25,14 @@ test() {
 
 	local genctr=1
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "$(_nvme_def_file_path)" \
-		"${def_subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "$(_nvme_def_file_path)" \
+				--uuid "${def_subsys_uuid}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" \
-				 "$(_nvme_def_file_path)"
+		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
+				 --nsid "${i}" \
+				 --blkdev "$(_nvme_def_file_path)"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
diff --git a/tests/nvme/030 b/tests/nvme/030
index 9251e17..8802b16 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -26,13 +26,15 @@ test() {
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
+	_create_nvmet_subsystem --subsysnqn "${subsys}1" \
+				--blkdev "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
 	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
 
 	genctr=$(_discovery_genctr)
 
-	_create_nvmet_subsystem "${subsys}2" "$(losetup -f)"
+	_create_nvmet_subsystem --subsysnqn "${subsys}2" \
+				--blkdev "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
diff --git a/tests/nvme/031 b/tests/nvme/031
index ed5f196..191ce72 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -40,7 +40,8 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
+		_create_nvmet_subsystem --subsysnqn "${subsys}$i" \
+					--blkdev "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
 		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index b0ef1ee..c6466cc 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -656,32 +656,95 @@ _remove_nvmet_port() {
 }
 
 _create_nvmet_ns() {
-	local nvmet_subsystem="$1"
-	local nsid="$2"
-	local blkdev="$3"
+	local nvmet_subsystem=""
+	local nsid=""
+	local blkdev=""
 	local uuid="00000000-0000-0000-0000-000000000000"
-	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
-	local ns_path="${subsys_path}/namespaces/${nsid}"
+	local subsys_path=""
+	local ns_path=""
+	local resv_enable=false
 
-	if [[ $# -eq 4 ]]; then
-		uuid="$4"
-	fi
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				nvmet_subsystem="$2"
+				shift 2
+				;;
+			--nsid)
+				nsid="$2"
+				shift 2
+				;;
+			--blkdev)
+				blkdev="$2"
+				shift 2
+				;;
+			--uuid)
+				uuid="$2"
+				shift 2
+				;;
+			--resv_enable)
+				resv_enable=true
+				shift 1
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	ns_path="${subsys_path}/namespaces/${nsid}"
 
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [[ -f "${ns_path}/resv_enable" && "${resv_enable}" = true ]] ; then
+		printf 1 > "${ns_path}/resv_enable"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
 _create_nvmet_subsystem() {
-	local nvmet_subsystem="$1"
-	local blkdev="$2"
-	local uuid=$3
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local nvmet_subsystem=""
+	local blkdev=""
+	local uuid="00000000-0000-0000-0000-000000000000"
+	local resv_enable=""
+	local cfs_path=""
 
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				nvmet_subsystem="$2"
+				shift 2
+				;;
+			--blkdev)
+				blkdev="$2"
+				shift 2
+				;;
+			--uuid)
+				uuid="$2"
+				shift 2
+				;;
+			--resv_enable)
+				resv_enable="--resv_enable";
+				shift 1
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	mkdir -p "${cfs_path}"
 	echo 0 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+	_create_nvmet_ns --subsysnqn "${nvmet_subsystem}" \
+			 --nsid "1" \
+			 --blkdev "${blkdev}" \
+			 --uuid "${uuid}" \
+			 ${resv_enable}
 }
 
 _add_nvmet_allow_hosts() {
@@ -863,6 +926,7 @@ _nvmet_target_setup() {
 	local ctrlkey=""
 	local hostkey=""
 	local port
+	local resv_enable=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -878,6 +942,10 @@ _nvmet_target_setup() {
 				hostkey="$2"
 				shift 2
 				;;
+			--resv_enable)
+				resv_enable="--resv_enable"
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -892,8 +960,10 @@ _nvmet_target_setup() {
 		blkdev="$(_nvme_def_file_path)"
 	fi
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
-				"${def_subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "${blkdev}" \
+				--uuid "${def_subsys_uuid}" \
+				${resv_enable}
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
-- 
2.30.1 (Apple Git-130)

