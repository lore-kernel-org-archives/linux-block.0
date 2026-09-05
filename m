Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC24E8E1C
	for <linux-block@vger.kernel.org>; Sat,  5 Sep 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632754; cv=none; b=PkfyYab7VpSs31gx9q9G+nIgomT4al5g6oFRTAIACTwy6ZssljK03Iu//SQ07vbtZaQcrgdFByZsBWOHr1eRMoLPjUV4Qc+YTkFBWX5LAz0n48ke8SG6yRyQONOUvzX1CFYSXX0nwYwNZarrpmyxLZ40KUwtCaL2Ad8ZpGjNE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632754; c=relaxed/simple;
	bh=rakUssaS3Z60N+MJ5OmiZGkRVrp4Fe3erHejZIlcqBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2iJ7AJrC+IntQqv2tyOWQ/uidzlx4fphRR8g1NXI7xppUuIiMGGWQXmU9Aj3rDHGrDpDymRANLbibnCosY+N1DT4qygeerdkULKeRIBQPpGHtUYMg96Ttv5/aj9MDtSyWZvQvCvQ90es5BLNXP/1rUy9TGaPddjvgsP2I7lW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=x7nOgQT5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="x7nOgQT5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b965570d7so25220365e9.0
        for <linux-block@vger.kernel.org>; Sat, 05 Sep 2026 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1788632750; x=1789237550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vh1tho+DMPBe6dOnmyRhQgSZf9FdJaDw5EyeCtsHdOA=;
        b=x7nOgQT57/9v5uuS/L3bp3Rp1I79CMDt3RPB6x5WzokX0qKuYgq/1Ks2QOTuMFpLBy
         wpXguFNBeyZ2i8pnQLtkncuOpnb0ezbdiDlynKW8mBU3m1mfW2vov8+x1uSqnS7DssjY
         x88hVLAZakH5j81wCIsdwPkxr+ca1SquUf2RR2/VTfv7pdR/IuQ4NGalxOBGClOZ2M2L
         xK2eUL/Q7OJQpT/4f0A7MURgRi/M8BEKc4YewZnOfnBOQu7lNu+XZClxqP9ZssV3d7n0
         NBL4RpAF08898ve1SqptTIhWZtKMAAjGxU9c75Bqbr6qSBlY6xyvvDc94WJvY/KcJjIF
         jPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788632750; x=1789237550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vh1tho+DMPBe6dOnmyRhQgSZf9FdJaDw5EyeCtsHdOA=;
        b=EpR9iE5xX6Zib2FN0omfAbzLCiXuG7ydvN4UfVjRsDhEtW8y+C4LfG7XwL7udr2S3I
         b1PX4usUBcHqAnDdlnKR/yr8Dmfbd4wEOr4jWQPH4mCIUCJzfVGl5sjd/u2l5DGmEUbA
         nN8kUWtY5Fi78qHXye3KeHcHAQf9kT7EXf8R7J5WywhCHKNm5oQBGYOSiJk+DUXcQaun
         vDxo7T9bdLmKsuRB3xxPOCG+OupzLA0uo2RU5qyjbHKJVQ1Kd2c7EI2fowwWB5JMQcop
         zd/eqJdR9T442sDUXXzZ/4PN1DUUvSj6v58GvqYE9NNEgHbCOeS6HVsXPNq0GSdPp0/g
         m+0A==
X-Forwarded-Encrypted: i=1; AKwUvByFDd1Wc2qCsmIiUHCKIPh4jH2zHH05tRSDFCZnbT6Av43hRcrz88XUHwvD0+RMGBElO/3C2SHxca0zJA==@vger.kernel.org
X-Gm-Message-State: AFuF++nWTkh5L/eIrrSMuBLUkawF3PyyBrBrUogSk40CshIJkv6UH8pp
	gCHGt//1QXYhMSLifVd1fiJNmg1DA7HAMGNHXnbV3gZIQmjmYe3r99ERqXz4x3+l5qc=
X-Gm-Gg: AYBFou2wR4JvbZG3hOydx8+PWuFwGtBH1g5rJxqpE3009rl50QROmKK8EjQdb3+ljSx
	joRqu8I5N/Hjn5/bgMCgQdm1XhG6DMLhX2VZK+74ynmBA5m8bKkBV60eUg2dN4PFbzWvcIj4Vv5
	6+dkLUBMgWT4w1oziJnx8cB8J3EtrPQ3OveZWBGf6F6P7soyKAYj8KBgZMoDMKUeVifCzVwcuYc
	4y96ES5aqu/phvS4gmZPBUWul2Q8kaDplp/RW+rvBwaPCS++W+Ek80CZcU4D4zIauJfn031FxMN
	ErsYBQh61mDq15J3fSY2pMAgG7YCnZ9WEalP6xIbHzJ3lSn3lVE/ZXIIXTFFqm+mtirfHPLA7+Q
	0H/QxqmwKFouxICnmm4zzMtH9fCkYfr97HC1MFkD2uk5CejDLpKgeB9cKFaMfcSTCkfAodwCh/3
	lK1CFavguIFqxeErU2sXM7+9HkL6vMXaW4Plb++zYt6070a+ngoWDy+HItRQi9TQGkcZKjv1iJV
	Iq5wZCQ/NH8Ad/iesfA7Az6jA9nc+nC
X-Received: by 2002:a05:600c:3b02:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49cf8220edemr149030685e9.6.1788632750385;
        Sat, 05 Sep 2026 11:25:50 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm298811535e9.9.2026.09.05.11.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:25:49 -0700 (PDT)
Date: Sat, 5 Sep 2026 20:25:48 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: drbd: fix typos in comments
Message-ID: <apxeZOBtnBZtgjfw@linbit.com>
Mail-Followup-To: Hemanth Selam <hemanth.selam@gmail.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org
References: <20260904113103.10805-1-hemanth.selam@gmail.com>
 <20260904113103.10805-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260904113103.10805-2-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 05:00:59PM +0530, Hemanth Selam wrote:
>Fix typos in comments, reported by scripts/checkpatch.pl using the
>misspelling list in scripts/spelling.txt.  Only touches comments, no code
>changes.
>
>Assisted-by: Cursor:claude-opus-5
>Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
>---
> drivers/block/drbd/drbd_nl.c    | 2 +-
> drivers/block/drbd/drbd_req.c   | 4 ++--
> drivers/block/drbd/drbd_state.c | 2 +-
> 3 files changed, 4 insertions(+), 4 deletions(-)

Typo fixes like this are usually only worth it if they come with "real"
fixes in the same general area. Otherwise, they just cause unneccessary
churn for the involved maintainers.

Regards,
Christoph
