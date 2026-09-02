Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F52387596
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373506; cv=none; b=rMDUMHJl2rus2+QiehnAzUNgmpFoxLYz0IvLN8D9am7QPTkbpRi4hHWK2zb+yJPvNf6L7VbOIR9NauYC3d5hHnzmIh3n8HZRl0HUeWJh/r7bikuinfjmeU+3WNayGa7h3HBRFSYA0Sf8I01OapMLho779p7zhT9dkZ7dQtNlZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373506; c=relaxed/simple;
	bh=j5z05H9my0ZEtJmvedrVdfeQ7u1S/6Jb1g3UIaBPI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMPjkK2xwXroSb7t7926HrjA98EuVPgNonfShd7EUAGFisxPJC4A1kzpftdVpUhTvXIl1g7RIosCw2gAPsKsjkzkA+XXfgqWNaeeuDw+peRh8bis9AWU1zN2KooiHWgDlmmzzFMhFk8Jl5yb48hhRTjZgOII5GtQ9SzzB6Q8inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg7Ghj2Z; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg7Ghj2Z"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1645159a91.2
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373505; x=1788978305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6AXQi4howHroN7DuyCWjjvFV0b8XeXdQweCPbXwE3Wk=;
        b=bg7Ghj2Zg9gHrAQAB507FCOukWRib8exoNHTU0g+SZiZ0dy+W9CV/Jl35z69LOeTwX
         AtLZx8i6dsAI0rcf+Bungk/qWi9XdEftQzLaZ3FLhNGh8ptAi7ymsZ9aiDf7w0IKzbRu
         B4yd37q10dldPR5FT4ZruigM5dp4eJA6iNYEOuj7ksw70dvHbmDobQWYWq43N8Y97EyT
         QW9nFg/mXTbkHoEXKXDiA4U8vDgmZdb5Tg7QOqd/cQahNUmgg/lUeSEbGYjkLL5ZYdhB
         Qvv8y0fUMj8vvYDBZK2SM9llX7yZQbDofyRET/MfDUU1cjK1dFbHw0A5Jx0vOQj1y4yD
         8/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373505; x=1788978305;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AXQi4howHroN7DuyCWjjvFV0b8XeXdQweCPbXwE3Wk=;
        b=CGAd6odFhgDEpakuLinpd0+tvRv5qNRxT0Z5xH1lpceJlb/0Oxm52R13Mr202TR6Ld
         KRPjwNlgnkrzHNpEjjZde/J/kO1To912GVY0Fp8wp7VkfTzk+GvCGRaLJq76LfI2JNqM
         BPrn7nBIvbC3Aq0xF5yuzhRrgWhWsLNGUyn5ZVBRvnpgMktTutX+/6jm2hzIsnoh5Z/B
         Iiy/QFsopXNouMTxnCePyB2gwBEkw7hhgEvsshPsJTj/zEXHvifkp/ZK7gI71BOTIaly
         fOiH3kZKjUzshtFB2ejbOj9c3IgRBGtR6Tz7EGm3c4G2qFr3mhhw8Vlb1lOtOI65cKCu
         IIrw==
X-Forwarded-Encrypted: i=1; AKwUvBy9QbVlfYErdjhhmcC4k9D0xjCiZTUHjIivy1cvqvAYPkHo/nmEM8rWBV59uEZITG/oDzOrK3Tz1+GSsg==@vger.kernel.org
X-Gm-Message-State: AFuF++lgdjvhV5Iz3tdowjN4egUWuP//SVtFDsPwHS7auh2DwNEV4oIx
	Z6PV9Q4A+ZDR/wGx0uxYXr6qfek/17TbLL8tXQTFhr83AUAWLk/FFAI=
X-Gm-Gg: AYBFou3xc0sUGg2QyIV14cKolpjkO+LvBo7sEk9SpvMHuygKQv5uMhgNvlBzuFWcfBp
	Xy/U+oWF4Us6i9eroYfknx7tz4mIqoBX3uzqVdwm+YrLMKLwx4WTcnjP+KgRpcrGvBVciZg7Wqv
	mw4z7+I8OIgtfZLugzZ8qcPbDDdZdp7TCAF0eBnTXI3uyROzXXCmTKhgUGEG5buw+4efoXT97LB
	iPGzQ8/i1rub7vPB96I5t2tAPI8DOZtUYOv2DEDmdGpRHZ8xJjcO93G1wuR9V+CDsy5PfrjAQsE
	DW0/x6h4yDFolSHivZqfcEYjAkTCYx9VYQHrZyQ5MtN9CviycyZ7R3s45IqOiGfN+VWBq1gjwaz
	SBMlQSg0yl6IgX1nzQhQ0IhuL1gkRLEYSx4j1fx7JJOijaOwZTdaGEXgo0upntqIvNKFNqCA7SN
	mE88bW/2Egn0lrUbZBcyHuTIIvCu1xApbn86Ox1f6fVJsePC5acF90DXFPR+jPiSSuwUNWOks/q
	+ewav9nkr3shUXEv/EC+g7UkCXa
X-Received: by 2002:a17:90b:17c2:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39aee13cbb6mr8049325a91.12.1788373504937;
        Wed, 02 Sep 2026 11:25:04 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:f76b:3efb:3463:cad7:ba39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079bd68asm8704512eec.2.2026.09.02.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:25:04 -0700 (PDT)
Date: Wed, 2 Sep 2026 23:54:56 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/17] xfs: add support for lazy direct read bounce
 buffering
Message-ID: <k7ugcithodfdkswsbzshcnwaqwiubmhf2zq5jp2usck6finbhk@xt4pbaimvl6d>
References: <20260831064010.2574896-1-hch@lst.de>
 <20260831064010.2574896-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831064010.2574896-15-hch@lst.de>

> +	/*
> +	 * Free the bio integrity data for the original bio, as we'll allocate
> +	 * ons for each sub-I/O, which could deadlock if we keep the original

s/ons/ones

> +	 * one around.
> +	 */
> +	if (bio_integrity(bio))
> +		fs_bio_integrity_free(bio);
> +
> +	/*
> +	 * Reset the bio to submit the bio to the block layer again.  Switch to
> +	 * an end_io handler that simply complets the ioend, as all verification

s/complets/completes

 
