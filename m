Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A71C5F1B
	for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776487150; cv=none; b=uFGCgrfcXBOumLOdEKa5slUpkX0XoWesSP2cFJ5ld3lH6AX+hg0mdt7moHBn2vhAKQfKxmY0pM1JFNKjwInUV7i3QPPF1EQC+T2MbjojPxhHGW7vooIQExNZifnswSAGBKIoZPyaCN/TUSRDXVkrOjiGJGUmOA74ngMm5buY96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776487150; c=relaxed/simple;
	bh=B/ttiCEoPPdWutdmJk0hG0cBf9M9xTEQL+T1pQ6rt6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwu56fm6gG3oCcnSuwlqV8XZm5FcauAioM7wGx6RFbYdP7DellmgxVwwPUrn8Fo6V9XLbgJ6A96d5C9Ynh2wJPQkusTD5t9JoKCzAKlmMSMMrKSiAggv6V85szc6XLpjvscSwkSRuh7zXY2C49fCX7rvQaPSrJhN029ofMX0n70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=BsA1xyoi; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="BsA1xyoi"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1387453eec.1
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 21:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776487146; x=1777091946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6Sm0eAi5i6nu1lXjAD16Cj/1TY9SEgFvZVx+L43ki8=;
        b=BsA1xyoichOEUqLEwUdkXKMFZZyiCLugV/mp3xuzJ0URHnRyTzy40iiRHCnEZchVbi
         31y+1nhFE7CtbGGnLD9crJVAJcRXKJ0Gc3OjzCgyi7c0LTBeEY/wviM7kSwhkLXDPzf0
         ri9AavO3OPP01PEqMljn+WJ+4hQCmQbkr+4fU/z7SnAiCOP2z68os1HBqp5zDYbRQRVz
         tfSCBpdxXWTe5lyz8LeekGB4pdfzbXnFceyocT7AeK7KeWSnghh9rsHTwcgShezrLFpN
         ftNF+e1UXyrHqxsNDaADjzdUHO9Waz1RNOIrKFvr666m9qyllKy2P5TSIGZM0HQCwHcW
         MasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776487146; x=1777091946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6Sm0eAi5i6nu1lXjAD16Cj/1TY9SEgFvZVx+L43ki8=;
        b=lUFbxXGwZetJFF2vbTYSkLrLb4DeL8/MImgiH/pQHnkzs8QPrNQL5LtOImg+jg+qZR
         gOOKj4EOZoTTBNmXc/CsaUyn19tac1Yv32fpfZFp4X5QH5k0oBCNTxqWg5fTt/6J8KNY
         wvGq2Y28+I36KfE/vcQZ1nBD6DjM20F6M7iaxrjOrV5dHyxaQ7ue1UyQmJ/Tw4lHiP+K
         SgbenBrxwnCqtokIhrl1Y8WgqlUx7nA9tF/0ABO25ls0H/oMoykb32roSEh5GQc6S7I6
         WCtIqpDhwg1ajiVUTLsMnuTbW7oL1xqfDrzmjxsBQq5sD4bxFziR/ntT/rna+fYvDZCg
         lMpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mVXKySTWQ7kGQ42psD/aoByluXiVeNUxmX410opVPs6DbDK3OLBakKbvdoyCZCqXy5Wcc/pdFe44vuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOR7PTaPvMeHYS9SywoAmfcNxIgC2s54a6NpradXOF/TQfdxe
	xKrhEHosMy73n7U70/zvg0PD31wmmx57plE4lQfzg2RbNmaTyJZKx/we3+uBE156A60=
X-Gm-Gg: AeBDiesZORcUCuwEGzOnoZWTBbUUro/xwvKKMi4AlQkxq/Ufi1O4B0pYlKfI32hP2su
	aL7xx+gNvlnKO3H57leQA5mJ5s6eY1RPfJPFAJsnzeOdrWB2DADSahEpPd23GkstNmZClirs9jU
	sSdA/XM0CCT9t+QF7+Jo9upN7OH4uLHQrAk7Pzjb4M6htUhnnFYovxNBVAzqDZWpVJjexvaTTzO
	T2ULRPQlDGDuroeiGHUjBkhlflILRV8bbQ35a1cXoWE4cKeIEk3woXtq080vS96O8P7PR1l2KnB
	HaNeJM2nfXUsxsd0jNlLSDn6VGLmKpL5RLhFUZRvtdw6LNkLT2Zq15VYSw7iQijBnb/HsAUt/RO
	eYxv3WKHi275Ep1TuJjEteV2rFAq5owiCGc0VJkebqmSbw+cgyiPUcuNxcUW9CqLoN6SkZwLHYP
	c3E5r+RGKlSf+89OTQeLuc4EFGDo7O06UrzBAHvjHLQKAM+g==
X-Received: by 2002:a05:7301:3d19:b0:2d1:9b35:4ed3 with SMTP id 5a478bee46e88-2e4874ea1f2mr3214701eec.28.1776487146464;
        Fri, 17 Apr 2026 21:39:06 -0700 (PDT)
Received: from chrysanthemum.. ([2804:7f0:b081:9846:727f:bf80:6632:6056])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce460sm5273734eec.19.2026.04.17.21.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:39:06 -0700 (PDT)
From: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
To: axboe@kernel.dk
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	Gabriel B L de Oliveira <gabrielblo@ime.usp.br>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] nullblk: use lock guards
Date: Sat, 18 Apr 2026 01:38:35 -0300
Message-Id: <20260418043837.721045-1-ricardo.kojo@ime.usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() for handling mutex and spin locks instead of
manually locking and unlocking in main.c and zoned.c. This prevents forgotten
locks due to early exits and remove the need of gotos.

Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
Co-developed-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
Signed-off-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>

Ricardo H H Kojo (2):
  nullblk: main: use lock guards
  nullblk: zoned: use lock guards

 drivers/block/null_blk/main.c     | 74 +++++++++++++------------------
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 19 ++------
 3 files changed, 36 insertions(+), 58 deletions(-)

-- 
2.34.1

