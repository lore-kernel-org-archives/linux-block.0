Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB3263C7F
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915084; cv=none; b=Ut9TdBf4zhO1M53byQ0pdsPPoK2HniM9jEnrn8l/s+nhhJhw6EqrRiI+8yLtjiGRzm3lVmGT6NM862gPnOAzUclPsl27aq//L7stNxL3Vo+RPPeA15kX967rKCpTZUB+I1Hy0W4vEW343+ppDUVDuzB1vyBYdHpWVO7NZICNUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915084; c=relaxed/simple;
	bh=QMsiM0ySSNrjfwPeS0PK3Pu9Qsboq6Ail5+VxWLHqSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzOjIo/Db+ZN5RNi8CZuGmJOcfAJgiPKO4bszcNhAMA1kmhaGn4OAlvLivnkQsoJVmC6zzDFlRsmVBYMHAFghsfCjrfI7G75hSf6LIMRpwS+Qpkl1MrrMKuJljIofLmpfuugfXtLBByAeYnTnTuVnsDHwEfSCJxr15dUvnrJtP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ouz58vCh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouz58vCh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so56469285e9.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776915082; x=1777519882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylT2a9o0aMn9vZ27CHmN21NC/r+pum3P0HNR1XgeLHY=;
        b=Ouz58vChw8qXFbO6J4IWNDlMWs4qu5la3bJAcUQLQ6E3Ot7obCbZf/RnRDyo50dKrD
         LTIKU6HUJjLZFDB9q2r/1ui22IZ9DlmsynV+BljVV411FVn7xdoBlgAiugroq7hzC8bA
         KSscamRpylS/SchqXMQEJ6DdUQf/PscGRGDVi3mPsR2eM8IeVDuUv7zidcqpIT/MyFV1
         jiR6lYaGU/PjDVKhRbvfaVoZWna/dA0sjMvr5W27zvUh47gELH4L23jEcDYqP3O2qvw4
         1iuKTF1KfidlJDPONN7TYcv98Yq5E1iNpG/0/aFQVC2BTGOXZpIW35G2CfRGkuUQUxe3
         /biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776915082; x=1777519882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylT2a9o0aMn9vZ27CHmN21NC/r+pum3P0HNR1XgeLHY=;
        b=TL4wDjvcZz6uIYYMPkwIDVSg1KjnkTxNh8PagxxMNS19zRFVYl0bnU3gfbPHuiV++Y
         6xORblZMCOMKKLZYxXj8JbiJJntw6cV8SaLvegGvNONdkenjOFxFZtbQ0ro1/t40mEt1
         XCK+jx0nsMAtJ2Hg0DdeOxZN8YXLqhZsRXcaC5ZtKqYsyXycAR+jtiAk3iM3zRn50LJx
         3YKPYscYufphPDFovDOaiuVj1CFLNv9XLwDxYS6Dt6wAw3oFTPOhO0TJQatzyKWAJrS0
         D6s09MNd77jPuHGukr3vKjt3exd3896eWh55yGJTsgIceGVOWUARhAYiLR2odzotwG2E
         ty9A==
X-Forwarded-Encrypted: i=1; AFNElJ9Vhx/pSKHAn+14fPtAqsCR1qLvy6HDgmopyaJHcEZ4AieNPNVm/ZjmMdbfarwsDSWOLsnuX/oH8tuC8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRD4XJgBrXgLJ0n7ZesqCCrzVVyEOJL7+hSjWdSTGD7G1xjPw
	kK1L5jkzKM9rH5N8EoSRtUgFLBey3NtitNVO1FuXaA1dcq82K09gH2az
X-Gm-Gg: AeBDietgXn9zevzRHNooEHhg86PEBapl92FF7y+h8sdmEnWC1AAiWRhNIQ5X1hneygb
	2RxmeQOwHjXEnf9dCwxXvwUitNbxMV9qixbY85E5NMiO7lqPfD1bELgT6LRkt1FcTCi8f672xig
	DA0ufCXu5m/mGybNPwSj/K8eBlRcd0Zq7e2YDQv0GvglPVPAWDBSKNxx2lfKkC7M/U4D6uv9z79
	GKTXadmTIT7F7vXra4/+jtunFQpazX/NvsMpqMdSe5MdZ5WhIrNy81fq6ZI48k4+Qj/Q0MaD3N5
	qmiYfQO17+sOgwbrVy4E0Qd2LHISnAkxckzn+gANrO/8gIlJ2CuqN/ZzTJxY2H9RWioZyGzqNjW
	EOA/ku+uzku8G73SfKHMc0IGcqCv4gf3bEUzBXj78Z2D2WAhXNH4NQtbtuWhS3bJOnKyRaGtM9J
	e5XQ9XDQ34RduBboigYbzC8XKoScIW6q9zfn56KhcPtVr62VQlzVTyz7WHmTcSDBXNWOjnGbypm
	MgBhcwTld6SsjitrDE=
X-Received: by 2002:a05:600c:33a6:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-4891c1f38b6mr134229275e9.9.1776915081725;
        Wed, 22 Apr 2026 20:31:21 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm104438085e9.2.2026.04.22.20.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:31:21 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 0/3] ublk: fix maple tree lockdep warning and cleanup
Date: Thu, 23 Apr 2026 11:30:55 +0800
Message-ID: <20260423033058.2805135-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jens,

Fix the lockdep warning reported by Jens when running ublk selftests
with CONFIG_PROVE_RCU=y:

  lib/maple_tree.c:759 suspicious rcu_dereference_check() usage!

ublk_buf_cleanup() was iterating the maple tree without holding
mas_lock, triggering the splat from mas_find()'s internal
rcu_dereference_check().

Patch 1 fixes the warning by adding mas_lock around the iteration.
Patch 2 refactors the duplicated walk+erase+unpin loop into a shared
ublk_shmem_remove_ranges() helper. Patch 3 avoids holding the maple
tree spinlock across page unpinning by batching erased ranges into a
temporary xarray.


Thanks,

Ming Lei (3):
  ublk: fix maple tree lockdep warning in ublk_buf_cleanup
  ublk: refactor common helper ublk_shmem_remove_ranges()
  ublk: avoid unpinning pages under maple tree spinlock

 drivers/block/ublk_drv.c | 111 ++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 41 deletions(-)

-- 
2.53.0

