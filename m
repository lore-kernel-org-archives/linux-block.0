Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86C22DF95
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129572; cv=none; b=nR/ky46sGLRBuRi+zzXTfcC5+iiriluAxS+gWBV8nlNMyNLB0hnC5C9i3DUFLpYep+AfjOEtrcRV7Eh9aVu4fkQWMAf441mgvQWIa72Z/g6epP1ifdFJrEP7Q+4bOtBTv53NxvqQcACYEg6GTwIJvhkmd59yxpgI95pfgzL8Wv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129572; c=relaxed/simple;
	bh=YFoXgbgup6mavWMsiZOhhOvd8aBFDXaX4CBB6vu+uao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCF9Yp9E51vVn4ijh89I9tyHlnDvTACzvKtyN5t/reRIctSvoi6J68MWINMLMvTzM3P9rcI1EJo11fpNCQyiNXvIbfei8/22JXlpp88au+in/wxSgCnyZO/gUZl47TCpDEFjsn31Mwu/AG6T+iEd4P9SoSLnyXaeWEPkZ7HREuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL3W2UZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL3W2UZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76637C4CEE9;
	Tue,  8 Apr 2025 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129571;
	bh=YFoXgbgup6mavWMsiZOhhOvd8aBFDXaX4CBB6vu+uao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CL3W2UZ2diIbsHcwCMwLhD4InNQmD4cOiyQTo82QBzcbO1zlL5trT2eTrTA3U5tQJ
	 n8LNeUzFjJal0mGGQCNlE+1vZEfK8i41thoA+VQQZb2tq9ZumP4jxbESPVWPq73y+I
	 7209vb58RZyE9BtY7Sn4/aJF1OGcU2MSSDCQitzGXd3Rts8+5VMLeiXYNC36NjMPac
	 Vi3S2Z5aaVwZbONqL3VGTUMDMJ5NGJ1P3UZI8Ccp3WsViDDeaeGy+UpnaoYOQut4m6
	 9LvEB+zxF1jj1yaFSCiepsw72CRqWfmGXPUn7dIpfYtkhG0X7TRmELMQWPPt0vEu+8
	 ZuLRCd08fwkdg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 18:25:58 +0200
Subject: [PATCH blktests v2 2/4] common/nvme: move nvmf_wait_for_state to
 common code
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-test-target-v2-2-e9e2512586f8@kernel.org>
References: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
In-Reply-To: <20250408-test-target-v2-0-e9e2512586f8@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

In preperation to add another tests which needs the nvmf_wait_for_state
function, move it to the common code base.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 common/nvme    | 27 +++++++++++++++++++++++++++
 tests/nvme/048 | 31 ++-----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/common/nvme b/common/nvme
index 04b49c2c1f9edc6de516398b537502fc30a92969..68720ddc20cf3ed5cfe2841f9921321d9899ce0d 100644
--- a/common/nvme
+++ b/common/nvme
@@ -573,6 +573,33 @@ _nvmf_wait_for_ns() {
 	return 0
 }
 
+_nvmf_wait_for_state() {
+	local def_state_timeout=5
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+	local nvmedev
+	local state_file
+	local start_time
+	local end_time
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	start_time=$(date +%s)
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+		if (( end_time - start_time > timeout )); then
+			echo "expected state \"${state}\" not " \
+				"reached within ${timeout} seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
 _create_nvmet_ns() {
 	local subsysnqn="${def_subsysnqn}"
 	local nsid="${def_nsid}"
diff --git a/tests/nvme/048 b/tests/nvme/048
index bd41faef4e5431957f63184408c147b8ada1a8dd..afd9272c1a31b5a3d2df2e1ce9fe3268de768420 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -19,33 +19,6 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
 
-nvmf_wait_for_state() {
-	local def_state_timeout=5
-	local subsys_name="$1"
-	local state="$2"
-	local timeout="${3:-$def_state_timeout}"
-	local nvmedev
-	local state_file
-	local start_time
-	local end_time
-
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
-	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
-
-	start_time=$(date +%s)
-	while ! grep -q "${state}" "${state_file}"; do
-		sleep 1
-		end_time=$(date +%s)
-		if (( end_time - start_time > timeout )); then
-			echo "expected state \"${state}\" not " \
-				"reached within ${timeout} seconds"
-			return 1
-		fi
-	done
-
-	return 0
-}
-
 nvmf_check_queue_count() {
 	local subsys_name="$1"
 	local queue_count="$2"
@@ -87,7 +60,7 @@ set_qid_max() {
 
 	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
 	nvmf_check_queue_count "${subsys_name}" "${qid_max}" || return 1
-	nvmf_wait_for_state "${subsys_name}" "live" || return 1
+	_nvmf_wait_for_state "${subsys_name}" "live" || return 1
 
 	return 0
 }
@@ -106,7 +79,7 @@ test() {
 		_nvme_connect_subsys --keep-alive-tmo 1 \
 				     --reconnect-delay 2
 
-		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
+		if ! _nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 			echo FAIL
 		else
 			set_qid_max "${def_subsysnqn}" 1 || echo FAIL

-- 
2.49.0

