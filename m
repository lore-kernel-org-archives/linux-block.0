Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558582;
	b=0ekVt6mWo8EEyZAstn8Q+o9oEJjIlrCrmLKoGu+s8wZC8KTOvXUIEZmHfXf74c1WcPtP
	 4jmOADS/t+fy/DLQKIYUyrSfaQ0KrTEx7Q5WwLDZZ97EJqLTxVEYsB9xAbcR9sOt65Xwt
	 5yg/LslJC3WGAbNai51uon5hU+MIyvMkp3LFW9E7oWfxOYFYFo4obS7w1tsG1rIN7RrBD
	 xWu4WCTRob3K/PG9CSXMG1M8GX9KEMjzZG+EIKoNI5wutKHnGmO/Jpj/0JdrPuO7wPkFx
	 J9sSNjnXOMf9QnSCEPYfGrE3nt3J9aw87KU4h8r0Gfcqfl3AgmCUwI+z1yx+OCOB9kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xiB7CdYcz2CO10I+090KxlJTct06C9BMHn0Ug9FfOXA=;
	b=pn8FIzpSV82izj73k63GfZaKIqGILx+ZNaZ3V9LgGTKa9jJkZvId2fuQsdRlYmAOhNpf
	 WLOrWI/HIoKvuxhtNBCw9YfuL4yawdd+B0jsMZMNzvztZjBmYF1JI1xQpHtvCkgsfWJ5k
	 hr5OcEKSAFITPh/awX4tLcxok5Y1xTd84yCjPbHqCTx7isAvxEHavhJWByk75HhrUHcrg
	 BxOVYc773RaFNLO+N6UFTqeRaX9iOULi4ItsMuHXPDfrmWbqszvCYnNGsTGMBuzKlfLdw
	 4gZ2Q+HJPdslfhH7aELncBJ/CwJUgiIXinZ2/9YuLpvDFPEa+dWmmke2cYPQUfJCl1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DYQSDKZN;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37050606A322
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 04:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37050606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DYQSDKZN
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36661f953e4so633085eec.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 21:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792558581; x=1793163381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xiB7CdYcz2CO10I+090KxlJTct06C9BMHn0Ug9FfOXA=;
        b=DYQSDKZN2bRL5F3RSwjiUDkSX1QVueyiGlVs1/IJGcCWCIO31cMEICQhyiIoyABEmR
         qr/YxUMpWx5GE4nCibjT4weDnTpv0cQF7mO5j0msjETr2h8eIMasnydI2JmufLIuQgc3
         HmBPGscfc0w4DaV+etT3N2+nXZ+tba9ykJkqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792558581; x=1793163381;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiB7CdYcz2CO10I+090KxlJTct06C9BMHn0Ug9FfOXA=;
        b=RkLzZooXR6TEkEN6KvnA0mIY3uuaKdrAFZfWOPK5U4T6RH9C/imFZsGwWN1MMQ04U+
         8Vm0I7R/Q6yarQ9VSvvIEpUnQ6VkyA1vZo/d1FQiA1vZ8/gKuVBzhxl7TTfavryB8Fs/
         iLnY/3AQvz6u91TWFlDfzi3OByWrHHolzQo5lmkMWPR9magGqz4LzpfiS5poa+Z6BKhz
         3XrlMxzATQPmJq+XGeWwTp+yNTndAWAkQR1omklKGGtnYziqa7bO/DV4V66d5W9S1w3w
         q3oeDYBwAL+OABPC+VveZtUY/ITGa1CoSLdah5HxnPsev44b2fMdAAo3jwCAOtjBE2Cs
         1ZpA==
X-Forwarded-Encrypted: i=1; AKwUvBy+651ScmCEDgk9u4mBc2J42LjoglMX4JS18KbFvoqLq81a+Sftv8NNxOYQyXlCJ/6NsHDPgWqeNcZlmw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJxLyogzZJhtk72im0gGandDqe6kIlnUKafU7pBti54rKF4daC5
	qkQqVFvopgMMTQzZtLLxBLzr9/GLwgn6YOcl0eREsf0RC+I7VWgm0nmOTLHo4md7Mw==
X-Gm-Gg: AYBFou3pXIivpjs+V4XyMFXEE9EgBsgMVYU7bvh6bJdMlQmGspjPLAmZtFwyxGZNgog
	ECcBX/ejqsPsnxmB/StTgH0SUWTDFQwoXa1mzvewFwhm9rfXtEtsgUnbtX94IywumQOmlBNKnaL
	/n9juYuQMoq9W2YVSMb55xcuopjbJCkARxG7w9AytsksM2DfA54r9vOcr/KSMxQyL92cZPqZHWO
	uIuP+HVlGJo7hZI3xe5lanIxEK5PBoThAohzOxO8VTKdyfbkf87DsXHBoYdFh/siQmpIwi3I+ut
	m3Q7ulINboAXhHBd+Iweh653DcWnDsm/qyIqmwqLDLPpHLBssutzHPya9raUqyjZBLo2PtfXG3y
	qmNVkYXnN0DwaEQN3YoHCOgkCv9RfGP5JyW0r6zF+QIcvK6jeh7VcUM4fyhO6LxUc5AM7YJRqjO
	d8IF209MuJcsoGzuESlTGYiS5hS1jX8fmgyUf/j6UquIYSwg8rvQFbCej902vb4+k4d/UpZSybM
	lFcy8QYSgigU4NX+XDp1Wm4ZNefP1lY8EJ8LB98gtu0Zc+eT56VKT79DYZDNO7DHIdhNpevQteC
	JY+XtjHm4SzC8V0flst0
X-Received: by 2002:a05:7300:8246:b0:366:913f:4d18 with SMTP id 5a478bee46e88-3674db4d094mr1602303eec.14.1792558581213;
        Tue, 20 Oct 2026 21:56:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e153519sm3617931eec.3.2026.10.20.21.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:56:20 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:56:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Message-ID: <athFf0kXopUKh2-V@google.com>
References: <20261021024236.1787884-10-senozhatsky@chromium.org>
 <20261021042350.907-1-hdanton@sina.com>
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
In-Reply-To: <20261021042350.907-1-hdanton@sina.com>

On (26/10/21 12:23), Hillf Danton wrote:
> On Wed, 21 Oct 2026 11:42:19 +0900 Sergey Senozhatsky wrote:
> > Split struct zcomp_strm into separate compression (Write zcomp_cstrm)
> > and decompression (Read zcomp_dstrm) streams, and split zcomp_ops
> > context creation/destruction into create_cctx/destroy_cctx and
> > optional create_dctx/destroy_dctx callbacks.
> > 
> > This decouples Read (decompression) and Write (compression) paths so
> > they no longer contend on the same per-CPU stream mutex (Writer vs
> > Reader priority inversion).  Currently, a (low priority) Writer that
> > holds the stream mutex can be preempted by a (higher priority) Reader
> > on the same CPU, which then blocks on that mutex until the Writer gets
> > to run again and releases it, which can take a long time when there
> > are other runnable tasks on that CPU.
> >
> Given lock like mutex, priority inversion happens from Monday to Friday,
> but I wonder if you are inventing some wheels in 2026 if proxy excution
> works for you.

Reader-Writer split is a foundation for further improvements (like
singleton recompression stream and so on).
