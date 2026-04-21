Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596613DDDC2
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802151; cv=none; b=vAlPer2Chr+3sp+iGOvv5WsfeVILwQqd9u29EXgYH/duxXCk6e9OuJOdWHZ1fNGiyXxzVmCGsQZLlezcpYG8m6qULl/4JZDvjIGGnk7lwJS2Svfg5ISE6ZA8nFz5YjymHsSs9IWWpb0ylMo8XB5o6SL8Wu6gNmJ0l8zV2HhWWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802151; c=relaxed/simple;
	bh=LjMorJ6vF8quAushze9k3CNaQKh5hY1aR3keeBr1Dcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMDm+Uy1p8g7bQJZOHeG+GFd4yEF55SaF1vLfwqLZ8f1/BVTe1pXO9QebMyFDUZAuWYhlCcPJ210LngHPuF0aPhMHC+eoPX+sDZ8OVAhyakF7vm1r69wUER5RAwNuFW2Ho7FWzMQndKf8tS4rUEqYju2umnxW9wyrTWqY//PS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S42DLqwI; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S42DLqwI"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-41574fa6a87so546145fac.3
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776802146; x=1777406946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UR844bpygXZBYChnXrR6i7D8NGvSxmnDO/I//llhVrM=;
        b=S42DLqwIkwus1hreF24/aEivbgQYW+1i2gQx2c6KGWWhn5jiyWmcyLOac6DGLhIY8x
         2o2d7D9rXKMcLvgVgPyGhqK7d/zRlA2OM+qBTG7XYZE3tGoV1Oct2agFepEFJXVWNJnx
         YGx9GzwyhuYK0crLOZixF42Rr6zUrsUh1DvbXbDpd3eLuBFhOMaE4bvjYHg25lC/HJI3
         FJXg7xI3i4olFMBpMETwKAiRiPGnGx7hZN+BtmoP8zKmrg7d8TIqOZJokMDLVU4VSrxc
         mKONqr5am+hY9qRBNugID1TjDnwMsiaweruSjtd6mC5NDEMuZtyVp4e+au8rPV0Us3ik
         Fotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802146; x=1777406946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UR844bpygXZBYChnXrR6i7D8NGvSxmnDO/I//llhVrM=;
        b=BsCP8Lj2QvrA4hlh9yyyrsLzkQhpCVzh2hnwXM+EO43QKqts6tw0hg9J1L5cnBRnFc
         ZX/kNsUV73C2WT84bot2LG2UM60Nkd26AELYEmOK8Y0iwNqDfn8P88/KyvS4KPuRnswq
         oPCkS2TJaF2UB2eKUc0yuBTPeuNtFMpVBuFKRMr43IsTKjts/zj/ewaL9sqj6gEBtRk2
         4zutKeN7EK3+EvjMTEBzbxxdXvZ/VNJ/qCsXADHTftcDH8UFb5XwTR28SLJvCtRDmPUV
         aWuynbZqQ3jmoNCHRjfPVLpQ2YJNivNxfnRhtfvEFWXszr/BiUzomIAVmlX9UeN+xrDS
         OMZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CLR59NwkeECN2aFZv0xZgJzH7iWY79Zhd+y+0uCC/aNUe27vmjTRk4r20TrkZcphDq1i4q02Gy2qmgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVts9LqQ1ghpsBbUPk8Zr4t8f53BP4OXLlq13FxDx9TsD+3Yi
	YBN/7AgUcNzme8AhY3uwCeQlHC3PHL7CxNPGX7Io2KI0vxKoeDQqukojP6Fne2PA6M+wQm/XHop
	APUjUyXmk++P+KrATS0qqPUfLpR3rkhUfpVCQgdDc4AtAo8cogOx3
X-Gm-Gg: AeBDieszvLJb/TAond/ltS2q/VGrzOjpNk1Z8zhfWEX1QRDq9rDygrsVe0fO9uiNZgP
	hJVv8HwNSRW/g0QaleazlBbtQCf6jKxmEPNxxW4/iHvQD3kJ+19IGhJPLEG2ZN/CX3MIV8c5xmM
	GMdWa6SIJwGAkjbWBoSi7SE1f/lbEWnwG/WMPvzJ16csq+WeAnd3qOTsE9FgIwD9Lk/fYg55/4k
	yCdN7rbnvKQ1Oki88rXlH4ixc5Hb//DWGPE2LITArzmTsb3mZh4gcRvtkNdDxrw+zkeOTHDqA6x
	zqMXf4e1HkkujRBh4IrO62SVAxS0K6cchBSkaqdb0pQ7oxX5V9lCBd2WZdz1MGzWn79Ed/ALjLd
	HEzBWw11XGcdH8ddwL6CXTHgMCIuNSbER2AqRWAvlZCH1329o1w==
X-Received: by 2002:a05:6830:4493:b0:7d8:9844:b8d2 with SMTP id 46e09a7af769-7dc951b74cbmr7466806a34.4.1776802145912;
        Tue, 21 Apr 2026 13:09:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7dcc327622esm462221a34.4.2026.04.21.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:09:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 850C23407AD;
	Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 801E6E41A9F; Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] selftests: ublk: enable test_integrity_02.sh on fio 3.42
Date: Tue, 21 Apr 2026 14:09:00 -0600
Message-ID: <20260421200901.1528842-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260421200901.1528842-1-csander@purestorage.com>
References: <20260421200901.1528842-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fio 3.42 was released with the needed fix for test_integrity_02.sh.
Allow 3.42 and newer in the fio version check.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/test_integrity_02.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_integrity_02.sh b/tools/testing/selftests/ublk/test_integrity_02.sh
index aaf1f52da559..2c35fbc8a7cc 100755
--- a/tools/testing/selftests/ublk/test_integrity_02.sh
+++ b/tools/testing/selftests/ublk/test_integrity_02.sh
@@ -5,13 +5,14 @@
 
 if ! _have_program fio; then
 	exit $UBLK_SKIP_CODE
 fi
 
+min_fio_version=fio-3.42
 fio_version=$(fio --version)
-if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
-	echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
+if ! sort --version-sort --check=quiet <(printf "%s\n%s\n" "$min_fio_version" "$fio_version"); then
+	echo "Requires fio version with https://github.com/axboe/fio/pull/1992"
 	exit $UBLK_SKIP_CODE
 fi
 
 ERR_CODE=0
 
-- 
2.45.2

