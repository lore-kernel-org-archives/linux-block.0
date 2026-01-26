Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9E22DFB8;
	Mon, 26 Jan 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437943; cv=none; b=XiLr1WPzwsKJLkTWcdnJdTAy4mIlYa3n6l/WybTSWH6egnSRY+PqHNUfR/p21il0jdM7yuujaYDuf8pp4cXFcLtCzFxsENJAPbcFMenErps5td6Plw0B3mhOLtTOCTMm0fw4qEQRT9YRAiTa1n50OWhADM8c3A5NEq3EJXO3mu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437943; c=relaxed/simple;
	bh=Lx6++P0Y08pAzledj4ODa0r7yp7FeyEzZvtm+oJhh68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOx6RuFMNy/13p0fIjEWIk1dfhO06bGFXlTvLPy44s4iA1xQjixnlr50RoyjBr43JwL76X6vCS/NhpG72x99maNakBVu86NuxM5SM7k4YhiWjy4DJ9vjuZMmw8sYASjv3lkHN15Ptbx5neJK2tjK/zCuNDpVyN+HBxjmkBoKr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=rszqdR+I; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="rszqdR+I"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769437937; bh=Lx6++P0Y08pAzledj4ODa0r7yp7FeyEzZvtm+oJhh68=;
	h=From:To:Cc:Subject;
	b=rszqdR+I+U+iBwmMvRXpqrjQk53QZiHZBvBcd2NwS6r+MYaLD5gkoUR5Z5wc87MLu
	 rPZ+98m6vuJhk4++oAmo+mxurRXKGV9MUGeCKWtwZCu/bEYwzAFiIj+gh5EVlfDas/
	 uYW0BexXSi8t5ubYfGpiKNitn9SsYw2lTpMYHc5qmKI//cEcnAn/VxlJLbvKVQTeQV
	 yv7DEWJZpC4klOR+dhQo+CUDrY+Sz3aME8O8ktdqKfRZjS6vYoovUIHkwCqDlraPj2
	 3VEhiPMhrKU7MNAuECKrEuw90s0aUGwmywzaPMadl8FumSjN1PoRvVa6biHa0jDji0
	 Zvbn0pJQv0PRXkpQpxbv60LF1fHMD97U49BWvd5q7kRmj+o0mZHfyD0Pfmly93TbZ4
	 3wfNVnh6gPJb2//VXZQCdxiTKXCQQa5fewacmUjwiwTP39787yYyWDylwFn1iUcuy6
	 tJlnXNoPhod4qRBLPv5ZnvY/VJlXZt/4jQ8ujiarbuNP7VCTOxAjNdNmuxuhj6e2c+
	 YQMclxk8+MVVzTg36H/RuBwtDkFCKxfKzttosX/F7UribPrZiX0ORb8L36OlNxsD5A
	 oxtcnuLP3ac3X6iI/7EutVs4QXPF2XrhS+VcDe/u4j2iUy3eXl8uae9NWHNFSrn6KN
	 M6WgV3H0RRg65eNmJnXIRjCs=
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexander Atanasov <alex@zazolabs.com>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: ublk: mark each test start and end time in dmesg
Date: Mon, 26 Jan 2026 14:31:57 +0000
Message-ID: <20260126143158.1830011-1-alex@zazolabs.com>
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

v1->v2:
  - rebase to latest block tree
  - include base-commit 

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 7ff6ce79d62c..e554e89e6e67 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -121,6 +121,7 @@ _prep_test() {
 	modprobe ublk_drv > /dev/null 2>&1
 	UBLK_TMP=$(mktemp ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
+	echo "ublk selftest: $TID starting at $(date --iso-8601=sec)" | tee /dev/kmsg
 }
 
 _remove_test_files()
@@ -165,6 +166,7 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 
 	_remove_files
+	echo "ublk selftest: $TID done at $(date --iso-8601=sec)" | tee /dev/kmsg
 }
 
 _have_feature()

base-commit: 8e5bcc3a955a2cc4460b391f55d3b49905eb248e
-- 
2.43.0

