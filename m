Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735028;
	b=aCYY5C7a+UinpWfDbsT+yS44HwFAELoPWJcDz6vppn9kQ4SENOdi5wNU4+h9/aLQ+sIW
	 qgpx9hnygBIkiF9oFYCb9vdDyCJ/NrNe7f+X4DUI66pNFVOaq2oIK+ViAbiSlnbkvgRTa
	 CiDzosG/ao9l5VDlgkkF/tZAdbapCvAfzjlddGC8q14wfGDlhEm2VgUybBP9jfdf2PWlZ
	 pemmcHCZZAbqxdXLDFjCFEZPa774B5SZgj9hilfz/hyQn6wgU19yNaO+9nTGFezz7lZdf
	 wJVQfOD7T3bjhC/eIvqgOuo6OTDg8JYVU4gAyQ7DZJVGFiSyWYSncRUOS6ORBOjh6Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735028;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jGVApWgljt1OAwqye7lEOooCatG4WYHlv/gc8SsIcd0=;
	b=EoZT1w4KENH2FhG5GGodK5GPHLV4WSCjlsvHx9f5zWehyYivO2svssmeBN0LQ8fJ3xjv
	 +byPWmKx3Y1jKe7/9Wlb9XhuwnOUYHfF+FDTtuor7gvAQM5l1phdpIwhqS3JANBEiVJXV
	 E2uEjLSrQW2cVFOtN9Yt8ORdOYAvikn9mmJGwiBZ7OWNQWsr/ARwvnfiBUstLrGci0INn
	 Nlj7GVGadDe3y68evWx2GaO9A8LB7/gfA1B4bN5RagSUWiaijBPMUiD7cNHHcUz8djzd6
	 w/cVg9sFRDrzBVX4YJNu6qPLK3LygDeCh9ln4NeUdLN8oYjaEhi1fu+5YXZnekDpTWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgLIzB0P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9538606A32D;
	Thu, 26 Nov 2026 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgLIzB0P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDF91F000C1;
	Thu, 26 Nov 2026 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735028;
	bh=jGVApWgljt1OAwqye7lEOooCatG4WYHlv/gc8SsIcd0=;
	h=From:To:Cc:Subject:Date;
	b=fgLIzB0PHlcTE99GoQ8jH6a5dHnsnyhJUlkc7TV6p1MeWj/yiJlu4VqYCvXXur2Vz
	 5CTMpCvml8uSFpSFokIEu/FYV3zHVW89fcocUgv5s+qGgPQQd5HXHhcZa8zZXbOvBp
	 1IlQgouVri3QroGkvbbl9GwP3mK8Eit8QdJRcmOuv6NsUieLr34wY3MG4pJnEtJFbq
	 Y2OG3wv+Juyyhs5jKDsdqoinkHBO2fL5Lxyhmv9Nvn7c/43pzGD8EW4UM+Cd/r1Zss
	 1eJU+uKCh9sFXbBbhN9kgvr6VO6yKE92Z4eHpJ35yQgBvb7rzAwj3Z1+b2Ud1pi+zR
	 P89CCFUwhhgLg==
From: Sasha Levin <sashal@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/ublk: use the configured kernel UAPI headers
Date: Thu, 26 Nov 2026 18:17:06 -0500
Message-ID: <20261126231706.1303486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

With generated headers in an output directory, the hardcoded source-tree
include path falls through to distribution headers. New ublk flags and
structure members, including UBLK_F_IO_DESC_SIZE, are then missing.

Use KHDR_INCLUDES to consume the headers from the kernel under test, and
add the headers target as an order-only prerequisite of the ublk
programs, as nolibc-test does, so that a standalone build installs them
first. Baseline builds fail on the missing definitions; GCC 14 and Clang
21 builds succeed with the output-directory headers and target liburing
development files available.

Fixes: e371b9d3368c ("selftests: ublk: kublk: fix include path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Changes since v1:
- Rebased onto v7.4-rc3, where 3197517875fd ("selftests: ublk: fix the
  build and file offsets on 32-bit") touches the same lines. No other
  change.

KernelCI's kselftest builds of mainline 9437ee8b6cf6 still fail on
kublk, metadata_size and ublk_cancel_ready without this, with gcc and
clang on arm64 and x86 and with gcc on arm, on undefined UBLK_F_* flags,
struct ublk_param_integrity and FS_IOC_GETLBMD_CAP.

v1: https://lore.kernel.org/r/20261014200144.1364828-1-sashal@kernel.org

 tools/testing/selftests/ublk/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 1a50d4695c9fa..8fc3291eaed94 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
+CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 CFLAGS += -D_FILE_OFFSET_BITS=64
 ifneq ($(WERROR),0)
 	CFLAGS += -Werror
@@ -86,6 +86,7 @@ include ../lib.mk
 
 $(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
 $(OUTPUT)/ublk_cancel_ready: ublk_cancel_ready.c ctrl.c
+$(TEST_GEN_PROGS_EXTENDED): | headers
 
 check:
 	shellcheck -x -f gcc *.sh

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.53.0

