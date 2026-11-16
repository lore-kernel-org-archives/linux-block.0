Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819940;
	b=XJtHmtOyRpxiZGX9ePt8qW1HyhAU4/7zR6HzQyD2VJial86QlG+oEGtzRf8XyaDabWoX
	 AnFzbk7GalopfH1ztNdMu5rbmYt+EgLAltp99U8mNlEZlj1O3RWalJ00nNbRNp2vOy3L+
	 KGygTycac80YJqRrggKHJPeAjOEP32/mkU1HOWaYTLoXtmDUdwGIn3W3N1ahmnPqynhi2
	 q8A88tP0FrEIT5tNosBacRIJstR3mtiAuHtMuRUtikbBaNI8XbZfEC5YAS1rasp5sUrXP
	 ADRSEjy9yMiTiuz3O3w+T67DybYjD3NLOCPAE+OBqzlMtDVwI1CXo26imlxANErIoKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1zvuDxYaIx+wRq51z8Ba2c/DCwXwLVuqXqRa+7I8efo=;
	b=VgV0jpvQN8AaeFG8TH4iJ0EDv7ddzfl8+9CKklUVk1pDqI61fkG9VX9GsBPJehfLjqBP
	 cWi+qmpZ6UvGLDNmWlIh+d2UnS0uiEJl4u9LnxcvwLapL3sJZDQ6SRINrIb2uu7fx17fd
	 2RWAwYOUoTnkzmrA71BieuJSrIRLJTFBLFXPQlsTBvVVvCrCtJhotTccgqHIDVs1WccHJ
	 ZBZVD8DztjJDGPf8n2bcy+kAf20EDiS/dDLoX/vl/05FZEL7J2RTi1KTyr9llDGvu0kp3
	 b+TueJbDhoNBbw5fVczXLJ7KUDiS1D9O5HtkfZWumuhTCSIuytjLOgLKjgNBvze+1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Matny45j;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B16606A323
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 09:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B16606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Matny45j
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-37198ed3727so4759748eec.0
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 01:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794819939; x=1795424739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1zvuDxYaIx+wRq51z8Ba2c/DCwXwLVuqXqRa+7I8efo=;
        b=Matny45jJHPjIWXkekS7kOaHLqe+34gj0u7udcwy8lDdIpS68CDXZP5LGnCpltTdf+
         dzp/fnKOEMmaGI2fJlFpKanKtIdr7KPLjdLdrRYri4pE25TITMaUdT3FOmIATtX5fB2W
         nBBvWs1vdMfQTQ3F33nHPrTeDv2CfPsMiyqE88TtvyG0ze6XcceBvRd7KNPsvwIRkFip
         MpbN2yeEb0EOPLH8gMB2g2syFrjEUZigMpOrWF69szbJKNM04yRNSM47T9TsibtwPqcz
         sIXARK5Wf4QMMZrTGsCbgtNASTFpP02dceQrq9eYFBaw70YmcwWo8ApNHcYS0cBj4uVU
         y0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794819939; x=1795424739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1zvuDxYaIx+wRq51z8Ba2c/DCwXwLVuqXqRa+7I8efo=;
        b=sU4hwPFP1Et1AxJO2fbwtoRM5lhaKE+cAnqsULbjKyVfO3gw6u68Zwkrvi/PZdUedz
         Vj8iBOZvn9n6U3Cx5h55CSv6sRzLdS66QB3vc3zUmJO0mVP3v9trc5BTvSrHzLQHGEGb
         Z3JSOXc1DLjlfqjWC66dZYXeopkNeFRGgOqzB+w7u2699VT8yQOq7WVW56mcbL0rAsXA
         SQ1ntOlaTl/7Qm1bO/RGJvmD8Bw1rqBhYx0a/3j+wPbM0T7TjAVtKQdyEypZuLKmGWsO
         BkWqM0kTrVExjhqr9wHu8C+WIgLRMJRps8bwGkW+TJ9yL5LYV4nhLmZJLqSL0Hygq5RC
         kYdA==
X-Forwarded-Encrypted: i=1; AL+hErEobPgfWL+N9uWuhvicXJPvX9Ls0N45HMOCo6xAbfZvt9alMiUcoVLdPvgAmEJHKWproULB+8QEfZj2HA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+DcMLupjU3tzPhSqen29nLhpTQ9SaQMYYuCa1y7dtj95qb3r3I
	FzN/e1Q38dJARnx0ZFgXgqYbq7FbgIwioQlofdngO5CotFcMpZYG64Yo
