Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECD2139BF
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881846; cv=none; b=ly6u/Bk3N7tViHcK0jsrcNBCtWK7Z2d5StjvapDxqJcqEihYtvI5iHoRGemPDpY6c3k+XXGc+i9IcTNBuZFcsjrw30IVoAZo0kPYCE1sb3Lha8ZiaxjHMN6pEbatsAZxSQjRBs/nPw1XpbentQS1CbkxYrad+6HGH/iKYDB7uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881846; c=relaxed/simple;
	bh=V6z7U2aK13VlHSymACPvCl0r1Hj+jEq5qL59ctGJ8CE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GfR7m64LmxhzS1e27+ddYEO7nTPAqdusW83T7QxhD3NmL22XBOtKw3l6i9H69pNkqTSXbrP1XeDPcyDwmBGXvrZ0pp26PbnvEk9YfYaa5QHNhJZuG+dXgHD9Qgh4qElyTMWkfwFfgxf4qj0HxqpwOlU/Z+Mss0unoFHYDyFQnUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KkgYZ2sK; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KkgYZ2sK"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d4436ba324so51882295ab.2
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881843; x=1746486643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoJLVk2Sn62iG3PhsVN8tZ93FRDpe04tgFauvMGG8/c=;
        b=KkgYZ2sK2Ukxo33EhXPUzCCASiABHFHNrttxWcm85bkJPll48PxGzr2RgE2DQudMWN
         TAn1o9037H9ULzRijwpOy53jN7zFdfb8Yhg4V1cuWWt7rWYHA9/0Z70AB9C9rQy88kYd
         cBSWO1KBS7X6dFik7uDd62LzmRk6IXFoDBLOLUCYT9TmaFsmfSOZzHxPa1Mt+uk9wBIU
         CtMwotGFnqG31iXyLzYj2fFCz3gxUwYqAXNIsn3cALOOvjzEgaAicbbxqG2rkdTpZ88p
         EIDyq3e3cGHv9UP1MWEytKLAscXNPI1Mitui1TE/IFToEPgvIj0huKrQRkgrCg0yjLox
         gISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881843; x=1746486643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoJLVk2Sn62iG3PhsVN8tZ93FRDpe04tgFauvMGG8/c=;
        b=nonMgrSY0dAGTCO/UHyVr2pYtDQFtMgMBgMu82mlrgvcrqHRVC8lTKogjHr31EUG+K
         ASTk3CMkdrAjWrt7FptGFuhZuHj7tI2emkZBOq8rFUf7B9XTKZqxVjGAjCvZcdHyhTpj
         Y/zdB6qM1Z6ZL1KXrrI/p6Dn5i3eybRimCuJsGbOkuLiK7vyNaQ72g/S0T7uILNs7UNo
         +B9IVpJzvQuPNJqvuEyvXSplHaf2emFhPAMgHGrKADFu1raG1N4Ze66F56SvK60KxxU6
         HJ0VsEgQU4iJ/u5z8jSA+dnAT9cEmvLTGZwnPboyx1BJ8IVwssPZim7TWUGy8WKXdrkm
         qmAQ==
X-Gm-Message-State: AOJu0Yz7x2qzWMiHjOw5Cq/XEabEJgxrHwy6VOE1Dpz3/e3GwFs2Kz7z
	YmKnUaPmf0yWcN2drfpAQbLHcllgANQrq84zG/o4UNlVxW9dtC+UQhn78WO/fHkmntDBQlrbWR5
	DUqFNlZl/gsgWqNPCW7oT2PAQW6nTK+PC
X-Gm-Gg: ASbGncudlbQNI3G111LYPfn6o1Bw+HVOd6j65pMTqv2G69WWKj8c2kebEXyOrvzCHbC
	JvlXV9sWZfPuuCeXNGfsI5nYWhCLRjx5vV1H64PYmQevzKi+ErvCOS3xlceMlo9MjHO6igQlwIV
	Ci4qtuETLERV3hTBQuUJHKItg2SpECfn4rVjgGRNYr3X+QtAHytUtrSydVc7m/NaL3JGU+bXJSJ
	I6ebSh1Z9gDV33H1rSX6JVCjh/tvM1HAnwJHQjO86SMsnaJXQ//iXYaHM0lw92YSXptHbldJcq+
	UG3G1nVEWLlHX0x29C1n4xX/aEKeV3Idw3LlDxUckiKDBw==
X-Google-Smtp-Source: AGHT+IGe5A9W9y3Mo5+kfpnNwmt5KhFphAnNJ2Rtm6xsdCtc5buF0dbnv7TNmO2d5giTwkyXslJWgll3DbLo
X-Received: by 2002:a05:6e02:2146:b0:3d6:d145:2ffb with SMTP id e9e14a558f8ab-3d942e42573mr129606055ab.21.1745881842428;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d95f45294dsm80395ab.44.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 41243340BC4;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 30933E4191D; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/3] selftests: ublk: more misc fixes
Date: Mon, 28 Apr 2025 17:10:19 -0600
Message-Id: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsKEGgC/x3M0QpAQBBA0V/RPNtas7bwK5Kwg4nQzpKSf7d5P
 A/3PiDkmQSq5AFPFwvvW0SWJjDM3TaRYhcNqNHqHAt19uvSCq1jIAmiysJgrp3pDFqI0eFp5Ps
 f1s37fvvmW3hgAAAA
X-Change-ID: 20250428-ublk_selftests-983240d3a325
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Fix some more minor issues in ublk selftests.

The first patch is from
https://lore.kernel.org/linux-block/20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com/
with a modification requested by Jens. The others are new.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (3):
      selftests: ublk: kublk: build with -Werror iff CONFIG_WERROR=y
      selftests: ublk: make test_generic_06 silent on success
      selftests: ublk: kublk: fix include path

 tools/testing/selftests/ublk/Makefile           | 4 +++-
 tools/testing/selftests/ublk/kublk.h            | 1 -
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 53ec1abce79c986dc59e59d0c60d00088bcdf32a
change-id: 20250428-ublk_selftests-983240d3a325

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

