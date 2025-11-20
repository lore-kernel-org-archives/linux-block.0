Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E933987
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608597; cv=none; b=IKy/B01sIGXp6fo+2zO4mT88EWXSPxw0cGVqvoQ4tkqofO7qPtd+UjcxszkX3LMIx+FBCEZNXw0qG1VsEPLV0he8nRzDicmCbBFh2E/m5QVmrQxms5aVoiyo4e0Cqfp1Wnb31RwAW9JD+oc9LuipLeABdTmWu5s3Yvv2DB5iLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608597; c=relaxed/simple;
	bh=dx0fKc0M7CnY/ywAMg7ADouNd443tVfCZbbAgAKAugg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTFaCTScylLu13hO2MRF93nbEotgzhqRmrL4ACno0IrpeI/CAKWR021f1cOQ/eUUb1j6hecdF60tv/yOD53EAqvewVOXJxt387t6hEndT28sEvqn1ksdhMlfFYPVKjMOI1kB7SRUh/K5OqHqrxW55ZPHpnrw1TW74MiDR2t/iYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Usws8Jm4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Usws8Jm4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ba49f92362so263884b3a.1
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763608596; x=1764213396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+22hRc1DSSZa2mj6HwiwLzvY0YVzTy2UzVj9dfXuho=;
        b=Usws8Jm4B6Gi2+d1HLwh9sWRsf4XXs1TWhmWUTU2hHjXL2N/a0YVMTb+MHQ9MFRJos
         9BQqTaxpUaiSWNxtRxgcPGaHld1oRka/M/dzygNEdkeT0PLQ40pypMIIe9JbaJ6iRPsu
         MItfvYoEbljy9ncGYLopmovlcL0MwNB/A7DDo+SLRlvHFpkRXs4tFP6Os69QVvhANKTL
         VMEyNhJD3bi2fUOaeT3XcQ6FOSSk0PBmrOaYl/N/81HN+sVpye/NbiFQy5+7MoDLosXd
         DQtHRwctTG8vPJN/IDJ8SzLFka60SZQrTjvtbDz+OShSN+zEYwEIfKviToabT6naLlu2
         z91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763608596; x=1764213396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+22hRc1DSSZa2mj6HwiwLzvY0YVzTy2UzVj9dfXuho=;
        b=dbAYSToucdRLDu0X6pa9h5PK1SykvMHVGl/m3MmtmGdQGMkFtnrCfFpzM8nDqhYbHg
         XEPCpbWLjw5C6K22jzoOTwbDL+iHmpAvG/Xcxo1yN2iS3nELvfwU0CWOK6VJoeulsFGF
         MzQc4jOyY1xQjHM2lOVQEjsAxWCuGmIqRbRyHhgE1Do4dVpqZ3wCWMYYaNzrNeyXbFt7
         hU1n70rzTtqoLfu6Z1d2oGN59nfNRuh8maighaoYM/6EyhQAndPdV//7AjLgk57C26Yh
         JW8iUJK0Zdr5g3NtSYeqm8fpTBfgSSao5nJ2J1TktQbY15j6EeerPwD01OyPPo1wWF/C
         dUhw==
X-Forwarded-Encrypted: i=1; AJvYcCU/I8wDZo5OOH4OIOLQYLdYENc3++ONquIRrmKY2EqpDPaN0W5/ItsTKXWPtSfHKuPbQ5VuSr6ZZQr+XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZprA/uZF+Yn2PWAo8HnaAL4lsLdyMgeH+ZVayaGVGEoKdA6b
	xoNV7hko/u9vXTv0kD2b1AEDQlCsN3PbvuJ0RRY1paJ5IfDUaDYrfe+K
X-Gm-Gg: ASbGncv5xqEF3StEyxzp7NEcnXsEtQuxuhxQ7PcU6SDoCDBtGF08hJo4JaFE1Ji9VSI
	568X1sqrkOliDNZq0WVCCA8B3JFRNGOCYpM7wHW6FdKspq1np4n8t/yc1DVRBigtUoGJEmuW3w9
	rwQSgR/qfhK54pSHSbF6ozUBEwi8UvWfg6EGNk9tQCFYGJE51pbu0Sk19iySvidi9kvSA8UxhSN
	CadgIE59t+hyWutuLNGfYHs6SbC+Dy+9bJoW/ohyNkLFVOzmgqmonocgoaKwJwcGf82s1zyyDBd
	460Px6B0+hBs6xSzU/RcYu1QO4TSrPiKYHshsnw33193zfjGYTjc4hOzWb3V4WcFM9knxToVIQ4
	C0BllZJP/IKaO4U0g0AAGTu1xevTfO2erJcaD7cIw/nQRdFVSoElbVbylJbOqNTYYaBlVI72D+6
	gn5dBqTKyE35SWbSkRWZ3l3NCg8Asq0leqzcSdMne9ou8mmi68
X-Google-Smtp-Source: AGHT+IEVaag9AKDVZb0w8fpMZLLyWv7etxaziSsl7K2LfzxdnpNFwE+TJazxWHDGeYu9z7z4D7OLYw==
X-Received: by 2002:a05:6a21:999f:b0:2cb:519b:33fe with SMTP id adf61e73a8af0-3613e4b25f4mr1081554637.21.1763608595598;
        Wed, 19 Nov 2025 19:16:35 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7c29asm879890b3a.9.2025.11.19.19.16.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 19:16:35 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH 0/2] blk-mq: use array manage hctx map instead of xarray
Date: Thu, 20 Nov 2025 11:16:24 +0800
Message-Id: <20251120031626.92425-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fengnan Chang <changfengnan@bytedance.com>

After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
an xarray instead of array to store hctx, but in poll mode, each time
in blk_mq_poll, we need use xa_load to find corresponding hctx, this
introduce some costs. In my test, xa_load may cost 3.8% cpu.

After revert previous change, eliminates the overhead of xa_load and can
result in a 3% performance improvement.

use-after-free on q->queue_hw_ctx can be fixed by use rcu to avoid, same
as Yu Kuai did in [1],

[1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

Fengnan Chang (2):
  blk-mq: use array manage hctx map instead of xarray
  blk-mq: fix potential uaf for 'queue_hw_ctx'

 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 63 ++++++++++++++++++++++++++++--------------
 block/blk-mq.h         | 13 ++++++++-
 include/linux/blk-mq.h |  3 +-
 include/linux/blkdev.h |  2 +-
 5 files changed, 58 insertions(+), 25 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
prerequisite-patch-id: dc4aa50f50259c7ba5a6a5439a6beecfa89897fa
prerequisite-patch-id: 8ffb2499d24e08d652438fd9dac815b8d4c0d8b3
-- 
2.39.5 (Apple Git-154)

