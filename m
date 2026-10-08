Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2EC3B636A
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431551; cv=none; b=nYuQKRKOmj0sxnJojWhNG34R6rp7mArlk5U+Ap5ybFKmT2yKvGzx93EHPG8Jaoa4IzqwLCbtszEv5RqDwJvp903V3/0QZzZu4hhWh6DCpETfOrtbRYxCMQBPyYmNMxekcdnWi2/9qdSVDVcNZrfnYBfLsdtpoGomfEmiDXA25TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431551; c=relaxed/simple;
	bh=+S7+6b0tE0OmnLFC+QstPEqY3o50EFg74OIiryzh5ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHUIDxZPa7N54F/I4lfaRdhdQ5Jo1/BeezafdvwKstccQtyi2L2h5iJguz9CcMS0XcjvT//bw/R4k0D4bRQ3sIQUpnmEVfrlmiX80x46CntqFvA0tTLdfo6ip6mS58bzuAJQMqo3UrGWIdsOhhjeC3JTlRaQJoKByMjnKMzkUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c+JIULFa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+JIULFa"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8897e83332fso108428b3a.1
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2026 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791431550; x=1792036350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vy0poknliGswHcpdQnidx1yFhBPlUDC+lTCKJfWkmRg=;
        b=c+JIULFawh9O9VQ87fwLeM+LvkiSl70/x6DXs5EcnJs4AIMY1GEWJp8ObgBPZGJB4x
         Mv05UncODjqv2XyRjoBKQVbMrhjwEpgHXgw9TY63vhs/aUwuE3SSQTJZSrZUcCc/8UiJ
         ddvf+4LXB6MROmkpIb8AqBcLQdRz76QjzjoX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431550; x=1792036350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy0poknliGswHcpdQnidx1yFhBPlUDC+lTCKJfWkmRg=;
        b=chbMDf/6anIXdz/8xzYjPVOb7wzRxPOACVxsJkbjbVDBK67RsfsFIAwwZM+Yp4Ns7X
         JC3t8CAMRXkyXhBrFKA6ubQWRlf0VIdhxNnpbWubhoOfjmdcwqFs8cAB0iZUKQ4GXofx
         FhBjB5zPycVhsDTzQvEiEoG1W/Y8t/u1l1bmUy7LPR585Fmo9aevnRBXiQZN9m1MMH6n
         dUxyTBnzpd7BwtXWZm/WoBlfJ7c8XqQX53lq2LIFNxYxwG3h8pdpkJ+e1B1uzyFjQiQs
         mz0J/b4UE+tXIRP+W+nDvxzUEAoIB/EbT2ow8htZZ17FjefvCo0kaeCidVwDIGjD6vy+
         R2Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwYpAbWVMNO4xdP9bjVjntXpPhppaw3nQeoLwMcLUXJ0U6LN45eLTcu4OV1psZEpGNHOE+3iMe8pLOC3Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKSNNxXOz6Pqryo7ajQZWv91NJSBHTT+4X6CaBkcDaM1+VZQd0I
	5FWLKVqm55w7F3Wv+GkJw28GKDYx2B0cF9Nxy/oqpRt8KakgnJ0E3CLbvjcT8fD0LQ==
X-Gm-Gg: AYBFou33qtIXidpyzAZmncleqzhqKb745Qnsop+A8R3xSsVFa4wPlFBSWO54bn23GLl
	I/vLuCWhrO5w6DIH9Hs6gwoEzlx2kgCAo9MVs5+scxvcW08U19ruqzKpMe3/eqwlCBwOLT/JLpp
	Mbytl959hmJ+s1XCRbaaXVKxO3te0jpAbfsL6hzAk/Kj2Uauzg4QtZRrhprrYn3RMmU0bzijm3F
	H+BgoE2Wav5jkd+QiE+8kV9Ssc4U41bTyb/Vv62N+FSsL9EhIQqlIZFjjvXEVUGSVk+Jetmu5I9
	fPZY78lK05qTb1+U01IqoHCiJStYZoFHhzoFZK8V8Gjc/PdJjaPBSg3kvOj5tCM80EohHqpBFrG
	PMr+/tTOrMcWWuWVzUO5Kp3BNNnv8M0lmddnhnXlHAXgA2yZHsxBajJmNc1GX8JcxagwvFSUahp
	AkfgCizl5Fm8nq865r5zVioZq8ve/qdm1Jan9INYze4gWzLmZKxlzRomKMrxvzOVpu0d04DZRD8
	na2RDInAzHWKdPpZTddfsxUc3quBhJ+zM6n5g==
X-Received: by 2002:a05:6a00:4b4f:b0:880:f22a:b123 with SMTP id d2e1a72fcca58-8930d0045e0mr655238b3a.36.1791431549972;
        Wed, 07 Oct 2026 20:52:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:97d3:292:91b3:138d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb49a188sm977281b3a.33.2026.10.07.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:52:29 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:52:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Georgi Djakov <georgi.djakov@oss.qualcomm.com>, andersson@kernel.org, konradybcio@kernel.org, 
	abelvesa@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <ascS2nPCSQJxOGDS@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <ar3yt8Kl3WUV93lP@google.com>
 <4ed3f09f-74fc-4f07-8897-5c773fbde0b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed3f09f-74fc-4f07-8897-5c773fbde0b2@oss.qualcomm.com>

On (26/10/06 16:53), Oreoluwa Babatunde wrote:
> On 9/30/2026 10:43 PM, Sergey Senozhatsky wrote:
> > On (26/09/30 07:52), Georgi Djakov wrote:
> > [..]
> > > @@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
> > >   	while (backends[i]) {
> > >   		if (sysfs_streq(comp, backends[i]->name))
> > > -			break;
> > > +			return backends[i];
> > >   		i++;
> > >   	}
> > > -	return backends[i];
> > > +	return NULL;
> > >   }
> > 
> > This hunk looks unrelated to the patch in question.
> ACK. Will remove this.

Thanks, if you are going to add qpace zcomp backend, please note
that zcomp API is undergoing some architectural changes [1] (shouldn't
be too much extra work to adapt.)

[1] https://lore.kernel.org/linux-kernel/20261005122036.718976-1-senozhatsky@chromium.org
