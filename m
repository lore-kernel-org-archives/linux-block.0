Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02747F771;
	Wed, 14 Oct 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008108; cv=none; b=U5W89hAqkNMNCDije8THxuG2EnJc0eanjzB1QR/q2YtkhLZtmb5y16bv/K3AV6syNgzwTTlX6wXGnahQmz/yc+BukLAdoKfntwXgtqSfZwb6q/BJ3lDac6WcJXVsVKuhiBrRohgvQM/enBJOgtxjlkevCb/pkTBtOxPEXW24DkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008108; c=relaxed/simple;
	bh=DgzexdvCeSP1i/H+Ue0+EZSaQXyBZ6e0vBQ9GEJNOuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpvpd0IxcQKstxyvKXl2edJ/wTOPv7iSnYrNIG6niwTm6TGQ3XJ967Sv+Q15YUjKndBmY1pULV3v5YojjYOzTLJFCyaltVqYQ/cjG7Ikw/9mWI632WE5GpTiGytpr6MpgNkUhEIP6tFCqg/Z5POXTVoQrn1j4oI55KCkglN3p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDvtWvHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDvtWvHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176FE1F000C5;
	Wed, 14 Oct 2026 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008106;
	bh=Z2c/x8kRyLdWlfUlyIfJHSMvGwSExpTZySUxGdeub3k=;
	h=From:To:Cc:Subject:Date;
	b=BDvtWvHz2a2m/WfCOeAC7NI4udN0I22y8qTt8xI4h0nJpI1ZRHPlV9n4NthYZn7Ka
	 TXa8hPnqcRLoMHVZEknzSjgT3CLIXUyrjQt+FgRjLw+oa5wQpzgPjwgB7+zLpu+HCR
	 OwGXEsH4n2Ic5DEXjjFKYoD2NjISnjggwOv6xNXHnTlL2U34wYrmDR9OsxSuQ+J8Cj
	 0FeEK/m9LOt/yozHgndeM6c/zxKqPvrmLx7Se4VfRAbDeKgtO1owXn/r/FXLPzxwd8
	 pAoIqMn9r3QWGxLScL9UZKu74vQozCVPgjgrSZs3fJfFwjVe2TdhKhus59y4QcTBUl
	 OWzV4ouKUlGjA==
From: Sasha Levin <sashal@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ublk: use the configured kernel UAPI headers
Date: Wed, 14 Oct 2026 16:01:44 -0400
Message-ID: <20261014200144.1364828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
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
 tools/testing/selftests/ublk/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 37883e9d50ec3..37db1ebcc7fb7 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
+CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 ifneq ($(WERROR),0)
 	CFLAGS += -Werror
 endif
@@ -83,6 +83,7 @@ LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
 $(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
+$(TEST_GEN_PROGS_EXTENDED): | headers
 
 check:
 	shellcheck -x -f gcc *.sh

base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0

