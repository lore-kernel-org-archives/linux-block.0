Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2648E0DD
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002632; cv=none; b=CZCgk7xzbQ1uzyeSNR3dRQ0OCzgRAYFK75H+wHZq6GH8roidynhh5MpqXTURV/FVM28FUbaJKhazhlMSGO9WJPdCre9+VljGlu9dzm3LkYM54LYrmmg5GzRTJjrQNEdgm5scrUCahEGxv8Ag//dwVUfVtq/H4Vx9+hLU2oVpJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002632; c=relaxed/simple;
	bh=UCqTXqZsJ2k/kQ21TuvlQAJLklSKZTn5AnqqEuXldZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkA5Pd3gNbKarSuviK3WmRA9q4MaX9ttMyIaD7K1VO3Zt9jatCTQUROri8zeN/UvECIhF1sEzhDMXCm322x7D+BeNUrUqJLb7UcHBVzynhJ1xNhot6nUtfPIH+0zALJZrbZxJxJgY9cOOI9jgh0jYZ8MJkZPVaQ2pSOUC2ThwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6Gv31w+; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Gv31w+"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso2630217a91.1
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790002625; x=1790607425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFAWgbQv1qSO+/rKdk0siS4WLAN6WSkmRl7OdK/9TVE=;
        b=S6Gv31w+oelZ/vW0a0cciRRRKX5ffW5DxE4TnGnxlclgqp/kJqF0D3eEaysk5Jlkg9
         o7XRdlG+lIDwu8FSr66bW3tHSJNVfg9Bb9f+bxG6aNTM1hXD6bIYCuKtL6JgsLRnWh3L
         /Mzfgh/VQBVW+nSg4LT3KY3QIouJ3Agk3wSy+6dvlvcHvlA4omk5lyCAS+3fXMP3heS9
         hID9GzfFWU9vjaRF8OXVQGJA/VhfRBSM0VNa2fb7HDFmH1ukBJvXWK8aeKO0YbURg/Gi
         QG9UwhiRKafL/4ssRw9liWSYV0wEl1S0mwVstgff2rQ8/WMo9IY6NUueGLQQyIc+Lxli
         StDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002625; x=1790607425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFAWgbQv1qSO+/rKdk0siS4WLAN6WSkmRl7OdK/9TVE=;
        b=SzSVw4eCpHctUZ/ce80BVlkFdzK77+v+SeHqHaTcWqfjMP98SmyPB44/wxJkFYF1xk
         dJSLMQ2bVUJabIX48Qlhh3Ru3KxvMPP7+6mor5yTTfdzAFbZy2lZqSPl3A3ljKDJU3Nu
         D+z8N4qFSSVBxbDhSLVqZtFAKkWiptHRxE4GTWnfF/r+WtLOBKSZco95jG049pKxVEZ/
         LBEs3qVXgFmPHiDbk+oIMR/x5RgrdEYGCrSjwkk5/SHBUDh/Bn5C3A1wbOkCc4WJfpib
         VgjATf83XD/Mf0lAi7YtWfbnw07xaVQnOeQsnIhnQ9CPqs7BXtJV/xlkuOhTJVSRvaTP
         lxiw==
X-Gm-Message-State: AFuF++kiikdmTSuS0CAeca94AoPk9zfhAF/IwuAlJS7dFFtKoO6PZJTH
	Z8xZPzK42FoYY0mvSjo7j+QEKkgBBxTbNguoKB5kdrYniVUqJ934S9mM9L3b3g==
X-Gm-Gg: AYBFou0VpM1qJd4RvkQlhKIXWHQPkW6Shlb7KJKdAS8e5c84eySmUulUSkEM68lvjx1
	5/O1W5V7jpATSvTBRdFEIojaAbKdgSOg1cX+sqUVCXzyCoQ2VOf4wvOmTt9X95AoTqiSz+NC811
	O1Qel9kTU/H7BLk5gjPzNosAZd+A8dJHQjqH5hUd7v3c9UqGmJ2+oaqbOAUh03MDLoP61z71Rfs
	770wwHXwhopni0wpz1ttwqcy/j8jCVA6u2AKOFqq0z0ObvbObdkZ012L8Q0aE1dldPUzmzKWRgY
	7Vn6WloBhbL0j8RuFu33NhaJzE+jBzWyEAZlvYLMqqkQxHml8vZlP9PSjE3Ik69QyGZQO1rtFu4
	GOmY6ivG4PE2iQUntQvxj8WslhYOh5ch2PITYurK5rzroOx2DHP5sEYSxjT1Tye/IgUf1e4Hsbq
	w8SFzaEOTPPjYmgaWqYlIXnG3/buEDUfkH3Mdqext6PgpEbToD1bKL2qJS9dZltjzeAbdDgh3Wv
	LpDeGR6VWzDFXk=
X-Received: by 2002:a17:90b:53d0:b0:398:c150:e7b3 with SMTP id 98e67ed59e1d1-39e54d8ece9mr21218146a91.4.1790002624613;
        Mon, 21 Sep 2026 07:57:04 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:70bd:a3d:dfa4:3859])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063a41b25sm505372a91.5.2026.09.21.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:03 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests] nvme/071: add a test for fcloop LS request use-after-free
Date: Mon, 21 Sep 2026 21:56:59 +0700
Message-ID: <20260921145659.17151-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 tests/nvme/071     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out |  2 ++
 2 files changed, 72 insertions(+)
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000..d17ef18
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,70 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Nguyen Ngoc Thang
+#
+# Regression test for a use-after-free in fcloop when the target port is
+# deleted right after the remote port. Deleting the association sends a
+# Disconnect Association LS whose completion is queued while
+# nvmet_fc_unregister_targetport() is flushing nvmet_wq. The pending LS request
+# was freed before that completion ran.
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
+	local i ports port host_port
+
+	_nvmet_target_setup
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+	port="${ports[0]}"
+	host_port="${ports_to_hosts[${port}]}"
+
+	for ((i = 0; i < 20; i++)); do
+		_nvme_connect_subsys
+		sleep 0.05
+
+		# Deleting the association sends a Disconnect Association LS.
+		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+		sleep "0.00$(printf "%02d" "${i}")"
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

