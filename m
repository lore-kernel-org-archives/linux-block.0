Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674593;
	b=K3JjbzrxYwX1n/x6ycvP/tekq64cXq/t7YsGBLXNtRGYm3Kl1xKezN+v25c9PtGCKRyE
	 fTaXfzZxBGyN55it7H7hB25jPlAe4FlVrPAYBZAjKOs+onbLptdjO9ejjd6ioWhg74WZt
	 LBD+8zYCfViJU8xsqolmaFPr14cmocv4xa5KhN+8KZBkzIcSk8S0gS9dkIvrw3LlcqGx6
	 connMd0Bucn94NJDHMK4jUqhtn4TEZjRkWkeFfgJWhT4ImURTZsidk1adNMDYa65usPD0
	 4BoCTXvuswvYS4KUlFX/bzOy2pvXxLjxsFOYHVN4DZn0vetPPM0Kra2xG/35uwO2C2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5P6xuL+k1YjcijfUOWHa2xymraHIogeGGhwbXIV+NoI=;
	b=XgY2PqNwQ2W7VzsNqA/IICmL5VaHKqBTf6PDnltNuoeGpBFvojp+In679uD5dd2lgCW5
	 kzFnDaENc/AQ0K1AwS6fYf/rPVlva22RcmMvC5Ni69NFZCevgR9sNR+AKpCa6JMiKa/CK
	 JRiMKKgSJEslRnB1m4ZL44IEyYbZ6E5lWcDXdH9yUPb/WNNN58yX5KrLgluLK0kzzxbJJ
	 3hMXuG7WCcrPXs8LG1oDBWjy+vuhcSttYNhmb532wPup/PeExaTwT+Wa+PG7eAa4W7fI9
	 PfCswLGGmnKGOCF12X/RbLKF3NzbFve1lkpiviCDoIwA7ut3kWn/9qdDpUG9SSM9pxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On3JxmNv;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08682606A320
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08682606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On3JxmNv
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so5580385e9.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674591; x=1793279391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5P6xuL+k1YjcijfUOWHa2xymraHIogeGGhwbXIV+NoI=;
        b=On3JxmNvYmorGbYvktYtyKYjOAYW975PXo0t1XI1VuDfYovWGyKNBGwKvdyz5xHbDX
         dHgedIeeU4Gzvj49MI2ZpIHYdabdQ/T2Fg+9JaE2jyv5+6m7Jm6F2mLuZ5XrCaecph6g
         sLOAe4Iu0E5QStDZNNxnHNMmMRCFiZxUFHepH188MLhtJZDZsUhVJJZzMAAqSM7bR/qS
         A+Y7H+CMtfuhDyoaHyldeo0gjtt+1UrJ3aL2jKfRhrdPTBOucHxbzqpjsRMx7+y/4OQW
         m+Rp9QV2brQ1v1pU9J72tYzHqMnLv+qYBQ7iKhEe5/84z0tZQptn9um07IjNR2zPJRvI
         N4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674591; x=1793279391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5P6xuL+k1YjcijfUOWHa2xymraHIogeGGhwbXIV+NoI=;
        b=HSj/ipb5l6BdhYyq2J2NtUjzT1IiL0LfQLpbJpwRpojBMPaLfGm0Jqr9ZVHdrUIaIX
         vyREtRn4IQqsK07dCBdYeSQ5y0ZwMaOGAtC0k8Fvzzn3RRaL5UhVtlck6WJteKc7x+qx
         vzjbJSQ8T022q4+a1KS8eDYAZ7xGgICO0nMA9/usluRK3eB+FbqUv9haBqbyOhoKrb1D
         rBmChiGkQAOeP7JpnFo7HKfG+bQhrrjsckOyeWHpnU7LdgHufb6xzyW6loHa8n2wZDhC
         4mBUTGIGuCyK7kDXzR/7UGNCBLJ+Au1CeT+myTI1fbdE0HtunzCf/qCggUk/4aMM93YS
         rcUA==
