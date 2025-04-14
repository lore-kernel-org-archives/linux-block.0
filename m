Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E662D0A43
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639559; cv=none; b=n5ECsmyVBdF675iPVmeQSxZJOcuPk/LfxFYUqclygaisoN87WlpZcFkZiHmfjHpzbY7XEOXSA+PrDySzKJqWEojkNeYRyuDirARicGEu9AqZXBFnBvupuXtup76eoLjYUuwerjl6zUF5n387YRJ6wjlknURTmctIDa0e90f6gE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639559; c=relaxed/simple;
	bh=YFoXgbgup6mavWMsiZOhhOvd8aBFDXaX4CBB6vu+uao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XN5Y8PbfJgxKPa8A1FcuFpn6atxgmuQcclW0lfBTAYoStgCDOaFr9IUQFr6nOGfpUzmHQS1yT/J0N/Xa3L3V0hDAr7BGWWZEViOQ0TUmmWuKLtCRQu5XluvLuELW1+93LL2bdow8ljWA8NCmtMMTVAT5FxQ3a1QdGN2FauojFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzAJ4eI3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzAJ4eI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECAEC4CEE2;
	Mon, 14 Apr 2025 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639558;
	bh=YFoXgbgup6mavWMsiZOhhOvd8aBFDXaX4CBB6vu+uao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HzAJ4eI3BxvxWzbE3hCDKbSQ/8yHSoj45fLyzNLUWClbkoV2FhFJQLSxa9IF4ycaz
	 ydC/FPCIqXMG8/bmVUTVGIDKgAYYfX18TitWNg2iWrMu8YiIVxE0IVCbzpTboWmx9D
	 ti5BldvAI4wpGEaBBdTMkw3njeNEfzOD/NwGgY2YyNiNlkD3ZzbUA1165tZTpD3Fhr
	 3IGKk0YAwZ+C6mw6UXbIm4yjKic9EhZiC3dZ3bvxiMZMOdgU/ZgFbUcm7XRZyFliYT
	 M0Au/AV1wX+8emZyN4iJXWxT6bJ8IEbkGl4IoHha0WsaltRV5PX01GT7D3C/iiJftL
	 Iy/y1kXvugqfw==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 14 Apr 2025 16:05:51 +0200
Subject: [PATCH blktests v3 2/4] common/nvme: move nvmf_wait_for_state to
 common code
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-test-target-v3-2-024575fcec06@kernel.org>
References: <20250414-test-target-v3-0-024575fcec06@kernel.org>
In-Reply-To: <20250414-test-target-v3-0-024575fcec06@kernel.org>
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

