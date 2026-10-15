Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1C221546
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029849; cv=none; b=syZP5K/RAuQUHAF9ZkQfG/mSExj4jEO0UsaYAdJcN0mhh1NaBZEN1jdpFFoEdyxhMvqJXOC8PamsjU6nRx3E9Fn7gGQswUp7l9Hty/WBCv6wNjILO1bHJBuVP//ggqAvulO1t6eHM4SRPz4EyEV14gYjiEPcKdZoBheT7C9OtVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029849; c=relaxed/simple;
	bh=5/R6V1sofD4k0McXJtl/Urnps5sOzFV+59970M1RyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTLSyGW+txqCdHlNIEVCxUrQJ5FNKzvxXyxYpYKK75GVPkkNf64qNYEZB58lYrrLypL+wS46U5l3W0il4LsJnjz6YmMOpoF0lb7Pr58R8FJ0Nxy2ZNhZKgwx8YPWr577xsxzoKzLpmO2fZ49HHDaH7vlmeuQGO1v+5GWtM53N/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DWVf8Kik; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWVf8Kik"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso749449a91.2
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792029847; x=1792634647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+wgW4AUmqbNUpe4dZRuBCucz11edTIwYqEDP8LKuxdo=;
        b=DWVf8KiknBxVj3QDwjr6EBhSZyNKrFhkcz0fZkHIgHbTD7vKtzHIlSNVF8PBAhtJWx
         DCJLzkpxLIY77V0es6cyjZ/JtD0lv48mfEExATMMKoD0SSA9P4YRXRRDTbE62sQ1Q4/S
         xwxJy7+vGQlnQif5TA8yeAdRby9GzOoGHv/c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029847; x=1792634647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wgW4AUmqbNUpe4dZRuBCucz11edTIwYqEDP8LKuxdo=;
        b=qHQ8YV1zWFaEfZTHdSbzI3l25v8ieezUN9jPpP2Dv0h09kDC/oSMpMoiBFNOmbEmFZ
         WTSgp8sGiey4GGsBn6t4CfxlXx6fZtliqxWXEPGzWatZZsllYw32bvTI2hsibqtm4D6o
         sRl7cd/HsgtgLzVefji9MOXoRrUeH8OAGL9ZKJuxwLYE8M5P740PHyEZyb3Ik7Y459Wj
         kmL4x+ESKSChweoSYExhz6144JtG9w4s2ZBWvlJHcNPbhbMVaHTr8d76uvNR+zwozzrT
         OOidcXVuQthLPgY6s41tr68LXupZj7NB4Z+ARwnmjLVdOQkEb9PTxdGCWrdnQdDmtd+p
         qtmg==
X-Forwarded-Encrypted: i=1; AKwUvBy3OPs8T8CeBD0hyUsgARsBlWDg1Bum0Ev5FiDkwPFAPopWReWYj33xvpaRnQ3RKqVNOArMVuXDPasriw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLtHbgRzkZ7DpAaYFrlmplgclEd947JOrdgqp+NXKJvd4HIGuua
	/b3hr5c99V2EYl4e9dWY942J2apXDYztabhnktdVtiUsJNF2S8yn1LHw0M2GCrVZ3w==
X-Gm-Gg: AYBFou2BsoyzHKghrOgp220E3IX9TYDI087L6Z6Iol8L570ZmFQ8GaHe6QbB/lGIQ9x
	MyuajiUPK37vDyqv3Fc+yXRSlfaPT6K8oDNVv2BEFuprJJN2VYM/gWELDXB2TF5r83jclqip/Gq
	Weqat5YhAI2p8DHNOmXYNQKbDRKNN61udShKa+fdQC5qwQQfGS3Qwb+FopPRlVxdy913Svo4+Ni
	IDp4YgYLu7LJ0mHKVWx3b+Vgbj27G/ranPGH2ntbIMEIa2iJ1lg59BvojPiFZZel6RLq7c4qeh9
	yiiTzrS6TG1atuFhusbSblzo7Mow0UV948vwmjwL1hkIACsVYTj/CGGm6UJXw0jS11I5xWckRLx
	evNMQD92Ys2g6cyFCZjt8QJ31vZ9L8QxdevpZtFgthou3OfrwkPeKwZyMsF21P0we6fn4p3NIQg
	YgtbGHspanfOtctWp2et7ALXX6wVO6gz3tRlVvjivkSc3HJRA4QTihYCBFAoGtedeLTnDWjUKQI
	VRrtUs8i/VG0kkNnYYYlFrqlHhJVd2b59+3Pnc=
X-Received: by 2002:a17:90b:5828:b0:3a4:ba6e:65c9 with SMTP id 98e67ed59e1d1-3ab3ac95f56mr12616470a91.59.1792029847508;
        Wed, 14 Oct 2026 19:04:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8455:7899:5a2e:26f8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94748c6csm1889088a91.10.2026.10.14.19.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:04:06 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:04:03 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <baohua@kernel.org>
Cc: Bo Zhang <zhangbo0325@gmail.com>, senozhatsky@chromium.org, 
	akpm@linux-foundation.org, bgeffon@google.com, minchan@kernel.org, richardycc@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atAzS6mTZQ80tTHM@google.com>
References: <20261013035201.2809924-11-senozhatsky@chromium.org>
 <20261014153603.1365617-1-zhangbo56@xiaomi.com>
 <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>

On (26/10/15 04:46), Barry Song wrote:
> Also, with either deflate or zstd, create_dctx() will
> always be present. So, what algorithm are we actually testing?
> What happens if we switch to zstd?

Right.  Am not that concerned with deflate, but seeing zstd on that
list is a tad sad.  zstd mutates decompression ctx, so it cannot be
shared.  On the other hand, zstd_dctx_workspace_bound() is almost
100KB so allocating dctx per-read request will be rather problematic.