X-Forwarded-Encrypted: i=1; AKwUvBwLAAZQQp+CHpzT9YFvM7n7twB6maGyn0mKkR0qHxZkzmo1TMyY49ErKySvRYb0Ca0ot2CbkkAWh8e5IA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0MBBQ3BX/soIwYeLAn59WpuoxL8iKAle7O/OCmKs/L9tLXmcZ
	y7dlz49Kh+Dsaehe4FwWvvL++I2zD+g/kTUQlw4VujKnR/wTxGMCZznk
X-Gm-Gg: AYBFou3QFE+M3GfXzHawgOe6F39FmIN9zrfcrqCssrcL5yPaTssPdKCq1AfzCYEOhjg
	1zFP5z6Dm6miBJyLWxz97gTvV5mVEZMx9lJxr9VI+pI5ZThm8WgaBMGESbE3O/XhQzvsFh3S1Qd
	pcohz5MExFoQw1tSmXNVVNb0cS0V5kwI5tror42kBLj34t4VUnMUo84OCIqSe2sAoPIaZZAMO7G
	3q6grE/RsvyPK1U1f7EkJce0k2m/bJ0HEbBeb59HIMuzoy9JrQjPm8gV9ialYa97fpSybF+ViQf
	bSNHY8HYsTG68zI/YspYB+vsJLfLSC5c6Ju+2rx6Q8Ukve+lFfApcsUdevfwLlybC7jNF+d5j//
	POnP5mWr0e4HkJHOGQnOfVmmiRtklZjzlldUG6mRzcHxKYDiwN7mUsCWO5ju5Ydy8N9UFusDlCy
	rPH1ZWUFdWPY/mGwqoogdCk2/HC9hqKu6QeYyw9E1Aj7kWTniKqB6lK9FySTWwXubaAnB0UaqSd
	Kudja6itIRfiFPu3aRlJwlMn1yRE3nQtqz+WW7a/NBpzLan+U3JdLN8TJ6Sqi6/6SpeO898BSxx
	oWMFQD88gVoL+YK/qwAspN+RadY2Yg0URtUNcHxw4Dshqg==
X-Received: by 2002:a05:600c:4513:b0:4a2:1a:a11c with SMTP id 5b1f17b1804b1-4a2047df0damr47749905e9.0.1792674591239;
        Thu, 22 Oct 2026 06:09:51 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:50 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2 4/4] nvme/074: test that nvmet rejects a zone report NUMD that wraps
Date: Thu, 22 Oct 2026 15:09:24 +0200
Message-ID: <20261022130927.3583166-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
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

Verify that Zone Management Receive rejects a NUMD whose byte count
wraps a 32-bit calculation, while accepting an ordinary request. The
test runs on every configured transport.

The test fails on the unpatched kernel and passes with the fix applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/074     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/074.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/nvme/074
 create mode 100644 tests/nvme/074.out

diff --git a/tests/nvme/074 b/tests/nvme/074
new file mode 100755
index 0000000000000..3ecd3ffcb6894
--- /dev/null
+++ b/tests/nvme/074
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that the NVMe target rejects a zone report NUMD whose byte count
+# overflows a 32-bit value.
+#
+# Regression test for patch "nvmet: zns: reject a NUMD whose byte count wraps".
+
+. tests/nvme/rc
+. common/null_blk
+
+DESCRIPTION="reject an NVMe target zone report NUMD that wraps"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_null_blk
+	_have_kernel_options BLK_DEV_ZONED
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev
+
+	_setup_nvmet
+	_register_test_cleanup _cleanup_nvmet_zoned_target
+	if ! _nvmet_zoned_target_setup; then
+		return 1
+	fi
+	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
+
+	_check_zone_report "$dev" 64 15 0
+	_check_zone_report "$dev" 64 0x4000000f 2
+
+	_nvmet_zoned_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/074.out b/tests/nvme/074.out
new file mode 100644
index 0000000000000..9c940dda4486a
--- /dev/null
+++ b/tests/nvme/074.out
@@ -0,0 +1,2 @@
+Running nvme/074
+Test complete
-- 
2.53.0

