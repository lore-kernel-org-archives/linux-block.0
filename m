Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904E3090FB
	for <linux-block@vger.kernel.org>; Tue,  4 Nov 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244081; cv=none; b=bbdf+BwWJ3uLS5LDthxwQyb2kaNiQ7/zDVSYf5oWVjX5VYtH2sThGOftMjWsEhAm8nTIhDNo+3F8caI6KLaOlPWJJy9LVJQ3T89bfV6LgFnDh4rzLsvFYL85OEzbr7zKZac9kXsKfguHRP3y9DrUt4+1B2WL6TzXNJvwUAEKv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244081; c=relaxed/simple;
	bh=Mx6TDbeipdWVRn1B/14Y4tyLZJrUGg71nJmtwYAh2VE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nCbOe8+zN8BZ1eSWcCRvj9gP7HlJFvNkqBd0N6t2Eebp0ILRuJ3bttFpLQ5hYFWScU9OfZwXQVYpV9rYKxU+ql7mIjKlypdtPp91SnHBqcgKrjOpPtt60iA4JTPDPXF9FuqVMlr85dTu8H2mK3OhVrhdkbp4m1AKI6XAKCqrwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNaEF2iV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNaEF2iV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2953b321f99so34203635ad.1
        for <linux-block@vger.kernel.org>; Tue, 04 Nov 2025 00:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762244079; x=1762848879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yPPom5EQkKpKnENEVWAiI55FVm2YuKTD0Zs1aq5/h8=;
        b=hNaEF2iVmYIENerjjvsNyR5IWBjatQ+CXfIciP7zAqTpZrXDRBIP1fD79uBTvy3RPa
         syLy8Kb8FCMUCcWo2d5vEG7LySVknZdomZq+EfSFaHy7Rm6a2qX7t134VYsu5BMfbpgI
         QL4xW34VPKNVRSTX6uOs1kgPJNePEgpD1Vhmo+k/2z5nXo/uVnvf8euZXX2x7hLqMHZS
         Jycko7tTcRuvfyq8ZcDNp7ZK3FRBoAq28ilDylwpDk01490LrLD1s7Gx5+LrDIr2CTIx
         GyckBWNAF9uq8nVbWD6J6WlYzUK5poUOqq5j0AUAaWkiu0dKI2jXWW1pHhQpmU4IK4xd
         H1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244079; x=1762848879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yPPom5EQkKpKnENEVWAiI55FVm2YuKTD0Zs1aq5/h8=;
        b=Y/f2H9RVSxePQZMKzDNqMyHmKqGjLKTgxaYq8N1QOZIGaaAiQTseicJ9PcSlRnFuF6
         4bxq38OCa5CEhrhmbtA3LWMwTLZ1M0uy47o6/tEvZPSZJPRXK22x3wwxru2cL/cFljKp
         HJepPyUjmCUUdRzG0lU2mYuCQOyMGww2QToPlmKAVcRwOvw48XxbwgVvb2TJgpx+83rx
         STrRtwySSQajk4YWTX29x6sGIdkRi8+ZV4sq5oJVCcVFbeSxbgm557BCIpZRxu+XO4+5
         unrxfShrb2hSuVHPzIK3HrDhoaNfsOEMRWuzMAMxP20wNOyETgh03F+60bQF897isOAm
         0oXg==
X-Gm-Message-State: AOJu0YxGukMjMBdazG45uWG0gr7GrP9jNhA7yNklTUcWi3L6Bxx/+b3K
	ijuIiGEbcBmBhXID+l2LAAoJek/euBUHLIgT+tLhAaK/CewQhPfZB/8Y
