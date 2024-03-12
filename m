Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD91143757
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282146; cv=none; b=hKURlJJWnBE/wroK4ceE7bOS68WKeUwvbuGNN7F/eSdJjKzqxJQmkbrEp1nqIKytqPUWoTuoHBNZPW0dHYhhpzU9sMsiy3Lv3zkZm/khqSQnOVm6SOf4dhtsU1+Yxn1xAJdIKz+/a8nJAZ/J227doY91sFT+2LdXXDT9H7OOwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282146; c=relaxed/simple;
	bh=GD9Y0Y/aRYEfzegiQHX6Lie6FIxnb9EUQBca2O5UDbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBWKk4CjW2osqNqwFIWmBoZzcv0VUQKNxi2ByxikWvM7AGte1O0Xv+8TxWbiM0gmEvbVUNbfdUqAR97YnyH+FG/t+mh6iilKyNuKikvOxkklMKxGZ3k/sv1siT9n+mpwOjaMR5YrCjN67NrqafCY5MFiDEDeCcZw67LH9corrzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4e9cdb604so2177266a34.2
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 15:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282143; x=1710886943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F5QBp75Nt5yt9KIOFYH3KbyyaonOmB5y1YzHGy0sLQ=;
        b=vNa6X7/pWyBhGsSHm6KmMY2g46lI3pSuaoo2TUm+zNXDXEur/aL8/0nOuRCFMOqRGh
         wGkC1JtvLDyvgXCWK9j/5FoyInGLbstQ927Mc+xb4LPclbP+TMDsoXcxMpNsaaRLSFDV
         tnei4pdw/7QAU/fl2CQCZa12JGWAnOb9yCfpn/wu6MOW7c1mMNVJFCwb03oZ3iyaZog2
         nCamD1aTSA2kVnCOg3Fp/E8hiwzh+DpcO0r7hIpLTE1K9lpvLaksth9Iy4oVq/Pbbzb3
         lSGcX5Bg9s6EtsG/sqL0PbrjS8WiyNS4xTjXU+IdMTouu23K9rvtvI+B90M/bs24t/e1
         9OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLLuJMcWFeWoBuyQuMXZYzR9Gte2MFssSWtEismtOzPXHq3AH95vVLSswpgoEnpdGg7voGYL4EQM+qUBI8l1HCqSPNICJy9WSLEyU=
X-Gm-Message-State: AOJu0Yy0NWva6H1UT2UnajVq4WAmK1QJw0Oa3fhpir+1fPDLhiqUUBHI
	soX4cRowGwj9vCY5lmIKW5XxCaD4V0nJS8Pxp+kgrkZojo79xItBFy8WQlBn4w==
X-Google-Smtp-Source: AGHT+IEiDgu2AH/cTRJGdQj4gxh9fPNhTa2QQybcdt4CdtQEhHbSYD7abjxi2wnfNwybhvE+CTNOoQ==
X-Received: by 2002:a05:6830:1498:b0:6e5:2fe1:dec0 with SMTP id s24-20020a056830149800b006e52fe1dec0mr6564105otq.23.1710282143028;
        Tue, 12 Mar 2024 15:22:23 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id l2-20020ae9f002000000b0078860cacdefsm3735134qkg.77.2024.03.12.15.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:22:22 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:22:21 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	dm-devel@lists.linux.dev
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <ZfDVnVuDYwzDVnDx@redhat.com>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
 <Ze-rRvKpux44ueao@infradead.org>
 <ZfBzTWM7NBbGymsY@redhat.com>
 <ZfDEtchBNeFLG-GV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfDEtchBNeFLG-GV@infradead.org>

On Tue, Mar 12 2024 at  5:10P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Mar 12, 2024 at 11:22:53AM -0400, Mike Snitzer wrote:
> > blk_validate_limits() is currently very pedantic. I discussed with Jens
> > briefly and we're thinking it might make sense for blk_validate_limits()
> > to be more forgiving by _not_ imposing hard -EINVAL failure.  That in
> > the interim, during this transition to more curated and atomic limits, a
> > WARN_ON_ONCE() splat should serve as enough notice to developers (be it
> > lower level nvme or higher-level virtual devices like DM).
> 
> I guess.  And it more closely matches the status quo.  That being said
> I want to move to hard rejection eventually to catch all the issues.
> 
> > BUT for this specific max_segment_size case, the constraints of dm-crypt
> > are actually more conservative due to crypto requirements.
> 
> Honestly, to me the dm-crypt requirement actually doesn't make much
> sense: max_segment_size is for hardware drivers that have requirements
> for SGLs or equivalent hardware interfaces.  If dm-crypt never wants to
> see more than a single page per bio_vec it should just always iterate
> them using bio_for_each_segment.
> 
> > Yet nvme's
> > more general "don't care, but will care if non-nvme driver does" for
> > this particular max_segment_size limit is being imposed when validating
> > the combined limits that dm-crypt will impose at the top-level.
> 
> The real problem is that we combine the limits while we shouldn't.
> Every since we've supported immutable biovecs and do the splitting
> down in blk-mq there is no point to even inherit such limits in the
> upper drivers.

immutable biovecs, late splitting and blk-mq aren't a factor.

dm-crypt has to contend with the crypto subsystem and HW crypto
engines that have their own constraints.
