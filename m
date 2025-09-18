Received: from mail-io1-f104.google.com (mail-io1-f104.google.com [209.85.166.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899CA2D8383
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224056; cv=none; b=YnyGlze5uDRU6dlczs0E9lFiz6tYJpY086KS5gAJTCbYt0b14Q9Q4Ovh2Y5QLicYwcQtrYgyRdAW93+PXhineP9Z7ktg0zTbfADwAj3RWAAzcY7Lznl9STvLDU2oYEOZPjeTtTD/zGJD9s88hA31qFLlRRLucZUeI7fSlTl7ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224056; c=relaxed/simple;
	bh=kqKHD5ehZXD1Rt9JUSSGS9cTnlizM80DHb0RRMG6eqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2Ah02pLq/QaUm7ewp9QQgK+8LUNBdWNDwwBy4vEwo9boHp9ojUEViWanjGq1r44jgyP7DBSSfIobNyrwY5CX8WxUbxmUVDL34zjMMpAeQmrnzCkFxfej7WWYyNIbDDIiiDGmQGmVRDRgqm8UqewB5UTePQTW9MIa50zQ6NkOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C8uDV37Y; arc=none smtp.client-ip=209.85.166.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C8uDV37Y"
Received: by mail-io1-f104.google.com with SMTP id ca18e2360f4ac-887764c2834so94677839f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qfla8bZUs3WSTY0zGPzDgRTSRNvs3BA8rlHoMH79c3A=;
        b=C8uDV37Y2VswDKnS+t0TMJnfJNOIvf6AItaCMVr71z8IBBquG2BS0qtyDwlCjK0t/u
         lvowz64VnudEGWKK39HAqnaI/IPXcbFLNLkEJE/qlF3CZlOS0MlevOADdQ1upRNMDptW
         naoqZMArCUlbqT8DLPqSS/Ni6ZobTPHAycmy5EY0CbNd77qRX5RCHE7z5nRvyvCQAR+s
         kgFvWM6dGnBwAg0DSfjX0/Y1aRAC3hPZYw/VzHNvluSBcf+HL/lBLI6qW4KPzyxEw7Su
         dxpmJN/PtM74hkj9TaxekQ0iBpZbMt5PpkbM2aWywxi31xrWqyf8aQ6ZVciCvtQGbFDN
         thzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfla8bZUs3WSTY0zGPzDgRTSRNvs3BA8rlHoMH79c3A=;
        b=PAfxT22vVSMuNwxYsaagX/zEQ7b+Rt4y9hPEi2H87etsGGN5+CLll4Qy9iMOygBcQM
         zyCI3K27ETBc1QB/VqjFlaaI+dSkmZOE3tnuejtfo32P3M4bCYEKDW+JaHb6ZA53+dDq
         zL0XRjPkqVKp2eZd7aqhpHFrxwi4niWAF+HKLNBwIyV0T16M4SxH1+IbUzMIctpIYg4/
         44+7VotdBjIx5dT/9SntPDvu7+LZjEJWXnkOvfCvW9nwY1/QsGfEFvq457PfmRBSuafS
         9zXU1M34YFp+gZ7Itoi1bPVEhsia0kWBiAanhOeB/65IZcSATrGYR8EDmpZ/kPH+KKf9
         +DQQ==
X-Gm-Message-State: AOJu0YxVun4wpRCc1rzWtgqxm5Qs13oQgiogTPhbhDrcd+e01a0d0bHZ
	Tpk0825oITLkDbl6shNZ/svti5kYxdZpBlhe1gcaSmkaoJ5+TCWWXE93ZtvKbWfXcWKuBXpEFXv
	S0X1H+WERStOtZSxMZ23l3/m6vSofLu0rzuCO
X-Gm-Gg: ASbGncvIuMqSH1EbeiiIiiSah//ta86wczteinc/YXZlVGceX7jBeJS1oSkJfqLfzWV
	tZ/kgbg07TbT3fe/aZ/eUFUmx6MSTnGsxU+hapkw92ndyY9VWm3nYW79nuGtF/K9nwdxw0M6wWH
	wixk7y8UceAVsTxLkclkjpoHAnX/UjbIPUBSNznZJNgHtzi8fi11n45rKCiH7m0QswLC3Ms1bZp
	tdTW8Jpr4GYUxVNRAbN6Y5v06W8oZRddueiaWi4LzrUjot68cqVt1z2yhV0WsynxpylDXOrWL/3
	sBp0L4Rnx8XX0fWhc/1rpHUP6kAWryDuJ0Tp7Lq/Ycg9xakG5NkgQoOovHsuJEamLCTqFyyV+Q=
	=
X-Google-Smtp-Source: AGHT+IElwU4J+0k5G0xjwarOPJhNJ8IHRnrr1sD6xBB+QeAq7JN53s/aglucgmQ+/5PoOoj3mnPaBPT+Q8cE
X-Received: by 2002:a05:6e02:2509:b0:410:f09a:28a6 with SMTP id e9e14a558f8ab-42481925dd8mr13628105ab.13.1758224052667;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4247353db28sm1480915ab.32.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 370BC34142D;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0F0EEE541CB; Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 18 Sep 2025 13:34:09 -0600
Subject: [PATCH v2 3/3] selftests: ublk: add test to verify that feat_map
 is complete
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Add a test that verifies that the currently running kernel does not
report support for any features that are unrecognized by kublk. This
should catch cases where features are added without updating kublk's
feat_map accordingly, which has happened multiple times in the past (see
[1], [2]).

Note that this new test may fail if the test suite is older than the
kernel, and the newer kernel contains a newly introduced feature. I
believe this is not a use case we currently care about - we only care
about newer test suites passing on older kernels.

[1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@purestorage.com/t/#u
[2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/test_generic_13.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..770269efe42ab460366485ccc80abfa145a0c57b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
+TEST_PROGS += test_generic_13.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
new file mode 100755
index 0000000000000000000000000000000000000000..b7aa90b1cb74615dd4727187a6a5aa9ed93088f7
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_13"
+ERR_CODE=0
+
+_prep_test "null" "check that feature list is complete"
+
+if ${UBLK_PROG} features | grep -q unknown; then
+        echo "# unknown feature detected!"
+        echo "# did you add a feature and forget to update feat_map in kublk?"
+        echo "# this failure is expected if running an older test suite against"
+        echo "# a newer kernel with new features added"
+        ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE

-- 
2.34.1

