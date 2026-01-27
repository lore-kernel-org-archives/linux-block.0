Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E01355057
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525755; cv=pass; b=tFG3x7Y+KBWSRrPlkhHMdmqJ+i02jf1R3mGxHEavH6gd3fr4IekyQLwHkDTEwN5C6OfNRUOz6KHQvHfQn/hSsLGP9SMEM6VyEEvuvE1X8RW9Bxy67YPCVNKdaQpJEVPY73Xlz0OCrG+qz8IkCNT//EUn6Mj6asfydNcI3Pq+6Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525755; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+ls7vhodPcKg+4REm1CwrTxISAo2UCsWyM5Ab28nwKzKGOSKau/Ie5IWeS6bZKdHWTAzIbGZX9gQ4CjeBNYfc/iPoeTtb4qxbD4YeFyrKfJF/rD0uhiffprGrZJB6iE81aGIPPx0+cH7V0ydPwK/5bBDd00M1nROFPlwmmjiA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfDWTu68; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfDWTu68"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso10922191a12.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525753; cv=none;
        d=google.com; s=arc-20240605;
        b=k5jJkw8FYvAWD/8l66z24a03YfVjmCNJi4fycoDhw48N5Uj6C5LymW4V3o8YW/chKn
         hNR+MI32kip6TzGvruj8o+JrBO1xT4Ydq8wj5LFurkivX9CMl7UGPlgn5n5zztYj8BTa
         XnL/3Lj2+l6E+RrAENTldhjjwkPbBKzIYKXnK3SS2uzAz3kbbOgR4EIY+Zs0FEAPLW4x
         1evCsX7uIbsAyKaTl4Y9aXkRG1kaHSdWZKiqCF+4/VbKyamLze3Zk4qBCmWEbbivqpgV
         scW5LEtyVC98D6MRPKQvx3w4Zx/cf8IMVPg8X62aB2frsAtU6Gr1RjM1qK6q0YL0C0Kl
         WdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=xvY+V/isO/vlFsNXfF2vi2w3eT9KvHAjM9DlI/G1KVQ=;
        b=E1Klno2BbtukkQ7iCOz1c2BCmnDLKDPEZaHOdpeiepvRya4///0VXTs1C3vB7Kg+5e
         O9SxfvkE0IH1dcJPns0Cckj6EBAf1/foGgOBsBB1Yf0X/n+Cb3G9lBJk48EjdRxHHeNE
         w43i5ia+4HqEMQSKpvjOeNWh1JQO34SKKQb4JCKzYZ0H4qs/eStKlOZpYRIZxISv28ns
         ixQK998qlVXmwlHGWwP79rhJIi9R65S/Pik23HjNO/Iy7cqpAUAOJQi7IUrb2lO314+u
         44VtdYtgooGRJKOxO3Italn7HH/piZ5vp/KQ77zd1pMGUAzzIEhND93iaG5yVUtA8uVB
         frqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525753; x=1770130553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=YfDWTu68rfjJPyRNgFqZvPZYxub+lCjaRdoiP3hCroWvGiqPsSxOw64HsiYAuiz6m1
         Z2EWpIzmQbewlKMvPMz7HCYu1Hmc8UKsWZeJKv096tQTfIw/qRA9FbRk3guXC24sTWL1
         UF84T6rTf3PxYMgUZ4L5GpOsyTs2qqmlbB9Z0pNPyHm088T+oWw7N9PHVUqMKVwCTCJu
         FUvWofElWIR1YWK+VU3MCP+YBPIcEuEaK2OBaRq8D2bqgefWkkKz1xnYfJf9t2nxoeUK
         BrvU5k83P+iePMimd9bAflS7rh9K1neP4UfWe1z6fZVq98pYdPl6mJW1PHdfN4jsxGIf
         OVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525753; x=1770130553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=H+UXzpMV3jah8+NWHZeeUJh7p76qjYZMAjhAF1F5XGCyQqrReuc9ecuYoD1V1f1muJ
         wjY/dIAR9PqO4AkLTaZM4bfa6Eua79FRZDZSpV1LsY+iClTwzlxPTWAtGAjXNNb0mTKR
         Q41lbyleUGl6z7MnNCYa1nf3UZeff7J5ZJjdgyur8pHYXVdEj5uEBUrP7Pu3q95kbF2/
         QJlzGOg727e/rhd4Q9M2G+OP3Rj1MOpaIOrJTPuNCGGllgKKc68HiRT7eltpvWX53yeY
         s6HxD3/gHlLEB1xvqxLGrlbV6BIlv4WTZ0XIhdz5b2lrPV2KDtUhnVira2aC+oL0r6Iz
         LrTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBrDPLmBSNU43rlSZkimLY/vZoXPnz6iSL+5oH6z2/TvBFfa4ZLZcQm+4Mlsq3KftDBt2T3gp2rKT3qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5RxxAQ0UlAIOZXpf0/9qWPPy1BcQ/934zp1knd5TT4pY8jyo
	JdXEddBmw+Z/61pr8MsLcDSJXKgiOHD8ndvbOcasaJRyk5hA615oosGgrtLgvD4kyI/WpDMTDOT
	WBhJMLWhVZ0xYwctHBEEEVdYmxclQmg==
X-Gm-Gg: AZuq6aLr9qgFF8ZeLxXGPkQdOv/GkW+qbFwErHsF1zSjo3eRPGpY22M5EYA3QhAOip0
	XwrQb4abcaPIfFvXhrAWh7wyyiKX1fjxZjFgaqU3s9ZQjW0ljsd0bkW3oKODWMTzN88AuCa1Brf
	Bm6MWZ6i6Z0f2Jw2Tr6fIwrmkZ9QtmV/tYSx7cq9t/P3WiZpXHjGSc1g7FKScZ/AGoZ7yQlse7p
	ZbhAG9ONfl+u0zWsgW2Ar/BJrqS9nz1dn0G5SkGHB+mcT9YpcuuoUK0X3/WEDyjoLQsMMUc9WpT
	opz2ul/a1m9W0qf1/QCQJdnWYoJsU/MewpmeUxw9s08vEznKQyaUcUZnYw==
X-Received: by 2002:a17:906:fe07:b0:b88:4b1f:5b1f with SMTP id
 a640c23a62f3a-b8dab423cfamr153134566b.38.1769525752488; Tue, 27 Jan 2026
 06:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-2-hch@lst.de>
In-Reply-To: <20260121064339.206019-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:25:14 +0530
X-Gm-Features: AZwV_Qh0N_xMlo-Jek-4Bqvm2KfCqCHKR16PVHuC2EtfsXWdRHcPY9i5RteQhPQ
Message-ID: <CACzX3Av31ZUXb9mVGkEm1=+gbH8SFeCd_k7hG6MD5MHosWKBHA@mail.gmail.com>
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
