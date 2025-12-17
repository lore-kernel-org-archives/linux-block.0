Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F235581D
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988890; cv=none; b=RpfO16dSA80FHfDaB1irr/TR7fT6xXBcbGiHsBJueYQ84LA0hMf7cWjn0WKyzKA6sa11dtjhwKzzY1TmqsjOVSZJwHwwXfnsi83sgFawA2s5muzHarwKtNxuIx7YEpb7UxTYbQRYzjdzhGkOVrfByvpahBqpui23Q8h6XaOll4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988890; c=relaxed/simple;
	bh=hHiQ13HsCnnPciHjNgpzJZ953n8TCFCJOtTwd/r8PoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWbjYFSyp+X7OsUKNsoZbkQ+tTJk9Tvt04lenIQLdjo+aZ6BoaI5HdSI5dhS2bgIUce2E7DuvMaEheAKPkPFixGEh5LdsESmZT2FkowgjGZLtPSR845zkyhnChStGWvB6vgjkPMOrlzZnUzrn6u+/f6wYLqGQLOMa4Fl8ycvkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZMi5D8fu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZMi5D8fu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso2351269f8f.3
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988887; x=1766593687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJElybK4r9OmuCr9uVdpcrBwONyPRzk09mZYQhniuJw=;
        b=ZMi5D8fu2ODKZpQGF1dOBw90mD2ODR5ig/yMm0KcbgkCLTaKc7hUdNzas614aB0+la
         ZOdRXudFavbdltCYbV90KhV0AHlhXQJxomZOFxqwm0qWWC8ZkUIuNY/2sqzcBQTKu2Ot
         cOU16w/Gfn1W1aGN6SzYtljEtJhE/vZgvFjnuLZhshDu704kAWXtENMSMFXK/VlE7OAa
         2yFeN5Xyrl2iRm4AxNUHHMO1O91lyN8wpDgMflZOcAij5h2ZNP7fpc42mSmyDC76ekwR
         /jJRYLBKKan1IUtLdHd941qEcKgshI3HNqBM5V1tl3mvVQwng89xHSnW798Vu6HdMkf3
         U0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988887; x=1766593687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJElybK4r9OmuCr9uVdpcrBwONyPRzk09mZYQhniuJw=;
        b=eU7lUFhaC3ks3pWT8egsbbRGrq5sL1aCUwPQAqG7GCf+8n+1ln4FcCDMTpxW5YWMDH
         xHdD5VRlwvqBBIkzTGcNCVaF7ASUSPna0pcitaSK9PDjbZOKV2CUazd6g985pAFK/RSR
         MhMcXdo7LMTESCcJEAv0bO/9hSuzxSAYD4jSVSyB0iMctSSpTQc14224EFnzBilJp3PO
         l5C6jV+Mbj0sUP6bsIjxiD8idE3CyasW9riup655RhI5T8SYc9uoCYmoJKT+DdUv3lne
         uY3X5WvqxpqtpMTMelI/1JgFvTAuYL2v8GBsOJAFFS8ZAWYtdiItYSkwHTYc0T+t9cNV
         06HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU97ORF+bP/8MIay+Bmu5X+SsM+BbJvcvsD5uuyYoSKcffZ7oKl2xzCbua8jsiBgDSu3V1lhYSGU7wK3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyByLDwwL1RlBLxrx+CMvDXmPiBFNns3GWNUYSyYvKC3RJ+Br
	yf7zdJxMV5nzQLQpmazwDhUH+K0OsOvXD25cxvG856tZWTfYOsqBKUKVlk6QFYiZ4ao=
X-Gm-Gg: AY/fxX44lhH29bmKk44Dlqs+y0s+lLvKqmdihJ//ylwhH+BAccFsuRvG0phm7Ba99Iv
	wcYaqrMJFXWwJ/j8dWPQxb4sM51Kvysfx1qv77+OSx75dAWVmrr95iyBIfTR1xvF6euOHHH8ZrZ
	kgSA0tW28cpjJHDVFhELpnYRBHzk1yIVCn3oM1lrHLm9XXIJPVvnMwfaYl9cwICVmSDl1zSdemh
	fhJmf7Dq37eym7exFXnunpVu1w1Oma5cqTeBS8Sa0156xqy6SNSGIs8OhsFhYTbouHle4s2qgl0
	H+MQNHgBWq55YDLUnp/eq66/84DgsNweCn8fWAeh+ffrqgYDY8zjH/VMWxGQ6Zz968lgTvBA/ga
	CecUbtjhWf/Nv5anSYUwDBatZF0vAqMYtcRZbUQhY4V8sxWGZO2PrTpb5ggY/mS5yqBdA8r+lWM
	EG2loR2zcwwRFNmdJS6BP7uT/Bj6UzjjI=
X-Google-Smtp-Source: AGHT+IGbhlvyzEjuDTSV+fNvDCFi8GKeD7MdXF7NnWLDDEh5pN2MML+EtVLT61FA020HJ60pRPL1yg==
X-Received: by 2002:a05:6000:22c3:b0:431:656:c726 with SMTP id ffacd0b85a97d-4310656ca9dmr6412349f8f.3.1765988886936;
        Wed, 17 Dec 2025 08:28:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:06 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
Date: Wed, 17 Dec 2025 17:27:36 +0100
Message-ID: <20251217162744.352391-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This comment is simpler than reworking level users for possible
ioc_gq::ancestors __counted_by annotation.

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b4eebe61dca7f..c5e09ebae5ab0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -545,7 +545,7 @@ struct ioc_gq {
 	u64				indebt_since;
 	u64				indelay_since;
 
-	/* this iocg's depth in the hierarchy and ancestors including self */
+	/* this iocg's depth in the hierarchy and ancestors excluding self */
 	int				level;
 	struct ioc_gq			*ancestors[];
 };
-- 
2.52.0

