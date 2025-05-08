Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99CB230BD0
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747875; cv=none; b=b+Cn/3JfR6DOOVCMbI6zBLy8UNB1XSJTr8fHpsy5NMtc+L1Fsz87oTt2TrfWLaQIYVRnHo5Jycgcw+VspMd8VRxA7Kmd7bysucKhqCYhL5Di8wVRlA9nZEd8BV6/a3srKO+fCgGTMb2SRxZbSISszapIhJvbdUgKvyGncWwn3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747875; c=relaxed/simple;
	bh=etYFRPWWMWcrKgX9TeHg05olhV9tY60ktTFH9X0K2CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uy02K+rCGo4U408y3tYgFtcOi5ZXkg786NURzrJeYnXH/V8j/wGZ08gdgN66BK/avvGb671UWiscPpBpMgViQMt/MdiwUIrwt/qYxypbQs5Mg/1hzDX09PrRYIabkUMTUHNLuf+sNF9j1J2NAxkG0cxpKbDyeNoWxNT6b9jdgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5cpvwFW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5cpvwFW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af908bb32fdso1405808a12.1
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746747873; x=1747352673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MAwekBo8haOWYsomhTT2Rz1tYZgby0EnVj2UikhOzs=;
        b=T5cpvwFWQt2nx39GXw6LOLZxec+j5i6emMQsa8rh2v0smrq/k6KbuIKrYmZDUvqTWG
         eAceAcpMPCjSk44MQcWHp0Dit3YVPPFv7fARnUOXiCKliDCXYLol98ex8XI+CiJF7M7l
         wqcdn2BBmUz1YaiBB5EH9ZWHfbU9j27dT9g3YbOsEKIjuRaWgo7arvHMfq2s9Uyc5/I4
         DaJFSGO6EqAVnRW0fwVYRTMbIsmWg7/P9tFzGqe6UrfnrumIxpj0RUC61vOZUU2yLZ8N
         Bxg/fGrbsXdFxObn88xAol1pcMZzRZD4na/1fQ+uYyduJa45KumBA/+dZRI4E6mSHgDx
         I0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746747873; x=1747352673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MAwekBo8haOWYsomhTT2Rz1tYZgby0EnVj2UikhOzs=;
        b=er7/w6fo7jqrLq8zHnivmOuXQEojxLqSbRTymfiXhGzmoq4Gy40adB7dJ8324h7Q/d
         JVOhsD6DrCx6pdds2s8o/pAiBu0Up7ptiaVCDVPyoxGJrhainL5I0J8AoA8OWGzUTFwD
         VR6qBWSVAN4kwNZ8ZNHmo9IueCksZvbC79DLwjiFJPqGv4kQo0r8z8k34J4H6IxR+4+g
         Qd3FPHjBL3f7ETxuQKABVT+i0otPW0NX2DCKyLk81yzXyvsQt3rKdWn9kZG1d+osX0al
         kEWEPnXnQkeJPwni4qdBw38KguxhE9MoGLjSUy57la12/IXMuNv4Jum+muaaV4NCexOx
         SB7w==
X-Forwarded-Encrypted: i=1; AJvYcCVdV7cmELKPxhT3je1rX9I0vsgT3htY9HOf5qh0u7dK8kQ1af6FMZkapLnlKb09OACiVbVATraR/F8G+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuycbZs2rc0c0IDPZH1cOLCs1DY+QNjYh2fdQbRX7ZhMbpo7Q9
	7QE79SCP81kzwyTsStcg5xLMrXmi2L9Y1CuNOBZ5Eza7DgT6t5XK
X-Gm-Gg: ASbGncs02cc/SUZcsfvyNGY6Z89scDnH6K0lKnMHcl+lxdef27SEwttHjN9u1hcVT6c
	L21W892uunftcGcn1cuqM4y9K5XMNnif5k4VMJGIjoScAd9geXgH/tpdITLY+SfLSKRZc4BfyN2
	v4cBqoh3z08mDAZW3i8s5bDJflmB9qzAi3YQFFqt4apR7kmim6L0LqrHD+iRn/L5P9YTFFZ9Wnm
	LsUT0EZzVJOizrGkjHk0au/KjTA82Ixss3LZtPSrho+cXGhDEpRqVXTINrkVI6/wALKv60RHJrw
	ql0ukDL9HJrOIuG9+595h5wggEX5EOClf1X5RVExzlr75cA=
X-Google-Smtp-Source: AGHT+IHXxFZIlKoBhVmwgQCYBC6gpqTCerV2jIX1ctGP4Wb61hxFfuG6x0E0RSSIUt8Q5B/AKzdA2w==
X-Received: by 2002:a17:902:ea0c:b0:22e:491b:20d5 with SMTP id d9443c01a7336-22fc940f061mr15330255ad.26.1746747872935;
        Thu, 08 May 2025 16:44:32 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742e1dsm5530465ad.78.2025.05.08.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 16:44:32 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org
Cc: dlemoal@kernel.org,
	hare@suse.de,
	yi.zhang@redhat.com,
	alistair.francis@wdc.com,
	wilfred.mallawa@wdc.com
Subject: [PATCH blktests] nvme/63: fixup tls_key encryption check
Date: Fri,  9 May 2025 09:44:00 +1000
Message-ID: <20250508234359.434022-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

The _nvme_ctrl_tls_key function returns 0 if `tls_key` exists in sysfs for
the respective nvme controller. This will be evaluated as true. However,
the test should error only if the key is not exposed by sysfs. Which
would mean the connection is not encrypted, as per the existing warning
message in the test. Currently, we are checking that it exists and
erroring out incorrectly. This patch fixes the above.

Link: https://github.com/osandov/blktests/issues/168
Fixes: 9aa2023312bf ("nvme: add testcase for secure concatenation")
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 tests/nvme/063 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/063 b/tests/nvme/063
index 7477078..5bfe8be 100755
--- a/tests/nvme/063
+++ b/tests/nvme/063
@@ -93,7 +93,7 @@ test() {
 	_nvme_connect_subsys --dhchap-secret "${hostkey}" --concat
 
 	ctrl=$(_find_nvme_dev "${def_subsysnqn}")
-	if _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
+	if ! _nvme_ctrl_tls_key "$ctrl" > /dev/null ; then
 		echo "WARNING: connection is not encrypted"
 		_systemctl_stop
 		return 1
-- 
2.49.0

