Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710905;
	b=VvI9nT3r2ChyIW90571bYVlfrY6NY/zVlG8+aRWaqdDpu1FuzS+NCdEAtaPs+eWUpJCt
	 kvB1JS9y4DxkD09M1z+HmHkZYIwgxoaszFTLBLT/q7NDEXfIfJklPNypkD1UPJkzvtohU
	 enuO+OJtE0W1GAe0UFwWVjWEzXatm4XkL+gVZWEDLsbDff1dqK/vwLI1hI09vi4DqSr+W
	 od+PIqx7/9Xk1rQvJbRyGgl36fx72YkKX8Tm0anLrzbUILaFa7+LEtAue1QfwSlN1rydT
	 aGtX7vvj29bb61XO8bB8tIh/SSj/jNy46hmihnxVTFagOuUeLtw2UxQJI5PyzZ+wgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=im19ijJnqDS7x6irU+zvomnzbUODwTEv8kALLgm4rWo=;
	b=0YGSB7dHOA1wyFTnILrEqg6pE044Um4fXjr9vIBp27jOq6SL1JFue2O4VGB8P4Fh5jOQ
	 uB15TIZ5XYP0cnSiJczrhkvAwO4jiud6t3fGqTrbMZk3WTamU7DDgmJDVGEOS3s/Qy5nz
	 /s+Cq57rfVdY7HcAXYvIOKyOuiB1Hgy5RrtZdUahBY3E7sHJps2fArik7iVgUHV9FzDz2
	 kbtvCnEL2nixaFv+aYg8YwaNUk/WkKoZtZclXgDVls41sAbA/ZaOT92j1T3wxPAhE1cvl
	 b+gfcLOoxn7LFzMzIHuXq4Zjap9zLykzhBZ8ZJmkAV0WpgsKncOfe4BuB8LRhPpZWvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3kNXWwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804F606D82F;
	Tue,  3 Nov 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3kNXWwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750EA1F00A1A;
	Tue,  3 Nov 2026 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710905;
	bh=im19ijJnqDS7x6irU+zvomnzbUODwTEv8kALLgm4rWo=;
	h=From:To:Cc:Subject:Date;
	b=m3kNXWwUsGj9Id/GhC5oAm42Jgn6JDBPAXWzFn+Xh/egjza1rpxwCB3KIoXxuA0mC
	 RtotCkl77ZZmY+AH5665R40l4GHG4IkYZAFDLwqaQdOt2yQeUIDDwwhT+CrxyiwCgJ
	 uw60/CF/fsHbOP6J3k2x1dD0FN8Dy4/eLu6MoFplasio930jVAe19oFTjdXkg7wUAZ
	 HREMCOkWc4Iv3MIXVePASEjifoOQmVk3CPXa7eG24UuWtAnq+5WvEpyir9LgxJ8J1O
	 2XlA/Mc9cibirG9T8FXbbMld5/K/qvQqYFmn1Zi8wGKEy9Kbvvv/b68oY7dNskB5sd
	 ITw0ybcLnTEcA==
From: Sasha Levin <sashal@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/ublk: use the configured kernel UAPI headers
Date: Tue,  3 Nov 2026 08:01:30 -0500
Message-ID: <20261103130131.4069212-7-sashal@kernel.org>
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
- Rebased on v7.4-rc1. ublk_cancel_ready got its own rule next to
  kublk in the meantime, no other changes.

v1: https://lore.kernel.org/all/20261014200144.1364828-1-sashal@kernel.org/

 tools/testing/selftests/ublk/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index fc64b8f028332..b8142bad63a1b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
+CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 ifneq ($(WERROR),0)
 	CFLAGS += -Werror
 endif
@@ -85,6 +85,7 @@ include ../lib.mk
 
 $(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
 $(OUTPUT)/ublk_cancel_ready: ublk_cancel_ready.c ctrl.c
+$(TEST_GEN_PROGS_EXTENDED): | headers
 
 check:
 	shellcheck -x -f gcc *.sh
-- 
2.53.0

