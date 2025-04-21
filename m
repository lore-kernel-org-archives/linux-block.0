Received: from mail-pj1-f104.google.com (mail-pj1-f104.google.com [209.85.216.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385B1E51E3
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279205; cv=none; b=CMuSyxnDC850hYlv0nG7OpbiNpycojV5QrMZTfkeTSiz4DL16UJ0tWe7gQ7ut0lKPH53J+dZ47Iu66CBZ/4oPV6EhUOzlWeEnMkh2bGB/EHfL+Z+Z8rGZAX+oO8d2uMeI7FV8lYodciQuWrS7Azt0TRvYhcLKr4GDLj/2VTCu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279205; c=relaxed/simple;
	bh=MgZlolvtjiXQgwF7T8ugwhe+ecGe6HjkZ/Z4cLljf0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UkL7DE0+nZKEGNMdIxDzs9A6bHBT5Q0lVSSBo+ZNZvcZq0VXRC4YzxALV4SlkGhfmgvm9BgdAUjjgAZEv9lEjjBor7upJ6jVBZbwDV05O4e8hWR/Hnxt/TW8os7lF2kjngoBAWSpeH6Z5FFfOGWrVm5+duYIXomR28Inz74wpjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dmE+0fG8; arc=none smtp.client-ip=209.85.216.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dmE+0fG8"
Received: by mail-pj1-f104.google.com with SMTP id 98e67ed59e1d1-30863b48553so4732706a91.0
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745279202; x=1745884002; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTxwRN46KxmBWYrElcrYvw4CJWFiySXxgp0fC8wvHYQ=;
        b=dmE+0fG8Umu7oOMaqaDc+fhyyrd6/CxYzo76k4ezgdrPx8HX4zniM6EFiSuZIOrUvM
         kn7flimx8cV5i/QJEutxqh4nCTFxZy5erG5ffYqgi07XfmU6bob4/BWhIUrtd358KWhm
         QpkCjC8Q+HxeveRqjq0KBGolcq8kwHi13OwcyXUXeVYrBh2ADOhfeDwDBQ96TphiqV2j
         iqIgL5FhLIwubUqRCyJDpQSa7TJxhylOKEAzrmVEq5AozkJja3i3Xbu3Tjs8RZ77Q4P7
         mvSwyHw43UfnbIzua9ibzLx5HFMEg40xpRQUmqlqqJe1k4xOeARgmgOEXXZNioOUXFI9
         Qfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745279202; x=1745884002;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTxwRN46KxmBWYrElcrYvw4CJWFiySXxgp0fC8wvHYQ=;
        b=kKBXc7v7my8Z6brzRzu5xuJfeSaEtx2mqYok+O8BJhkPyAJDnSFZCxCYU97jLUsTcm
         GcXcdkBhCM/JqLEbX8PGRpMh8BRUNZT4cNxuV+FP7/Q23BPjlwiaYl/LhiX3z7EkCjAK
         MnY7/cmtA2awgmEVucdBuH14RXN2YgiShonqMoZFZWv/+imoSEvitshWeeaShX3g7Bjf
         U2/adegN6YIOPdHaW6vGzssknHJmfumWOMP8/togoNX9r3xOcjRzgIdUf0DVzRsBVMpB
         Jtxm7rzlueLMMPUDaanP95SykYjnq3Th/4sJb98dCa49YHsTBp+TaBWS9KfanDkd4q06
         3XFg==
X-Gm-Message-State: AOJu0Ywi/RwZ9tm7lorfNEg/fDIsdi4ddlj72tl6WmOJoEERXXCYR1cG
	fFnqlOSKxHXiTf2za6BuzYThsq1h83fhDMa0YuO8AZb6sHOfAeU5xqvDvURSG8ncjz4STJ6hxfG
	xryvmc0Ew6GBs4DKE7YVSAexXrpO1q2AfhGokcBNaNFk8M82X
X-Gm-Gg: ASbGnct1Z/VNmvEj89VvBrenQXHPaf+cGPRq7Rxh6CELML7OP0YiP+RJJ+3P59wDtsk
	70VU9YpEDRkzLWcuqShTFOZk5IBO/AKe/iIltpxZIWDN66eZSqRwqwkVhOGzkPPJrkKgrXKYuav
	Os5M17YAVpO75p6dcK8Xrvko0oTMmzoMJ4Fubc5e00r2Dk7TRPxOCw+lxxK6AfN9QWaFHCybhIC
	GyxoEdv0cws1FaxcckNWg02m2I4S0i5njJJUqjaYnxYlNIqkJGDILI9Bj4FiVPV+XM2smMv
X-Google-Smtp-Source: AGHT+IG5VlJ1RIxmxTNJQSsKgUu08tRnQu4AxwH+uNxOrySYInQwR2aUQ0baLfIWdUvV8P/PJ+ZEdv6C/VZb
X-Received: by 2002:a17:90b:2705:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-3087c2ca65fmr21290540a91.8.1745279201745;
        Mon, 21 Apr 2025 16:46:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3087e05ee89sm512928a91.15.2025.04.21.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 16:46:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E2FEC3403C6;
	Mon, 21 Apr 2025 17:46:40 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id D7462E4055F; Mon, 21 Apr 2025 17:46:40 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/4] ublk: refactor __ublk_ch_uring_cmd
Date: Mon, 21 Apr 2025 17:46:39 -0600
Message-Id: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/YBmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyND3dKknOz45Py84pLMtEpdY+PUVMNEMxMLs8RkJaCegqLUtMwKsHn
 RsbW1AA0uycxfAAAA
X-Change-ID: 20250421-ublk_constify-33ee1a6486ac
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Refactor __ublk_ch_uring_cmd to:

- Have one function per operation instead of handling operations
  directly in the switch statement.
- Mark most ublk_queue pointers as const. Given efforts to allow
  concurrent operations on one ublk_queue [1], it is important that
  ublk_queue be read-only (or accesses to it be properly synchronized)
  to avoid data races.

This series is split off from [1]. No functional changes are expected.

[1] https://lore.kernel.org/linux-block/20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com/

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (4):
      ublk: factor out ublk_commit_and_fetch
      ublk: mark ublk_queue as const for ublk_register_io_buf
      ublk: factor out ublk_get_data
      ublk: factor out error handling in __ublk_ch_uring_cmd

 drivers/block/ublk_drv.c | 133 +++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 68 deletions(-)
---
base-commit: edbaa72ba1bd21040df81f7c63851093264c7955
change-id: 20250421-ublk_constify-33ee1a6486ac

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

