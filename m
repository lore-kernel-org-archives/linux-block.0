Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8E380FDB
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380030; cv=none; b=FbLXU9XYt7a3IFHoAya9tXpI4zPD88rzgN+Pl7hgLZK/R9odqZWNMwQjyIS+ixh2GvJyDf8s/+/+VIq34vv7fVszLx7ZkNqX+amH6ar4etwEHBKs6plJnZVSyo4V2MF6Y5sOe5sQDDwtPcKNDUo66HE9buZVS/oi4ehM3zoPd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380030; c=relaxed/simple;
	bh=jXcTbfOcZI50P7oqH9SjfD0ladlQdXpVuq09YIbedJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU2Sy2WgwhhLg8HLk+Amiz5XLPh4TRRd+1hGIthsoCwq5shGrT/goeaKFcTS2Lp6r9Twdzx6kqRyJ1d1g3+kKr01r98D1xb7gvZnBzSVrAvTGzafAytl3gHyqRlYsLhHA0+vYY5RjfBnpDu4CAZWnfbO/hS43LN8vDpmGdn6804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgPFCjbV; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgPFCjbV"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so8161645ad.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785380029; x=1785984829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5MbLfjSrnJWWI1jI1OLfdDvpjCDKU2sxe/DK9xe+OM=;
        b=hgPFCjbVHBCFYB1ZFNR7DrfjQB3oudJQKocP6lRHgUf8Uq070C5zL8h7BT1dDnB2B0
         LwR6Tji9LUqNlCetRpNDo51jfXALAiipXkdxcxmCMDCFDoZ4NRJVLatYGPOXPzbPeSHS
         OQVQp+iLClXbS6UIbrwbbRjeKvJw7fvP58qSYp3qFjw1It2rSEUUk46/y3sFyMfK6lf6
         AefiQgge0iOY24NyQpQtvDHEtlVoUS9hEfJUZFODp5lGfWS/hb83SVWxO9r/l95koitr
         Dayzv7gaVM9iBHN+aAtcaiOgbUyIivCEQZvWelECWVnRJDXiJNi/oELGlMakca5xXz0O
         U3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785380029; x=1785984829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5MbLfjSrnJWWI1jI1OLfdDvpjCDKU2sxe/DK9xe+OM=;
        b=iZcUy7iFhmo0Svgdqf2Qt+rywv3ZsrYq2TV2xmm9kUIQG1g6sydiL4zHd+SfavoiqD
         lYFkSK7GphPeSPX6WPuWwOnhlejbe7hh/LWXyP72CMNP14Mq+GbQxJRBI4W7jv1VXiwv
         74+DQBNixGVe8q6z0Z5rhN//PstHaIfsHy218UYFmHaUHIc6M7gdtNpGm4Bw8eu9O0vs
         29ctM5krUWCUrou+rZdrFInYnx8k+O1mdiNf3BTHhhE2PwGfQn1wzwwrfP6AxJ7mCoxi
         y6utzc5a762Lw92H1sPSRwHnOI/q1QTf/FQjqfesiVWnwjIlygFbmjdW5zMENTrbyYHD
         zyzA==
X-Forwarded-Encrypted: i=1; AHgh+RqXFuBjr2gvhQZSh3+IuaMwDtv0eX28pOAdgsSNbnd9tqsJE6nQKZRA19OAP+D7dD+u+Vpwf4hcMPIyUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFl0KVBuPBuwFT1h2KP+juELdG5NOLN2NIPHGe5R1vl/ZpTpOj
	76Ab75C8sxw9cK8QMCSmGjp1u+CYArb8FWXKyrii4vR36iGm44Prb41U
X-Gm-Gg: AR+sD10E1TVJECY5RRPUM32oL0U+IRCgtQBFPhjteAsFJe4ciukad/6SCENFzPb8rLe
	jBaBAWc7LQzRefKACV2M43sv08tMH9hiN35tWIAHj2vuitRpY9dtpxN8Or6mmvjJEUcDtkDG8lG
	EkYYCNkQh+XWWn1l74HUwBgRPXTr6wUc8UAtTbUMFqjFSRmD4t3In+oPFM8q9kgDERshU24rMtU
	UDADdRaQxmmwR5b+QE3lsstfFgfg/ofiwxqLIEc6nIh3CVL/WJwWEHTH408+ZS/1Bnj7CjvUh5o
	3siJJXqHahhGt6CgFrpw/h/l0rlU0ubJJXoebAnFnkdOpRgn/7Aj6cEPsoEV/8TNAiQJG2cGHe3
	vFuTK6V5Id8ZIrpGhdFakX9OakFeT5cv9EyX7Yii9axTJ0UbH90iXIhF+LZ8y+YvI/n5A86ksys
	YiX7y35tgfzq2yzc2JVPM0lo2M8gT4Ik3zUSfsFUrzJtIgtGcbWCc+jQsfF1DefdcnoOKaoBgKB
	H+TVTVvBxuBwhFIFFRFDtEC5W1QHzw1PFwloQg552rR
X-Received: by 2002:a17:902:ce8a:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d035bd7e2bmr9924345ad.14.1785380028722;
        Wed, 29 Jul 2026 19:53:48 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm18656485ad.69.2026.07.29.19.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 19:53:48 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v3 5/5] zram: reset per-priority params when changing algorithm before init
Date: Thu, 30 Jul 2026 10:52:40 +0800
Message-ID: <20260730025240.17724-6-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730025240.17724-1-haoqinhuang7@gmail.com>
References: <20260728092935.31139-1-haoqinhuang7@gmail.com>
 <20260730025240.17724-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Parameters validated against one algorithm may be invalid for another
(e.g. lz4 accepts level=65535 but zstd does not).  Although algorithm
changes are blocked after disksize is set, they are allowed before
device initialization.  Reset per-priority params on algorithm change
so that stale parameters do not silently carry over.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0c804bb4a701..b4585b3bc576 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1661,6 +1661,8 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 	zram->comp_algs[prio] = alg;
 }
 
+static void comp_params_reset(struct zram *zram, u32 prio);
+
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 {
 	const char *alg;
@@ -1681,6 +1683,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	}
 
 	comp_algorithm_set(zram, prio, alg);
+	comp_params_reset(zram, prio);
 	return 0;
 }
 
-- 
2.43.7

