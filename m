Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB4285077
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060373; cv=none; b=Fu68faNe3wqntXYqjPg35jnthRIhUeLYdEUkqXHD9Q6DWF5EIcBX+zE6SczAPw8QjPUNswhoCClWw7q8AIslYATPk6S2s+ZmA4KUHAlJbvhqF1d9X+I4EF9axg8Es6RqbXxpgQjY4f4xvllQL44aO2qLrTwYC15CkpNPepqStcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060373; c=relaxed/simple;
	bh=0T3RfCRDcnpozJXeQUuhKRw9ET2REuSg2YGW2FlpbJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mWO3xZQiRrBN888u3WMfZR3MYlog9wM2wky/wHPQtcIRKlPCmcdXrCTKfd03ApsJc6G0czmxx50Td5DpatEKO3KV6d8txoKgXu0mcV4tthw+fifxNyelT6PcE/RK2fX2SkVJ6xfhAaGtNgyCMrhJxkAqfNqiXa1tJJ/Iqdqj11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A8q7tEap; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A8q7tEap"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-544ad727e87so4261005e0c.2
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyhEptnkjYKvTtDaCmbO0qvaJj1u/0HzrshZ6BHXL2g=;
        b=A8q7tEapTkZQ1Ew071AOO8E5XBAjEx6WJ2lhrI3lsktwlpFOlHH8CnF6+F+xVWW/hU
         SD572Aw2BbHYlzptdVQd0ml3K3/+1QGxCcqtworHLXCTPY9H6l4guQqRj6eTzuXD6gHC
         tQm3OR2zO1aZv/Y+Y7BAZNm9YzHq4K1BJmMx28IReb1hh2WFC5XHasrqXQRYzZVv3Ci2
         yqQCdZi461OAPBAovgoI5BeAy9AuyM+F5g5awD72cRive27GwUclALcV/kHUKDUtMR5d
         2iMos0p1GaGm0jvym6/aEShSvDQiG8H6QfYLqWZgnGRij6MXssJb99y3aUS3II4I2fcG
         KAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyhEptnkjYKvTtDaCmbO0qvaJj1u/0HzrshZ6BHXL2g=;
        b=ZxWGsgkQO4XRDIWUpyTghr7JfABmqWZWVpFazzi6Ygbo76PgBCDdiTHUB4n1ipYIq4
         B8kbz9a3+jSRyJ18o8fTFrqhd3Ov6B6JoQcb+EMYlQrIM0szKPG4tvA8xxLH9U5+e3ZY
         OLa73AfM70BWK51AWMKQNM8bxb5g+c4xnbZ6c82dXFWfbIs2Sj1/Cb5p5tKgGu5h9u1f
         Q64MXmoMFPfyIIOZKExVdlppmJ/lEHihO+KyRDUCLOiMltTZSS0KSN6Jq8imErebUE2D
         tchanhTDpVEUL/pLzir19VjpC83trEvdrouzMKxpUlp+o89iZltdoF26K62AcoUtD5Qn
         8UVg==
X-Gm-Message-State: AOJu0YyIKjSBesFr/Tchor4RNf887xanE0OO0quA+kmvsQ3y4hsyjnwZ
	z2Y7tUKCOc0HzKSH8lBHuHIxCCPEMNG18zK5YKMYn5ux4E85k4li2uC7ohM/NBWPhN60SHqeIAT
	2fKfJJFTZF2Rj1H+8VjV8IjvfA5SDGaXPt2KT
X-Gm-Gg: ASbGncvi8TmCycTbXB4iuOkaXnLmNCCTcBk98ypQCRsvij8WFrm3pN2jiyF0/m2UCRK
	O/Ir7aM2Ij2bFWXexHI4urDIpYbpYqJA5DQlOa02y8XQDj1m0zDB4Qshn3vD4/kSV/WWrVudMu9
	zCZuLa6IPHxJ/17JmeBeZT5MvtD5IKX+b8ZepZRQwIFEN9wGwkHaBwGSuwR7vU3mSpdyM1wcwZM
	g1mGiMmGJyi+Dw0aArFbxgBRP0OZtiEPnIddP+oB3exZlOLIiQk4oacRhnEiBlHFhjYexltbTIQ
	/QrDaHr11AL8B1aFtCPyB7oYb/tJ+Pip504gSapyHkIjwTmMKh38Pjvbz5WkO+tC0KhC3yApCg=
	=
X-Google-Smtp-Source: AGHT+IEzFWi2OlWmB6cbeEaJlNpwq3SZVqUGZX2zuzQBFkjFOWfMIWTfg3D9KsLmzXHUiHz5L79IAjQs2mnu
X-Received: by 2002:a05:6122:1795:b0:540:68c4:81a2 with SMTP id 71dfb90a1353d-54a60b8b059mr36111e0c.14.1758060369613;
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-54a0d1b95a0sm1704081e0c.2.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C61A4340853;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B6B3FE41646; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/3] selftests: ublk: kublk: fix feature list
Date: Tue, 16 Sep 2025 16:05:54 -0600
Message-Id: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAELfyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3dKknOz4tNTEktKi1GJdA/PENJNUYyPDVNNEJaCegqLUtMwKsHn
 RsbW1ANaEpHJfAAAA
X-Change-ID: 20250916-ublk_features-07af4e321e5a
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch simplifies kublk's implementation of the feature list
command, fixes a bug where a feature was missing, and adds a test to
ensure that similar bugs do not happen in the future.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (3):
      selftests: ublk: kublk: simplify feat_map definition
      selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
      selftests: ublk: add test to verify that feat_map is complete

 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            | 32 +++++++++++++------------
 tools/testing/selftests/ublk/test_generic_13.sh | 16 +++++++++++++
 3 files changed, 34 insertions(+), 15 deletions(-)
---
base-commit: da7b97ba0d219a14a83e9cc93f98b53939f12944
change-id: 20250916-ublk_features-07af4e321e5a

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

