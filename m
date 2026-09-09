Received: from sender-op-o11.zoho.com.au (sender-op-o11.zoho.com.au [103.138.129.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38651548557
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.138.129.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960637; cv=pass; b=kor2umJx+SOEVAUpPpkF+NoTKbk3fzU92Ve8YDEcwdRuGTBaP/BidGdcIfevJxtJ/wmsAFSKyUg7sq/8YujZQJ4fNqoywJYS2CECKIn2DmM9sOq3wbO32x2dOWvtRYpUyLglh8bT0fDLoq3j+9fo8ch2LTNZ29dvjjDkeKjsB/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960637; c=relaxed/simple;
	bh=wnIEckzl3YvU4zGMWKoUpd2EuG7T5k1v1Z3UfykwPCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/1EtViWh+05XbvN9e8kjyKPkmQCAmTum+cs4cshLRWQFJG/jk09srhZg6AhFRHzFQ/kUw9LB74pqVTytpf/2zGYP8exclTd+hiHH7wgSZLIgPPlvkCnmdo906dt4U9rdpW7AL1pPdoaCti3tqjgedT897aWmXBuZTRDgZL4y50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scstudios.tech; spf=pass smtp.mailfrom=scstudios.tech; dkim=pass (1024-bit key) header.d=scstudios.tech header.i=@scstudios.tech header.b=fXldWyLY; arc=pass smtp.client-ip=103.138.129.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scstudios.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scstudios.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=scstudios.tech header.i=@scstudios.tech header.b="fXldWyLY"
ARC-Seal: i=1; a=rsa-sha256; t=1788960608; cv=none; 
	d=zohomail.com.au; s=zohoarc; 
	b=TSSG245HajykYkpKVkM9jPZKMmricLkUOv1StstJiFeV2rG2qESb7jFzTaU6VuJWtjJpPDW5U2AExnwGayUQkxdrKa8XjKR8Xg94426NGzZc4DO20egabum39FsouoUfZfku9DaIVaHnG0qIr6GjNQ2Or26VESrElV/RwYaFdRk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com.au; s=zohoarc; 
	t=1788960608; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DdcpC3W0BLcMSiBBq4v/ocnr5yVvMkT4UHv097w6Q2c=; 
	b=0j9VqxIH/Ro2BFnW6rY7Qg8ULkEf+UorIljdKobV0VxWYsydF3VjhqkZeZxbjYWoNXfKPNnzv6YXXWPHppLuwbGDij2vIIrorAatrLIYOA5H5zElVIQnyRhi4g6KKIgkeUMd2XawRPToMPpnAAuTGYRrg5XzT+8bmUu+3yBvNfA=
ARC-Authentication-Results: i=1; mx.zohomail.com.au;
	dkim=pass  header.i=scstudios.tech;
	spf=pass  smtp.mailfrom=ruben@scstudios.tech;
	dmarc=pass header.from=<ruben@scstudios.tech>
DKIM-Signature: a=rsa-sha256; b=fXldWyLYPSSZtr5ZafQ01xv7KUHV6v8qDszaWkxqUI8yDDg7tumcuj0+gcan8xe7dcMgINqpUdQPYvNcvK6K+MfwmYGetaszUyZny+2QZJLbpwDckpnfJNwCXBOioXKkeJF9YF5DIhjAWQc1PV22veGVK/2TQyMw9BajNtHUzEc=; c=relaxed/relaxed; s=zmail; d=scstudios.tech; v=1; bh=DdcpC3W0BLcMSiBBq4v/ocnr5yVvMkT4UHv097w6Q2c=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Feedback-ID:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by mx.zoho.com.au with SMTPS id 1788960606940529.3280510955219;
	Wed, 9 Sep 2026 23:30:06 +1000 (AEST)
From: Ruben Sutton <ruben@scstudios.tech>
To: Ming Lei <tom.leiming@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruben Sutton <ruben@scstudios.tech>
Subject: [PATCH] selftests: ublk: Reject excess backing files
Date: Wed,  9 Sep 2026 23:24:12 +1000
Message-ID: <20260909132412.8965-1-ruben@scstudios.tech>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

kublk stores at most MAX_BACK_FILES backing file arguments. The
argument parser currently stops collecting paths when that limit is
reached and silently ignores any remaining paths.

Reject the command instead so that a test cannot accidentally run with
fewer backing files than requested. Add a regression test that exercises
the error without requiring a ublk device.

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Assisted-by: LLM
Signed-off-by: Ruben Sutton <ruben@scstudios.tech>
---
 tools/testing/selftests/ublk/Makefile       |  4 +++-
 tools/testing/selftests/ublk/kublk.c        |  5 +++++
 tools/testing/selftests/ublk/test_cli_01.sh | 15 +++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_cli_01.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5daf36c6c3..28ce542d4e 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -7,7 +7,9 @@ endif
 
 LDLIBS += -lpthread -lm -luring
 
-TEST_PROGS := test_generic_02.sh
+TEST_PROGS := test_cli_01.sh
+
+TEST_PROGS += test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
 TEST_PROGS += test_generic_06.sh
 TEST_PROGS += test_generic_07.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2400b46157..3af2f10ca8 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -2525,6 +2525,11 @@ int main(int argc, char *argv[])
 	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
 		ctx.files[ctx.nr_files++] = argv[i++];
 	}
+	if (i < argc) {
+		fprintf(stderr, "too many backing files (maximum is %d)\n",
+			MAX_BACK_FILES);
+		return -EINVAL;
+	}
 
 	ops = ublk_find_tgt(ctx.tgt_type);
 	if (ops && ops->parse_cmd_line) {
diff --git a/tools/testing/selftests/ublk/test_cli_01.sh b/tools/testing/selftests/ublk/test_cli_01.sh
new file mode 100755
index 0000000000..e937b8e20b
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_cli_01.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+UBLK_PROG="$(dirname "$0")/kublk"
+expected="too many backing files (maximum is 4)"
+
+if output=$("${UBLK_PROG}" add -t stripe a b c d e 2>&1); then
+	echo "kublk accepted more than four backing files"
+	exit 1
+fi
+
+if [ "${output}" != "${expected}" ]; then
+	echo "unexpected error: ${output}"
+	exit 1
+fi

base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
-- 
2.54.0 (Apple Git-157)

