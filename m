Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287387;
	b=OVPmyxPOFheBtOTT7H6pYNwe33AdnXyahE6NPS9iNRqTb+LuLZd5R+nCquhcDy209lc0
	 Urq5TrJh7fc/X0wXwwlCTwTa8f32YsGPO1VGh576jWRSoruxo6vihHuWRLLn6TsRoMP8G
	 E0BNzrbifqSss3mY3QEKSW5DzFIawy2piqQPDFjfx0WKfnYceRxMxNk02vJ+fj/l5+mSN
	 aiNXDQt49qMVVcBuqlbPoOHDUFx0ZpTjw9CEXXRRVtLUzFHsyFm0n/FYEkewJDJAjDur+
	 5PzOtqeGBIBYPnPIQ5l1ZCJayVUqGzOXgHnnYFfwa3ltqPubEW0O25v1tQPT5u0fvFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9nI/EA+STEPCGq9S2NlF86HxTqJD0H0ath9HnAszLms=;
	b=CHND/bt8uQqVZiyYV40ZPKzdu1ZCp76LZ+3RtrcVkiC/TOdP50XQZCGQfsBGmG+Ujeed
	 VL8mQQRnmITyL+7f2VGWXMF/Bn3W9Y3tR7wznbwh5i9vwYB3eB3pzea4G0w7bMwFqL1Xw
	 ZHCC1W6dI0YI8xlYASVftR68ATgzhjVsUHEDmzmsCp0u/7PoFcjHoOYY8bF+XXp2eHda1
	 d4r0OTUiM6hy5wbIntMI2f8NYYJkXoPGo3Ar+7k65yLZMwrOCozo3TcY5fGJYloWj//hp
	 VM/5HqQGB9Ady2Ano9yPz9h5HD1GusiVzvxa1ArUFMiZEAl3uRE7edlCU+Np1kvbvRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X7+hQdx0;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1860A263F
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A1860A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X7+hQdx0
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a058315c79so801324b3a.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794287386; x=1794892186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9nI/EA+STEPCGq9S2NlF86HxTqJD0H0ath9HnAszLms=;
        b=X7+hQdx0yyA9roUSBEbNrghAiQdwgxCGw+u08pYEgpDuVe/254alZ6BqYpQDmWWLCa
         rjbEutU9tL/gRvHmKMTjch9ruRmPPYFqn9Zd3a8lsdpZbpzmyw3HfY+iTgXKRCji3Tgt
         XdKybJyR8d25fY5DNSBXB5u0pFlyZNxVaph1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794287386; x=1794892186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nI/EA+STEPCGq9S2NlF86HxTqJD0H0ath9HnAszLms=;
        b=UIjZIBvXuqz4P32DVGZByxJwK8AYTkd4qvzkzA9DtiBT1B0KcngZjlrGLIDBiaYJNC
         Lyr76Eo3HYJLBMC3Z/CLEFGJBMPEV7To5L286bCDm2OqNvL/CCe8BSYNICvyJj2Xff1E
         /xtVwC3Kz8pNg7vazDDUXCXDm/iWm/tnpwluWR4XvoiJU8WAYk7OBxMfcjyeygGh/6qb
         Hvl45eluAuNMPUa6HQ0CmA/dzMI+4w7W88vKlIZFLNux2046/vZSXHx84Q2P7e3QYkiZ
         J/e+nfQEbEINlH/2OlEyyiUUT65qgxr4P5YLHZfDCX82o0PSTEGLvhXepKFF7tHA2L1a
         YmaQ==
X-Forwarded-Encrypted: i=1; AL+hErHsbqwt7KB5tb/tc5wt2dkMdkgcqyDfhxknt9HBqSvS1br8v3eTyszxgBroOpn1jln4KhH06wwd3/1ttA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vdQ/dDK08N+8FxXFN7rKkrGNrijY+UEFhf/2Z687TOKQ296zy
	VPDY+rF+W5qgD58GtikwE2/jkKkyaLX2ImUKh5yObegivMhwDS3a2KdJmPfzMJtGBA==
X-Gm-Gg: AYBFou2J7qcI12FN+ThPe1uV0+nSJd4knMBBFxxM33HBDBLbM3KCk74vtwmkZo6KcEb
	sVDbwfT4BI7ORmSHrSr7zkPr+QIDz/AZwBqMs/xn1oOauwKBoFlwRR6b71fc1/QAJ50TpmkACiT
	JhCdJNRSok9z8UC60P6YxHmhcsYphEG/up7HlwFbCnAfciLooxJSmeT4Z1gCay2Df4pJjq1dvo2
	X4x42GJd+WOe0fhz/9ppV2jHycj4n8elISC0FePM213qTmMH9ocUsizhC5E8oKT1sCQ8Agramn5
	qRfLY4mnPVReOUgv5JMXGJQq2PWRDZBlEwzOxzctQiZbtrL82pdiFxMM2+RU3KkuTRgtQoXmHCQ
	1BbvZ1B7mpOVWHpsWa15/Btj7uWk5+ZGvopWVuUVvoI0GOqvf3QbauAFzny1vEb2zZwQPr5b/9H
	Pyz0k6eCEdxqcs6mLNKlcz+Yd2PziXJWeBg6mYZd88NZQ1FV0tnAgju5g7YQefXcZJLqtGcBsFu
	bcu8G7NhVWJ0gGEaXt7c+lcKB5xthEBq1oEjhHqh7ILD85onHStjqt8EF6tt628HCjTGiFyXqFF
	vTSid6nSf3TzYd1uq4UcpcqCNUy5HzARdWxhhrePEKpssGlPIHzLV38nDpIeVsxqY2lZuQ==
X-Received: by 2002:a05:6a00:3692:b0:880:849d:c07c with SMTP id d2e1a72fcca58-8ba8590318fmr1720593b3a.25.1794287385925;
        Mon, 09 Nov 2026 21:09:45 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab4fc2b5sm384573b3a.50.2026.11.09.21.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:09:45 -0800 (PST)
Date: Tue, 10 Nov 2026 14:09:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 6/7] zsmalloc: fold zs_obj_write() into zs_store()
Message-ID: <avKkvXNesmBRORnn@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-7-senozhatsky@chromium.org>
 <auy6wQIz89NxpskT@google.com>
 <avKFDz0PGwkbwNgz@google.com>
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
In-Reply-To: <avKFDz0PGwkbwNgz@google.com>

On (26/11/10 11:45), Sergey Senozhatsky wrote:
[..]
> > >  	spin_unlock(&class->lock);
> > > @@ -1332,8 +1324,14 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> > >  	if (!zspage)
> > >  		return -ENOMEM;
> > >  
> > > +	/*
> > > +	 * New zspage is not in class->fullness_list or movable yet, so we
> > > +	 * can allocate the object and copy data before taking class->lock.
> > > +	 */
> > > +	obj = obj_malloc(pool, zspage, handle);
> > > +	obj_write(class, zspage, obj, src, size);
> > > +
> > >  	spin_lock(&class->lock);
> > > -	obj_malloc(pool, zspage, handle);
> > 
> > Should moving obj_malloc() and obj_write() outside class->lock (and
> > skipping zspage_read_lock()) for new zspages be split into a separate
> > patch on top? AFAICT, it's a separate change from merging the
> > interfaces.
> 
> Let me take a look.

I like the idea.  At first it looked like we might have a tiny corner
case is when N tasks attempt to allocate in the same size class, that
has zero empty zspages, which now potentially can result in N fresh
zspages added to the size class, each having one object allocated.
But the reality is that master does that already, so nothing new.

Maybe something to look into separately.
