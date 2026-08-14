Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733F3D9DB3
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674838; cv=none; b=hxsYmWSSyuVsh/BJRRHZzzRZdpETBydhTA0aQmkxcSKQFMRBvvdEpqw1kHGrm35a+2y7sC3hy25rm7rtjwk6BUoeHmqs0FQalZJPZTNMSZEdl/gG2Ki0GoA+eJ2jM+sG4B+1sRQPLikHMJUo0gmBYI1niHkGXnNWU1Wr7NThEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674838; c=relaxed/simple;
	bh=KcjYqoxvhR9SB2KHGqQZ/60bquFYE/8tIO9ddFG6ges=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGFBZR1n5gijOKPEJFjX4xpfJeVasbu0WvVxje4pdVnNL6eb2H8dl8mFd/pUuIYnjmtiyf+Z8LRaoLUHrKvG1jjawxTy/rB8iPn87mAsX+O/H50yuvEc4lFf3C3jYFMM4qYuSOOypIUFXzAwX6Y1CJQA1IPl7tFLJmfQ6hfh2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 938fa272978811f1aa26b74ffac11d73-20260814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a5c308bf-6e5b-4986-bfd2-bd389bf40f40,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:a5c308bf-6e5b-4986-bfd2-bd389bf40f40,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:72d41024ac79581fa7ca87f7c0711e4e,BulkI
	D:260814103349A3KX98OQ,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 938fa272978811f1aa26b74ffac11d73-20260814
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1174821598; Fri, 14 Aug 2026 10:33:47 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v1 3/3] selftests: ublk: add SET_PARAMS validation test
Date: Fri, 14 Aug 2026 10:32:26 +0800
Message-Id: <20260814023226.354288-4-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814023226.354288-1-sangyao@kylinos.cn>
References: <20260814023226.354288-1-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test_params_01.sh for SET_PARAMS. The test checks valid basic
parameters and several invalid parameter cases.

Also cover zoned parameters, including a non-power-of-2 zone size. This
case must fail in SET_PARAMS instead of being accepted and rejected later
when the device is started.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 tools/testing/selftests/ublk/Makefile         |   2 +
 .../testing/selftests/ublk/test_params_01.sh  | 114 ++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_params_01.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index a3cec7b35db7..5daf36c6c36c 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -55,6 +55,8 @@ TEST_PROGS += test_stripe_06.sh
 TEST_PROGS += test_part_01.sh
 TEST_PROGS += test_part_02.sh
 
+TEST_PROGS += test_params_01.sh
+
 TEST_PROGS += test_shmemzc_01.sh
 TEST_PROGS += test_shmemzc_02.sh
 TEST_PROGS += test_shmemzc_03.sh
diff --git a/tools/testing/selftests/ublk/test_params_01.sh b/tools/testing/selftests/ublk/test_params_01.sh
new file mode 100755
index 000000000000..928e72b1035d
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_params_01.sh
@@ -0,0 +1,114 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+run_set_params_success()
+{
+	local name=$1
+
+	shift
+
+	echo "$name"
+	if ! "$UBLK_PROG" set_params -q 1 -d 2 "$@"; then
+		echo "$name: SET_PARAMS check failed"
+		return 1
+	fi
+}
+
+run_set_params_failure()
+{
+	local name=$1
+
+	shift
+
+	echo "$name"
+	if "$UBLK_PROG" set_params -q 1 -d 2 "$@"; then
+		echo "$name: SET_PARAMS succeeded unexpectedly"
+		return 1
+	fi
+}
+
+run_zoned_set_params_success()
+{
+	local name=$1
+
+	shift
+
+	echo "$name"
+	if ! "$UBLK_PROG" set_params -q 1 -d 2 -u --zoned "$@"; then
+		echo "$name: SET_PARAMS check failed"
+		return 1
+	fi
+}
+
+run_zoned_set_params_failure()
+{
+	local name=$1
+
+	shift
+
+	echo "$name"
+	if "$UBLK_PROG" set_params -q 1 -d 2 -u --zoned "$@"; then
+		echo "$name: SET_PARAMS succeeded unexpectedly"
+		return 1
+	fi
+}
+
+_prep_test "params" "SET_PARAMS validation"
+
+if [ ! -c /dev/ublk-control ]; then
+	_cleanup_test
+	_show_result $TID $UBLK_SKIP_CODE
+fi
+
+run_set_params_success "valid basic params" ||
+	ERR_CODE=1
+
+run_set_params_failure "missing basic params" \
+	--param_types none ||
+	ERR_CODE=1
+
+run_set_params_failure "logical block larger than physical block" \
+	--logical_bs_shift 12 --physical_bs_shift 9 ||
+	ERR_CODE=1
+
+run_set_params_failure "too large max sectors" \
+	--max_sectors 2049 ||
+	ERR_CODE=1
+
+if _have_feature "ZONED" && _have_feature "USER_COPY"; then
+	run_zoned_set_params_success "valid zoned params" \
+		--param_types basic,zoned ||
+		ERR_CODE=1
+
+	run_zoned_set_params_failure "missing zoned params" ||
+		ERR_CODE=1
+
+	run_zoned_set_params_failure "non-power-of-2 zone size" \
+		--param_types basic,zoned \
+		--chunk_sectors 96 --dev_sectors $((96 * 16)) ||
+		ERR_CODE=1
+
+	run_zoned_set_params_failure "zero max zone append" \
+		--param_types basic,zoned \
+		--max_zone_append_sectors 0 ||
+		ERR_CODE=1
+
+	run_zoned_set_params_failure "too many open zones" \
+		--param_types basic,zoned \
+		--dev_sectors $((128 * 4)) --max_open_zones 5 ||
+		ERR_CODE=1
+
+	run_zoned_set_params_failure "too many active zones" \
+		--param_types basic,zoned \
+		--dev_sectors $((128 * 4)) --max_active_zones 5 ||
+		ERR_CODE=1
+else
+	echo "zoned ublk feature unavailable, skip zoned SET_PARAMS cases"
+fi
+
+_cleanup_test
+_show_result $TID $ERR_CODE
-- 
2.25.1

