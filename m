Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219C23FC5A
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786886143; cv=none; b=GM871T9eS56nZdTjdXLuuHq1/VAwbvqwG1JAGNZYcC3CVl39+1zYqEKS59OmUpjxs+e332gBk0/AfzmzdvavGNFsVW7YpKGp8EB/BtRjaVK6nkHsvpBmKaBM1XigO1FRjMjv5Aeti5hhYNFsRyhbO7puArlXhmgGkSjVWXbvUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786886143; c=relaxed/simple;
	bh=7bHEVnffJ0Ha1AmdgWjbxfy5izeofTmU4jrvr0MP5/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CD19gJuzHgSZpNz1yclr4H3P3lc1pZCtF3hPID0kZIehAwLiVyFosI+P6PdqXMxYtvktXhTShWB7azX9SmuvHqLeGCj66ZKMYdxvUnCHEFqBAw97ArykmwOCffqZNp9mzKk1A96cHIdDjLXqux5Oe8SZqoeH+uB81jehqVVjKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhM4HYu6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhM4HYu6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso2088112f8f.0
        for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786886140; x=1787490940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pv2jURNhPUK2tV76gyguAJRM2PrSOiDKR10eWUSfOs8=;
        b=VhM4HYu6l9om3s5PVkAvhKLsN9PjfTM4YgBN6TL1WvDz7mc/Rz4S/aSRp30m1zBNE/
         mViO+qhGTggpgBXva/7eW0D/AvQ1JYq/jauNbUup6w0QwYJoKiQNqO2sUo9idQy61NyJ
         Q5+Sm9Or5fsJGKd5EWNQGWSkY0v2u8fV95JB7NIw1bky2qfFdzquX+TkCCmcsBOdJzY6
         eUbmELe82Zhol2jf0NzS2ET99YsCARjB92qZf2mUI8S9rwYNu1hWibwtD1jTLUUNjwJT
         lEHaGTAQ2j6ZuD9X9b0NzCWpDhI5PO8CfvPyBsmMMlIQvvLeoBbdg6MZU2B0Ud0yB6kZ
         vw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786886140; x=1787490940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pv2jURNhPUK2tV76gyguAJRM2PrSOiDKR10eWUSfOs8=;
        b=BF2S4hNgfW5b4kt7G3e0VnPOH4ZBjw+Cbehra5wsNADyurcWwgSKG36daqycUajh25
         BKjR8RqA6ajjtaOB/8mEfi3D8LIou4+1x+9ox7XjmCdgDwNPGwTGxrMgXszxN2nY6UAM
         jmoiooHhMhMFlVvbxwKu3zagza8hU/zyo+9hKFxaFiozMarBIIEeIKwxLP+pf7uXOuQa
         Kg87OeKUri6y6zjfWA7ssiN9TIboyyLCwxpstjuXTHq0Y8QwP/QeH+jEnlEoR+fgD7F2
         ZrsQv3TcnsXxlJYUGXHoQ8Ip5uhAo57kkzm9fWgL3UFevzE+ag6LB9UqFf66YsISxJ8U
         uKtg==
X-Gm-Message-State: AOJu0YzDyTqcSaD9G1ESRZLDKCEmTLNKZCW92VSBrzkfn+4p9giy49sw
	tNmygnQf717S5rtkSN7st4jIla0XxnhvTDx4CHBGjaezAUwHHLEGZJxO
