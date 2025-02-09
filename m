Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445181DE3AC;
	Sun,  9 Feb 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104521; cv=none; b=h6Zdx21TbwNRuvQ7tT3Dhou1mQWnguRryzWM+J/HAjSvvb47WTNWO19aiIsHXqtqauRXk6SRXkTaN4C7KYYrLX9xPXzs1GjP9x+OTnP1U1fw3SsBVA2SNb0nWmPFRAssmK51SdKxQBxEvhyRa0mOBSViMMJZZEVks0UMd2RMYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104521; c=relaxed/simple;
	bh=ce4F132fcqciOz/gW81f3drV0BoX4GFDFQtMSwOpGJA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XpN/baorjHAYBwOABF5Kz2gp6NElrkSMsoqBFo80chMGnQBTC3kt7Wvz0upEcrcm+Oe6wSlF2S1WRQYHP3pt0/G5yX1yeqy9gpm6K2nnhep5nARQ8kZRW66ocBslXRs3f9yBQ970UEMIwuuX1AioEKDE6nrVd1CftE4d8Cj7u8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HgaaFxi7; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HgaaFxi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739104507; bh=xgyDXV7/Yrb8cuza/B0hzVeTz8Pkefq1yLWtX3HgNoA=;
	h=From:To:Cc:Subject:Date;
	b=HgaaFxi72Ot91VDYcxhZAdHaUFsIBs1/5yJ0WHLCeRrICUJx/7+t2VEMHKbCqC/pV
	 CqGE3KfaJdUWfIoYiJ8bVJ0cz/76Mq2HlNOKaLtDO6dJJ9wmvMlPwRdh0QSuCouRfP
	 vSJ+Zo8/RenW0VDCDLFACXHa4kQ7935OeDiyaMO0=
Received: from ray-virtual-machine.localdomain ([120.196.143.198])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 8C685829; Sun, 09 Feb 2025 20:35:06 +0800
X-QQ-mid: xmsmtpt1739104506tjmao4yg5
Message-ID: <tencent_208A5FC4C96DBFC52E02FC3CC394272EFB0A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9xNXTQCuF4oFAxd3ll/jQe5m4vjVt5IytFhd8WaQEP5/qWGq6x4
	 yRLEMK67sj0prxwUXOXe4mjiM0CCU3j8ECPYSy97HSAycT9EMjfO+/rgR45dHa12gxdLCST59o9R
	 IPMTeKUMm7HFlmrUvQ4Ll6vB+YF1m9ayLVJHhWsKTiM4KJzJgSU9xk6E8fvMGAByOYq/Te7RG5mT
	 J93p6cM6tkQwbzW8vNqTRNwtk8yEreM/TeUETmkKjMGGZznf56HTyTDunkdGdObby8YHqfP0WYr+
	 R6E490ahMSxIiq32uxzJykoJ8cs47Z+4V/tlTV58kb3V6FpNHuQXRA5Uxt+qB65dCeE3/Lu+OR4N
	 4wjn46gp664N2g84k9a7PBA5+w3dhIAIXt65SKXevwZvCgJdUh2/43fTzBbr+51tu3k4ZgsZDPXt
	 suz8O9uiQd8dv5xA0UQSsbXT1o0qQZdD+nj8/S8R0+++GhnV+4w8JXzHHs3H9yUFC2vz1rRXqXQ1
	 w2Ga1D1hZFe3++SErlvSlzHrtxxTgNJSmjdwjBEeesZgzgPvnrxqKIrCsRuRq/7+P0XOHfO3ktN/
	 uI3DFwf8gZEVY9R/kKZigC9h0ajCWl9iFrCSq/KSJhdhZWm464mY16Zptxr/ZOHE/KkvaSvZ5eMv
	 MMDwznQqasKNjRFxs4K8g0btRhvKqX4xnE868MNQumfJ/GbmjGLqwJtbuh0FYmZ/+vAgdovSV4Ye
	 7UG0g1gM12pxkvp5uWGuPQtCDC0D0VfLwTzplHLK53D25znwzlKOwrK/P9VJP7DXWN+BwxV2xEvq
	 yHao9+3nwVVS+7XIRnmiJ1kAaHmJ77t/kbVhlIC89/hmmtQCGFC31ltiFZCTwGwJWdas5ka94KQ3
	 HCr7CCxO5oyaDyWEELeEXgT0pGwt/IFmAGll11mNKlLamcp65X+BgCBXL82YuvcSGwp13/kCBZnd
	 ozkwuGT0tqA9mknxgo0PgjwerxpFYVR9iEsiIyCWQ=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Donglei Wei <veidongray@qq.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Donglei Wei <veidongray@qq.com>
Subject: [PATCH]     block: Modify the escape character
Date: Sun,  9 Feb 2025 20:35:05 +0800
X-OQ-MSGID: <20250209123505.273707-1-veidongray@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    The iocg->cfg_weight/WEIGHT_ONE code has a data type of long unsigned int,
    which is escaped using %u, which generates a compilation warning.

    Signed-off-by: Donglei Wei <veidongray@qq.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 65a1d4427ccf..693e642d4235 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3078,7 +3078,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
 	if (dname && iocg->cfg_weight)
-		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
+		seq_printf(sf, "%s %lu\n", dname, iocg->cfg_weight / WEIGHT_ONE);
 	return 0;
 }
 
@@ -3088,7 +3088,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 
-	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
+	seq_printf(sf, "default %lu\n", iocc->dfl_weight / WEIGHT_ONE);
 	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
 			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
 	return 0;
-- 
2.34.1

