Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056031DDC36
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325476; cv=none; b=UpN3c/tpQY8uCpFCFBHa9C1YJwbpWbqykIzDPFT6Z5INu6xKuq6JXjeBv0nmxub4AWh+OEmSzD00namDJUfmHVhfJBH14RcNDJPkq+mZ3Ik/DtwBLpVmIcO/SfWpAurO6t7sQ+VvBNPQ0+nKycJ/h1rkhW3bRHBWC/lVgy2PdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325476; c=relaxed/simple;
	bh=Bm8pohTrWTkYKI3XXcCRH7TxwPDICL+HxiIBiPqI2Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uG3zud373xV8BqoHCZs3qYCkZiVGsc2gYp1EYyLaRJwgQwoeALfpGLveN6OwyHIJvN2Va6CBVdSESAlVNAdNIf60Gdea/pbdAfl2w92Bu3gf4sfMBf4FrqGAjt0SDsw0HOdukXCs0oE28EVPCSIaCIx6qlICNqBHPGNc8ctA/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q7lhBTJ2; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q7lhBTJ2"
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-539983beb19so5894393e87.3
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1728325472; x=1728930272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7F+reMg7nqljdqdR3c2o8Ja1h9e3wiG2vM32ITmUUU=;
        b=Q7lhBTJ247f85xIxDSqv2NMmAlDZP4EizVr+cvnyHRwS7pJ0F0K9erQKD8z4/VqUkX
         lgcoSOgKbURMFXC4QG0tN7JI4f5hZHTj0gjkRffs0NqQOnHaxn0TKbBtQP6pq8CisIzM
         uP8bBiaU4oTCnO5VDHYCMWu57NbyZsxZ1zez1ibUBu2fsaXwxn6rKnvkzyMwF+X57IWp
         MaKwXL1wicretbCkvWAK9gfgkFABvKB+XFq93nYX8xzFQem+Ed/0DvZwGmbekd/AdZhp
         wMpksez9yMtWp4eCdXn3RKQHXjbNQtVVM9nYDfRlZdpBD4jI1UiuYEPS5YrYg1YdPF+u
         Ctvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325472; x=1728930272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7F+reMg7nqljdqdR3c2o8Ja1h9e3wiG2vM32ITmUUU=;
        b=u3GaBbKFtb7oPivpAuGbwwqSRmCVka0aJ7ODnUXTF/CWizf5xF2YPAEgnTfYwiZLmQ
         V4rhQYRFGNsjRbdzYRB270JDqwJCntDWveh6MUHyvQ3oJcIRWqTIyPQBhNdX8sjrsKAS
         n1Fy0boWGVoKshRM5N/p+vjoWZoEuTcVxFQbMZCkXcdVCUjZZ6NA/T4UGE7ZTZP8tHTa
         UsxxhN9AP8Pa3PsTWt/Nn0jng2lR6mxdbJiUohLttEa/k/aFfTwtNosR5/IN+ddZBUu/
         pWgYsonfVfapuXL2pRPhyv/jxmgrh3jut9iy5bf3TtWFbne++jWVeYC7mt1aHJZANXHc
         VaDw==
X-Forwarded-Encrypted: i=1; AJvYcCULqe+fBtggDqLHGxUyYCnwbREv4u6m93apAd2E5kLpMoBGlCFFVjrdGXLaLPRr1NmAr0ZY8nRGmo4TfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkeYdqHojYx5J+hbifp+4xGsAVkiAw/NMdWhIlZw2hk+p1Kqrv
	3gdzr04kgFQJbg33SFTpp6QxOr2RaDtparapcYNnCNVApqHbT6pioRuEl/TdkqSMa77CJGlZsII
	Tg/1Q01zJiwM3jerk/XWPBvPlCdNFpErY
X-Google-Smtp-Source: AGHT+IGV2t3SngtLGsSeHOFwsPlCDhCLEKm2RUGTjOXvgRo5Y3Xv6FXDDHYkwFJhHaqW8oG3UkU/YWg0ALw8
X-Received: by 2002:a05:6512:6c5:b0:52c:de29:9ff with SMTP id 2adb3069b0e04-539ab84e79emr5326901e87.2.1728325471882;
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-539afee57cesm172020e87.70.2024.10.07.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F69B340204;
	Mon,  7 Oct 2024 12:24:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 23EF1E41398; Mon,  7 Oct 2024 12:24:30 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 0/5] ublk: support device recovery without I/O queueing
Date: Mon,  7 Oct 2024 12:24:13 -0600
Message-Id: <20241007182419.3263186-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

A + 2 is a currently unsupported behavior. This patch series aims to add
support for it.

Userspace support and testing for this flag are available at:
https://github.com/ublk-org/ublksrv/pull/73

Uday Shankar (5):
  ublk: check recovery flags for validity
  ublk: refactor recovery configuration flag helpers
  ublk: merge stop_work and quiesce_work
  ublk: support device recovery without I/O queueing
  Documentation: ublk: document UBLK_F_USER_RECOVERY_FAIL_IO

 Documentation/block/ublk.rst  |  24 +++--
 drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++-----------
 include/uapi/linux/ublk_cmd.h |  18 ++++
 3 files changed, 165 insertions(+), 68 deletions(-)


base-commit: 8faa82888e7109d91902260ecffd12291abb4bf6
-- 
2.34.1

