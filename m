Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5163B6BE4
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218613; cv=none; b=SHcNqbP6TmLVK7MJpI2cSuFhqP4e3pf4Bphvi1WxDMOidYLQnGZ3QMoLwpl4ZMTswsc/amP+RL/5khJtqpjs+kGyN6/nBA5lSt97JefPMSe6QnrRo4WrfKncBgDKhlEf80jUJO72/YpJi1qejRIpC5okj5aNOmce7TtLdPf4rtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218613; c=relaxed/simple;
	bh=KDc2ud2l7xM9sZ9vfq1eC8pkoCZGZwHQWrSdOUShWwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrhXo/LQVshvTEGQJyJTp9PsgCvTeEL9fhjrOxWHCLsLLunpj7MyhRae052E85SC2OEG8sLJ5SMfGHfrGLIa3Bru2377YFVYq5lBZl4wpuzZtL3/lOSP8IwG1AnLr7R72FKFnktPg4f1TJfPfrzCIXtJVDFIBlEFI4XIqB4ZymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AvQMIgRt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AvQMIgRt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aaf43014d0so101718495ad.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773218612; x=1773823412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opLhtgMBHI5PHBJ/QKK1QZfBQHPqKZenu2IgsOh/g3c=;
        b=AvQMIgRtrAo7Yt7kdJKcJ0joQ/j3BSvd5SPSHGxiis1eXGgEE7fajeZ61lv/VNuJDN
         QaiSY94flulAwphHUEoWOr9Byh6EqY6i8FK+VbGh6UwQWMxkHN9+JIQpwZ1wGzNMhSrG
         eH2AqrKHZX6V6qsAB4ApjJoLsJPWTimlD+Z2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218612; x=1773823412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opLhtgMBHI5PHBJ/QKK1QZfBQHPqKZenu2IgsOh/g3c=;
        b=NiA4JrLYvH43IvrV75quosn0OqkdS/nObsGUvXI+F+RQEguPaeMmKNGT/QME4h6F9x
         T1F3wexp3K1HIkeBFExhxlr9RLg+AFq/Rcti6sSL8BfKSS0gexgHxNo7929ul/5bk0mU
         F/j+AlCRVfsBHSsySagea1lEE2da/3TtNoyPiYKpjlbl+mrn3afuKnYHD/CAVStwe6VI
         7G8TSl7DRMGKSesBZeQ4wp2HNtLmiih7cCwje20XZ/mOc/3pt3pubMbsvM9iVS3zSAuo
         oioprivgG+KWrw8fmY5LYXfxbLIO5FROozWeB6hzHmaTw8OCPvvcdRshcKz9KUMkrX8n
         6EMg==
X-Forwarded-Encrypted: i=1; AJvYcCXYo9pHxa4toxhNhGoLD4Zzvn5/ebfNHPndp7wz2HmfSmQ3Lfggv1YH2zzC8Slq+51L9iczOdvZkce/lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyodwr68uy3Z2/BxjtDf+de8CZMc6hvVQVdw/kpoHspC7aaV6Ke
	Cxj5N5LhGz3lvOwNX1zAAlSiWHwJB0htg8X0qyQsKtBUskhwAPaLQsy9OXdrXU97ohZxSCISbAf
	i5ok=
X-Gm-Gg: ATEYQzwH1VlbFCvZtL5WxXKWP95gIU3wkXDafChtqXyX1jpepCkIMhlMKF633PyAgFr
	W4DOUXT4n9Vb0X0UhDvP7ngRA+WdEbHTnJy0ZG2RpTjdlb1Nf6x77oRK4+YjkLjdgEU3olEmN51
	4D1ZlUMy4WrL8Arj+/FXcKeX82Cbgg5JVCqddv7Gkdlauq7wu4CuQAa3o4D4n7V6tjjrmfJ2QCi
	zP1fK2zf+MZJMyM8ttV6qIwG09siciUk4ABWK7adWxO6kApDmX7P14b7ustejIRrqLRyf5zgSYY
	WWnfv6SXOMI7C/Nn9ewe60P9/uRzDNMSm6OZJtM4lrqT86BDi/KoQXBBm936rbRNWZQXJEsz1AH
	oiUHgKGeAjaV/8Wem+bhjwP0xho8/e60OFHKV0CsB5xF+FZkPoUVQ9whnT8X0TPA2Y87SFs4Q38
	OdvhfVbAwWRJV+tlJmV+soEOgUtbX98w9WT6EiUB46Y2If2ahq9wruQXq5NvMXaofl7KUw3435T
	VvT6puXbMIRNw==
X-Received: by 2002:a17:902:cece:b0:2ae:3dcc:eb1d with SMTP id d9443c01a7336-2aeae7b425cmr18071985ad.18.1773218612065;
        Wed, 11 Mar 2026 01:43:32 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae261077sm16062035ad.40.2026.03.11.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:43:31 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	gao xu <gaoxu2@honor.com>
Subject: [PATCH v2 1/6] zram: do not permit params change after init
Date: Wed, 11 Mar 2026 17:42:44 +0900
Message-ID: <20260311084312.1766036-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311084312.1766036-1-senozhatsky@chromium.org>
References: <20260311084312.1766036-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, algorithm_params_store(), like any sysfs handler,
should grab device lock.

Second, like any write() sysfs handler, it should grab
device lock in exclusive mode.

Third, it should not permit change of algos' parameters
after device init, as this doesn't make sense - we cannot
compress with one C/D dict and then just change C/D dict
to a different one, for example.

Another thing to notice is that algorithm_params_store()
accesses device's ->comp_algs for algo priority lookup,
which should be protected by device lock in exclusive
mode in general.

Fixes: 4eac932103a5d ("zram: introduce algorithm_params device attribute")
Acked-by: Brian Geffon <bgeffon@google.com>
Cc: gao xu <gaoxu2@honor.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fa38d26119ec..db862179cf59 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1750,6 +1750,10 @@ static ssize_t algorithm_params_store(struct device *dev,
 		}
 	}
 
+	guard(rwsem_write)(&zram->dev_lock);
+	if (init_done(zram))
+		return -EBUSY;
+
 	/* Lookup priority by algorithm name */
 	if (algo) {
 		s32 p;
-- 
2.53.0.473.g4a7958ca14-goog

