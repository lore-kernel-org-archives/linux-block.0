Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD84A9D4A
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364938; cv=none; b=uf3YrMjKo0cTyrOHS/wzXOtuSzwF+WfMbdavC/bn9Vkuoq5miPvuZal24Likx2FH+SRYWEWzmbRA7OSiPFkaXTNlnLEF2OIT1V992NPh9Y4OPa1NZFgoWTPLkPTTN9EMG8VwhlVc6C+Fmc3A/ptV2Q2Bm7sq7jX7QfJzOynIHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364938; c=relaxed/simple;
	bh=hi5B8631ZCUoKVXebUUqejKb7iuOqQZ55/o1Ipl83eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyHQxnD92KOpXyWInWES+SsyPgfuZdYSOWizODP6G7nYGXpcrb5crcm69VJyxn6bsCKPV/b8CGwYNUjH/3DL4UXcyZvcZIewjBlTBAizSGmMq88TQQiLM7H08CUEyuyUVGAm1Ozv8hB6OT4SQEzsluRUWbHBs8mXzPqMty38FXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apCCKf0I; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apCCKf0I"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1561306a91.0
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364936; x=1788969736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nevPdevDdDWdAWCNH64YiGAe7oXmwOpEPCd54OU20M0=;
        b=apCCKf0I7HPgyI7jhZthJngYpSGBrO2bqqoq5dLkLmxGLL2pIWwhgvsA8cJ0eNz48D
         ALB2wcvBEDD6S5oXmnFAPGuzDEn8uogA3qr8bcDRf82beu4lce3xATbH0wSNORlxA3Nn
         esKF/94XOw7dmSTSZTXzhuxR6gkBLZa/xVqGVNeuZuucS/dAM6izfpIyy8DmzoprmPCq
         XmmTCaXCtr6/jfLgHuhD7D0aphney8bikg1V1Auck7dJ3hq5TRXa5I7fL2o9NYH8fI0Q
         a/aL0xOgsEHXbValfUMKUsBszsRbfOEweTzOpn5RlGjPv8Ri97jL6uL2/ZA4miWiju2j
         siUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364936; x=1788969736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nevPdevDdDWdAWCNH64YiGAe7oXmwOpEPCd54OU20M0=;
        b=M4zoqYQJXASAXXcZCH86oRMhtteECTyOQBcMhmgsQ1zbwLpp2dxrrzyCZAOnKpmRYm
         vB4OyqahZekW+6toFuthO1mIx7z9j+cn6tunZC5ugUC4AmqrMrCAFQwa0n4Q+cLDD4+Q
         cmIkUbb5KLeW9DwJwxsSJOxH227a+pV4OuE0beVEU/+knbMa05eHdo0eC7ozRwa1XfuV
         nq6PlY7kOwNrV3gaq/X67c5MCD5/nBnH9YtZbnrWhjacsY/JPbpV74534FbrobidISMX
         jBe+a33rOYekupIob1Eu3wF4bh1/HzuGAZ1EVkaT2T7mKEQBGruGcNc1nxlXdJ2VJCkK
         HphQ==
X-Forwarded-Encrypted: i=1; AKwUvBxr7y8b8NEXp9SMixaWEx44GEzVAYhcQ7x41Q+5irm5KL6I2xpS3j+MbDNVnEj90QZS+yInuVAQ2bpJcQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lgo2e942TTkUEp8rFgDTohbmLpvNPegooZzxiwL7ki75yssMwb
	vc4Aj7MY4HI8g/0xS+ErKBFVz/TEkDEpPZc89PeydFIhpMfEh7kp35A=
X-Gm-Gg: AYBFou3pK5W9IcdtDkGvuj29CL46QptLGj1AAH+W/rcfgjpGaCrS1QrbS+SkyCCAuzV
	GjSct8enWmgWtZtSHaPaEKk2a05imw978UOvxOq6M9RnF1c0/cq0MlLjphSO7PQ/wOoK456nm8B
	qyOaZ4424hPmODrupHs2enhe0QTd6U8fL0LVYU4Bz89Ge2PfZ0hrARL1hJpHdJ27m81ESfg6yy7
	1s0MHptQ+7uYaojV/B9xWVtbjyl96AYFxMF8FO9vSsI99vgbmgsUcKhMPst2Za7sG8wxc3TGyl2
	OTd1V6FHTSOFmWG7x2Br+//6jN3282bnqf1rgfuA5YMlBPiq3DDqHo/pMKPQi9xpOQv3WsLQryS
	CwIQ41uk6isdays0+1icADpuo9m1PH6y0XV57Jr8eszFR8Hna3uMDGZpj3X2jMHmAb99EMFQLjY
	dDdQRWb/mPenxftgfDkY6xP53rumyNzrK7nrT/UNPj3zHHE6BGett6Urt5ZcZwz0IK1cF9c5slb
	xgG5sBlS2olA/DnpxG8gZ3j0/LE8fXQ9ejQK8EP
X-Received: by 2002:a17:90b:38c8:b0:399:221d:63c0 with SMTP id 98e67ed59e1d1-39aee292b17mr6402646a91.25.1788364936343;
        Wed, 02 Sep 2026 09:02:16 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7bd00sm7327447eec.14.2026.09.02.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:02:15 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk
Cc: colyli@fygo.io,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v7 0/2] badblocks: fix rounding bug and validate input range
Date: Wed,  2 Sep 2026 21:32:04 +0530
Message-ID: <20260902160206.322319-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two related fixes to block/badblocks.c:

Patch 1/2 fixes the actual reported bug: round_up()/round_down() don't
modify their argument in place, they return the rounded value, and the
callers in _badblocks_set()/_badblocks_clear()/badblocks_check() were
discarding that return value. Depending on caller alignment this could
leave sectors unrounded or, in the reported case, stall the CPU with a
non-advancing cursor when reached via the nvdimm ioctl path. It also
fixes a 32-bit build breakage reported by kernel test robot, since the
old rounddown()/roundup() macros pull in 64-bit division helpers not
linked on 32-bit builds. Unchanged since v6.

Patch 2/2 hardens the same three functions against the input-range and
shift edge cases the round_up/round_down fix exposed: s + sectors
overflow, and rounding itself wrapping past ULLONG_MAX. Revised in v7
per Coly's review of v6 -- see the changelog in that patch for details.
The remaining open item, bounding bb->shift where it's populated from
the on-disk MD superblock in drivers/md/md.c, is being sent separately
since it's a different file and a different root cause (missing input
validation, not a rounding bug).

Both patches carry Coly Li's Reviewed-by.

Ramesh Adhikari (2):
  badblocks: fix in-place round_up/round_down usage bug
  badblocks: validate sector range and shift before rounding

 block/badblocks.c         | 52 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/badblocks.h |  6 +++++-
 2 files changed, 44 insertions(+), 14 deletions(-)

--
2.43.0
