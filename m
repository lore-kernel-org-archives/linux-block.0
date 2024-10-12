Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35D155330
	for <linux-block@vger.kernel.org>; Sat, 12 Oct 2024 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731532; cv=none; b=Kax9QsR5bkKBzMOanTIM1T9T3k3oUp+2ABpS3SYo4nh4O03xxkF/nAXKH+bzo0ZT/HQ3zGv0AT0EqenQ+164S8OZP8zGeKXxGav6zrLJhOAcvnxDeZgQMZ5XAI3Z6xEEOBscbxS4CPk0q96vmhu83oeuzV8dENqclYvoc0C67RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731532; c=relaxed/simple;
	bh=g07ngL7VT7crILy/jxHDFdU34a7ybny7T4/NSo7fz88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m522wJj9t2ysOSxQe7E+qrCYP6bghYi/eP0opv9PvdC9K6sTAGbFidnTAhs4fqN85ZGGofyuA3J6unr9nNczQ8lHeiW4WqSBc1AXhGVCAYKfDhHaItK8EVW9HIVADqLGNnr7c8AE12vn96YPzvAitABK7Tv7n0hgyAJJNytvFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OyW+tWx5; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OyW+tWx5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728731527; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iRQ42eZ1Ht6BV+uO5lWeSTgLxhqUt3QRmGkgW0F7L+4=;
	b=OyW+tWx5UZIe7YPZ9g+GD6OCOViJfaeSLgjrEhT9Iai7CS99QWFZMzg1DKLQyhP4Ia+PrJ+sSLYKGK4j+TNL9kkENVo1Jw09UEDf2oF4QunoZBEXtF/8umeHbiI3CeQZ4WOWQ0sKvZad7gRLVTESHfwiM1AYfNn+KUEOGBPGNOU=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGvl9Zm_1728731522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 19:12:06 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	dwagner@suse.de,
	chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v3 1/2] nvme/{md/001,rc,002,016,017,030,052}: introduce --resv_enable argument
Date: Sat, 12 Oct 2024 19:11:56 +0800
Message-ID: <20241012111157.44368-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012111157.44368-1-kanie@linux.alibaba.com>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
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

And also make _create_nvmet_ns and _create_nvmet_subsystem to parse
for arguments, this makes these functions more flexible to use.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 common/nvme    | 89 ++++++++++++++++++++++++++++++++++++++++++--------
 tests/md/001   |  4 ++-
 tests/nvme/002 |  3 +-
 tests/nvme/016 |  7 ++--
 tests/nvme/017 | 10 +++---
 tests/nvme/030 |  6 ++--
 tests/nvme/052 |  5 ++-
 tests/nvme/rc  | 11 +++++--
 8 files changed, 109 insertions(+), 26 deletions(-)

diff --git a/common/nvme b/common/nvme
index 9e78f3e..c1aa8d6 100644
--- a/common/nvme
+++ b/common/nvme
@@ -452,32 +452,95 @@ _remove_nvmet_port() {
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
+
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
diff --git a/tests/md/001 b/tests/md/001
index 27df7b3..98da51d 100755
--- a/tests/md/001
+++ b/tests/md/001
@@ -52,7 +52,9 @@ setup_nvme_over_tcp() {
 	local port
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "/dev/mapper/ram0_big_optio" "${def_subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${def_subsysnqn}" \
+				--blkdev "/dev/mapper/ram0_big_optio" \
+				--uuid "${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
diff --git a/tests/nvme/002 b/tests/nvme/002
index f613c78..043ab1c 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -34,7 +34,8 @@ test() {
 	local genctr=1
 
 	for ((i = 0; i < iterations; i++)); do
-		_create_nvmet_subsystem "blktests-subsystem-$i" "${loop_dev}"
+		_create_nvmet_subsystem --subsysnqn "blktests-subsystem-$i" \
+					--blkdev "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
 	done
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index d1fdb35..1143cab 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -29,10 +29,13 @@ test() {
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
index 114be60..5721000 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -29,12 +29,14 @@ test() {
 
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
index b1ed8bc..5db20c0 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -30,13 +30,15 @@ test() {
 
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
diff --git a/tests/nvme/052 b/tests/nvme/052
index 401f043..1dcda23 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -64,7 +64,10 @@ test() {
 		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
 		uuid="$(uuidgen -r)"
 
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
+		_create_nvmet_ns --subsysnqn "${def_subsysnqn}" \
+				--nsid "${i}" \
+				--blkdev "$(_nvme_def_file_path).$i" \
+				--uuid "${uuid}"
 
 		# wait until async request is processed and ns is created
 		if ! nvmf_wait_for_ns "${uuid}" created; then
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 671012e..357cab9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -324,6 +324,7 @@ _nvmet_target_setup() {
 	local subsysnqn="${def_subsysnqn}"
 	local subsys_uuid="${def_subsys_uuid}"
 	local port
+	local resv_enable=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -347,6 +348,10 @@ _nvmet_target_setup() {
 				subsys_uuid="$2"
 				shift 2
 				;;
+			--resv_enable)
+				resv_enable="--resv_enable"
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -361,8 +366,10 @@ _nvmet_target_setup() {
 		blkdev="$(_nvme_def_file_path)"
 	fi
 
-	_create_nvmet_subsystem "${subsysnqn}" "${blkdev}" \
-				"${subsys_uuid}"
+	_create_nvmet_subsystem --subsysnqn "${subsysnqn}" \
+				--blkdev "${blkdev}" \
+				--uuid "${subsys_uuid}" \
+				${resv_enable}
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 	_create_nvmet_host "${subsysnqn}" "${def_hostnqn}" \
-- 
2.43.0