X-Gm-Gg: ASbGncsVsjaS1OPoKaPTlZsAo75gmanzepjM76Q+NbJuOKLjDsAEVpVs7ve/7jxsE9D
	ch4/K5Hp3h3cuRpvpG9bnlaREs51GNdHXTyVQ5k//4yYlZ6hLe5w1QDGzK0b3PrWtw3Maa++RHj
	VKz8U9SxJmSnNMA6uwOzDJye1LVrEBP9bk7BW4yACwyIAsNZxmQWP7bhGMwUeG9Lx+t1pXkJ0Qq
	JEDbYYZgedI42d3IDag8/oE2QjAuU3V5XWVMyY1rWPnEDlI+Qgl4nnFxTWuWO1Qbqza2J8gG7zT
	J1cgb/NnPAu0Z2LlMAl6zG3ykzNz2mmeTzSsf4zN40wko/dnrVYINMVEjMGAKnS9zt7Hcba7i52
	hnzSPxaEUTNejAUd1jRlJz+8yb/5kd586+CELBmhFncA229HsleFjveqfLmLoi78zPjq8iVfBqr
	9P55dahEIFrf3CJCQ7mayTjoWJex8InRRJwibN
X-Google-Smtp-Source: AGHT+IFOdB7IzjwFPem2ggmTDmjy3G6bzYqa3MERE3FT9sIp/UxQCFfmCHoNZ7seosLifsrFBq+xAQ==
X-Received: by 2002:a17:902:d48b:b0:295:fac:7b72 with SMTP id d9443c01a7336-2951a4b3595mr182681015ad.52.1762244079082;
        Tue, 04 Nov 2025 00:14:39 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601b8f28esm17214615ad.5.2025.11.04.00.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:14:38 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktest] blktests: add nvmet memory backend support
Date: Tue,  4 Nov 2025 00:14:36 -0800
Message-Id: <20251104081436.191823-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for testing nvmet memory backend across all transport
types. This allows tests using _set_combined_conditions with
_set_nvmet_blkdev_type to automatically test memory backend alongside
device and file backends.

The memory backend provides RAM-based volatile storage for NVMe
namespaces, useful for high-performance testing without disk I/O.

- Add "mem" to NVMET_BLKDEV_TYPES default value
- Add _require_nvme_mem_backend() prerequisite check
- Add _create_nvmet_ns_mem() helper for memory namespace creation
- Modify _nvmet_target_setup() to handle memory backend type

All existing tests that support multiple backends (device, file) will
now automatically run with memory backend as well, providing 3x test
coverage: device, file, and mem backends across loop, tcp, and rdma
transports.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 common/nvme | 135 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index 3d43790..a558943 100644
--- a/common/nvme
+++ b/common/nvme
@@ -23,7 +23,7 @@ _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
-NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file mem"}
 nvme_target_control="${NVME_TARGET_CONTROL:-}"
 NVMET_CFS="/sys/kernel/config/nvmet/"
 # shellcheck disable=SC2034
@@ -62,6 +62,35 @@ _require_nvme_trtype_is_fabrics() {
 	return 0
 }
 
+_require_nvme_mem_backend() {
+	# Check if memory backend is supported in kernel
+	local test_subsys="${NVMET_CFS}/subsystems/blktests-mem-test-$$"
+	local test_ns="${test_subsys}/namespaces/1"
+
+	if ! mkdir -p "${test_subsys}" 2>/dev/null; then
+		SKIP_REASONS+=("cannot create test subsystem in configfs")
+		return 1
+	fi
+
+	if ! mkdir -p "${test_ns}" 2>/dev/null; then
+		rmdir "${test_subsys}"
+		SKIP_REASONS+=("cannot create test namespace in configfs")
+		return 1
+	fi
+
+	# Try to set mem_size attribute
+	if ! echo "1073741824" > "${test_ns}/mem_size" 2>/dev/null; then
+		rmdir "${test_ns}"
+		rmdir "${test_subsys}"
+		SKIP_REASONS+=("nvmet memory backend not supported")
+		return 1
+	fi
+
+	rmdir "${test_ns}"
+	rmdir "${test_subsys}"
+	return 0
+}
+
 _have_nvme_cli_with_json_support() {
 	_have_program nvme || return $?
 
@@ -726,6 +755,71 @@ _create_nvmet_ns() {
 	echo "${uuid}"
 }
 
+_create_nvmet_ns_mem() {
+	local subsysnqn="${def_subsysnqn}"
+	local nsid="${def_nsid}"
+	local grpid="1"
+	local mem_size="${NVME_IMG_SIZE}"
+	local uuid
+	local subsys_path
+	local ns_path
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			--nsid)
+				nsid="$2"
+				shift 2
+				;;
+			--mem-size)
+				mem_size="$2"
+				shift 2
+				;;
+			--uuid)
+				uuid="$2"
+				shift 2
+				;;
+			--grpid)
+				grpid="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	subsys_path="${NVMET_CFS}/subsystems/${subsysnqn}"
+	ns_path="${subsys_path}/namespaces/${nsid}"
+
+	mkdir "${ns_path}"
+
+	# Memory backend uses mem_size instead of device_path
+	# Convert size string (e.g., "1G") to bytes
+	local mem_size_bytes
+	mem_size_bytes=$(numfmt --from=iec "${mem_size}")
+	printf "%s" "${mem_size_bytes}" > "${ns_path}/mem_size"
+
+	# Set UUID if provided, otherwise read generated one
+	if [[ -n "${uuid}" ]]; then
+		printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	else
+		uuid=$(cat "${ns_path}/device_uuid")
+	fi
+
+	# Set ANA group if not default
+	if (( grpid != 1 )); then
+		printf "%d" "${grpid}" > "${ns_path}/ana_grpid"
+	fi
+
+	printf "%d" 1 > "${ns_path}/enable"
+	echo "${uuid}"
+}
+
 _setup_nvmet_ns_ana() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
