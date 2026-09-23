Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA16374178
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171386; cv=none; b=iKZDfOS6Tfa/Rjk+FhlEGwvDiehsW98UnSrSRbAiIAWyUGMf64jXxtaUHsO8Ngu0fr0prjsNKDhFnogqhZ2RuymHtO4G78NgFgth1sXbzWetbaVnXzNEbAB8wT1P1DFB16jvGVURfN22R1waALbody9kUj0stgAiO6RDR0gfH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171386; c=relaxed/simple;
	bh=cCQTXm+H/RF188nyjeKnn6+rJFQZz7XvWT6Zx1aJyRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIXNxCNd5mZoL9DsHB0sUatXf7OCd3TmocxEMX2G2SQO1+Z3p8hkwdrTpiVLKYlnrZ8XdFwVGIUIiyxiTBxMiO3GzJ1snN4Nfulnf+/LB6nW4d/UIkTbUdjGXHvQ+kQXP+5rB3gu5XxAhxDybnD4FMNyL0GJ17gHR0TajrtpG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC0dJNBc; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC0dJNBc"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86868f7707dso396762b3a.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171385; x=1790776185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hl7YnjaAsEmCFUnVGh3gw3Uebzmmjg5lfPeWcSdrH8g=;
        b=fC0dJNBcVaEdB0Jsq0M8lqzpobAwxDKvL/O0unLnzmg2eT/NrYjQfk8T6DxxRytNQ6
         mzXQTtk/LXVpegzi9vXxthlh1fCxxczYV6nbW3P61+ADS/B0PH0zDGGTVJkD5EwKe7Vm
         x+IILN9CeP7hh8aQKtxLgtVvXbRTvRoQFTikShOODOOe9BQPVuXuf+WoMyaB9i73qP25
         L80BweVuFG21LENgnOLbZFIgfbWllSMrjMHcpN2xzhmwl32LTwKoZ6HgJAab+0cLbA17
         TFjGpddxfnvq5c6m6FsOh7qhmkyGND27UAMvLE1PgsPhI48Dy5Lef9Q3sooFamb8tyaa
         ihzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171385; x=1790776185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hl7YnjaAsEmCFUnVGh3gw3Uebzmmjg5lfPeWcSdrH8g=;
        b=eEVXkuvq5kFnh2c8eyxBTiyrJ+PLUebb3mrO4WNfHdCGMiDhqeuM5tobeoOApwprZI
         yBpIoqQwzP9/F9mHhwP9BKa6vgzavFmfvwrrftDzDs4HWYA28CMYPOPo1nhqVBrhBEWd
         g+ieICc0A03qcVLBn5TKduemFn4vMdUfgjLSmUbnGunKct3tTmC6/G2H52+S3zLP4Qpm
         W/amRdK66duVGv6j3jDCcEy17N0vsYm2hMr5ledru0+uCes7cYEtzWlj+PkP3MLejuCh
         HFs2FsZDvpVF8bQl+Mqxm50KU88mvDyrSbTBoz94Q760OkZ/6Krd09RoF/39aYfnvJar
         PoPA==
X-Gm-Message-State: AFuF++l2bC7YrKoDn+Qa2EN5S4Vzcw9CuD8TWxmF7T8uF2XuJhL/upjV
	m6l7xygh99rSh15X8R18OlviY3Ls+xI3fHmhOfI6gdFjJPcA63qk1uBeQ6No+A==
X-Gm-Gg: AYBFou0dX/1VU3yztzjdtXZs2Z/fmfJJHRUGLAUdyj6f+tzAdcHupB1DSGvuM96aiWW
	9oIlfyi6q6IScy0xx5XnwxRbOJooH1Eb03GJGQqX66OPBRsYF99Bluz7i8wLzEtkAHYxYs77H8K
	TaJJ8hqaHIBQZu8sZR/v712Kk7MvFcPcrfmDdUQ8Xe2Br8DsZVTRimVlGgk1BeBTWXVTwIX/SPJ
	E2tHUowvwN6x6Ml7f/YC9ojUR6kIxfO/xGmaURBEoGeI7ay5/7wF9DPrygiO11Fsp7bUMIdVVB+
	f0vAHLScTQ4hPkZxJfuWzkTLHLfh+t0eHsNzfXIoGUT6bfi+Ia9hfK0Y2tW/EkrTgm+Xn5UGA3U
	xretk7eBzgUEb0Kq6nmovPgzzHzLSxGqxcLfRP3XTm65pei8J1I1Kz41mwBuXPUApcDfl1J7Z3J
	j4dOjFmzf1GRkDCbNs6h0r9x4KD3hM3DWyP8kSywXAbX9B1SmkruwDGF2d7Za3uUkkN+PQxxSdl
	30H+TlRcVQ+4V0DoghgoWoeYeWPW8P1dqXhaw==
