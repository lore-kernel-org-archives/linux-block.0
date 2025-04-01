Received: from mail-pl1-f231.google.com (mail-pl1-f231.google.com [209.85.214.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1022153CE
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540561; cv=none; b=YR41nc1oVTJssDu6y45yvjmyG7GGIQRhWQXCNCsu048ORshuxw6pv/ju5bYVASXX3STOH0e6eXkcxSf/1CXPuoYESF5myVGmE66r7c1beGQqUCFVDjarnS/Hss+jxee0NCCJH8UDv0EwuxEwqx2a1mjRXTPz5ox+yw5xpWLDPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540561; c=relaxed/simple;
	bh=30PV2+70FCQMUCz+gunbFAvwdSKP+yMM0OGPlJ/I0uY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g+Pqp/lKTByeIki7PEWEakjdxABeGVfP1pKJTjpCqU4kR8Q8YMtfquzZRCNfMRy9E+fpeBR87MnLhv5XOdR/7a9zJ51V7guERZaSM5qqRgsaPglBJbmwDUz7cMjV3ZFjXeEfhabmg64wwTZDjl1IkuH3Pr+H9VWDh3F93vzer/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eOe4Qc5Z; arc=none smtp.client-ip=209.85.214.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eOe4Qc5Z"
Received: by mail-pl1-f231.google.com with SMTP id d9443c01a7336-2295d78b45cso29979145ad.0
        for <linux-block@vger.kernel.org>; Tue, 01 Apr 2025 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743540557; x=1744145357; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mstT9j25mjz8aUy9IpCZAB9h1zoQsbNBC0c7IzzYKmM=;
        b=eOe4Qc5ZL6PxBdceX4WZA0jY4bi3HOOTm0/symgIiB4WNyTjHs3G47jdkpEJZ4bZ/E
         Mq1sg2WjUcPDnuGgHYCiviD2KBTt6RG+8SEqUlKlyq7Sn22CbkFRJkb26Nn5aeIYCCtw
         txeJg+gN+1U70zPMXe2vLzJGsjybG0V3lJB6uKE5/nwpv2FZrZl7u6tNswAt2Sa38ter
         +4wkb89FRx/+L4vqAC+Xcm/a44TyjUjRfsDwFhs4yiLNvcvXU9NTE0qJ4dkqXUkLcYzG
         Vn+1OdI+dZ5NLL6LkwzX+N/VjVy94zX1GknIiLYko4Nkm4Bh3N+xiXOhG2zUAZK2tRUM
         eRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540557; x=1744145357;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mstT9j25mjz8aUy9IpCZAB9h1zoQsbNBC0c7IzzYKmM=;
        b=DRhjjl30sA25hwdVexrmKlQF4Mj5AbOjtAumPSCQuj5REAVSyEGp9+0GNqiLGFaZxz
         AgdWAPjDG+6NMjZlTia5KnNTW1HCyl1DN+MSoPFzYuDg/T7HbwNXKaZetS5CGgk6cR2s
         2a7a6+yM+PvKo1c0tPnfZupK0PXW19qsG33UV1eYuGc2RjPozFsFw5qYwD3gyOhNx8LE
         8fbPALcOs7/bN+sLeZz9EyAfEKmPWfkTk37KMZtOC6K+5MrX7V49TDYuOlGacFg89Vmt
         XHyV+WxEDvuo3QQU5VlEovdi4CBV0cBKjXL1HEMagZfSci+2sty80qtzxMXwqOJEZ7fn
         ZY9Q==
X-Gm-Message-State: AOJu0YyoDPFYI7z/Hoy0BL1sZi2fuyF0dClNOBgAJeWhvtxNbQ/rybqt
	kQ1rgeRC0CQXmz/hTmVH+0ujLq+BQ7Z+j/dM5XXaaCjbV9SLl4ZTrmhiPq/N67V3pOP1O32BUnp
	7O5o3IK55chHtorllw9t2OBRfP9Ucq9IRJnwi5eSZtZS54W4s
X-Gm-Gg: ASbGncvDgYjl7H9GN6/HSG1ycCVXXsDYQDyhySMYhDvHr6hqD1bf8QYq3G4D6+55rYj
	/sTccwmQAxI6xPjp4yANcZyWMF0lfnBNFHwXaj23/pf9Jk6ZuycSIfCakxIrLldMEa9kVcpkJvL
	7A3ev5T1R4FcO4KEr5RCzeEiUzXjXeeHEcgbbo6pyaz00cIH5xsL3maIs1v9bHS21nE+OlABqOb
	PqxZx+KQgj1ZS3fTVrfOZikk/wSWzrdmhsIIQyfYQhGBznCdLOa6wAXkBUjGApSa2iz8SrWGoxr
	iHNLezSrxINPHr2n/yMptuwoIGxk2KIB2w4=
X-Google-Smtp-Source: AGHT+IGs2poYi76n3mLJWXhUA0XPnz0aQSm3PIe6uqP21P4f4eb9jq7kzrwsD2tGzgMq7M/2nrRv9Bzd3IVu
X-Received: by 2002:a05:6a00:3a1d:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-739803990admr19199141b3a.14.1743540556836;
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-739710cb596sm757975b3a.20.2025.04.01.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 104C43400D7;
	Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 038EAE4034D; Tue,  1 Apr 2025 14:49:15 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/2] ublk: fixes for selftests
Date: Tue, 01 Apr 2025 14:49:07 -0600
Message-Id: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENR7GcC/x3MQQqAIBBA0avErBPMmBZdJSIyxxoSC6ciiO6et
 HyL/x8QSkwCbfFAoouFt5hRlQVMyxhnUuyywWiDujaoThvWQSj4g+QQ1Ywa0Xk7IVrI0Z7I8/0
 Pu/59P8Y+ip1gAAAA
X-Change-ID: 20250325-ublk_selftests-6a055dfbc55b
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Fix a couple of issues I saw when developing selftests for ublk. These
patches are split out from the following series:

https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      selftests: ublk: kublk: use ioctl-encoded opcodes
      selftests: ublk: kublk: fix an error log line

 tools/testing/selftests/ublk/kublk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 4cfcc398357b0fb3d4c97d47d4a9e3c0653b7903
change-id: 20250325-ublk_selftests-6a055dfbc55b

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