X-Gm-Gg: AR+sD100W0aLPgVFCkIt+i6JVeXwYI1fzr4TRNVLKL4S9yJCSPx838b4hUZlwydGCki
	Fm7bihu5h363do7/8M21YjuIY/SjLts2PQxxF4PUpKg2+Ti6zQ2AF/konVwSLcQgVelKpi4IMpQ
	JSw9ZVp30dDTQR5EAEfiB+7P8qYS3YbwJeezvjZ0CAhjryqzaU7tSZZHeZ6+03qsncpyMAgPVB4
	u2Ocg+rNzMtCjK+YxA0dghmPk5Dsb5Kwovbnazy00jl7P3wjCnM7GEnJ/SMn32weef6g7TOpoGi
	MHC+vG6KfncTyTavQRarPuss+H81PzW5cCzCcFjZLhrQuyE+QgCGZ/g1CPS+vB8rlftnic2sjpV
	qHkC7qzSH6O99iEV0ltxLIGMPQx3/z0ULPaBjk5yuOm9x8IRkSgsYSX2v6a/XJSWCv5p3mVfpB6
	MR64LufB1uTzjs5X4guGh6MqQehvIlseN/Zg4X46kGyzgg3RdpxgH9wvfu+dbh5aicFRvGKi+Uh
	lRPryCGLS6NEMNPmJgQH5xqz4lNXYLLeqcDGdzzKQ+56BA+yLprg6BMOoKWCaaLrBMI6K6hq+sy
	+dw2Ss6XNg==
X-Received: by 2002:a05:6000:230e:b0:481:60fc:edc6 with SMTP id ffacd0b85a97d-48160fcee5bmr27201126f8f.27.1786886139921;
        Sun, 16 Aug 2026 06:15:39 -0700 (PDT)
Received: from macbook-pro-de-bryan.home ([2a01:e0a:d7f:f4f0:306b:5f99:5378:73e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm24721295f8f.34.2026.08.16.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 06:15:39 -0700 (PDT)
From: Bryan Boquel <boquelbryan6@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan Boquel <boquelbryan6@gmail.com>
Subject: [PATCH 1/2] blk-mq-dma: fix kernel-doc for integrity DMA iterators
Date: Sun, 16 Aug 2026 15:14:55 +0200
Message-Id: <20260816131456.16374-2-boquelbryan6@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260816131456.16374-1-boquelbryan6@gmail.com>
References: <20260816131456.16374-1-boquelbryan6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_rq_integrity_dma_map_iter_next() documents a @state parameter it
has never had.  It takes (req, dma_dev, iter), as declared in
include/linux/blk-integrity.h, so scripts/kernel-doc reports an "Excess
function parameter 'state' description" warning at
block/blk-mq-dma.c:379.

The wrapped summary lines of both integrity helpers also indent with
tabs directly after "* ", which checkpatch flags as:

  block/blk-mq-dma.c:320: WARNING: please, no space before tabs
  block/blk-mq-dma.c:361: WARNING: please, no space before tabs

Drop the stale parameter description and use spaces for the alignment;
the rendered output is unchanged.  No functional change.

Both issues were found by running scripts/kernel-doc and
scripts/checkpatch.pl over block/, and verified against the prototype
in include/linux/blk-integrity.h.

Fixes: fec9b16dc555 ("blk-mq-dma: add scatter-less integrity data DMA mapping")
Assisted-by: Claude:claude-opus-5 kernel-doc checkpatch
Signed-off-by: Bryan Boquel <boquelbryan6@gmail.com>
---
 block/blk-mq-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 88fd9cbc951..fca7ac01e73 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -317,7 +317,7 @@ EXPORT_SYMBOL(__blk_rq_map_sg);
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 /**
  * blk_rq_integrity_dma_map_iter_start - map the first integrity DMA segment
- * 					 for a request
+ *                                       for a request
  * @req:	request to map
  * @dma_dev:	device to map to
  * @state:	DMA IOVA state
@@ -358,10 +358,9 @@ EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
 
 /**
  * blk_rq_integrity_dma_map_iter_next - map the next integrity DMA segment for
- * 					 a request
+ *                                       a request
  * @req:	request to map
  * @dma_dev:	device to map to
- * @state:	DMA IOVA state
  * @iter:	block layer DMA iterator
  *
  * Iterate to the next integrity mapping after a previous call to
-- 
2.39.2 (Apple Git-143)

