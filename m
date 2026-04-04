Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6029993D
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775273040; cv=none; b=Y9sh5H53FJK7DnZP2Jv0cjcCkCD12qjmof/icuH1DLY4XOg3RXwGRDpixSihMopXpaY/3QMKwL6yv3X0bLxRZY+939gl5yqBaTEd8dBUd/fXeZyt+/i7XmXT5+wg3B1UKgbBpt68ZUDM5AvAZQabLy2V3z0ekVx05K2iJbHK+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775273040; c=relaxed/simple;
	bh=Qa67TNFCcOH4tBu5F084Y1/qAc7QBNf2XwPUgfimvlA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KMT+fVPCRtLSul5bg1pJxEGEJDuO2oRMYZIi7cULcCJXFxm89uo4BUcP6ZYWoJBTFqQMK3jqtKXMvKDff011LjH6YfhuEx53ZmYqK5PGsLXJmvrgGCckVOMX6laiHdsOtxkkKMxolwfhYPOen6epsbNzhTkyvMEhlr57oOr5Ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QxGo4Q6I; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QxGo4Q6I"
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50697d6a69cso14232631cf.2
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775273037; x=1775877837; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLT8JtQvCSx0sAb011tcnSbwaL8+sDojsYJGa3R1ebY=;
        b=QxGo4Q6IVMsEvW5cIdcsza7dk0hZRQhfKPYEmHB7pwM4nFWEwhLmd3PnE92Hp8fRMc
         wwm/cdtmvKJI+jFa0iwoWkdIuPazkWilRRwN/t3gGaHUgzzv6zMep5kGCRchImHcuFda
         UsTpsutR3SyOpgVpvGeUsKhfxKBgYdAXHTNI0ce9YscB3ucdZTclPbQPELm3aJSkhA7N
         n5EPZU5iBYvuxZ6oymKlB0DWQ5X/nxLDKaI+vCYSmea4G87/3Da2ruVsygAYQ5xm/7ye
         5SWv5JnJKT3M6aaN7eVvInFqO0PNDOfRi5Vh1pgYxvEa3w2ioYw4AVuNvUcMXYfTxJR3
         0j+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775273037; x=1775877837;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLT8JtQvCSx0sAb011tcnSbwaL8+sDojsYJGa3R1ebY=;
        b=BkVs6+knxD6fs0iJJMyDj0MJnbGj9lh/JhsvJjTk1APyOBH5r1222Y71DsmdDleuKX
         XcmXyLOQRAjTYuR8wGwVK+w1s8M2ubTDu12gGrqIRh6KJJbXZKAKhhs/d7iCL8sdo53W
         hkAwBF9FJEH02hVMat75R5T/jkJ6Q1+MCTibTOdJAaoUpvcdWzCIZXRTUGcnDBAOuerz
         kFsoTOB7PB/z+z/Y53gGRODivPknBlTKXrstqikhsuCkBfEcNDNcTYTGmMOGpdKl0/lb
         l5mmYDwtwu1Sa/aWJDKZ1baPrF8J11T7SFpBwyoEEywyTnR+uxmZ6c++v/V08aGI+Lio
         V2lg==
X-Gm-Message-State: AOJu0Yx85hsi7U6iE+r9skwnTVVV3GU6XZSVK+sE+dUGNd7iqVahQt2F
	b1pcZFiEKzzfvZXPLLKCpwaQ1r+NOSBFsSuLcBim4Jtb7hLAKSOZnyLjF+ClyI2L+0SU8PsYXQQ
	ZL2Da+mAWPqHMMmyL+nwpLO8keGgGwbddLfRq3iFvLEiOOAZJ8pHZ
X-Gm-Gg: AeBDievMUu+XzLt50oee+18QOVcxHOnJTdG2zQiaKfLeUOcEmcc3erbjOwUlZSriklX
	MVZ9suKNMRftDwogPJZ8vn7sIeZhVcsBmRbkGzYzAeYPZiPM34VOi3uHpMf3gLHxlCyV/78AL1h
	rbI3XnNaYdvxTZfmm/gCan9Vq+DL2UWQD+7Ud8zAIFiQOeta4SggzjJ0ef49igzWKkPnSakAoW4
	ivJ5acFJyRZMWwelCx9HDhzBHDKS3XZmBhQ7x32lycHlGkfv+jevewiozvFJYFcWBd0rMBhdbZV
	s//k7S8DSP9bxUWUjsIrhGDyPqGtvHmOlg0yvHU9djTOT3bPERc3dYXdJX9f1pXrtDc7fTOC//U
	lzM646+dUfSPo9KkULiz5ctQswoF921Da0IDdk6AM
X-Received: by 2002:ac8:57d5:0:b0:509:3025:ff59 with SMTP id d75a77b69052e-50d629c83femr78341571cf.20.1775273037465;
        Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50d4b9939c4sm4583371cf.22.2026.04.03.20.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::2c94])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9CA8734023F;
	Fri,  3 Apr 2026 21:23:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B7001E54F59; Fri,  3 Apr 2026 21:23:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/2] ublk: fix infinite loop in ublk server teardown
Date: Fri, 03 Apr 2026 21:23:54 -0600
Message-Id: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqE0GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNj3eTEvOTUHN2kJLNEQyNLI1Njk2QloOKCotS0zAqwQdGxtbUAilB
 TPFgAAAA=
X-Change-ID: 20260403-cancel-bb6a1292534c
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Fix an infinite loop in ublk server teardown which can arise when a ublk
server dies while recovering a device. Also add a test which
demonstrates the problem and verifies the fix.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      ublk: reset per-IO canceled flag on each fetch
      selftests: ublk: test that teardown after incomplete recovery completes

 drivers/block/ublk_drv.c                        | 21 ++++++----
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/fault_inject.c     | 51 +++++++++++++++++++++++--
 tools/testing/selftests/ublk/kublk.c            |  4 ++
 tools/testing/selftests/ublk/kublk.h            |  3 ++
 tools/testing/selftests/ublk/test_generic_17.sh | 35 +++++++++++++++++
 6 files changed, 104 insertions(+), 11 deletions(-)
---
base-commit: cdd71b7feb3674d14c5edd9c133242ddf9a363f2
change-id: 20260403-cancel-bb6a1292534c

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