X-Gm-Gg: AZFdTZetWVB366EqfpTsNm+52nSOAHxI71hipfYVsYuzpEMdTmuJ1d5lomkURsF4Tn7
	hndt//VWVMOtYJrwQu9gerWH1vcPVqUe61C1W7nHkMIzR6IRZQdXPSrFf2tdBUgirUI2S+fZlR/
	BtwCtDims+yZ4dQRe8xKJGwO/AEKNWh4AfsN3yxI5xIEIi59iMgJ0dj2wE4WCe6N0ZncdwZv74x
	L8K2zDEcM48Vys9IDxa3b/II8MWkGAS9vDY7iOLWLTQmCepEoRGB8IVwPELV/uVQOpBbMDqxM0x
	HRwBLN/HeTIlaEmAVzAN/whkbk46h+dUXqM2CKls401ezwj6kvnJbO4s/fIUeXdkAVIvWpDbYPo
	qy5aA4RkRWbB5VnXz6N4fS7MDxsYzNLRv/nEpWi/Vf83Ke4/Ue/6+jVof/DOgjvXp5iZzSnn83f
	91udCvlrat1fQrgohKcvW+9Q+JiXbF3sm37bYhbnesiNnMV9+xbiFRpou7VXvpJ0hPXSEkgwdpC
	5FUjWhLugNBs/hWo4tILguNdS+jgnb/g3fUE9xpqbgB9DKAimIQVcNzm/sxOjZJokWNv6REF5cI
	GEKsi5kYJ5c7lf5VUML+VzqOyEHPvKA1tXAYyXumdUifZ1fF9i0fuT+AJwK/GHLbc3KmCx2V8Zq
	I4UxFDWUAxVx56yqk/wakOaW7q6kWMv0CA2py9w==
X-Received: by 2002:a05:693c:60d2:b0:362:2e2f:c261 with SMTP id 5a478bee46e88-377e1cebaffmr13409680eec.27.1794819938661;
        Mon, 16 Nov 2026 01:05:38 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm32581548eec.3.2026.11.16.01.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:05:38 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: tj@kernel.org,
	josef@toxicpanda.com,
	bvanassche@acm.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] blk-ioprio: check capabilities before promoting a cgroup to RT
Date: Mon, 16 Nov 2026 09:05:29 +0000
Message-ID: <20261116090529.69650-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioprio_set() and the per-request I/O priority of aio and io_uring only
hand out IOPRIO_CLASS_RT to tasks that have CAP_SYS_ADMIN or
CAP_SYS_NICE. The io.prio.class cgroup attribute has no such check.
Writing "promote-to-rt", or its alias "none-to-rt", to it changes the
requests of the cgroup to the RT class.

The attribute exists in every cgroup that has the io controller enabled
and it is not hierarchical. A user that got a cgroup delegated owns the
files of the child cgroups it creates there, so it can create a child
cgroup, move into it and write "promote-to-rt" to its io.prio.class.
Its requests are then issued with IOPRIO_CLASS_RT although ioprio_set()
fails with -EPERM for the same task, and mq-deadline dispatches them
before the best-effort requests of everybody else.

The delegation model in Documentation/admin-guide/cgroup-v2.rst expects
the settings of all resource controllers to be hierarchical, so that a
delegatee can only distribute further what it received from its parent.
This attribute lets it raise the priority class of its own requests
instead.

Require CAP_SYS_ADMIN or CAP_SYS_NICE for the two policies that raise
the priority class, like ioprio_check_cap() does. The other policies are
left alone.

Fixes: 556910e39249 ("block: Introduce the ioprio rq-qos policy")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 block/blk-ioprio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 8fa8bca35062..ea32db727b16 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -14,6 +14,7 @@
 
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
+#include <linux/capability.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include "blk-cgroup.h"
@@ -91,6 +92,9 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
 	ret = sysfs_match_string(policy_name, buf);
 	if (ret < 0)
 		return ret;
+	if ((ret == POLICY_PROMOTE_TO_RT || ret == POLICY_NONE_TO_RT) &&
+	    !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
+		return -EPERM;
 	blkcg->prio_policy = ret;
 	return nbytes;
 }
-- 
2.43.0

