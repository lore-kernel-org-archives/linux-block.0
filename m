Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374093CA4AF
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915088; cv=none; b=o3DORRYQXGoeHNPvuBbnNuAnS2yZ2h8xqUECWEXfpSyIDgAlRvoxbS6TY14dO9JZBtp2WmKm4i9p+xZKrQM5WU6NZ6ctH16YRIOZ6RWZ8N7qm4szHtcOJem1noyVKzXkCM3rdgYZpasAz1Ivw8utBRS+hXAEqOb92hlVpy3n7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915088; c=relaxed/simple;
	bh=Nr/49V3K3K9rsc5HvM0//hbd3nY6n0Vj+jQKXvT862o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/AMq97byIPlrCcCMAOMJi8B2zoYHkq7hZbgpPIao4gg/CM307k3CyhYNqXWpBgTiyA22lxYvqg10I3YGr2Pra4YnsivE5ww3MjgdvT6fCkFul0LPvJaoMrYwhkuXTij65jThwzi+cxfHEYHckEpHakonMkZRdrfFj3MNdRYmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSZId2cH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSZId2cH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so78797035e9.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776915086; x=1777519886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/0NBDoaUULa5jhIFU2p1Dzi9sq8Nje+/uJCYxP7zyg=;
        b=YSZId2cHAuayzF7X1IRwf/jIOVRiLY/+UESij7O9nwXr23wQRDk5nSUAWyzdpvwXZ6
         rtLqwZkcVbJvgewSeWXko381i1G5dy9FttB5PBOmPfrGhXt7Syg2/j52sVIbv2XPyPN/
         5hFstApcdeJur/J2w0i39yjKPPtm8cd3iJd4fnM2ZHGqIOGRWJeSyRAqizJFpV+dbca2
         GF6CmD/zoEnjKXf1dlgRfmY1gEkNZuS4MhI+P05Xle6XcIAjqjWz+nJpnVtvsfPTY40q
         foWXgPbAIAq9RZ2tGrvE36g6r65srpsMzw0SYo6KQkUHyO48OVRfxuLk1y/yrtVnsZ6i
         LhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776915086; x=1777519886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/0NBDoaUULa5jhIFU2p1Dzi9sq8Nje+/uJCYxP7zyg=;
        b=PTaDpqnZsr8WxN86sKzYBKXo4nh/WS2JpHPpQa9Bfm234NQJt0965VhJCk+GW6O+JH
         eJJTfATCl7z4Kf2ZGgmKqCwxNjrTAvVt6brp9kDiNOvek2GuukdLIEF/wAE2ZLRtgCgV
         IcwXs+dSxG31rRt7wvX+HbOumH2BFVPP6/jjmW57kPkxFABWHLyTQ2skkG0MVXSuTUPu
         4d9XnlnwTYgnR49JxNJHTtQup43oGnJlrxX5BeHmPDj5MZVbzGrxxQIjUaILFZcQt69u
         Rk+LufgkT4sAk9Svq6asssNt81smzt09xMWtTQzO9VkDbRe2OjeJKMfbdIU20lEMMWiX
         orBQ==
X-Forwarded-Encrypted: i=1; AFNElJ91uIO+6jn+4LTHA8AxTD1u6g3MVV2kicQGkd4pXSzHYCG+Lh6yvoVYtjovb38vLWMhnNZ9rTbaeEHYqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI9GtnHh/O8+fB8/LnRMpr4baXEDlxaLzp+hWjxSL+CuBsrZrJ
	EMqemGOqGG7W3UTNtqnv5wtYtsx9COsbTbFAyPUB06HdCs/HZJIJPfop
X-Gm-Gg: AeBDieuvRWoUhNhqeiCt49zk9y1MzQn2781gBzMLSRfJfV6yzUdmfbEf/KDUGWY4ozz
	bTMr5c13F8G0c6KkE/eqtiaWywBPoe1m0G4jLLZTAfe91eLUoPehEM4KkuQgLc+UsH8SD2xa5ee
	NJRazoSStOzXvIPDB1CZrBjhIoBdbfGzq0chS2v+AZ5tiIUjyNqWcH7mS0++TQvn8j3NFsIKRge
	7HPil0dziwnmaTNbwTBTJWmTu3lPiolXUR0+e3BgOUzOlTrBk4jpc22HscNY8tfB4UD5ZOQLfZN
	eJXdCHxmZh8TKwsW2RAAxN9KVLapss5xfVoZ2ZH1+byqSlscyovZirwPQNroePbNKcuLbFxEXHS
	U+/2TadiyRF0pXYnxKYF08fAJ6+lTGaQ+v/nq82RVHhw3ziK8lks034xuowWPpkfGsCOZ2rLJQe
	pjReD/wC/BTQVSX4AvaCnrFVcKnS/z6DMRWPC0jaLIC7pSppLfl9uVglbI6HC0KZ/iYSp17aB1W
	hx2KXjVjkhe/uSKO1U=
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr359737545e9.23.1776915085583;
        Wed, 22 Apr 2026 20:31:25 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm104438085e9.2.2026.04.22.20.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:31:25 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 1/3] ublk: fix maple tree lockdep warning in ublk_buf_cleanup
Date: Thu, 23 Apr 2026 11:30:56 +0800
Message-ID: <20260423033058.2805135-2-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423033058.2805135-1-tom.leiming@gmail.com>
References: <20260423033058.2805135-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_buf_cleanup() iterates the maple tree with mas_for_each()
without holding mas_lock, triggering a lockdep splat on
CONFIG_PROVE_RCU kernels since mas_find() internally uses
rcu_dereference_check() which requires either RCU or the tree lock.

Fix by holding mas_lock around the iteration, and call mas_erase()
before freeing each range to avoid dangling pointers in the tree.

Fixes: 5e864438e285 ("ublk: replace xarray with IDA for shmem buffer index allocation")
Reported-by: Jens Axboe <axboe@kernel.dk>
Closes: https://lore.kernel.org/linux-block/0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 49fb584e392b..e8d71617fbda 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5469,11 +5469,14 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
 	struct ublk_buf_range *range;
 	struct page *pages[32];
 
+	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
 		unsigned long base = mas.index;
 		unsigned long nr = mas.last - base + 1;
 		unsigned long off;
 
+		mas_erase(&mas);
+
 		for (off = 0; off < nr; ) {
 			unsigned int batch = min_t(unsigned long,
 						   nr - off, 32);
@@ -5486,6 +5489,7 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
 		}
 		kfree(range);
 	}
+	mas_unlock(&mas);
 	mtree_destroy(&ub->buf_tree);
 	ida_destroy(&ub->buf_ida);
 }
-- 
2.53.0

