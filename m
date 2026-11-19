Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795062561;
	b=WIvgs/J1px5PL3sMqB2PxJSfgfK90+nJhG0pzbK/mv3S/xlfkunPRUvp9+wDL1D1/ILg
	 JpEmEYn7YmAdcsO2G6Edw39NCrPSldDOPPW9yExT6FPfsTZnpNMkBESWPkiwwK1rL6IHd
	 0p+yJr2jr+maBQX7JkmZ3VGNPz+CnyacWv6fOIxN4/jJkMncQBJAQrSi9kL0nzcL5gC3l
	 hhqbEaoFY3P3y6sx3AB1n68DmjUV5loF42KWBTQfp5KeMBlO6Ig+Ewwwn1lBNhfOGKKw3
	 qLPyEDqxc6T4kfI6RQ++XI+Woi4JXEDbc33Brcudylua9knViofLMBDNV9sxxUqA0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dCICOQDRVMWPO5nwEzDmnqXj88ffqAN3Sthv4ao13Hs=;
	b=IWH9lV5VenzB9yLMTIgiE35mvj+M0jvilQ9mGO5bzhMa6OAmFn9D6dmSeMUzu3m8tZCK
	 GrfpfKx5GjaR7oNtAp6sxpS4bVxoAk0Jm8lk6XlIjLt7bb72QHQZSBWzKbSZS42kqhyT1
	 uiK1SVPz19cPa8c088ai6h5uHV9hXkSOSrDjzId0iAw3RZXYl59bQ0Fh8Bnx78KlYYYaJ
	 ExZDPlAcvQ26Kx0LN2p/1oBYRPVQX73o6QgSnEN0qla36SLOJdWEHqBttrsLtPqw4J1OW
	 Vhim4GsLMPhEpi06j2BL90Va4K2NpNdKhicUOoVxr0D3peacV3OfTJN/KCLtNPBenWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Zq7L4T3J;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CE606A325
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 04:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D89CE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Zq7L4T3J
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f00fc215f9so6926605ad.0
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 20:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795062560; x=1795667360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dCICOQDRVMWPO5nwEzDmnqXj88ffqAN3Sthv4ao13Hs=;
        b=Zq7L4T3J8M42EFfoxkNRZCacZXcWTgN/kfBStmAHfA92PN3CWDZ15fxTLn257uEIfu
         jZz7TTlyUbIsW+hz4oljQdAXyxU5G+0KQMiDhorTmAwACDLQogma/l6ndlQe2OlzEF5C
         F7GEhB5DQcaD7uzwPIJZnGdQRiQLMeasgf7eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795062560; x=1795667360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCICOQDRVMWPO5nwEzDmnqXj88ffqAN3Sthv4ao13Hs=;
        b=J6buDV6wrj40Fky1LIcpdh9PoQtNC3WBxq8BQsP3Npc6W8H62qWg06EvxC6m6qIgaP
         36ZVsjjL5qi1vaqBlRBSk+AR/CcBUv4kKvLKyuu3I9QgJf4uGfEZd7neRKST7FZUN2Gu
         +kjPZ5ulp0jfoxSMJnSdD0Qh8bYtN5+djY6RnQq/ksmr80jtO2Mk7BwnnP260eVbCGJ0
         wG1Q+7V8Ckk3Uurw5E1VvYyUavh03K4lRwUylRNghmagEVkKOOVy8yNNHals1T+7A+3X
         zWLxEoB9bclrBYqnitBfcYDUZuyQsSWDVJ9S/aQ72gcWiG5ei3CxIAX+PZekF9dsA/gA
         nh2A==
X-Forwarded-Encrypted: i=1; AL+hErFjJiNZ7armtxj1kERdkaIqsfrH+mKlLWd8agLwwKdrgO//U13DDU7KkTxoIZPMPngkq58bRBdCB6VzrQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+secHv3kJ+G/F5Rhmu8byJTwOqZ1vBFDJDWhm3HkZJMH3n7KoA
	Ln4LT9HyRI20XBSvDkIRGSfQTfAFq5UmqIAQSkH1gL0orfdN82wd5OQ5+bxI9ngeTw==
X-Gm-Gg: AZFdTZeThp3o5o0FAVHQpeXz1pkFIXIj5B91R0ggfo9G/LgHv9yR81kJnFprTGDSjuv
	NDaS68a9fjLlTQ5YgGoKKkvvv2cVcbpW4cFrM63uu3Z25MOys8NN2y51wiC2jQixLnxzIj2VOsi
	iDrG8ky50l9PYDx2PYssbJGVnsSylWE5Tl3KIzCoqhTQkMPt7vzdV6fCXP3+zwHYuDB8tdCh1tw
	Y1c4vlJBK4xfZrqNmeVD4+4j4MeIY/FTtqbepduD3adXi1l4wM8BhQysw9PEHjLJ0UtekplmjK3
	2CyRJhIL4J8kAOKPdjvIlkk9cHDqVwDLXiOoiIv7Qjjt4UEJBeB2ygB0sTEU+Vap+n7EbR42hvA
	JN3h/ZC/mJCIyOu2bU0AWmNPYNgJofbJj6lSXtQG1rv6qmu/12MogePFEaUQgSdZ3nG/nei5qHz
	CD53o8Va6TACHCu5kRmSmW1Dwls6S9WdZRKCX6VfHwu2x7YCWnBEiz8HMbAMfnj5nylzRbwgASl
	dyrcNF3s6v4obyYoWWtRM5tebjJCieYqbMr75V5agWEg8TnyzmM2LiUKGmgD3TFd9x7NoUeXRgu
	zsu1yzH+y3odyBNi8IYRKN8YE/srGiTk2pww+jxHc1SFcGbDJBt8eya+p3/4DovbTXn1nw==
X-Received: by 2002:a17:903:3bd0:b0:2e9:5829:9b48 with SMTP id d9443c01a7336-2eff72ea3f2mr42869015ad.20.1795062560125;
        Wed, 18 Nov 2026 20:29:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:9297:4989:4c44:dad6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ec9cd0sm23174315ad.11.2026.11.18.20.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 20:29:19 -0800 (PST)
Date: Thu, 19 Nov 2026 13:29:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] zsmalloc: fix SPDX license identifier
Message-ID: <av56Sq5ZxntVn3al@google.com>
References: <39f6056e0c8834fc3eca2001fcb44f3b6048f74d.1795061575.git.senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f6056e0c8834fc3eca2001fcb44f3b6048f74d.1795061575.git.senozhatsky@chromium.org>

On (26/11/19 13:13), Sergey Senozhatsky wrote:
[..]
> +++ b/mm/zsmalloc.c
> @@ -1,16 +1,10 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

So this was introduced by commit 91d0ec834786 ("replace kmap_atomic
with kmap_local_page").  It doesn't look like I have reviewed that
patch [1].  Somehow.  It would have been difficult to spot that
SPDX one-liner among all the kmap changes anyway.

[1] https://lkml.kernel.org/r/20241001175358.12970-1-quic_pintu@quicinc.com
