Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6E371880
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192807; cv=none; b=VcFcdG5sf2bXq+81eMbPSjEtbzg9hfza6F7LTSPxpbwwAFsBkP6qXJXdlhO1UmG5NwLxCnFDjrF5a3zVrL1VrZXSJrHBMUT2dW//+b0tM+iarQXYbJDj5mWMkiriUQc/oWn8zA03E1BE5fog9rC6vr9PvsWCP2SRPlNxRgI1VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192807; c=relaxed/simple;
	bh=D5MEDIEC9qIXAUXca6pyMDvq9lh9SB0qMU2IwUllUfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSDeRQ/UOVXgyg2TrX8/ihYxM9oyKwCFgnJ8ntWQBRq7MawA4iBVTjk6evBI6mByFz2KHXj01cCODx6Ot/3DZHBSIUdVzSLd7Ra2Yden94ARVdi5kLGoW85luaFzXZeJVQHMIABG0eUdGWtkVQ752SXvNvqd2bdChtu5SFl8oHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/W0GUCr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/W0GUCr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so16191275e9.1
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784192804; x=1784797604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8NytrQmArObGFLayPxbq8f0a71RoqylBa6qvKPw/zWU=;
        b=X/W0GUCrmxd4pK8SOOsA/SD0KqRAeAD86w2EcYlFIKU8NYn0JF4cS08DBND361ZT5I
         1P2RWzjAfvMbYwmE9n2cz7PMd9P6RiV7mj0VCpprGp+TbNbb0kw2JiDnQxfJ/NmzU0hb
         fJ71do9AI9sOj4n/0SHAzOS1IUirr3bHQqV6WKP+bkYKGvTNu6Gq5xBInixh8RH5aN2j
         n5uMxfawHwDOtLQnKG8ia+/Ckccbda5Pt/y0xmm3m8x86WNSzA3WPqwYbFO+1HzqJNf5
         9WN7Uu/VXSEsvSTKGOq6zsmBmGFASndLSb0Lpk+fJzBEEJWWqjy8K7sEL4PLmRJQb8ai
         NDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192804; x=1784797604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8NytrQmArObGFLayPxbq8f0a71RoqylBa6qvKPw/zWU=;
        b=ieM3D+aEBV3oBOUfwGndpkabvijWDl2Aby+w27cHvo9dnV88dg18oigwK7RzD79MLZ
         OcfuZub1Dc3ZFqm9xcBzlo1qXhM3uR9QqyUNRG3pTqD80PShHMsmEwdRwFYcemPBUuHR
         6ZD9ekD173JD4YEEzrmTYiE71tN8zgGCOs6s85XTNsUMVFr1wbhAwI1H/xK473/8nVqo
         uwQe8oqpItHgKG16iZjnHAzw5a3YZCNIIR0udVFPhj6zV6KuAYcwX+iR4Ba0tFkQ4SV3
         g4PtscYK+q/Hwp/bI1L6bsluFwKmNgFvSGxmvXtOP8R+zLXppEKWxpmJuMO1r1oIshTh
         G/Cg==
X-Gm-Message-State: AOJu0YwuVt90mfIWFjZ4JOGke5gwEKrQeUENGJILwQ0xUnJp3FWSTiYQ
	XLK2zoZ+zyShNNqMTHEp4owgRGU1lm4sD/8V5CbbhHV8vBkNNrUVC9hYg0J25g==
X-Gm-Gg: AfdE7cl7gGqVYnWUoTrQheGYCCrLTeMUmmJHgosYe0UtZOxNwswY87miwgQaew6r2cG
	LjPHof4XIVAll8yh3jnqmiDUxCbMSh2a1ykypbPq2ruHfRI4wgt9xGS4AGUAYLBGM1EvaBBxXF7
	Va3XVllIhJlsq/OaxkLvUu9uy+G8nxpWYDgqnMBNgHsqNBiXEvRPMsFAcRRnxh74MGWf1E5oWI6
	rJjErp+qfxiXNbqR4OP7WDWqpHaHGv7IM0/J3DL3s5sA2IS/G8JO/uQFtaFyGdFTNjUER4GXYXT
	2hgDVW0o8uvR0jX/6W6I/hXXaALAVKAsUiv3AF6ChCGFZ1TUx3NUIbRtgAbgjstqsR+vtBIe5Og
	I2ZLsh/eJdGN8Ba8K0cuQd5wyUV/wqpYeuz39IK7UTM3F3nTW428DFqDicPpz4gToxohGRn9xun
	m+vePt9T/l6qFemWibEzp6VtCIF76M4l/WiPFTkdzQ9o4DbG2Bpvyyhwnpqg==
X-Received: by 2002:a05:600c:190f:b0:495:4056:2c6d with SMTP id 5b1f17b1804b1-49540562c8fmr38148115e9.23.1784192803991;
        Thu, 16 Jul 2026 02:06:43 -0700 (PDT)
Received: from localhost.suse.org ([37.109.161.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm39662895e9.6.2026.07.16.02.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:06:43 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: [PATCH 1/2] common/rc: add _have_debugfs()
Date: Thu, 16 Jul 2026 11:06:25 +0200
Message-ID: <20260716090626.27558-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel options like FAULT_INJECTION_DEBUG_FS being enabled does not
guarantee debugfs is actually mounted at /sys/kernel/debug: on
systemd systems, sys-kernel-debug.mount may not be started by
default (e.g. SLE).

Add _have_debugfs(), mirroring the existing _have_configfs() and
_have_tracefs() checks, so tests that depend on debugfs-backed
interfaces can skip cleanly with a clear reason instead of failing.
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index d60a125..de5eb6d 100644
--- a/common/rc
+++ b/common/rc
@@ -223,6 +223,14 @@ _have_configfs() {
 	return 0
 }
 
+_have_debugfs() {
+	if ! findmnt -t debugfs /sys/kernel/debug >/dev/null; then
+		SKIP_REASONS+=("debugfs is not mounted at /sys/kernel/debug")
+		return 1
+	fi
+	return 0
+}
+
 # Check if the specified kernel config files are available.
 _have_kernel_config_file() {
 	if [[ ! -f /proc/config.gz && ! -f /boot/config-$(uname -r) ]]; then
-- 
2.51.0

