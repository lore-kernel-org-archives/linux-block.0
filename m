Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61716DF72
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nk02B5Fp"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EF128B6
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 07:15:34 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77773d3246aso25357585a.1
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699370134; x=1699974934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSo2uHzA475zg1anJM/RFwUnIs9F8vQ48D/x02K64wM=;
        b=Nk02B5Fp7jtkBtCEjeJc0gW6rHkaAcJurdgMAU5EHi08tQkHoNl8yLhjRsuz5wZ1zr
         ZLWvXuYWkzGDIdoc7BmdikAKtNjMwEjJeEJyZUm0NtXGdllFoYxKqW1F3FP0CL5+GmLN
         UMF1brx+luBkREGTkRJ22fSx2b8tSJwztJKrobbTjTS2JodKwENlM8G/gqQRCI9LM9/S
         3duTO5rGaI+94Zw9FCbURYgbDq9sUmDahq1rIpG/mi4gs/c6FWm96BoHokmOgBY1JL85
         d0x0lETHHH27XG8YA3HWY99suL4BXwSUzKhmZdKaITUsefoixTWqbPTOaFQmDTemz2RQ
         IYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370134; x=1699974934;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSo2uHzA475zg1anJM/RFwUnIs9F8vQ48D/x02K64wM=;
        b=NzgCA2/1eRdRSjE/fRWGIYNwZoPFfuqS5nr2InsPhpSqZ1ghBPihvU0GKN/dZ5qlFj
         jwgrb+IHXzijTHwMkh6UKZIcA4UNgs6ipoItoRC3EUlX7KME1eKJs+Fj739EurYlopCy
         utxmmW7auQPzYhnRBywZvjnbhq5JYPQ67YwghFI/uzWvNjKhZ1D5YL/GDWJRK8MuUE/+
         EgZ1wuE51FA8z5neN+iYSreyMNdvG44dfTw6Xa7G/+Q8xqUjGV9TQPeS2KuFk4YG4v3e
         ATWNriBm5UeiClFKBGF9C/HgR22yWudp6T0ktXuvX4EtSvA1Yt7qcvwa/nrnOfXlbT3x
         vtjw==
X-Gm-Message-State: AOJu0YwDYHtpocOnYFZHBsfIQymrsgXBOyOIyA5zWeVxqxiW4k5LafAd
	d9h9sWB4DE4MLXuTS+9gKrRYJA==
X-Google-Smtp-Source: AGHT+IGJa06jbPvLPTKkjguuvMggjPIeEu5QTDeqHbmw67+dg1/UxbCzkpBE+F8xjlTqdqK//qjGhQ==
X-Received: by 2002:a05:620a:19a1:b0:778:8ae9:2247 with SMTP id bm33-20020a05620a19a100b007788ae92247mr39219338qkb.5.1699370134013;
        Tue, 07 Nov 2023 07:15:34 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c091:400::5:f968])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b007759a81d88esm4215667qkf.50.2023.11.07.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:15:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, linux-block@vger.kernel.org, 
 nbd@other.debian.org, chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com, 
 houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 lilingfeng3@huawei.com
In-Reply-To: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
References: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v2] nbd: fix uaf in nbd_open
Message-Id: <169937013187.545643.6485076095455389311.b4-ty@kernel.dk>
Date: Tue, 07 Nov 2023 08:15:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Tue, 07 Nov 2023 18:34:35 +0800, Li Lingfeng wrote:
> Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
> blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
> disk->private_data as NULL as before. UAF may be triggered in nbd_open()
> if someone tries to open nbd device right after nbd_put() since nbd has
> been free in nbd_dev_remove().
> 
> Fix this by implementing ->free_disk and free private data in it.
> 
> [...]

Applied, thanks!

[1/1] nbd: fix uaf in nbd_open
      commit: 327462725b0f759f093788dfbcb2f1fd132f956b

Best regards,
-- 
Jens Axboe



