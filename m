Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CC1D0431
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894569; cv=none; b=ILqNfjqIl1qjtswMcToY6+993isXaTyfKGao7MZGKnUkzPuIPc62RuzWzbXVgZrwpnerzGFmRVotZo+Fs4sJGVHF2xPXj57Ekp9cMMSw973Zvw9aX8Ch1zwPdwoyRwfwYTAZ4MXm6jLxzC8OPQNvY5rh+GtUpxZZIqPUOR1IVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894569; c=relaxed/simple;
	bh=5fXwlvu/i5SzI6mtM2CnEsX3QT/fay//U8wWAi6ZQHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTY/7SPTIOT2CBHaI+iqepeqrxiYqqa1KWA7IAE6xNexuXNyuiYs+PK/CksJH5mI5WJHjin+JjQ1fYgZ21ibjshF5lcheDPRrjZ5PMVH4prbEqbRT996tyK8ExcnkdDyeorLYw0IJ35hfKPzFNmKgR3M3DJDDyrEMXT1xwk69Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lErW93qN; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lErW93qN"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a363feabc6so4196405ab.1
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727894567; x=1728499367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4l60eyXSEPtt6iDstGelFULL3ABVlMng2oXtkcSsas=;
        b=lErW93qNlK5Tyix8w9AEngZFdOzydYg9fXSOiSITGTmt7HM/dJjx8rTZrTHs+AecMO
         2gNdlG8eqbTyesulkeA8kaZAzLIlz+HxPoCSe1HiEnVfB7MAxVJuCrhvCGT/ERX3SXlu
         E9cSrBdob7Ygz1n3lhTkYGasPj1NOgcvfBUCgLkUnhMuGWzEb6UtG07Z+ZjTbcNkdkyU
         D6cDRBrZuQvWKny9VbAWrj3qED576G2DLqfAI+SLfIKc0EWFe+SLZmsG04L8/7C2Pgtb
         ZQigX21dvexlkT1B6wBWnGNh3iYLmxbCF2pH+/DAXuuYkjbvDSjrIqvF7gk7Bl/AIPLN
         o/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894567; x=1728499367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4l60eyXSEPtt6iDstGelFULL3ABVlMng2oXtkcSsas=;
        b=DjLmriI4IEbqzDDv4dIAoO+iBpDhEAnBfmj8dofF/bW66NS7khRzeB3twYHw2xAlpF
         PFo/ferdkwYTBeMvcoYcU2ehevy0S3fa7Lhb0lFjQ8ABPBa0CAJ946Nc1FcXecOoVPXq
         dI5IhhPWnew7/1N6vYO7UlS+MrG6Rf6ckGMWIF7Y1DLN8adOqANRGupWYxVgXr3solr/
         t0E/xr9AJZZ4311hfQKq2WOTV1H1Cf94X18ui3VKPHzQBiDFuCpxO4F4WZwvANdouLIj
         snolLclk5TL93sON0RRlDd1GgVfww2E6lEoa8MpZKBfxmVKiWfivo2cQcEdvBu+x/9n4
         zgdA==
X-Gm-Message-State: AOJu0YyO/pWAJlEg9hea8MODsFNuan8fmr3QzPBgFtNHkL65lqjOMbuw
	wLDCe593x757+bxN2JNHzvNghGpqhNkYedpIGi7KdggWV2UrthautwTLFs8GuKU=
X-Google-Smtp-Source: AGHT+IGkNOIHmtsK8Jc90wuVxQ7LqZmMQ2F0krBQMJ/mgjZyCRSzxGxp2bwS5hqNy2an5EN17b6Tvg==
X-Received: by 2002:a05:6e02:13a1:b0:3a1:a2b4:6665 with SMTP id e9e14a558f8ab-3a36e2a863cmr5918495ab.12.1727894566876;
        Wed, 02 Oct 2024 11:42:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344de1ce9sm37628065ab.58.2024.10.02.11.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:42:46 -0700 (PDT)
Message-ID: <5fff643c-5b24-40f9-8054-59cdbb6186ac@kernel.dk>
Date: Wed, 2 Oct 2024 12:42:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix kernel-doc warning
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002184040.18315-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002184040.18315-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 12:40 PM, SurajSonawane2415 wrote:
> Fix a kernel-doc warning in blk-integrity.c where the 'rq' parameter
> was not described in the function blk_rq_map_integrity_sg. This
> warning was triggered when generating documentation.

Fix for this already exists, going upstream for -rc2.

-- 
Jens Axboe

