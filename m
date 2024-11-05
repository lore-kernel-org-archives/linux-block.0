Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81771D45EF
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807447; cv=none; b=HOG3pCqvPpBUtnDVnira7I3XEG9RktIZsjbsk9TpCNBtpoIPl5v4hpnHyPmi3cu4jI6F8tuY5FuPXT+DguFYKAYZEh8rUhgrGWaVSg5i+IFEGj+zPT6dsf1XgCReqfLhGgVg93BakcD9P2xZFpU7XEvaLefZbLu7DuFLDGm/bxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807447; c=relaxed/simple;
	bh=eFmDTZ0mvH40C2n3riuUszzKOF00psDdI40q8+QQoxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ChvHI4X42A8Abbc1Zt9YluTjbU6be3dxcc5cXIbSJxusEA1RjG8woS0871lXxsNb+EGrueetv0n0gHvGoLiU/wGaqIx49eIhqm3l6d8vIq4ZxgttIy4a6TirHdM3CZzlIII9pfSPi1sc9XtSQcc+u2NDIqAPBz+VOCaKIKQ0f/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ae0d:26ef:36dd:9be1])
	by laurent.telenet-ops.be with cmsmtp
	id Yzqd2D00131l0Qj01zqdxS; Tue, 05 Nov 2024 12:50:37 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t8I4f-006J5k-7r;
	Tue, 05 Nov 2024 12:50:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t8I4y-000nlT-Rz;
	Tue, 05 Nov 2024 12:50:36 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] zram: ZRAM_DEF_COMP should depend on ZRAM
Date: Tue,  5 Nov 2024 12:50:35 +0100
Message-Id: <64e05bad68a9bd5cc322efd114a04d25de525940.1730807319.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Compressed RAM block device support is disabled, the
CONFIG_ZRAM_DEF_COMP symbol still ends up in the generated config file:

    CONFIG_ZRAM_DEF_COMP="unset-value"

While this causes no real harm, avoid polluting the config file by
adding a dependency on ZRAM.

Fixes: 917a59e81c342f47 ("zram: introduce custom comp backends API")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/zram/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 6aea609b795c2f36..402b7b1758632807 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -94,6 +94,7 @@ endchoice
 
 config ZRAM_DEF_COMP
 	string
+	depends on ZRAM
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
-- 
2.34.1

