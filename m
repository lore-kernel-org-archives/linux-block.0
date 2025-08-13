Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DF39FF3
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088340; cv=none; b=tmZEu0B7h4H8Rxf0Bm4nbW0SGSSazPRW62XduxuC2E8h/Y4zfxMq0Vo32F3tq7JvSXrb5/ioMLcMOXHRFr/RIETuA7BdshT5vKzz4ohi0w058H6r8u8q1M8GAWWJnlBSEtJf02t9m/8cPGQ8pn6liC0S+TzzPLiTYaVQazxFjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088340; c=relaxed/simple;
	bh=78VP5p10Jg8NcnMtDmrrGCJeg8umSedtsXpZInRySm8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b3k9C3AJorU6p54cxZuPkfxh6ajp/9ze9GaiqEDM5J87Rxx8JQC7UCns/lo/wMROF9Ip2w0CQLw4CX5RVm18SDylJxMD2rWSzR6sm2HRyfbTJ3VbGodFbN25kKob/HP86MV4psPlMxpclBI1hocpgsG6z9eZ0ORflJ+PmjnexKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TBburqiv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TBburqiv"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3215b37c75eso5570868a91.2
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755088339; x=1755693139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNG3CwDZnVq+LlYCqJlDgz0JDJC7ub+N0Uk1MeSzHuI=;
        b=TBburqivT3KjGd0sx1ZE6gaEt9UKi92w5ljhr5HpeOgmGTfeV00sTQqV6m+oQc1rCB
         7SI1lcCNGSVz+igOdgKYUClWd8J03WLMVFB4WjtUFeNgj5EZSmlkTMYIXaAw5yfgF15y
         uDUzhqE0hDyZ0ZMeTXouW1i4VvZlaa5rZaMqQm1ubEIMaqfANh24AbH8yoXTZDW8vMxG
         2wI8i0YpypuV8oo3KUyAufbN/k9Ir64dB7/S8b7I1Lbc7UcSXv+gOdWyciMvbzcXvEbW
         PaM4Wj8p+8cuNF6PjHcD7Wd8XJslZoj0HxBuq1lSYLaEsUnYA2VMo8Ni9MyivVrZE+F7
         Xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755088339; x=1755693139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNG3CwDZnVq+LlYCqJlDgz0JDJC7ub+N0Uk1MeSzHuI=;
        b=jrSJay5XT20N8yDVDDNVGBBvZSBCAzmBtA7v/pkiggVs1L4c9PK99bBZSu/4J/D7SH
         r9DmVpUJRMZqXLx8KweSuYG/tkPdN2kpRhq7TCh/TE5q01Gmrux8fUOZLUIg5v7AT7hD
         RPY/wP2xvogXqbtagGVh3garTsczroUJUNveruyyITea0ADm2U97gNvtCITtKvAXUeZc
         38PxqKPaRab6LSCeXLw9Kf0jFK8YdoATz1Ytpog2fugZrLl1y4jp0LiuddRVoq1xNM83
         ixMZ+Wnsk7YraKWwRo6mJaOWEIMjG5wi+5cNt63pKz6x9Ktt4W2WWCtPAQWEaVWb1SnJ
         GgGA==
X-Forwarded-Encrypted: i=1; AJvYcCWkASydvaxJAyyQ4aRfUnNliTrW7KiXTzdC2VjxCdva8vfwbedtah2c0n+9QSkmQlJ9siGB0PlhKJN7sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OfqXZva74hB2PtHYGJCIPOoUtCDMR/aoQajEdKAlxCg5Pegd
	kk0Qqi+rrF0zysneVIn0a0Yzdg8pWNzlx/c19y7h5LI4wjd+IAC1y/0M7J3q9Naykj0=
X-Gm-Gg: ASbGncvSr5pRVTuKPOmBQiLUXdPjUl/sTdG3rHplBCp/ZbeomgYVXkjmxLkzSLo6HD+
	Ew2FW2N8oY0WevnPNGhaYJILwkn2eKvK9AQORYYQTx5FJFA0hjUggeZtY22ZUJi7nwR0y+xZ6IA
	OK7UQGFZ4eckdHkWVx2b88UoKprlc8ZFOCe3l60Gkw47I1ushG3x8W4cNb4IvAvYgwxMVQZ/WRX
	yDjKSOhn5sCGe9bi70quVKqgc4Nv2G1Uz0FAdBgL6QFTuwfgXUBYuFCIOidw27o6Rtl9xBDGKI1
	oAA1OCSNGXc7sGsfNIXlRrbu/NaV9HzzSbhEpBkJWV8hsVPARqj9g9ZwzZ8NEbDafn1wQQ9YBM/
	0RRUQu78FEffSVI8=
X-Google-Smtp-Source: AGHT+IH45G27XmEuq78X8gxw6G2P5IIWEUKaJJDkJWCvlT9IOAHkUHlLvMF5cfFKCUbmxNPSZShPMA==
X-Received: by 2002:a17:90b:5211:b0:31e:fe18:c6df with SMTP id 98e67ed59e1d1-321d0e5cdc3mr4379625a91.16.1755088338731;
        Wed, 13 Aug 2025 05:32:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232553e4a2sm82418a91.4.2025.08.13.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:32:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Jonathan Corbet <corbet@lwn.net>, Erick Karanja <karanja99erick@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20250813071837.668613-1-karanja99erick@gmail.com>
References: <20250813071837.668613-1-karanja99erick@gmail.com>
Subject: Re: [PATCH] Docs: admin-guide: Correct spelling mistake
Message-Id: <175508833758.953995.10420055026430792302.b4-ty@kernel.dk>
Date: Wed, 13 Aug 2025 06:32:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 13 Aug 2025 10:18:36 +0300, Erick Karanja wrote:
> Fix spelling mistake directoy to directory
> 
> Reported-by: codespell
> 
> 

Applied, thanks!

[1/1] Docs: admin-guide: Correct spelling mistake
      commit: f7a2e1c08727384cde1c686dd57172f99b5f2e6e

Best regards,
-- 
Jens Axboe



