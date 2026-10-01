Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225074EF145
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850463; cv=none; b=RpxFDrdWBpD1PV3a+CiET007GiynvWDtFhnHL2kjecU4QVDuXQtAMhrKQ7su8vCiIcERaFNdepgkLXeyNHGFrskShwm+SxFO5m7kjP59co1nY+447PXE19oph6FeJieQplLcQVgOPxRObrtVrVWAl6nKlj5DQVmkrqTm71yrp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850463; c=relaxed/simple;
	bh=2y4gEjNzgA3MrPbQRg5Ifw5WWUUepc12pSJtVJWCuNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdLsruBGAbVeyBKi09wQtNM+ZfcLL9Uvj3f4QKyq1trg7y8gjdeKnYYy7Lb53euOhP1NvvjJkaR8hBhP4LbgKrK47Z/dGGGmsUB+nGS4iIv5ZB6CM+cSMTbghFHouw1sKw+dMxkmzqaAk/JxZp57nrLTHMdO7Zf5Rzpi1bp4UD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Js8hr/gx; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Js8hr/gx"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so3017858b3a.1
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790850460; x=1791455260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zOoZbBrkeSpdFA8vWrJINhow0mO467LA30uvn4Xle+I=;
        b=Js8hr/gxkm08MeaRvuDgNr+iPda5i6qBPBSUP4g0y9i+FDF8Z4TalxCSF+ZgmaLVo0
         mCOqmMVQS4iQ5wfblzULoMqXCcV6ZJzCQ+w3+v1UOngMbAcD/qhk9emqRnzCBxPKAff7
         qJpaxxjyfXiO9jUjTRt1VRr2vv1ar9O8NF4ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790850460; x=1791455260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOoZbBrkeSpdFA8vWrJINhow0mO467LA30uvn4Xle+I=;
        b=TziZ/MfqToRAU/sBr5ZUSBBB//T74e8ORbzEwhlpWsVXuKimPqgmXsgt89zF1o9v8h
         Sf0DlMwb5Tg0LZRQetxGIC/21tuaSG/N0DhP7eShVOfyERMZ1fmqjfjohU3NHOsxobAX
         vzwsdYbS6/swbBIKnBKSiBSiqbfY3tvP5PuHtHx69OUSOryIVctXHQ1LqwTX+Mr+soPu
         LPI0PqyKxxMbu9m8pkc35QPsL3X86y/NETXd/fYbgL5BO/WJRNcdgmcuoq9z3g5T/jvg
         jRU31dvYq22rLIUCRAVdVsT2fVLis9konzJhfRR5x5uREhu933+xCAqXcxK+/Exc9kLX
         W/fw==
X-Forwarded-Encrypted: i=1; AKwUvBxScVmh62WD7MXgIO+h03lH1eIWXfyXc00llwDfuk9MwBX18czjelr9xcy+p6nC1TPMx9wOn1uUXNbybA==@vger.kernel.org
X-Gm-Message-State: AFuF++l+xjhhIttzxyYE5aCTN1E33SpzBMXidXNE9Fr0Et/aCVdB6ai2
	5onE7u5jyRlFVU1kMrsbDIBX6Wsan7WeUnI6O6C+zER8moSIa/NcC5tjeo5NIKKq9Q==
X-Gm-Gg: AYBFou2COmWNhnOWpSPDpJ+QgKYEBRAFD87E5oEjWWTP6zeNmObJzU8fswNitGr9iI1
	+wD2lilsa9n7SqW3/Uo0c5rlPY9RZBt0T89fnnYQYsPt7RC4VFLWyt+06jWC/mNbs4vi/5IpI2E
	odrXMQIeEyPVjCZBQDlZyxofxApBuMJ5rbn7BhqD26PBMWqK0Jp7M5IHkmxRMb6bAiRkhcaVyFN
	kg/S07zjGr8rm2LAQabFfT8ggjHgO/i0W+XE22yKPbgyUQxH3zPo+KOb9Mq5+Ow0dbJOf5QXhmX
	qyrNv4g4Pf66W7AjzRvKIUVqETfJn6nAh9oRKQbMV/9T1Kj297BPxYboab8v/74fz2F/Fc4nt6j
	/0GGpjsnbSa60Fjzdox5iY6B9mtFX/1LrTs7OOn+QC4/I5LDeUP2ymXAiM6R63OnFg2gGBXUI2S
	VT+tPFOwdvQWMZf7Po7KZbwV1LzqIAlSpVWvl6voIcWAr/a8g6BTrJbF9E6i4S4Ui0BPogiLs+v
	dsOcE67lgbtbQLDCIB3/R0GsE6XnTipEMbWcnE=
X-Received: by 2002:a05:6a00:b81:b0:874:705d:f64a with SMTP id d2e1a72fcca58-8874bffd4e6mr3058007b3a.44.1790850460353;
        Thu, 01 Oct 2026 03:27:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:d042:b5fa:ebeb:ace6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88818719cc8sm861475b3a.16.2026.10.01.03.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:27:39 -0700 (PDT)
Date: Thu, 1 Oct 2026 19:27:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <georgi.djakov@oss.qualcomm.com>, andersson@kernel.org, 
	konradybcio@kernel.org, abelvesa@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <ar4070oH8lRCJMRw@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-dramatic-hasty-pug-68ebfd@quoll>

On (26/10/01 10:51), Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
> > Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
> > zram can expose qpace-lz4 as a selectable compression algorithm when the
> > QPaCE driver is available.
> > 
> > Compress and decompress operations are handled via the QPaCE urgent
> > synchronous path: each request DMA-maps the source and destination
> > buffers, issues a blocking hardware command, and returns the result size.
> > 
> > Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
> > ---
> >  drivers/block/zram/Kconfig         |  11 +++
> >  drivers/block/zram/Makefile        |   1 +
> >  drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
> 
> So entire qpace should go here, no? Why did you create this entire layer
> of indirection, singleton management under drivers/soc?

qpace seems to be standalone/independent arch/soc specific, and can gain
users outside of zram (fs compression, zswap, etc.).  zram's backends
potentially can disappear all together, if we switch to acomp crypto API.
