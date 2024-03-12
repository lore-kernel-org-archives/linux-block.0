Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267C14293
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283855; cv=none; b=F9HrGUvyZgXVEq8BBGlQRwOTBhkarK1CXivRG6tphtr8iPobSRD+CxTV6SZWoVMDbvVAAykIXwlFXDYhu2d9u3zG+w5zmILWqcvXFX+tbkC8KQoz+PouoxUm+LtFsEn4WDdPbN51juYyWL7W2K20TA4C1CXTDGe/IhMHeF1WKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283855; c=relaxed/simple;
	bh=PclF/O7qYfyEhrocuRXf1lPkupqWeJw3/nVH9ngyx+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkJ5Xta0vHfYykLyhY/ZuGjCy7w1OJOsiRP9RBuwBKzc6Qw+eroq+akmJ8tuq/EKFF93SoKE1uib1ZJMEPQvNxbI0WZmh1koSxKtnIvk15/6fF2j3GWqPw4uFAmTj1QhinHRRHkX2HLNKnxzLxguQMDU+m/MyFDCxy8NWpPlz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690db6edb2bso12107266d6.2
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 15:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710283853; x=1710888653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlxA4zN3+sPNzBs+kJr4+RA0UafItZ85NKafakxbxd0=;
        b=WgPkEALrCXtOUc6d4VBULg9zhHKntY4Ag1i6f/rLQX4PXurd+GvgGcXnG4Y3zsvcyY
         N+T/Bunp07ohbYgPNWdblVqIc0rEphbVynf51qIcXcNMCh2raGv3s/deDHGOPky3+xW6
         eMmzgUSW62A2jCwTnC8+kYcSRWubAHE6BaiqFpUK5hRadVNiblQjTv9OK6sVue7iY4kp
         u3xXOg4kwBX4cWTzwVcPfS+ggb+Cu1HAx7Z21A0i99l4vpDIhcJOFXfU786szEwZU0iq
         RmMBob9x9/wYP56s8I7EOTxyRCvLm6HE+1tDaTN3uPno0MnGC4iuQm2RGAU0IAITSK4d
         fAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz9oOfzsLx0asaz4GxHt/9585e2rFng60XLLRfIihe5+BYAR7fiiczkwABFjPOSe9sYyUpTmJQtQTny5BRpUbLhjRY8/CfaIcAk0k=
X-Gm-Message-State: AOJu0YzHLdwoqPXMNJwwBOqjZdvg0RNU2sdUYytRekqD35qNZI4pjaJr
	QewbxDnVLI4Bu/iEScCs3NMMrqw2Rw0gzZoIHkj0e1J4oRgw0OF0jdcFBJeBzA==
X-Google-Smtp-Source: AGHT+IFz7w4TCcQF6u/QupyyFnA/rCjGWz5BrtrrQZTJ0gJN/jUF5dV2aDeDiPowvgueTOaPJ0/eQA==
X-Received: by 2002:a05:6214:1764:b0:690:a77d:b6d4 with SMTP id et4-20020a056214176400b00690a77db6d4mr11454505qvb.56.1710283852813;
        Tue, 12 Mar 2024 15:50:52 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id v12-20020a0ce1cc000000b0068f8a21a065sm4073634qvl.13.2024.03.12.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:50:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:50:51 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	dm-devel@lists.linux.dev
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <ZfDcS4q5l2sn2h5Q@redhat.com>
References: <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
 <Ze-rRvKpux44ueao@infradead.org>
 <ZfBzTWM7NBbGymsY@redhat.com>
 <ZfDEtchBNeFLG-GV@infradead.org>
 <ZfDVnVuDYwzDVnDx@redhat.com>
 <ZfDXiK2knK7Tx8Iw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfDXiK2knK7Tx8Iw@infradead.org>

On Tue, Mar 12 2024 at  6:30P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Mar 12, 2024 at 06:22:21PM -0400, Mike Snitzer wrote:
> > > The real problem is that we combine the limits while we shouldn't.
> > > Every since we've supported immutable biovecs and do the splitting
> > > down in blk-mq there is no point to even inherit such limits in the
> > > upper drivers.
> > 
> > immutable biovecs, late splitting and blk-mq aren't a factor.
> > 
> > dm-crypt has to contend with the crypto subsystem and HW crypto
> > engines that have their own constraints.
> 
> Yes, they are.  The limit for underlying device does not matter for
> an upper devіce as it will split later.  And that's not just my
> opinion, you also clearly stated that in the commit adding the
> limits (586b286b110e94e).  We should have stopped inheriting all
> these limits only relevant for splitting when we switched to
> immutable bvecs.  I don't know why we didn't, but a big part of
> that might be that we never made clear which limits these are.

Wow, using my 8+ year old commit message against me ;)

I've honestly paged most of this out but I'll revisit, likely with
Mikulas, to pin this down better and then see what possible.
