Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642841ADC7E
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893161; cv=none; b=YayVBNj8srb40rJ4CLuq7O5fBuUFHdbwwQ6yAhR+FjEFYuaVzp6Jr2Uz1gmszKjQz5yoy/4qAxxP5JqIwU6aPAxpZ998uUTVXD3aRpXstCDH6PkbD4+s8lTaCC36avC3FZRhgavwijKNOkRDSezC8JJRwVzKISFUQNQu8emxdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893161; c=relaxed/simple;
	bh=R2xPo+g1LMyPcUc9CmkvXv+xwDlkoKwjnBtO4usK8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRhioO+T2B8vR6DxBkhkMiP4SiVG8micc6M8QTURgJYEoCYyfxw4+q0IbKRgSSubmx95LEOgHnAqhZfl9hc0x6cYy8BNN3EH18qsqzPFM5u30+5nj2uStuFT15r9GB8CyhTWc89zS7T5k5/fuDnsiPQWArn8nARSH9/tOUqcanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kLGMkOGb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kLGMkOGb"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35bb9070644so290974a91.2
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 21:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773893160; x=1774497960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHOwjv3YhlkQefFz19R3DRihRwLiRVCyfnjzhTGc9sI=;
        b=kLGMkOGbxgnbT7tMqxlRT60kqeXqSsF+EmNQgEoXmTCPe0bIQfPLxm9rWCApmRZZzj
         UjpQMY2LYtdHiCdPgcDcg3Z6bHahntkk5EiFJc+YaBoC9ta6y7857GlWllsdRPwRjtuF
         T6/Xvx2zR+tKiH5E6Iw4tuPap5BIMcX6dhStQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893160; x=1774497960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHOwjv3YhlkQefFz19R3DRihRwLiRVCyfnjzhTGc9sI=;
        b=HvI9UuQP48HV8LthQjWpFkhKqMU9DY7i1ZdDb1poO0yTH211JG4xZ0Ow/G/g1djJ1Y
         f8hxIzRoUSSnvRhXetWZIuT3lWG6w7ebz99KDNIWWlUxCVzqSggz7y9Z6aZJm4rPvrld
         CleTJfkNetPc9jkYYyxAy47nbLbgT04OcWAiI5jA8GiIgIfWL0bBG4zo5wR1jFP09Oe3
         QSyRAW6ge4apATFCmEGzFja0j4e2g4HifRtzwbAqbzcarzlQ+9kkpyOWn18iw1M0onoT
         OJsXQFNWdYLZs7cWyot4CzxYKiBNql5crMNT1H44etbsve+zENnhm4skloJzKjSPXE8n
         mm/A==
X-Forwarded-Encrypted: i=1; AJvYcCXH9igSXPbSOhePLPr070UooR/vxrEnCwbW2ZVAfvpsi04TrIQ8KJ7pt5R2V0iOajrENtaTlQ0vJ8yRkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWX3Gl4K3R+iuFalz6HTid6NZjnpacp3AJmSK9pbw/T1BAUb3p
	+cf1BQSQK/Y9Eg872VHz3eS7kGljcCTuK7DgrVhSDmMd6BbQFqqlT6gAGAj6GUsNHg==
X-Gm-Gg: ATEYQzxKwLQIYgWjHJZ6q0lgekwzN+tm4OzVtO1mDYXiU4MGfV8qRfNk4lTggWHe6dt
	y7V21XgC6bYLbpq+7Z95SdUvN3rTSv11QkF9bKpFLdK/dm88e3ilY1vsC1kNIofKRp6nPspKoNE
	mZBkGgvknIgOub6vjNdkmefl3JJ0y2xFQGYtLzko4PL9/EOeNvMQ0QH/y/8Mcr4UjfA2A7iKXUL
	ELB7t05urlUVOKlOgJB/ZWbxtOGoHwiRLo0ABWBaPCeAPoKpM48UuHsPFxfdKH5A2kJvN9Ld9/h
	iWPIbLOe2DnZ1PFke6Wwc1UqnCZvV5etWZek015rYu3iPBIT1X4alEohAqOHT/mAv4aIBfrINaa
	ITgrSxZDepE1YxBKVbJKIpOU72CZikujyWwq3UdUwvV0Z5J5CudfQHsq2MMgHTTrKDPAPjMB45L
	I95pc7+Gj6qTtNhL7vLQJSVtq8QIxbCC+g/e8mZRTN8EMf1Vp39UD5oODiFQBLxQU=
X-Received: by 2002:a17:90b:4d0a:b0:359:8eaa:7f42 with SMTP id 98e67ed59e1d1-35bb9ef601cmr4835762a91.18.1773893159754;
        Wed, 18 Mar 2026 21:05:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:13e1:7517:52f3:cfc8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm1281973a91.5.2026.03.18.21.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 21:05:59 -0700 (PDT)
Date: Thu, 19 Mar 2026 13:05:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, 
	Richard Chang <richardycc@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: do not slot_free() written-back slots
Message-ID: <abt1dsjsT9826Ewy@google.com>
References: <20260319034912.1894770-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319034912.1894770-1-senozhatsky@chromium.org>

As a side note:

On (26/03/19 12:44), Sergey Senozhatsky wrote:
> -	slot_free(zram, index);
[..]
> -		if (huge)
> -			set_slot_flag(zram, index, ZRAM_HUGE);

Original code had a bug.  slot_free() would decrement ->huge_pages,
then writeback completion would restore the HUGE flag, so when slot
would get freed for real slot_free() would decrement ->huge_pages
again, leading to underflow.
