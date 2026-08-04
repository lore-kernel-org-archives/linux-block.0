Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158343C7AB
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832898; cv=none; b=h+tTSSyirX4K8BZiwV6qPoleUY/dCljmyUlhfrna2eBucQ1CZZFADErPk9SPUxeH0aver7/JVH4ei3dgI7Qv/emrxXpVMxXzQxam8nv1UinEcbVozTvZv5dlh8U0l9eVfk7MD10YzOS9+6y6dJOZZPvkdc2TeqCsddyNnEJ1qp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832898; c=relaxed/simple;
	bh=9gSqiJz6XGNwmera6N1NagiFzsXO1G1ZbBb0iBzg/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKAzji4OyC4V+U5sd2gPwvTb4jDo/udMhYDDPHuwGE6mSjlikO64LIJQi9A9TmYTw8EW9L96zx+N4A2lWK0FwtRR0Xy8Uwop62LmgKAL2V8zK3N97LXnlsh3tGVGuNwEwfpvJRcHc8of5QiDr56cz+G/EVwcAfdEQo3T6qLQhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XdetY4/d; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XdetY4/d"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a2dcede83so5870896b3a.3
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785832893; x=1786437693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BFRFRfJMZ4b6gvD/HiRAMl7FYBOFgGlyncLVS5iH/pU=;
        b=XdetY4/dzhR+Hegtgo6unZCw5OMEtGapAd7KcYyJHKKJTZNTh75bTz1Qyu8Us57FSI
         Sbm36cLD1+MjLz/FdbfEl2iS3emI7taKWUGFPeoXEd2oVAQUctV/XpERCmLCIYMdMQJw
         185p3tMRsCV0ABAVw0b/xuQ8QBU4anDNT1kpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832893; x=1786437693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFRFRfJMZ4b6gvD/HiRAMl7FYBOFgGlyncLVS5iH/pU=;
        b=Rp9krSyW7gOZ59oz7+N8GU/0afXq/dken8Pcm6CpWVf5bxof/+IpsiWH24/ScAAhJZ
         mTY+ZXMke8lXTIea7qR9zpV2XoAx6IwiLkyZ1Sg2iyZx5cyK+BAG+HaFbCaUr4+WWX8Y
         PnFau+n/NfoBjcqhB1vEubEnKdnpciZ+q+XQOCCa4x1lGCMv2Ev5WN5AwSLqECabq9GU
         +RG/YuUdgK5NDuMqRVHzOF+3t3C2HQYEe+UijgdgWsltQbSOeTNPEl4u6VxxaponDUKH
         G6AHPZngAKdDcx71iD/Q92YNlAPud2URn0v1gH7lMb3et5fB6qm27aJqrzlcE/lcBAbC
         48vg==
X-Forwarded-Encrypted: i=1; AHgh+RpTFc70CkVuNWd9mzN4qRv2K4Zc0hA4gvUN4roaT6KNhkuuM/aoed85AY8twRKyV5uNcnvX1XyImRkO8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqwnpHw5aVp5w+4UwU/mHLQFn2txlCvQuy7XiSRhOGs6wcuvE
	ncx9iatZqk1UTpkuyoeo/+x0lAljBM50bby/cgSdQ4VZr68y0rOrjR01/AqdCcsSOg==
X-Gm-Gg: AR+sD135NH22WNOzFBlP5M3eyT4sWp4DSTOXk5h8o7kmwiF/4HGQ2i9NttUeSsNe0xg
	2NdWVjhO6H8a0tgL9kulo+ZbWmE4MKkzxs6koQqTfMVj2H6IEU23N4CjIaZ3M7YrA8zRZGfbwB3
	KxfGonEJ2xSmHkgMIQ+Z4uEL26mKvF2yB0Kup83yUEQ+4MiRSYPnbrd9hWDiSFEqp/BJ3Y63wAI
	TLbVeLZ32NMjUDsmmc7u102TaXzR+hOenZAg9nzAfFY5mMT8oVRuOArX62SEBQd0MTwfRcP2tCy
	3Qq+61lumh7kcBFvuEO9mr9xDuhlWA0TBcVtZrMAzgVFO0dummbwML8w2f4RDYvCinswz1Xq1g/
	KgI9NG9uATSFGQISKtaQVGTbOGupU9OTI+D1ZXzrFaenggelm7XYrwk4odZCKR2LRyv8zHSyEyF
	AcnTP17T/KqI+pL2rMfjq3dNqFgfLz64dTUf1Ol581vROV+vqujeAYJ/lMeR5jGdHS83a61kD+M
	GHTgJvmd40ux1NpR638eK3/p5Yy
X-Received: by 2002:a05:6a00:1496:b0:847:8bf0:b82 with SMTP id d2e1a72fcca58-84ee495bdcemr12441171b3a.60.1785832893553;
        Tue, 04 Aug 2026 01:41:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29c73bsm4783637b3a.29.2026.08.04.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:41:32 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:41:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix out-of-bounds access in writeback_store()
Message-ID: <anGlfDQuLZbrXvrn@google.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
 <20260804065919.3970386-2-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804065919.3970386-2-xialonglong2025@163.com>

On (26/08/04 14:59), Longlong Xia wrote:
> writeback_store() calculates the table scan bounds before taking
> dev_lock. A reset followed by reconfiguration with a smaller disksize
> can therefore replace zram->table while writeback_store() is waiting for
> the lock. Once it acquires the lock, it sees an initialized device but
> scans the new table using the old upper bound, resulting in an
> out-of-bounds access.
> 
> Calculate the number of pages while holding dev_lock so the scan bound
> matches the table protected by the lock.
> 
> Fixes: a939888ec38b ("zram: support idle/huge page writeback")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
