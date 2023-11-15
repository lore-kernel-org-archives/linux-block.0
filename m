Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13F3BB55
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e6IG3kS5"
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFEA6
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:37:53 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e623356e59so816392466b.0
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700066272; x=1700671072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qEoWtFJ2ZbPQeIDzSqBV/clRa0NgKsBGFACso6xedSc=;
        b=e6IG3kS5QzsYNQs35BixA3myIBtfQlFHk6YiOBQFHhdDdYau9RagXM1jxCBTuXHlmR
         mjZd0AQZpUgvQ46fYDc9cR7/rbkTNAEbTf/+TsFQaPjkQoET2p47EgvOEyvLkw0KabzU
         g54G9miLfeY5/t9nof0k69G2C4GTkFa9ndqUsmAcN/G5P4ZeBEDGy72D2A2Vuh88dBDw
         MZ7qs/q8IZ0185qJ66+oTJtgl6ptOA3KKX/AXutnib48KfumeLIN6cSSSY6XrWB4Ykno
         lq6eEA0l5mbJJUiyKCQhwHluxplMbfJq9UaPJysworV7Zfm1YatQ38a7UAVr2ZFY5NZB
         S6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066272; x=1700671072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEoWtFJ2ZbPQeIDzSqBV/clRa0NgKsBGFACso6xedSc=;
        b=uD670Tmzv3T0+ZdKT+QPKLNvS5qm1E/AQtSMWrMzOQMxzVhnmTuD8Af+9m0xBuX9OG
         VQo4lBBw8HXJN+3rKhi0lutAb54UDshdeasNx2RKdio5+3NUxA+nTVPoJ/Zx3JWMEizL
         NzBVKzkuFX+BphcTz0E6oqBmubH49UrW3wTstbD0k+Kz/w2MrlzOIduDr3UCG0KngdrF
         bkj45pvjfJ4fbhR5CTo7z/TCsBu/LKr2/NdJ7hv2JbOvLhS/H0mDELMcrwpOOxJ25EMP
         xVSelbZRAAa4+p/CAsqkYK/IuQduZWHrl2ExiYTjz7+q9eDz9VrrnmHLjtHuXy+vOeGb
         fbcA==
X-Gm-Message-State: AOJu0YwJJ2+r1a6pa5Q/iwWUJXzjRtxKJplfWGv9tbp/d8luZbI/rg8p
	mDp9EEC4pTeD3FH+RFRkthFZwackyjuUJaEodUQ=
X-Google-Smtp-Source: AGHT+IFDiEMaFzf7wIAVX/dt+kvu7nzdocFyTM//RFADzV5oOEjvjcXs1PaOSsKYr5Tu+KMvXQ/j0A==
X-Received: by 2002:a17:906:3c43:b0:9c7:58cd:b57 with SMTP id i3-20020a1709063c4300b009c758cd0b57mr11429414ejg.37.1700066272072;
        Wed, 15 Nov 2023 08:37:52 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id sa31-20020a1709076d1f00b009d2eb40ff9dsm4591316ejc.33.2023.11.15.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:37:51 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH for-next 0/2] Misc patches for RNBD
Date: Wed, 15 Nov 2023 17:37:47 +0100
Message-Id: <20231115163749.715614-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please consider to include following changes to the next merge window.

Santosh Pradhan (1):
  block/rnbd: add support for REQ_OP_WRITE_ZEROES

Supriti Singh (1):
  block/rnbd: use %pe to print errors

 drivers/block/rnbd/rnbd-clt.c   | 13 ++++++++-----
 drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
 drivers/block/rnbd/rnbd-srv.c   | 25 +++++++++++++------------
 3 files changed, 31 insertions(+), 21 deletions(-)

-- 
2.25.1

