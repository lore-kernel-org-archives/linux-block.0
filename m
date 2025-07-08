Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17E8488
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997617; cv=none; b=EOSlbX7KI8Zu3nDNNz0P1QEDixXQF7kkdQjgJzEnPNxnHuR4tJBDBBQlAQ48i0k4JEtrkWg+AT6deqBdRxngBlnkh0PEBHpXfOM2siXhDQpBu3Qdg3LLP370j+IqLywTmcB6UXBHrKbaR/DzDQ5bW3PWgAH5Vbnl7MD3RrRbgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997617; c=relaxed/simple;
	bh=K0FtaLvPDD58SdNpxuK7ai80vnTyKwzEJVT+QPt4lJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WJFN633+3VT0wg4U+7y0DxvwAurXpGdc4BIKsUJL6upGrMz8aQuRf2AtRuvGcFKALPLm/EgJLRwAuqkcicsqcmIoPbjAsF33/FT/oauinROG0jKpiUWDdDALnx0oaYpfDowQXBzMJ7HNyj0Ly8MaCRHrKBfxZHoIaLsvygSbDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X5b3c/0g; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X5b3c/0g"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86cfc1b6dcaso156338039f.0
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751997614; x=1752602414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpAeStKhuXFhmoLjTEJdf1ChqrXW0xgEt5fFi6Rv3U0=;
        b=X5b3c/0gI+ME3H87aw58cyaiWUUTANGDq/BbV9NkvevC4YQTJi4d+sNChbyOD6vsqT
         d64Ht28xoiXcY0n4I8T5S2LHgIU3LIEPdxPS/nZD7CWmIoDZ6IyNqf6TwJVO0Zd6BesO
         HgcdFJe/3aR+5y4+fMK2LQYfrfbdckGs98AFwsqg2yKQfez2HIXE0e2IMlAGMU//uqbj
         kqpqT0uLM2uBzqFQO6n0zTOuL5xMuKsCN5+6eJMueTImqn6aRMClHOLkGYcjFYoBa6+x
         c8ZZIipZMTsUsah+E8q3PPfERjJ/2DsIdbvwQ7Svf2bZzkpRUqELYJps5y6YX/Dt54UZ
         Zehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997614; x=1752602414;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAeStKhuXFhmoLjTEJdf1ChqrXW0xgEt5fFi6Rv3U0=;
        b=PJRBtkGSZxJH418c6Hu1KOjZcE13q4pepvqtNoC5V3SVpf/NMVEsalOdqU76f1Vvw3
         KdFilH+ufzlV5GJrCbUU2p9Sqh1g0maM6jsaPSIybo4qDBuSk2Vca4Q2S4JCOKKQ9uY9
         KrKjgJTXq799NHSkvvhCo5LjBomzO40qBAyW0x9Iy/fNSQ/VzlN6q2iewwDWsk3jsg8t
         zZXbSNKs26kBmUwOt/nvrJJu1R1Lu8PPsyI/oZbbny5FWZFzWCiryzpRgjkdAWwcYr81
         kpjpUV4bHZKy9gM10dFqyXNhZt496G8M7S4orWPzMBHksueLc/06licrL2dMphtFNpRs
         ga2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX++aLZLckziuec6T6yrDxdxb9k0qmVsaKqoZsj5a1eEDYrcbgVGtkCdeynuFppdNab9gNrzyPZSBZ7mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaWndLOfipjwyl6SW50Fz4PgMG/jKLAXcL0uCDoE9gYc/F/s7
	HaAwwA+xPKKSBTRnq3/nQHDcDisz8npKuR3+bNg7lJrswNOBqUAb+eWPfI36+oA3g+xljBEFL6h
	Yde40
X-Gm-Gg: ASbGncuu3GzPLcCywFOSTfrFkVsGHzFtdYS5jEtz0k6aRoKL4Gh2qLP+DlSjEOMKKh3
	tPctiycLIRwvAGhU6FtMxbyMYJ2kSUTh/QSzJ6UEm5w1pEnpRQT/QCDYI6VpP8efUVYr6KwaWBe
	XH+TvK1boHxwciasjncsj1S7RIQa6Gd1vwbPPaU8L5SB0/Pm0/uX+G1JgCzLM3BNGI/IyFL1Gnu
	t395WNyGjtLr/oKCD4RcVJypd+/7s/4k4GdbRXkpQHPifDYywl1mLtRlRZueXMBN15bXnAfCzf2
	oDpSOBRStkn6iI+ZaDFIoi1uagilSzG2AspsVyUWXifjytuqH8fIthHDiSkNIFg=
X-Google-Smtp-Source: AGHT+IF7FEKSKTg37RdYgnx6ZNfepZlDJuC0fV06sUWu4KRmrj0zOy1YhAyMZYb/GQVD06m6nkGkVw==
X-Received: by 2002:a6b:d319:0:b0:879:26b0:1cca with SMTP id ca18e2360f4ac-879596436abmr83046639f.13.1751997614319;
        Tue, 08 Jul 2025 11:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c72bbsm2276958173.38.2025.07.08.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:00:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>, 
 Asai Thambi S P <asamymuthupa@micron.com>, 
 Sam Bradshaw <sbradshaw@micron.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627121123.203731-2-fourier.thomas@gmail.com>
References: <20250627121123.203731-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] block: mtip32xx: Fix usage of dma_map_sg()
Message-Id: <175199761337.1185853.10292369872403699020.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 12:00:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 27 Jun 2025 14:11:19 +0200, Thomas Fourier wrote:
> The dma_map_sg() can fail and, in case of failure, returns 0.  If it
> fails, mtip_hw_submit_io() returns an error.
> 
> The dma_unmap_sg() requires the nents parameter to be the same as the
> one passed to dma_map_sg(). This patch saves the nents in
> command->scatter_ents.
> 
> [...]

Applied, thanks!

[1/1] block: mtip32xx: Fix usage of dma_map_sg()
      commit: 8e1fab9cccc7b806b0cffdceabb09b310b83b553

Best regards,
-- 
Jens Axboe



