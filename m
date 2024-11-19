Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98602157472;
	Tue, 19 Nov 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019274; cv=none; b=tGqrpWPX4hZSU5mNPYgAJDwJJQNWzAoe1D42TdqdCZm6zfyCbmdz9jb2vmnFjV10mWnlJVwpI5CG4HdsEXTQ3DjmE7dv9YuKb8/k4MqibXszDJsKacTPhmHBr0WZXqwnjDrmeQRz2TqOUuDsXyfI3+7APwDZrga6O/cR+vAnncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019274; c=relaxed/simple;
	bh=INatHOUfKUefHBuvKCNTGnOli5aAvlCIxFb8+jS7Eis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JmDFEoJzFOLTusRVr85YQ1MuWmekge993053Af23qS7Mt7+wVRnfAHK/FepqiBF1U60Mo4bHoO9N3k4lxYh5GIC8Wl/JfQjfyqSyYNyn07ztBW4b7Dl7jkIHhJrqNYgHcXqyzN9fShTAGzQejTi0muB0Wu/Msv+vvgwEuKB/sz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gGC3R1Bd; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gGC3R1Bd"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 798DD100009;
	Tue, 19 Nov 2024 15:27:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 798DD100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732019261;
	bh=jwM895vIW4kiPsereF3G+yaWIjMLRALxnRXpzW1bPRk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gGC3R1Bd+ogk9MQy+3Zesr6aTehvlJxa2+ebFjP6b8ndtRq4ijv7QMoRRET8SKiu4
	 MZ3SZTZBVCGqQqyw+Daec3T1R6VqvLwvZOM3jUAs2rn/dKORkTUlE5xk22faVToitP
	 2oZq3V4gVlFeyppEMrBkApF7EBsoPWHJvIFXWYN1qB651YeWJ7GfTXYPjz9Yqw1QwZ
	 HTMjv3ZFN+9iUBTRUjoDhtkRR53AapaAxvXcwlGhEzGIhqvscLz/xYGqINokb13OOR
	 O72F1j+TC3KW5Dd6j2bBjIPS58ZBmBQ7JxN3DnagfAB9QE7OUv5v2DbwQxd8YcMeJp
	 oz0lHazQtSTAA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:27:41 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>,
	<terrelln@fb.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 0/3] zram: introduce crypto-backend api
Date: Tue, 19 Nov 2024 15:27:10 +0300
Message-ID: <20241119122713.3294173-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

Since we use custom backend implementation, we remove the ability
for users to use algorithms from crypto backend. This breaks
backward compatibility, user doesn't necessarily use one of the
algorithms from "custom" backends defined in zram folder.
For example, he can use some driver with hardware compression support.

This patchset adds an option that allows user to enable Crypto API
backend support. Crypto API backend is also implemented in a separate
file backend_crypto_api like the other custom backends.

Alexey Romanov (3):
  zram: pass zcomp instead of zcomp_params to create_context method
  zram: store crypto backends in list instead of array
  zram: introduce crypto-api backend

 drivers/block/zram/Kconfig              |  10 ++
 drivers/block/zram/Makefile             |   1 +
 drivers/block/zram/backend_842.c        |  14 +-
 drivers/block/zram/backend_842.h        |   2 +-
 drivers/block/zram/backend_crypto_api.c | 117 +++++++++++++++
 drivers/block/zram/backend_crypto_api.h |  10 ++
 drivers/block/zram/backend_deflate.c    |  15 +-
 drivers/block/zram/backend_deflate.h    |   2 +-
 drivers/block/zram/backend_lz4.c        |  15 +-
 drivers/block/zram/backend_lz4.h        |   2 +-
 drivers/block/zram/backend_lz4hc.c      |  15 +-
 drivers/block/zram/backend_lz4hc.h      |   2 +-
 drivers/block/zram/backend_lzo.c        |  14 +-
 drivers/block/zram/backend_lzo.h        |   2 +-
 drivers/block/zram/backend_lzorle.c     |  14 +-
 drivers/block/zram/backend_lzorle.h     |   2 +-
 drivers/block/zram/backend_zstd.c       |  15 +-
 drivers/block/zram/backend_zstd.h       |   2 +-
 drivers/block/zram/zcomp.c              | 183 ++++++++++++++++++------
 drivers/block/zram/zcomp.h              |  11 +-
 drivers/block/zram/zram_drv.c           |   7 +
 21 files changed, 390 insertions(+), 65 deletions(-)
 create mode 100644 drivers/block/zram/backend_crypto_api.c
 create mode 100644 drivers/block/zram/backend_crypto_api.h

-- 
2.34.1

