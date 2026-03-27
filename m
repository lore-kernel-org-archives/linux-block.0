Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD139EF17
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651177; cv=none; b=nwKvOlKXdeOEzb9fY6BEhcymijWZrzpxHB5r0NxAXdNueiLXx6ctVblkzps65YxV7GJGOy7LnYQPCyXt1LgISr6shRas2DaLjvzra0NjoD1o1QMU0EAhB7aIK08H/sIbQ2mfpd4iutA824PJw1FSdAfh7HYb2yIZ4h+T6hy4bjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651177; c=relaxed/simple;
	bh=zkIHiu8a4H8PvrMYhV9Xu2CrekOHCvzxp5XX6QHzxac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brwgl17kEYCnYsBrlq6+cObkLfe5T6RTWECGXTw4uYJZp7Az39sJGtZLnarPuM6aokMwlI/+BsRmKeFc5XTLq+uvyzNFf7VW2raYlajiqjgWL739uJMMUM+cbUkuskN99491EBy5OuQeJ8utVR3RfdFr2BSIXMfJ+eTp39KXNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=VjOatt2e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="VjOatt2e"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so19485645e9.0
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651171; x=1775255971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VecWmpi83v+PE+reglGIWmaIkeSxUqDGWr/8h3U8fxc=;
        b=VjOatt2eQ9DSKn1oa2MsaUiTn2tqb1s1hSXBHy/Bmwi9aRc4PhrA7xF9l8sqJS+wTx
         Oqg7GTD0fZ1YorjX1E64XSZcvYzRNFtPVUkfplyCoMaFfrTJnAI/ZRdkPK3p/9cFqG4P
         AIdmc6ZF+K6u3Nkzrl5NuycRt+sRVb6CJmoU6MjrkNdKnkPpHbI+jbSLKOBO/2aXuQl4
         uJqBYyfQ7aQfV1q9Iz4/Cx6hExJnDf8IJbnWnWerm1u5X5GYFIQNHKj2u8+Loz4yXz8Y
         3fBb27GKVOQ6xjV9O4NeaDUMpuhRscTp5rbZxA7xFE/T5GtEvIGJdvmlAFvibkXBM9GA
         JBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651171; x=1775255971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VecWmpi83v+PE+reglGIWmaIkeSxUqDGWr/8h3U8fxc=;
        b=bq42GQgIMJJMmoujwL8rIxltjEI7rer/rV1K38cJhGUV/JdAUm3rEA82H9h0EO/L9O
         MV6y93yidFcZknu3iUm1/qEi/YGlGN2LX9iTFeBfHPXxSXsFdq0M6XfXtAXVImdnOUdH
         nP8a0upuDuQqlbvj9YxOvSQQOxRPV1zqJMSiZ8v1SWRoywxb/tHwBSa1uM+7FXeeLS0A
         znw9iZZ1uQzAfEu+ZlYNIHJZvBVwN6RxKG4i0apYgWQhbS4OUrLcF/SdoJjJqryBpliW
         gdyaSB7of0vD/aYR49d426as7ZDtrZsifqCSRGl6HK2R3UhbK6ae6MQg9fWaWnLbNNG4
         7j2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpHaq/W4qfq7PN0EKqfWFiv6rcxnnD+95MmB4ZetAXm5qZSOT5F5zltNJ43ZmaUWRohRkKRlFNTfM3Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe92Jf//3upRc8ZMM3RSnsAY0uN/LKssPQmzf1/YUol2oDobCz
	2bR+lsEua0/7pck5VmZjkXyTXRjYBR60dpkEHro7cQ46i9xgDmY2yvGR2XVN13gbucw=
X-Gm-Gg: ATEYQzxcxUl7OBwQHtoHpslIKrSExC/eeo1ju5bBAaLJcIjNIcwsiHolxPTV14dOk2P
	1J9iL8zJJuJ7jdg9do9KPf5i90EtjljuvZ1R+XEXGNkWhoP+X2hO/9D72B5F+AcUflYhhI4Lp4A
	/KfTdIRQmvufvtPhslfcLiA9oqp1Hta9Kox5z70BN0Cv8cUAMpbz7nKM+ooO4skqS3Xg8dyq1yE
	FZ6XY3YCblSSO8Rf9SfIAKiMVB5pJzLNYzqfAFYtPHEaPHVYv0JCC4i3t0aychLn7j+iqwSjGWk
	a95PmploDtoEXHe8fUzfPG0eSUfxSV6pY84sUSi41quPMRh6mk65ckkx2Z5jV/l5J8FMkUGTnXu
	95vJrfsoqTcwA8iibJ3/swiumHxQBpoUrClbchrYoJSurrs2aYdTD41em23HqEnjIL833cR8+aK
	dScVLn215hNWorBidnfn+zAGiwfVEWs2cdj38y7uZAu9TxMqPugQNMhIlqmNFRfM076oavr2yYA
	u3x1vkqb6edGZiVhQEvqQ==
X-Received: by 2002:a05:600c:83c4:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48727d8816amr68969855e9.13.1774651171200;
        Fri, 27 Mar 2026 15:39:31 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:39:30 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 20/20] drbd: remove BROKEN for DRBD
Date: Fri, 27 Mar 2026 23:38:20 +0100
Message-ID: <20260327223820.2244227-21-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the BROKEN dependency now that the DRBD 9 rework is complete
and the driver compiles cleanly again.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index d4975c21d4de..ddab8d4ed40b 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,7 +8,6 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
-	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.53.0

