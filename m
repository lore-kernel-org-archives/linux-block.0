Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90D3A1DB;
	Thu,  2 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819304; cv=none; b=COsBycBaee8BYzNr/JiGT37xuITToDsfjHgTtTVaG/9Y9jVSY+q8XSCnpZIZVNw1wXvKp15c4I+I6dcprIYG+JWBK2eF1T9G71Oi/5+uVMLJPP110M9pHYIYSPTFKL7VIbfHr5HsKrkk5j0hs6VtJIBhbVvJdrwd2jEILXVucLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819304; c=relaxed/simple;
	bh=DdEeNixq50fkHfaDHiWJWkVLsRvQVsHi5QlVFU5P5vQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e0Z19aYaLh7Aqm/f9u4vOWPTLaLmcLP8XNoZnRqj/Ag+TA2mjNALckYu9xJ7tX9gDXnsMSKBXNqdr3LYXlJjL1SoP1ev//qUcn8ZGe0GQHQuD9Sez0LU6/UOwsxmgWYYQatiFCS61f8x3PH2NI06FHtVTv6tc0BKiGw1W/T7QtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o0vr66/Y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o0vr66/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735819292;
	bh=DdEeNixq50fkHfaDHiWJWkVLsRvQVsHi5QlVFU5P5vQ=;
	h=From:Subject:Date:To:Cc:From;
	b=o0vr66/Ysxyu5cQV3TfUxbBiZsGa85dMMA1Fu+NdO7p+Jg/3znSvkrEb8R9jvLISN
	 jmXvi0njzLx3EsWYYV5mkFGACDDwyGZJdMFJxi65p2MwwLj0KSpJhxnMGNe8LL/4p+
	 cwZwfmObtE2cZSV1wmSrYWx4rJ3cVzIG5xEn1JAQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] elevator: Enable const sysfs attributes
Date: Thu, 02 Jan 2025 13:01:30 +0100
Message-Id: <20250102-sysfs-const-attr-elevator-v1-0-9837d2058c60@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABqAdmcC/x3MQQqEMAxA0atI1gZsrahzFZlF0agBaYeklBHx7
 haXb/H/BUrCpPCpLhDKrBxDgakrmHcfNkJeisE21hnbGtRTV8U5Bk3oUxKkg7JPUXDsB9e6wfi
 lIyj9T2jl//uevvf9AC1xJu9rAAAA
X-Change-ID: 20241231-sysfs-const-attr-elevator-97843481ad5e
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735819292; l=803;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DdEeNixq50fkHfaDHiWJWkVLsRvQVsHi5QlVFU5P5vQ=;
 b=/9NWiAzoP/1Z/E+X5TtLVGhlOtpUxzDgYQ69JuOPR0YgRn9BmMDuuqF2bNWThYgXfEhOweaL7
 /zcor7MKGzXDesj7NINamu/sF3tTe5bHV27P0vy4e63/CYntTOoOLHP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The elevator core does not need to modify the sysfs attributes added by
the elevators. Move the attributes into read-only memory.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      elevator: Enable const sysfs attributes
      block: mq-deadline: Constify sysfs attributes
      block, bfq: constify sysfs attributes
      kyber: constify sysfs attributes

 block/bfq-iosched.c   | 2 +-
 block/elevator.c      | 8 ++++----
 block/elevator.h      | 2 +-
 block/kyber-iosched.c | 2 +-
 block/mq-deadline.c   | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 56e6a3499e14716b9a28a307bb6d18c10e95301e
change-id: 20241231-sysfs-const-attr-elevator-97843481ad5e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