X-Received: by 2002:a05:6a00:178e:b0:87a:9335:c93f with SMTP id d2e1a72fcca58-87d1c0ab0aemr2062753b3a.43.1790171384406;
        Wed, 23 Sep 2026 06:49:44 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:f072:2258:ced5:5d8c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fbbsm1319790b3a.52.2026.09.23.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:49:43 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2] nvme/071: add a test for fcloop LS request use-after-free
Date: Wed, 23 Sep 2026 20:49:37 +0700
Message-ID: <20260923134938.12673-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
References: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the fcloop remote port and then the target port while an
association is being deleted. The Disconnect Association LS is completed
from a work item that can run after nvmet_fc_unregister_targetport() freed
the pending request, which KASAN reports as a use-after-free in
fcloop_tport_lsrqst_work().

Kernel fix: "nvmet-fc: flush nvmet_wq twice on targetport unregister"

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Changes in v2 (thanks Shin'ichiro for the review):
- Note the kernel fix's commit title in the file header.
- local -a ports, and use _get_fc_host_port() instead of reading
  ports_to_hosts directly.
- Connect with --ctrl-loss-tmo 0. Without it, the host can spend up to
  NVMF_DEF_CTRL_LOSS_TMO (600s) retrying reconnect after we pull the
  remote port, which is likely the hang you saw; disconnecting it
  cleanly then has to wait on that reconnect state first.
- Drop the swept delay before pulling the ports. I could not tell it
  apart from a fixed "sleep 0" here either (KASAN UAF + list_debug BUG,
  both with and without it), so it wasn't earning its complexity.
- v1: https://lore.kernel.org/linux-block/20260921145659.17151-1-ngocthang2710.1999@gmail.com/

 tests/nvme/071     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..406a841
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,75 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Nguyen Ngoc Thang
+#
+# Regression test for a use-after-free in fcloop when the target port is
+# deleted right after the remote port. Deleting the association sends a
+# Disconnect Association LS whose completion is queued while
+# nvmet_fc_unregister_targetport() is flushing nvmet_wq. The pending LS request
+# was freed before that completion ran.
+#
+# Kernel fix: "nvmet-fc: flush nvmet_wq twice on targetport unregister"
+
+. tests/nvme/rc
+
+DESCRIPTION="delete fcloop target port right after remote port"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype fc
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local -a ports
+	local i port host_port
+
+	_nvmet_target_setup
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	port="${ports[0]}"
+	host_port="$(_get_fc_host_port "${port}")"
+
+	for ((i = 0; i < 20; i++)); do
+		# ctrl-loss-tmo=0 so the host drops the controller on the first
+		# failed reconnect instead of retrying for NVMF_DEF_CTRL_LOSS_TMO
+		# (600s), which would make each iteration look like it hangs.
+		_nvme_connect_subsys --ctrl-loss-tmo 0
+		sleep 0.05
+
+		# Deleting the association sends a Disconnect Association LS.
+		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+
+		# Remote port first, so the LS can't reach the host anymore.
+		_nvme_fcloop_del_rport "$(_host_wwnn "${host_port}")" \
+				       "$(_host_wwpn "${host_port}")" \
+				       "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+		_nvme_fcloop_del_tport "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+
+		# The host keeps trying to reconnect, drop the controller.
+		_nvme_disconnect_subsys >> "${FULL}" 2>&1
+
+		_nvme_fcloop_add_tport "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+		_nvme_fcloop_add_rport "$(_host_wwnn "${host_port}")" \
+				       "$(_host_wwpn "${host_port}")" \
+				       "$(_remote_wwnn "${port}")" \
+				       "$(_remote_wwpn "${port}")"
+		_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	done
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000..146809b
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,2 @@
+Running nvme/071
+Test complete
-- 
2.43.0

