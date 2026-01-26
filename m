Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84E332EAA;
	Mon, 26 Jan 2026 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426808; cv=none; b=QW7oWDQQGt7nLdvHzaHqRz2WYzzFQTRxXXg5XrP3IEu060S3XQQaR3g8Ndq+qWYoXcRd3pfejYO4RvibqbIva3pkMcAhNLeJvOeybXwC30DBCNoQkZ42h7s24RzI5qf0rJj4Ap05SSY2VMxN5SFvs6UfWpDXl353QCyjuchv6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426808; c=relaxed/simple;
	bh=S03bBiZAL0QIg/zum26DykKIYt+SWIiNpDEGrqvctc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/Bt7cw3cVofBLNccQk+UuHcjRqx8+3V3waU3L8XVTZf8xzhtqH5ZT/7/mP01I7IIvmjNExPyHvKxKRfZmaBP9N8M5hatEQ8KdqMNptHNKfn27S+ny0L5jzqQXJ0FQC9S73gL2bhlGn9OF+oR6pVhRD5ouIrM8FCjm5+ZrJgCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=pu3UxJgt; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="pu3UxJgt"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769426796; bh=S03bBiZAL0QIg/zum26DykKIYt+SWIiNpDEGrqvctc8=;
	h=From:To:Cc:Subject;
	b=pu3UxJgt43hoIBRsFV8ryr+NYgLMtb87go82ZRleKKrChWO8r3RvCEWcbtxMt/ey8
	 Pl4jogWzYaktz3sadVXDHOSmyZrPF0K8mTRLza+OZ8lPlSOXkYuQgR5IVfo/G+BNRU
	 bYSS8xXb1Wd+AV9qG+lwHNV7/76ViW7Rv2blV9B/y65FO7aALNwOpjyhoQGGBWAU1A
	 6bY99fKhYFgu9j0+EpghHg6C65lW49kXBdL99/rBlFbt+uWMfgWV+EkZUGfMeXRyxp
	 DIG1GOx19WXkgxkByl/55gAln9jT6ZfZ8hSKhaZLOFMHUN7eXELu3ZcqEAbRb4/th/
	 oNwmTSH9mUC9EBpPhhREzy+tZ8YqYfyfWe9Y5SAHeB2OfkU1GWdlD8iwWCcIvTSQ4n
	 R7651XcpGieJTX14AD1NOnqUYlBJL5XXou1C0779UkTkP9mcaJetox5jhsmRzwRgmF
	 jNo2aW2Y6mJfmfuM4CkoYdpN9Zg7gFOIf5MdPUuTp7U1TWrXf4ffgujgpW2qHkz45L
	 Q39kOk2H6+I0IPMAKuiHR2nss+ptnn5FH0qsr4kRYjbGRbMx9NQO8Cjp+Hu/m67MK3
	 FUoJ0rDRscg4WLZgFbcH4CUW6wRIqa4uebUY88NmGY03UFfUcSgc5iOGAHphRVkk1X
	 XIky+ETWYnYmfK5asHl16ZQE=
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexander Atanasov <alex@zazolabs.com>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ublk: mark each test start and end time in dmesg
Date: Mon, 26 Jan 2026 11:25:44 +0000
Message-ID: <20260126112544.1811817-2-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Log test start and end time in dmesg, so generated log messages
during the test run can be linked to specific test from the test
suite.

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/test_common.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index ab1ea5cc904a..5865f1e640ce 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -122,6 +122,7 @@ _prep_test() {
 	modprobe ublk_drv > /dev/null 2>&1
 	UBLK_TMP=$(mktemp $TMPDIR/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
+	echo "ublk selftest: $TID starting at $(date --iso-8601=sec)" | tee /dev/kmsg
 }
 
 _remove_test_files()
@@ -166,6 +167,7 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 
 	_remove_files
+	echo "ublk selftest: $TID done at $(date --iso-8601=sec)" | tee /dev/kmsg
 }
 
 _have_feature()
-- 
2.43.0

