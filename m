Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A32F1FDF
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114089; cv=none; b=eFgxZSelmEPmSE2K0A6ETCIz/ox7rNDQyOwWAw6TwxnkrjaRLycDMy+T7utSV6PPOUJmCpsvdOr5bCmZH7lKgCdv4CA+RY+RZ7W//nl6WAjqNswrEJoXV0C1a482/P6oY5sWAeYGBDkjr2wgrDouBa1Qcm0X05FBr08TXQEZ7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114089; c=relaxed/simple;
	bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOJGVhuNCVpdPlEj3oFenTCKB1kGXHlQDsmv966OZsMU/qEDbHn9rarwcdPftb5qu7zrjmy/V1IJj45teSe+vyi289fygay6kS+khGRMsuM4UDuSioZNC9c0PR3gWDlPuSeTKb44c9j3/HfGgBVLB5lhl1/A+yvJKPEOXaloEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh2eSTbF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh2eSTbF"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340ba29d518so3850674a91.3
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114087; x=1764718887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
        b=Bh2eSTbF+S2eJFmwCc1VKmsOxCMxgZ0bmxzfMfQ9jvpx/Uuu/exl9YrXv/CpYqrHPA
         MDznPP3EecuhDZxjOAIPcy9aUfePrAG1EUyAmCUiy64KsvYcFDoSKCseaORNt71vJ+Hq
         Xh+BYWayuqLVLedpm3/lQuvzYyqOoQymqd2HoBkBGfuHBmF+xj/ZaaSIhjHp2CcGjNOF
         ACSYynNugZr/MtNQd1ZesmPTUP+SkLkRvXqz0jInKZjs/4Vhj5MRmpQTnvHtd9MVwF7e
         GZZTTMD/yIUzeyFr6CeFH/mqtlwjLxDx7REF+C36qjFfi+Q24Ssk0cM8OSJGS0+ugu1H
         tFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114087; x=1764718887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
        b=LjGqDTTrXII9m1FHyezhLv/CTpdgaB/hE6nzz9KaykKKkjnYYnm30v0QLt9SZ4MeMe
         ldNgXtSnH1N9OksaDNVJY8d9AHKdh/MEAbArerLPSz9yrKdxOHrtWF3Zk0UagAuqIM7/
         Kn0PoEZRVLgj4+UJosmoGrgigfN929jBs9YjGI30w7baVZCaVUYSGDirFE/GpAnY+QAu
         rW6FFnI3hEVKNZSXYP+aDwywECNxazlGYW7GGChvQLpnns1u3l3Ajhbb1ZA9a8Ylnsl7
         5cAoKtE0Zp04VwTLNUJxbxIVu5VB8G0Q88Ae9DElyQjGIQWQjfAzEhVH2ljnjeaDtju3
         +l2A==
X-Gm-Message-State: AOJu0YyxFmT0W3+a6xZZxPQxy6YMimuQOdIGR+sTZDpuRzWAikrGag+P
	9f7gEoHj9x+IFVFHUKaY/cfJ1VdOGjcDAMonKfoNZ0/+dA7FhjPAolgq
X-Gm-Gg: ASbGnctSQqBQKBpWetcxVQQrq2t6DKJ7pT6i+NAf2mTBpkltNKie/+MK/TcHlKSPYTe
	IOIh/ee/PFd9OIj2GR28pOHjLXE2FFLDzsyNxkQK1jAOdcPGhVha/hEHZcxyGoHKWgv5pxeemBt
	ZHSmmRmXE0g6Dy+bNfxdMVfiz7Ql/0KunVIAoNUInoLrSIk/g6uMaFcacNx4/dmN43p7YElhcUF
	XCGhPOiPq6rOz6zW7guZ7/tVQ6pHpJ9kcDgNIHWUW7DBzghFiiQpO97WGaNaTh0BbzQiT6x8RKc
	ww3sTEr5fIROYxBNwggyFkMx8U+hwHyMy1Ee+0+3UHtJeKDIcrWcpyTk/7gXc1JsPvrUM95Xjbu
	NPQhDH6M5XyR66te5dL+Gm253FA+3rjxGdBUWGuq/2NBHOmBc17S/sw0wuREVhZw+B7cVAtUZJU
	6Fj0NWWf03rE7KAXCIBWy2ZTwugUrui3ztjRmLuA==
X-Google-Smtp-Source: AGHT+IERAr6ZaAk8N2XfP1sLPZ8ltdcZpy2by33AewknK2HCsGdLuO/dThk3nDRSpzRLveBkNTfbCg==
X-Received: by 2002:a17:90b:3b41:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-3475ed6ac44mr4636649a91.26.1764114087385;
        Tue, 25 Nov 2025 15:41:27 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0e6c9bcsm19291748b3a.57.2025.11.25.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:41:26 -0800 (PST)
Message-ID: <2f356d3564524c8c8b314ca759ec9cb07659d42a.camel@gmail.com>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, 	chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 26 Nov 2025 09:41:19 +1000
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	 <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-23 at 18:57 -0800, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making all error checking
> at call sites dead code.
>=20
> For dm-thin change issue_discard() return type to void, in
> passdown_double_checking_shared_status() remove the r assignment from
> return value of the issue_discard(), for end_discard() hardcod value

Hey Chaitanya,

Typo here s/hardcod/hardcode. Otherwise, with the split as other have
suggested:


Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred
