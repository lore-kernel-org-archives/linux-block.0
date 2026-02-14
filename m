Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E63D1F8755
	for <linux-block@vger.kernel.org>; Sat, 14 Feb 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771080232; cv=none; b=YvymxIi0mZ8jgJYuIH5K8EmE4y7Qc6b3AGu2ZSQTZepWfrUvG4AjFuIgeoEPEBV2b337buvMMG7JGJ2fPYU3zMM/oXOKpFCRURDdgzBxWdtrklccdsP2/eulldQ3985FZ8uVxQTj/qtfamHr06q1roAQtU2+flYsn0FO1h4BNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771080232; c=relaxed/simple;
	bh=5KkyZPOUndc6O326aHFBDU8VUsiOtIVfHs6kFHLj4Gg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AbBjEgr+IZPXVhBE1Ff82BQAt7+ZP/0Nwlz1cOqeaE4uRUFcXD0w7XF29V80eUuBnFQL9ODoPKqUk17K1JPnfNYJtxPYzOpKW61xfPpTkqWbC98iIz91igCVTUzsdXBVoDkFDAACHffco18TYQs125XMSYsdicMBGEgUFIkiwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PuyCIx+Z; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PuyCIx+Z"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-662f30d3f1fso2284160eaf.1
        for <linux-block@vger.kernel.org>; Sat, 14 Feb 2026 06:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771080229; x=1771685029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMkHcz062skC6zRWMlYM8EhOpBlqIimKHKwqRQYvsvw=;
        b=PuyCIx+ZHNg7I0U4pCcfqoxMoK6/mJP1NjEC60BKUqzik0IKXgMqgwiirC/h7pvz9S
         ettz6yiKHLWeS/PemTGyqh7WoZOnmD2GGZL2dYQWKwgzx38DfgqVERd0fAgkbQ6yxC9h
         HPujB6y64Ohwl2nRJ+CKxPC9xvjzpyZdNFUnd9Kvygby8Ir/N93+xfHLLdSKMLxe3Sg8
         iREucLfd1LRY4XVEN0OcM3WwpoHyFLvkgMlRRKt6huZ6RPuoLXpVd3IkdJ/wom0FiIek
         bbVL3OLU8E/tYbHnwNbqhT2klsbbxbO2ZjceFF5Qctzj6yahy9mzusl530fbR7np5tM5
         vN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771080229; x=1771685029;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMkHcz062skC6zRWMlYM8EhOpBlqIimKHKwqRQYvsvw=;
        b=ma/IYFWI9cv9SQBKrWqfYfQ3RFguHtYN3x0ecM3QOl5wVz12LpSlDv2tooRbGaeNGr
         0wfBKl6wFEeAtUVOmVLv9W1k7bq54BP6ZT91UssyPDk0cctOlgjroc5MTbUYYhghKjfj
         SlnYHeeoc/4dBHLqICenSwO8b65Hwwmv3gyMDEo+AQVhiC5vYtc7a6LkuxqvD1jrCCAZ
         6FcL0vg4pqjQfgV7c6HY+k4t2ysNUeAmzT98Q0u+6MC4oa4Cn9jWJZuwbqxxdIgvycin
         8zVEqi2AiwruL4TH1AwvdHAk/Rbph/85COvKrFjJX/Kma4BX5VKW7H4xf9r8AyxRB+fk
         ryEg==
X-Forwarded-Encrypted: i=1; AJvYcCUMvGXLwVqvCCrzDccoTGuDXQBkQsVPAK7z8euetCTKI2zKco5jVoIvymJ7Stvg71OO0IQB92g7/oV4HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XG4tqGMCMcoOyCQWNoSmtbzuzI35RS5xUg+exEBSDiweXGN8
	FtMUMGiiCXlYQr80d2svfR1exe2tojcc/BG60ZvyPbhhBmBcvLSqR3pE9hHhsYxc7S0=
X-Gm-Gg: AZuq6aJr6Qw4ncmtffU0q0NeYfAAgA118e3tQ/oDHUCbL7soZbeKj9Y+WNCc0Q7DaNT
	VpuYWjRPf7cwoYQ0Z+oHQoYLlz+EPTZxAenis5FRtaq+3gCB6dYmvaG+VphT/3tutiidUUmic5d
	aGdNCDyt+lcegznrh07riWE1Q0sv/GhaFMklkyDiXJ0ekcZMgVJepxVXbnBdC8YspjVv7k/6B2+
	50MuS+3Wj/ksWL90AHcQcz2zpMYLrsfBnK3DqoMR1yO59Dz6SZ9u98Po+v58FOY+dSU3hK0BjHk
	35nqjmaxcS0fBDHmWzgUUAUs+dbv1YArL6nfz9N7utTHZVgKngJYoaQogD483HGVNJ9P1aq1cKZ
	5oQEt/XI4+v4h8Fawa4q9ObWMvdl5DDGUn9ORzRvVdVCyKHRrjeiJrkxkPqhNddEo9U2JHoFmqq
	Ez9bjm36hfRTFcWZgQwLyB0v/52rFQbsf46PIQ3vfAaPHQYDu8pYYfbrRDiowUyFPotpyX9zoS7
	dhs
X-Received: by 2002:a05:6820:81c8:b0:661:1bee:284a with SMTP id 006d021491bc7-6782288da1bmr1675196eaf.28.1771080229349;
        Sat, 14 Feb 2026 06:43:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40f2ae0a899sm49042fac.6.2026.02.14.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 06:43:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260214-bvec_iter-docs-v2-1-1c82ee5900aa@kernel.org>
References: <20260214-bvec_iter-docs-v2-1-1c82ee5900aa@kernel.org>
Subject: Re: [PATCH v2] block: update docs for bio and bvec_iter
Message-Id: <177108022757.334513.3094419669166358218.b4-ty@kernel.dk>
Date: Sat, 14 Feb 2026 07:43:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 14 Feb 2026 10:12:54 +0100, Andreas Hindborg wrote:
> The documentation for bio and bvec_iter refers to a vector named bvl_vec.
> This does not exist. Update the documentation comment with correct use.
> 
> Also update documentation comments for remaining fields of `bvec_iter` to
> improve readability.
> 
> The fields of `bvec_iter` is using a mix of tabs and spaces for
> indentation. While at it, change them all to tabs, which is most prevalent
> in this struct definition.
> 
> [...]

Applied, thanks!

[1/1] block: update docs for bio and bvec_iter
      commit: 11506b3c233fcead6eba2842d17ec29c84f550d4

Best regards,
-- 
Jens Axboe



