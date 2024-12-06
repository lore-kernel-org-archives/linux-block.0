Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAA1C548A;
	Fri,  6 Dec 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516624; cv=none; b=fhtrTrwCv8FVwvxADf7KM2JpaWC7gNbmM8dT10DRugA22KVyskOVlatqRVefkR3OdVv498omej5kdV5kX1J57jZwVSa2EE8zteBiZgRsntG5tVo8B0f0J6j6sf5gc0llW29mt0msNiNvINn4xd84oKDtW0N5dEwHPPqyy7/9gLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516624; c=relaxed/simple;
	bh=nJHqvSDEzZWwHL/QPBmZ+zkpjjhrSiB8uAjMJNM1B+I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rwsP2RLIS4vGLCIlSwzzIYdVyTQekq844xEuWx0+Dkf6BZ0tK1BZnvFrHh2IA6mt88y8wIu/AtgX8QAOQ4ncCogjKRZOzDeIQoPOJ98fw0oN01oo8MEr7znx1SyWGkWgE5z/oGkh+F25eEZzE9PMcD/jwBVbxXeA0789xvz/NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cirno.name; spf=pass smtp.mailfrom=cirno.name; dkim=fail (0-bit key) header.d=cirno.name header.i=@cirno.name header.b=XpptpqrD reason="key not found in DNS"; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cirno.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirno.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cirno.name header.i=@cirno.name header.b="XpptpqrD"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id F076F625CF;
	Fri,  6 Dec 2024 23:16:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:26a5:0:640:547b:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 682CA60023;
	Fri,  6 Dec 2024 23:16:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UGps2S5OmW20-snDwSBOC;
	Fri, 06 Dec 2024 23:16:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirno.name; s=mail;
	t=1733516193; bh=tSqt+eXRv/K6O8RPvlHIS317PkdnNTHI6BdZrqilh44=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=XpptpqrDLIolv0A/quUuGeXn+lzt53oKawT8YYQVOZCgW1jLFg/mnWMRz7gLtBkmy
	 ErjdCCOFkZk0BUDn4qqsYYtqwUVj+awWwynSHR5Hnh+83Tx6sq2aEq7I45J1n+I82p
	 yEkXFcFBspU/fielyRYDkcTqnvg4sWRO74kNEnR4=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@cirno.name
Message-ID: <7d73e19b-f264-4c31-8f5a-fb17b6bc0600@cirno.name>
Date: Sat, 7 Dec 2024 04:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From: LiviaMedeiros <9@cirno.name>
Subject: [PATCH] zram: make default ZSTD compression level configurable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

From: LiviaMedeiros <livia@cirno.name>

Add support for configuring the default ZSTD compression level for zram
devices via the CONFIG_ZRAM_DEFAULT_ZSTD_LEVEL configuration option.
If this option is not set, fallback to zstd_default_clevel() is used.

Signed-off-by: LiviaMedeiros <livia@cirno.name>
---
Disclaimer:
This probably should be implemented in userspace, I failed to find 
relevant options in zram-init (v11.1) scripts nor zramctl (v2.40.2) utility.
I also failed to make something like `echo "algo=zstd level=9" > 
/sys/block/zram3/algorithm_params` work in runtime, but I assume I'm 
just dumb and/or it requires extra steps.

Nevertheless IMHO it makes sense to set defaults in kernel config: when 
kernel is built for specific hardware, it would be handy to adjust it 
depending on amount of extra CPU power or extra RAM.
The main usecase for adjusting the compression level that I see is 
making zram device capable of holding _a lot_ of transparently 
compressed text data, fitting into RAM at the cost of additional CPU time.
Hence this patch implements this only for zstd backend, which provides 
the best compression ratio potential (perhaps implementing xz/LZMA2 
backend would also help with it).
If this approach looks feasible, it can be expanded to other algos as well.

I'm open for any suggestions.
---
  drivers/block/zram/Kconfig        | 10 ++++++++++
  drivers/block/zram/backend_zstd.c |  8 +++++++-
  2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 402b7b175863..8a5e6da39834 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -32,6 +32,16 @@ config ZRAM_BACKEND_ZSTD
  	select ZSTD_COMPRESS
  	select ZSTD_DECOMPRESS

+config ZRAM_DEFAULT_ZSTD_LEVEL
+	int "Default zstd compression level"
+	depends on ZRAM_BACKEND_ZSTD
+	range 1 22
+	default 3
+	help
+	  Sets the default compression level for zstd compression in zram.
+	  The value can range from 1 (fastest) to 22 (maximum compression).
+	  If not set, the system uses the zstd default (typically 3).
+
  config ZRAM_BACKEND_DEFLATE
  	bool "deflate compression support"
  	depends on ZRAM
diff --git a/drivers/block/zram/backend_zstd.c 
b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..af7b919ec11c 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -7,6 +7,12 @@

  #include "backend_zstd.h"

+#ifdef CONFIG_ZRAM_DEFAULT_ZSTD_LEVEL
+#define ZRAM_DEFAULT_ZSTD_LEVEL CONFIG_ZRAM_DEFAULT_ZSTD_LEVEL
+#else
+#define ZRAM_DEFAULT_ZSTD_LEVEL zstd_default_clevel()
+#endif
+
  struct zstd_ctx {
  	zstd_cctx *cctx;
  	zstd_dctx *dctx;
@@ -68,7 +74,7 @@ static int zstd_setup_params(struct zcomp_params *params)

  	params->drv_data = zp;
  	if (params->level == ZCOMP_PARAM_NO_LEVEL)
-		params->level = zstd_default_clevel();
+		params->level = ZRAM_DEFAULT_ZSTD_LEVEL;

  	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);

-- 
2.47.1
