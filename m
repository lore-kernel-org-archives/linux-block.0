Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE869463
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164444; cv=none; b=BpKWsf6Cs63MhgverKy35YDw3C5Er4NaL8IOWiqs9jr9LMtm5/INlEt02KDsKhPNl7pNxfrqwloMPEEaE9KDnVApJSSgHuM/bRgTHzLTY6O4UtSvDo3CJt0/bTrSo5ibcyUBfODG/byPoKYl2o+ELcCgCf+n4iH1F+rVhu6ykrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164444; c=relaxed/simple;
	bh=fouKT50FVw7UqNe9uvc0/oPM1u+E42v2PZIZQUWhjKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew26W6v3pQTgV4HFN2yj8zSt0WlI0MjB4CWKxn+7dNKoA6v9J4KoQwyOiuInO+22WXXBtArWqlus8hkMnyYNhDBEp2IUmPqTAYdxSwGGpksMsH808PipMYpbJiI0/ZwrGz1z/l6YiqNpubvtJNTwdg7U3CsEjfJAtjiaeeGFznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=SFia7mHQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="SFia7mHQ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368380828d6so829682f8f.1
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2024 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723164441; x=1723769241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxVq7d+6lXAdN7ZFIDGRdxH6RrI8kbrtYwFqEDODc8A=;
        b=SFia7mHQ1YUsT9TLtEnA6tC1C3rUdVnkcflV1JOa2jKWX3pu+UimyBXbsbRfVPv1uR
         O7ADGf4x8x9FvREGU5RKPNlQlLPIz7/sWbetzYb4Birg7Xh9BD/q72hDYdFuQ994AN6s
         qVLw8/SpkdfOEzVfb2sEmlFAdGcx7ppqM+2yUttGsceqLPyXAcd+hSo56VMZtGC0uoJO
         lAkytWWKGNWF1VtbGVGiYMVkGT0QMMpYlpL5uS64BV14pdEzuxMa+geojgJTmYkoCp15
         /XnT7lQguQNrxDs9LOuPOdKH6q090/VSdW7jlIoacHLV3nW0fzrgP9K4g4GHZ8aA3aVr
         KlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164441; x=1723769241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxVq7d+6lXAdN7ZFIDGRdxH6RrI8kbrtYwFqEDODc8A=;
        b=sdSQJ3LuZTDNCWJe5maHMp4EXmdDPCl+RmdyLDFwzJZR2PBXhcLpWC8aEDDP9ZBNQV
         MmpU39zaI+TGAffiuYjyc29W1xMif658HHgYeL/wEKOWrKeqW25P+bJTG/y5csYD0Icp
         dbqPNJMTHGPg59NXhi2p6rzdYgDnYkCPV52vhShkQzbcyf/dmaf9j0JdiuEANfKGIs1V
         3o1MRyAzvrsK8v4a3M8c1vOzfwY/aZMCbrkp3l4rwu+NlhhaKyIwUSvqMnSbZJQaG8qo
         tk7U06yCem1Dm1gUbiLtq9wyP9RLcHwuWzEvai19cAZHKIuO7tDsN/ngij9rQwNldIJr
         j/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWq0jBfhig1gMcGLlyqdjCRrY2UF4MnEh9sKQODzxPjhvvHaUw4NXEl9rbAK7iqsG2a+RSfHkfbM+k5xWftanXGhq+JiwMrUyI42K4=
X-Gm-Message-State: AOJu0Yw+wCqB/HQrXyuyT1sUnGlqQeJVaHm8Z7mncayUJM9Auwypcm16
	Fh1GWgJG5PyGzTnrKyaTUYcKpRaI70kTkly/qFZnqBhxaVOFRKhc/Qp4gUirj4o=
X-Google-Smtp-Source: AGHT+IG02JlKzPETdcPuJPuSgKYXAOpTJiQ4atbv3qc1eTce1EJoHA2HclbW28PrRP/jDb8I8nRh5Q==
X-Received: by 2002:a05:6000:1f85:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36d273cfcf9mr3084838f8f.7.1723164441070;
        Thu, 08 Aug 2024 17:47:21 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27156d99sm3578981f8f.23.2024.08.08.17.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:47:20 -0700 (PDT)
Date: Fri, 9 Aug 2024 01:47:19 +0100
From: Qais Yousef <qyousef@layalina.io>
To: MANISH PANDEY <quic_mapa@quicinc.com>
Cc: Christian Loehle <christian.loehle@arm.com>, axboe@kernel.dk,
	mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, linux-block@vger.kernel.org,
	sudeep.holla@arm.com, Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>, kailash@google.com,
	tkjos@google.com, dhavale@google.com, bvanassche@google.com,
	quic_nitirawa@quicinc.com, quic_cang@quicinc.com,
	quic_rampraka@quicinc.com, quic_narepall@quicinc.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regarding patch "block/blk-mq: Don't complete locally if
 capacities are different"
Message-ID: <20240809004719.yuxvge3n3gnqziyz@airbuntu>
References: <10c7f773-7afd-4409-b392-5d987a4024e4@quicinc.com>
 <3feb5226-7872-432b-9781-29903979d34a@arm.com>
 <20240805020748.d2tvt7c757hi24na@airbuntu>
 <e5f0349e-6c72-4847-bf0c-4afb57404907@arm.com>
 <aabce4b6-2d3d-45a9-8f75-b1a6b3ede6f3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aabce4b6-2d3d-45a9-8f75-b1a6b3ede6f3@quicinc.com>

On 08/05/24 22:54, MANISH PANDEY wrote:

> > > If no matching is required, it makes sense to set rq_affinity to 0. When
> > > matching is enabled, we need to rely on per-task iowait boost to help the
> > > requester to run at a bigger CPU, and naturally the completion will follow when
> > > rq_affinity=1. If the requester doesn't need the big perf, but the irq
> > > triggered on a bigger core, I struggle to understand why it is good for
> > > completion to run on bigger core without the requester also being on a similar
> > > bigger core to truly maximize perf.
> > 
> Not all the SoCs implements L3 as shared LLC. There are SoCs with L2 as LLC
> and not shared among all CPU clusters. So in this case, if we use rq=0, this
> would force to use a CPU, which doesn't shares L2 cache.
> Say in a system cpu[0-5] shares L2 as LLC and cpu[6-7] shares L2 as LLC,
> then any request from CPU[0-5] / CPU[6-7] would force to serve IRQ on CPUs
> which actually doesn't shares cache, would would result low performance.

For these systems rq_affinity=1 is what you want? the rq_affinity is not
supposed to be one size fits all. We wouldn't have different rq_affinity values
if one is supposed to work on all systems.
