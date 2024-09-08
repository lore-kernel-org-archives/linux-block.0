Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFE13A261
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725834362; cv=none; b=PDkYt2SLaLdj2TWnnztdrA5O/PhwTA5aVmUZyYPMrMLC/zZOdI60fXu+ldM5Myust4E2NLkCNyh5S+CNdsAncjFZDVdQAW3/LZdkIm7lj5Ql9wOpAKJtlsFtz5bKyScmswB9D2nBW9wTfAfSZn7g0Ey4G9yk30wxZe0S44m7lXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725834362; c=relaxed/simple;
	bh=WmpeAAzT0TjzN64zX3hckcbNTMWj+Us84tfUUkHbKn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlXSxAhnPyXMrvVTIwUH/E5aHkq26bFX6iYM/peR3fw9uFdGcDJrFydHIHsWxNcPhsxQZkObmnsxgsF77Tz8JH/OBSNLbh4uZ5xwezoNzmb//YCUWvR1mTtmIIbGT0ESSAP6bX7sgjd7T/efHcJObwcTpQYHYQcsXBioG9NbSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ys9BY4lB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ys9BY4lB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so2872424a91.1
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725834358; x=1726439158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhheKD2MaWmX7ObGYzIUVDmcL/vXif7CCP5OFRo31ag=;
        b=Ys9BY4lB5zHXyCVGjrUix4hM76iemo7BaEtFkHC2c+CPURV6hplNoqBvpBGRGlaFHn
         mDFooUus31D/tMGTTijCIU2k9eB577UqW3y8pK40vCerC2PlrtA+iQV0oUmnBJlVLlRq
         ABL7LsJe9jqvPfeT83xK+BDQs8Sjz4rtGsCijB0wn0TfrfD+We6qmgEY9uIwWcghjTzU
         MgTCWL/ixgM7H1v7AXGLru3dI9iRTnOZS6vXYHXTA/i0FEJrkcCBDsmgwkbMtCjJ4SbR
         +I4SQ7CEBYbrb9kB4hesiV9CgPq+/4+6bv+4fQU8dCn66MmTJQaAHMk01b+kYUwTJoht
         IIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725834358; x=1726439158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhheKD2MaWmX7ObGYzIUVDmcL/vXif7CCP5OFRo31ag=;
        b=iljpAcgpmfVqu7sp6TB04jxRn7w3hXpyaKc9OuN84IYHnaiDzUwmOLG4NwTKIA4DGV
         vbvMWAeqe398fpvo75/VUcP3lHyriimZ5V+wfpGU/jnPihZNmn4x63rzTbR+LlVs8q2u
         uHp5+zm6/B/O7jZtXGAmGIc/i6S39iV2AIoMaax96gZN9IP5HfYMaXWiXvp3pHuX2d+n
         nwLhiZEbVl9Sp8CMIiPEP2YX2OY8X3iY32FsDrvzsqcsIkXCfbou1pOvZ6ASX0PqsmDV
         LeoMe0toc9DJLqnac34tFY54rdvFmhJsN1fVYlX6I7RNKOslTUj3bVZUsWpdyro3/cxQ
         b5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWxMsbFru/cGfWLNgAAP7VS2y+OZGwTbxjO8MnWtS2wZDs6uNoRMzQWU/ClSU018ySrHQ0eCTLUkroyuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3tSz4c43P9KdebXYKmAVfr/U4SO23tGr6/Z/R1fZo3zhPhmW
	IKOFh5dJv8Mm5mVoQ57L9RBhomOxefDn9cwE7pbbz0SV/29CtWJ+p7hF5L37b0g=
X-Google-Smtp-Source: AGHT+IGovwS3k3odF8N7sOl23DHwA+IOE/iVu4aQQ89/6DHIT/GBnaepkRD3z4HHegIOEg53WSFELA==
X-Received: by 2002:a17:90a:ea05:b0:2d3:ca3f:7f2a with SMTP id 98e67ed59e1d1-2dad5023345mr8442074a91.22.1725834358439;
        Sun, 08 Sep 2024 15:25:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db033fea14sm3156249a91.0.2024.09.08.15.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 15:25:57 -0700 (PDT)
Message-ID: <3edd6a16-3e95-4cae-ae16-e1702eafe724@kernel.dk>
Date: Sun, 8 Sep 2024 16:25:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] implement async block discards and other ops via
 io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>
References: <cover.1725621577.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1725621577.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 4:57 PM, Pavel Begunkov wrote:
> There is an interest in having asynchronous block operations like
> discard and write zeroes. The series implements that as io_uring commands,
> which is an io_uring request type allowing to implement custom file
> specific operations.
> 
> First 4 are preparation patches. Patch 5 introduces the main chunk of
> cmd infrastructure and discard commands. Patches 6-8 implement
> write zeroes variants.
> 
> Branch with tests and docs:
> https://github.com/isilence/liburing.git discard-cmd
> 
> The man page specifically (need to shuffle it to some cmd section):
> https://github.com/isilence/liburing/commit/a6fa2bc2400bf7fcb80496e322b5db4c8b3191f0

This looks good to me now. Only minor nit is that I generally don't
like:

while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp))) {

where assignment and test are in one line as they are harder do read,
prefer doing:

do {
	bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects, gfp);
	if (!bio)
		break;
	[...]
} while (1);

instead. But nothing that should need a respin or anything.

I'll run some testing on this tomorrow!

Thanks,
-- 
Jens Axboe

