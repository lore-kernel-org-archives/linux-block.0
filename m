Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173F2FF170
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779257; cv=none; b=OK7E9GZc06qDqu14hMKaH9VXxS7lytotj8vhOBs88I20lwvvPFA+hwyfLgda3uHA/ymCMyBin99Zdk3511DcxDxriMUVav6egbsuiIIMdz4x1dTrH04MPfAJX+u5gb+aR+x4cTMoIaeObRtuN1v84PUyyN0XqLM7i9WigSHXU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779257; c=relaxed/simple;
	bh=d+Ycl62/leAnxtSAgivt5g86iPtT/Dk6S09KWMzg3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYKWUT/UhqqGaMtK2LAA3/bKXLggn1aJtwrFI/+ahs5FdDR1pZ9lULEuTw3+18GhAch9p2jDL92CjLyZlSp3Ppbzl3NrKbwTuxRnU9LAtMKMOjUDtjEKaslB0zUSGfBtjYvMS9WKki2KoPOuQeDeJLKqHLBhiriqWx9QRHl3Rqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XT4EDHfy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XT4EDHfy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824923c7059so596538b3a.3
        for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 19:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770779255; x=1771384055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kdwUSceZmDAkePxcpaC3kPf3XjbthHmmdDCwpY/AiM=;
        b=XT4EDHfyPr+0vokzeNVgChwNwc2IgJh3i3rUQxHfDfN6TPSIK48JIjaiSU3fkns3LY
         JrS4/T8qLqAm9PhA/lx/2NgPm9SpGPpS0MdwN9aj6LssOWQAU/bVYlXAGywX6pmVa/FD
         qPIta5XijSihYQJ3U5HaDlV2u8C7ycHuzfphQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770779255; x=1771384055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kdwUSceZmDAkePxcpaC3kPf3XjbthHmmdDCwpY/AiM=;
        b=PmFKzTJLL61FGgrhZRf5iFxxjI7I/SJEnv4Vyp8KowhZaO5Nsa0mL9IEzlSzLtqVxa
         E7/Z/kOdc0FrbB+rJSVoo1qEkh6kxSywwKJqrb/zUe2RIXZGLDwp/rmX6tGjkBZgY2E1
         SVJHWeLWxsUwBYNcjhv6yls+MdHJvg9ANVAvpiEvC/Fi+l5+J6Q3AQka8haBKNp73Mkh
         utXF0vAYr1ys1ph5isp5CdGXaMMtFU3u43plr0Lff5i2x7KlLx8OUauhNWXYlPMchYJM
         i0ubG/fjLAwUDIoBdfq/uK/jl4ga3jmgDQvyjuzrtlisKlaIxjcgf093658/irNn40c1
         d7aA==
X-Forwarded-Encrypted: i=1; AJvYcCUQJZPZew/njskRlFepUaUDngoafZZVW2/m/797QGvnPwW9DiiUB9NXdhYMDvKMGH5Is7IL036PcwPiiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiurgcGajcjvSdDjW2I+An4cGtMX3v8GmxbVSQTp6/BvgOiY86
	vXjIYny7kOVxrGF4OqeX7dTuH499uUJkpIonXRqpDh1bDF/ydItJCeoXTsv8Bula9Q==
X-Gm-Gg: AZuq6aKjQnrBZL8T6Jgf950GYLiOCYdv1Q3lTQa8UGLYWg5Iwj+jEWU7zyjB1E471c5
	3svLdertcwQLyQPc8+rEi1AMsgm0DfpTNe4HvFhKVHrA94KX3XsVwaObQfm7iAmB8bAdDRMKw/H
	nYlEw7oSvm6F+xzDRrPDLsFeGIhOrLrfPpq7Hu06qOtycrdUjq3XXe5CuuFXJOCrT4ljSMTO8D8
	nmFdzorq3qbiBRXxRf9USI2mQr46MSQGE7+adi1O8gx85av3MGwV+a+xrfTLzRb/CNcBg/kSu3D
	WORXLK90fQkcoh6PoW8MdScGYwTdJ5F1b6tDcv7DsCavJPCF1UKzqlM/rIYpTepZNMCoLAZ+xuj
	sR+aDrD0iDXGlZNJom6V0SyEWhJeWO7aikP3JESd6VsViC2pR1eVx1FLX4K+PTNsb/Y5Gez8PRy
	6skVFIwwUUNGpTOobugmkEiZ2JEwvrjCJ4icIFadAyh+dPsQKjp0OaIVricS0g/A==
X-Received: by 2002:a05:6a00:3014:b0:822:1dbc:e75d with SMTP id d2e1a72fcca58-8244160a9d0mr14781080b3a.1.1770779255616;
        Tue, 10 Feb 2026 19:07:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ec5:3497:e96b:e7be])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e3af080sm423001b3a.15.2026.02.10.19.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:07:34 -0800 (PST)
Date: Wed, 11 Feb 2026 12:07:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, Richard Chang <richardycc@google.com>, 
	David Stevens <stevensd@google.com>
Subject: Re: [PATCH] zram: drop slot trylock and miss_free
Message-ID: <d2wp2s3jj4lm6shynryqwkvamyrpn3g5larn6z3yeyplel6by4@5ew3ii7v5sjz>
References: <20260210035045.3817297-1-senozhatsky@chromium.org>
 <aYtAz5vQTod7DXqV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtAz5vQTod7DXqV@casper.infradead.org>

On (26/02/10 14:29), Matthew Wilcox wrote:
> On Tue, Feb 10, 2026 at 12:50:37PM +0900, Sergey Senozhatsky wrote:
> > @@ -1943,15 +1927,9 @@ static ssize_t debug_stat_show(struct device *dev,
> >  {
> >  	int version = 1;
> >  	struct zram *zram = dev_to_zram(dev);
> > -	ssize_t ret;
> >  
> >  	guard(rwsem_read)(&zram->dev_lock);
> > -	ret = sysfs_emit(buf,
> > -			"version: %d\n0 %8llu\n",
> > -			version,
> > -			(u64)atomic64_read(&zram->stats.miss_free));
> > -
> > -	return ret;
> > +	return sysfs_emit(buf, "version: %d\n0 0\n", version);
> >  }
> 
> You don't need the dev_lock any more to just report the version.

True.  I'll think if I want to send out a v2 with just miss_free
removal.  The objective was to remove trylock (and all the things
around it), but trylock has to stay.  While we cannot have

	slot_lock(42)
	<IRQ>
	slot_lock(42)

any more, the slot-free-notify is still called under spin_lock, and
slot_lock() might_sleep().  So trylock has to stay around.

> And should the version be changed now that you've changed the format to
> not include miss_free?

The idea was to bump the version only when the format changes.  You
normally (well, technically "always", since e914d8f00391) would see
0 miss_free, and with the patch it's just a hard-coded 0.

Thanks for taking a look, Matthew.
