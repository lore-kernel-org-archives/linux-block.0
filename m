Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8110942
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750819571; cv=none; b=pAmSB8X5nkLC6Aa0w9Na1hBPprNE8jIrR+1yeMJJ0kK5KJAa5Ex+CgfxFOPDu7p5DDpyUtRLG6gBHKy6YJDqUoRvtbCJAd+jEt+eugf8K52DOOTkpst08f4SAAsqulwOj6mPcLkE0uSzatYuVfAj7QF31Ep/TopfzAE+Wxemklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750819571; c=relaxed/simple;
	bh=SkVe78X7yoEJNmRWkKig7c1d0kPO8gNBl+Dgc13DX9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TAtHSph3Wctsixu5PMkq5U1qqNeDfMMx45M3lpZfpHCXPHN2Z9SXjYVqfiax22Ys7uogFDC8dw7Cik2EIsQ0T0mSGkhXXmDchWn014cn8+02ORfEcjiUWYoOZHYH/nYml8D2/mcNfVnP4o4VWTM6f8PYGvJSQi/KZFpLCjgX+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lYcM/v0V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lYcM/v0V"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237311f5a54so60359665ad.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750819566; x=1751424366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9oS+Z502ChbXB9hNt/CCe1plztmCyTN5spKbU8RbpQ=;
        b=lYcM/v0VhCvUCrTDexcSqXgl0HFT9/oIX377bCVw21+xyoSpE7z6L5NkNXP9SgT01m
         gzIIwNLEGMReBEgum1gJ/qME4bmq3nfNhhw3GXLRzFT66m2Z6EAqQRDyxrJQtDK2wqS1
         Lgoycpa+zaiCtriu24FRPCRio+CfPfwZqTSCz+QoE4HAaDT3lhsfj1P27PnpUnA/Xjya
         7ExDsNmQUgWHAkxkuSORe3ZI+Ewp71NbXqYaT4GKAqOIp96TavLFaKPZVJ8Mdt1Xzss+
         CYOo8hgBllTXXKucP3FD5+MFAB5pwH1Hs0s7Ef/rKOFK926LOBGwH9NVixJgjzo7wING
         hSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750819566; x=1751424366;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9oS+Z502ChbXB9hNt/CCe1plztmCyTN5spKbU8RbpQ=;
        b=GlYhoBLi5qOp4f+zNCrsM2rQlfQUGC+4NmvWZA/tGXO+rhWQhciI40j72ntzsk4l4F
         unJ3tIR9ccOyGgCU8AxB/9/oHUkYC89TSGqKpdoFMYmrDUt/NWNA0jI1vv6DDB96zm86
         YILQ43+zw+Lp/HA8I1D8w2Kj1+HI7AQBvaTofVJd8d/yTuohe5AtiABWxkxy2LlVmkgm
         e9ZMCjb+GIsLdZ41R9zVWKOMien6ZHBbo5cp/S9o24X0DNjpsbWYU0hxcvTh36O/HUZl
         6SM7PrdAu5F4Si8O6SkRDHTi8zgO9F2NK4BurRctmdXdJ8uQi2w8/EPEhTeoBF3z0qkK
         BaKw==
X-Gm-Message-State: AOJu0YzcOfiNcB54925XKQjWeTxh8QovU20pS6WFR2RfOZXjdXWo6bmv
	5ZI4pcgdELjMH8S+Q2Dr8qUpToCcl6C2XW69BYLIg2Z/jXT/+0rXbGJhH9E1C5Z+G3M=
X-Gm-Gg: ASbGnctfa4eoFEHEcksPTpHnV4lE5ZKv6KlLOVH70udDzmT/oCPH6WN83q6z75zIQp8
	kGCnUW4c4vthg2erJ+Bka71jjtwSWt5znlSBM5PydobIY5PiN5h6RD8hZJXJRnkLo2cuRyT99Hv
	M8VhBB4kDxHTbRFgW2YxBFyfIG2j85XFxRAGiWyFjIK5V082U5UhBpIb87RpgCYa8ExVg3MEVgT
	Q3NPOTZHTcSvIxP/UwQnSeZ9u/N8N1h3A/wg2GedfK1xBi5CikbILvvtOJ1j6j6Y3VRVEWwHLcC
	hEPnXERabVKLvwGeA61Fir1GBXR3x/M6vA3T3XghNsJTQD02/8SsSQ==
X-Google-Smtp-Source: AGHT+IHr/Yz2okzV3fEXidojCurmOVhVYAL5S6M9ctVNOZDu+wgAkrONf/puwbq+P3t8CZsuTTXsUA==
X-Received: by 2002:a17:902:c94c:b0:232:59b:58fe with SMTP id d9443c01a7336-23823f87edfmr27131205ad.1.1750819565923;
        Tue, 24 Jun 2025 19:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2380d1a9d79sm23033855ad.93.2025.06.24.19.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 19:46:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250625022554.883571-1-ming.lei@redhat.com>
References: <20250625022554.883571-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: build batch from IOs in same io_ring_ctx and
 io task
Message-Id: <175081956499.87490.15874921177465445793.b4-ty@kernel.dk>
Date: Tue, 24 Jun 2025 20:46:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Wed, 25 Jun 2025 10:25:54 +0800, Ming Lei wrote:
> ublk_queue_cmd_list() dispatches the whole batch list by scheduling task
> work via the tail request's io_uring_cmd, this way is fine even though
> more than one io_ring_ctx are involved for this batch since it is just
> one running context.
> 
> However, the task work handler ublk_cmd_list_tw_cb() takes `issue_flags`
> of tail uring_cmd's io_ring_ctx for completing all commands. This way is
> wrong if any uring_cmd is issued from different io_ring_ctx.
> 
> [...]

Applied, thanks!

[1/1] ublk: build batch from IOs in same io_ring_ctx and io task
      commit: 524346e9d79f63a6e5aaa645140da3d1ec7a8a0f

Best regards,
-- 
Jens Axboe



