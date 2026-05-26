Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B11242D72
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779759856; cv=none; b=hTLR9kn6YsMG3ILxdmYicx8S1UyQ0eD34WGTWaQafaQsC+REKRiQDprLx7ZAFXGI8hd9p6GEgeTUrePWhZaJuCff/QjbECNDXjvk6a9fKw3d7xOBkfw7kRHGwzKeJ6GpWfHbR38ZDLW385NuSTDld25JA7BvQuXrRkBLgE1X7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779759856; c=relaxed/simple;
	bh=bXGkjaGQLPPRhGoaBmy14wkmNOAIJLXs1pBYxWUTz3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+VyvMgH6uzy3hNNvj8SfMC4dWjaa40ZFNd//iHkp4g2bzmsQy8kix0f4lxhzqNaVZKCryy+k6fLRvy8KRf0MnHNWEGvKJNVzbt6NPz6mb7AjPm0nle1+PBFwX6DGUoW2zT3gkd8XXYJaEVewmRjwN063PBYmApA7so5feK5eBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj6x0uut; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj6x0uut"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-914bd98faafso252530285a.0
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779759854; x=1780364654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/laSw8wGKqpG7xDWFNSVZINyUhQN2Xmwzo1IdWSZlZE=;
        b=mj6x0uutxWAoGY2OMYCMZJTR68JHYn28I4CvRNIOLedgDGXsYKtPdBKwhaxKrFBsAe
         cB99gBqDu0WUxLwGcgp4uVIP0Oh0O/Syt/I8OusJ69q85mHUdOKgz+U78ZomAEOCv0LU
         58neEV3pZ3QqO1hAVSpbgHKUtbHRNh7d7cmaUi2JXqTzTaCsoCpxmFyjGjAXIamzn/II
         X8x5WW2NStOgH8pjA5MYYaLAWjtOBFQVifbbjVr5tRuoLkoKonDt/2dBvgdMKxIRFb7D
         PT9kURPN5PZT6SJiG15TmTR+laDz1pjkmYyn3OfgfE7n+KyWw2M/Iht5V0wmYmgiS5fn
         cy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779759854; x=1780364654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/laSw8wGKqpG7xDWFNSVZINyUhQN2Xmwzo1IdWSZlZE=;
        b=SiepFypOPw+1UoF/VGoaXDRQdoMSrw4DfhIDTwD09GeSFgJ/EMQcPwtfl49N8/Qdw9
         5ceYApmGIoDk/20EhZHeEWchEc1Og34t+S3K6Xgb7O/5ud9krHCkcU+96HLuFLlQ+aTb
         Pz57rdmjKb8AZ/5w6lCT7t4rAbbZvrm0BYDaPCcWC597YMDG9P7sYG+M2+4W6a7aUYzy
         0OH1NRvsvGU7ZHWGFXuvgXbFEXmkUxX5Z64MV53amMRg5nilj3xNxsBnqBDbhIfYz05d
         Q2B/o00y8K4slTw1Xmh92jp0glFtIT9b2k9F6TPkk4vCSTSEbSm4F+Ye14yLZyXiDKEj
         2AeQ==
X-Gm-Message-State: AOJu0YyO88303ImNfY+iBzD6W+NHOJHL4vuvumFrgudXh93C38lnVi5J
	97b19pXSB1hFHEm2x9Ih8tgiHn8bnUM1RX/opMxIbhGd8FQ25sty+dSvAKt5MXjl
X-Gm-Gg: Acq92OHhya10OqC7WDb+XlpqUjckMQw/oTwhvKYP1pSIqiUao/qKn31udB2BMoEhy5z
	b3ouKgR1/1hrWYMSMH8/SBpW9AepI5rr9ceITfKDtpkirkP/VlKLRSzeb4d86uBGktqOSYTESK7
	rK6tMQK1DYAETr5EnKND+1reOwASyGiuGrTV5blF8ANhoKGCqkXoL4iLrE8Zzd/RBtS1F3jlhv2
	5Q3MROg+/A1Zloy39BT+M6kPcn7PjkwXLwygpnC/g9D0dFl650Pzri2M3T25YBOF9cJ9G4lSPqz
	MNz2pQR+XN9DcibI9vmzd18uIHxaSLYWAzemxmSyDpdZT9NBzG5TDZRjvbYMkuee3GXV+E4YGSA
	HQhjNTFc5TOWaigUcmEG1ZMxHZTJsPfkxfxXAW6inGfzpWDcl/UEdYPtGi7Vn2f4PzjKcylVWJo
	QQfuxLeMpba8SfKJeREjBngyau4Goij3J2mSU7zBPUfeyaLA7N9HeB+TQXFKw3DVG5YnW63WFff
	i2SGyCX+secFtf/3YEm9w==
X-Received: by 2002:a05:620a:4407:b0:8f8:e046:999e with SMTP id af79cd13be357-914b45c4865mr2309734285a.0.1779759853761;
        Mon, 25 May 2026 18:44:13 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c526sm51476685a.39.2026.05.25.18.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 18:44:13 -0700 (PDT)
Date: Mon, 25 May 2026 20:44:07 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: reinsert cached request to the list
Message-ID: <ahT656Dazfz5oc8r@fedora>
References: <20260525160744.896047-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525160744.896047-1-kbusch@meta.com>

On Mon, May 25, 2026 at 09:07:44AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A previous commit removed an optimization out of caution for a scenario
> that turns out not to be real: all the "queue_exit" goto's are safe to
> reinsert the request into the cached_rq's plug list as they are either
> from a non-blocking path, or a successful merge that already holds the
> queue reference. This optimization is most needed for small sequential
> workloads that successfully merge into larger requests.
> 
> Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
> Suggested-by: Ming Lei <tom.leiming@gmail.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 28c2d931e75ea..72c8ac805882c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3246,7 +3246,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (!rq)
>  		blk_queue_exit(q);
>  	else
> -		blk_mq_free_request(rq);
> +		rq_list_push(&plug->cached_rqs, rq);

rq_list_add_head()?


Thanks,
Ming