@@ -956,6 +1050,7 @@ _find_nvme_ns() {
 _nvmet_target_setup() {
 	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
+	local mem_size="${NVME_IMG_SIZE}"
 	local ctrlkey=""
 	local hostkey=""
 	local subsysnqn="${def_subsysnqn}"
@@ -1011,7 +1106,12 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	if [[ "${blkdev_type}" != "none" ]]; then
+	# Handle backend-specific setup
+	if [[ "${blkdev_type}" == "mem" || "${blkdev_type}" == "memory" ]]; then
+		# Memory backend - no file or device needed
+		blkdev=""
+	elif [[ "${blkdev_type}" != "none" ]]; then
+		# Device or file backend - create backing file
 		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 		if [[ "${blkdev_type}" == "device" ]]; then
 			blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
@@ -1036,17 +1136,32 @@ _nvmet_target_setup() {
 		return
 	fi
 
+	# Handle namespace creation based on backend type
 	ARGS=(--subsysnqn "${subsysnqn}")
-	if [[ -n "${blkdev}" ]]; then
+
+	if [[ "${blkdev_type}" == "mem" || "${blkdev_type}" == "memory" ]]; then
+		# Memory backend: create subsystem without namespace first
+		_create_nvmet_subsystem "${ARGS[@]}"
+		# Then create memory namespace separately
+		ARGS=(--subsysnqn "${subsysnqn}" --mem-size "${mem_size}")
+		if [[ -n "${subsys_uuid}" ]]; then
+			ARGS+=(--uuid "${subsys_uuid}")
+		fi
+		def_subsys_uuid=$(_create_nvmet_ns_mem "${ARGS[@]}")
+	elif [[ -n "${blkdev}" ]]; then
+		# Device or file backend: use existing flow
 		ARGS+=(--blkdev "${blkdev}")
+		if [[ -n "${subsys_uuid}" ]]; then
+			ARGS+=(--uuid "${subsys_uuid}")
+		fi
+		if [[ -n "${resv_enable}" ]]; then
+			ARGS+=("${resv_enable}")
+		fi
+		_create_nvmet_subsystem "${ARGS[@]}"
+	else
+		# No backend (none type): just create subsystem
+		_create_nvmet_subsystem "${ARGS[@]}"
 	fi
-	if [[ -n "${subsys_uuid}" ]]; then
-		ARGS+=(--uuid "${subsys_uuid}")
-	fi
-	if [[ -n "${resv_enable}" ]]; then
-		ARGS+=("${resv_enable}")
-	fi
-	_create_nvmet_subsystem "${ARGS[@]}"
 
 	p=0
 	while (( p < num_ports )); do
-- 
2.40.0

