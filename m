Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80B1CF92;
	Sun,  1 Sep 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725220605; cv=none; b=NGNCbGbbHXqAhFmebOpjCo+yTDlE6RtuaTDCsyqJIlmPBBpCod3tdZ/oU3hAiYC5Uka+llhPYX++n+Fv8urFbz02ZlJyeea/gbQlrmN8JHFT4Y19ebtak/5WrPCuiPq1nGImjs9XcLK666R8CIZJThBVMg12mJJZTAHtJA7hrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725220605; c=relaxed/simple;
	bh=opwScwAzJ4SuYz7lXpODvSBUniB0vjMLmCBqGmtDU1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4TDD88gpGXSHvUsTSMVpjPuHm56UjcrqUMdylpu1oOtk5Vf0y6nc94f7WCsJT3SvsAb3yG3PhkClNNkfc+XWjuxLJe5bRrAam1EtAW8UFsVf3XNgaQaWf/6QjcDisgHMzOJQ43e3PjpJdi975xexC5QDDetuhl6Y5/Cw8Qs32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLZtiOtT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLZtiOtT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so19608315e9.0;
        Sun, 01 Sep 2024 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725220602; x=1725825402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBvhvcZpJuppNvV5eqoolAx3Z1GIRJtw881QgGEbaFc=;
        b=XLZtiOtTjDF9G7sctp1QLu62AW6k6aomMjPI0Bt6WovOnB/aUe2DMVU/hmObcEiykd
         E0mKbMjxUg7BAA/R6ZHSgaoFm/sb6bLzf78t/YqI5F5gaIax5bv+J8PAJvvlnVNdXlcL
         ouw2ZwFYN2p/gFGWj5ukJx4YAj6pEuUknwbZkghJnDgmB6u7/Md72ZwzsqAmiaIGnAzk
         v7WKhSsn8GVCfNWRyADdOsWorNhD+3dHJg1aBC13OE/4JdA0M55HwldBHazEDYM4gKQT
         imjbkqMwKFm6pxy2Q+jWSYIudIknNQTGVPlwOXYzFprD1ruh+Hn0PhgMlwQ64qCxT1cw
         K2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725220602; x=1725825402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBvhvcZpJuppNvV5eqoolAx3Z1GIRJtw881QgGEbaFc=;
        b=J0gzQJRW/x2IAMzYa4VEG3Nt4CnXSfRjJT2fYkk5Ljl5jPgZEbUBKOWBeS9cunWf1m
         BamqD4ODuerpKX+8V/J6fJP54rAoqCaTEJISpH+OBVB59M0wOpwusgz1QqbfdunJwVzB
         IvZncgiZKcpZB6OfgwUzJbi4lO5ZG+mvSQ43mdjEMLJcsU2jNCdudZY/6y8tMiMFBEHG
         0aTK/gtWmbCwC4Zi5MQSSUmHuqQvbwoFe2Keml1o2dfjAfAq8GCfhJB1v5RpvAnzGXit
         EUQc6hYZ5l9iwfYmjsymL7RAOyhnO6iavC+og85V6Ks7KuqPBpg+18P94PlyuAh+Kf8M
         NlbA==
X-Forwarded-Encrypted: i=1; AJvYcCUl7t8+nYN/lXJIJmjA/AJY82MT3U7bNFon/jFDp+onek65fegKabe7DVYFrNSADxbqyASshZ898h88ew==@vger.kernel.org, AJvYcCWh+dKXsJb4twEi+olITgUouU5wI+VPg+3c8fYCgQTJ1KFrOo0zaP1+Oou9yfFz6fUq9sbrnEQMceHhcFUxlw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Tqv9cy+BnDdz7k2mGqN9lAtAyYpsZEF5KMsKQSH5m+zQdReE
	GD0S1Z7b24iNmtFKMSIQmsgZ3fOb+x/b+qXanNQuCBQ8eAlhZCo=
X-Google-Smtp-Source: AGHT+IEJt1pkn1XOJEc7YetNVV+lHgO6WI5kl1l/CPsAAkz6YqicaqM2cjer+XMf1/MPVW4QiFucQg==
X-Received: by 2002:a05:600c:354b:b0:42b:afa7:804e with SMTP id 5b1f17b1804b1-42bb01ae418mr89079705e9.3.1725220601628;
        Sun, 01 Sep 2024 12:56:41 -0700 (PDT)
Received: from p183 ([46.53.249.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273e3sm114163855e9.30.2024.09.01.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 12:56:41 -0700 (PDT)
Date: Sun, 1 Sep 2024 22:56:39 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size()
 function
Message-ID: <4386823d-d611-44ef-9017-88ddd5e7ba57@p183>
References: <005b6680-da19-495a-bc99-9ec3f66a5e74@p183>
 <309bd39a-0c58-472a-9fc8-6fa33d14925a@proton.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <309bd39a-0c58-472a-9fc8-6fa33d14925a@proton.me>

On Sat, Aug 31, 2024 at 08:39:45PM +0000, Benno Lossin wrote:
> On 31.08.24 22:15, Alexey Dobriyan wrote:
> > Using range and contains() method is just fancy shmancy way of writing
> 
> This language doesn't fit into a commit message. Please give a technical
> reason to change this.

Oh come on!

> > two comparisons. Using range doesn't prevent any bugs here because
> > typing "=" in range can be forgotten just as easily as in "<=" operator.
> 
> I don't think that using traditional comparisons is an improvement.

They are an improvement, or rather contains() on integers is of dubious
value.

First, coding style mandates that there are no whitespace on both sides
of "..". This merges all characters into one Perl-like line noise.

Second, when writing C I've a habit of writing comparisons like numeric
line in school which goes from left to right:

	512 ... size .. PAGE_SIZE   ------> infinity

See?
Now it is easy to insert comparisons:

	512 <= size <= PAGE_SIZE

Of course in C the middle variable must be duplicated but so what?

How hard is to parse this?

	512 <= size && size <= PAGE_SIZE


And thirdly, to a C/C++ dev, passing u32 by reference instead of by
value to a function which obviously doesn't mutate it screams WHAT???

> When
> using `contains`, both of the bounds are visible with one look.

Yes, they are within 4 characters of each other 2 of which are
whitespace.

This is what this patch is all about: contains() for integers?
I can understand contains() instead of strstr() but for integers?

> When
> using two comparisons, you have to first parse that they compare the
> same variable and then look at the bounds.

Yes but now you have to parse () and .. and &.

> > Also delete few comments of "increment i by 1" variety.
> 
> As Miguel already said, these are part of the documentation. Do not
> remove them.

Kernel has its fair share of 1:1 kernel-doc comments which contain
exactly zero useful information because everything is in function
signature already.

This is the original function:

	/* blk_validate_limits() validates bsize, so drivers don't usually need to */
	static inline int blk_validate_block_size(unsigned long bsize)
	{
	        if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
	                return -EINVAL;
	        return 0;
	}

I have to say this is useful comment because it refers to another more
complex function and hints that it should be used instead. It doesn't
reiterate what the function does internally.

Something was lost in translation.
