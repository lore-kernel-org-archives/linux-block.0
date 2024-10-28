Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE441DF728
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141475; cv=none; b=WsXw8YzuNasRNMMa4/jXImtAzp0dMBB7PXLYcVcesEWelE2sTuUTn29TD5ZQTjREO/nzxRmNrjHgcgDaajoZ9gsBbUnm61ZKtnCfXaQLOucZmys6XlajNiXZMZXEmo4EAWci/c/wp0c+/X2tPVrYRxGJIUZksZCnhgmhzP+ZmFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141475; c=relaxed/simple;
	bh=f9kepVkx7ozexatwzky/15PVvfGex2hIQ3aQJm8Uw0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sM6GBVMMyxLTTSGLNz30nDAlzrWNDh+6G9K6UilFH3hlbw1dliQ7H3CmEmVVULNuIY2z0j6acYWlTaBLZGn4xFNflup8i+V3yEpI52S4TUPrtloTfnurt3ksAoHIckcSppZ5DBcJh+nezNkBR7yZ3skICFCPwFADDXxKZvb9R6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBJjWUwb; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBJjWUwb"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso6059811a12.3
        for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730141471; x=1730746271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIxdURF54ugS0I9GsxO6vUsWqiwPODNyGYtyXOv/jbs=;
        b=YBJjWUwbwWpqCNsu9L/uBac0yt3w6jcbucqVOaFqnypeU8a22MBD4CEFWVvjsxed81
         YQ6HqlI/epm8B53BXZpwZPam633hvXX/EIci4rBebxQyrLg7I09wnZi31FPsaSoPtiam
         gUXOBWq2oj9PZz+J58wo4ofIWiFiR7hU1zVM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141471; x=1730746271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIxdURF54ugS0I9GsxO6vUsWqiwPODNyGYtyXOv/jbs=;
        b=k+wgpbMBKiVCCOyPXCVBtmsHQraphOSLlKlDbOOnpVn4dO88ANZgwt4b52zaO55fPg
         gdX7sP2qNMRAdZIBayCZmANf3H2Ji9jOjJ9R9XbXVIIPUmE3cSP0OoHVwxK8vcs2xtFf
         HHIClqaDmx+Shva7iG9nB5D/Y7A8G4XtXc/QfvfLQMjRqJHX9Vi2DKiRIITPo7SrXZTO
         LlK41oyq+HXkV8KButfu+QKWuV1ysKvME6GFMXRG28iGWmvoiH4f1WIoEzvNru0h7lOv
         H5d0mH13MJfVZXncnmABZm5D/gbj7XRxZV7qbEn9mjgYA45WHjpy0C9BEpUKtr0R2Ibv
         1OoA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Lqck3yajU5Wx81zSUWH12QXSugWcatYyqnIpPKFM7DnSMcY+YG7pLVR1xegAtoYxK4Ej5caqD4ZTpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTg5ICldAdWbd24dPkW4Dy/2U4+iyi4PIwPwCwy3IUgFo+Gbhp
	fzcmUsoN30J2mvAtSuXofVLHy21vm/jeDkHOIMIcaU7eJyolBpAEI4Rv8OwvpnTO6j0jUOKtxyD
	mSPQ=
X-Google-Smtp-Source: AGHT+IF4H54v08EvfEI+kt/9GRqF+/3zoKVu4UCsN/EFBweYtMlNTdMQLPI6IW0ImOVl+M/tMPmaBg==
X-Received: by 2002:a05:6402:3719:b0:5cb:6745:539c with SMTP id 4fb4d7f45d1cf-5cbbf8ba985mr6407325a12.20.1730141470800;
        Mon, 28 Oct 2024 11:51:10 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629d5besm3354113a12.33.2024.10.28.11.51.09
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:51:09 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso651253966b.1
        for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 11:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWU7JFp/GxnO0UkxbvmpWQYgHP7kr1pBU2Mfv0MGpa/5e2nE5FT3rbDlL95Eo0skODAFiBi5PfY7YkqCA==@vger.kernel.org
X-Received: by 2002:a17:907:7e9e:b0:a99:61f7:8413 with SMTP id
 a640c23a62f3a-a9de5ed3f62mr706790166b.23.1730141469413; Mon, 28 Oct 2024
 11:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com> <874j4w4o1f.ffs@tglx>
In-Reply-To: <874j4w4o1f.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 28 Oct 2024 08:50:52 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi4+sVr6MUsybh8v-fPYoruZK9AmtasqMYi7z09UKHf6Q@mail.gmail.com>
Message-ID: <CAHk-=wi4+sVr6MUsybh8v-fPYoruZK9AmtasqMYi7z09UKHf6Q@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Darrick J. Wong" <djwong@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Oct 2024 at 22:41, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> It has caught real problems and as long as we have highmem support, it
> should stay IMO to provide test coverage.

Yeah. I'd love to get rid of highmem support entirely, and that day
*will* come. Old 32-bit architectures that do stupid things can just
deal with old kernels, we need to leave that braindamage behind some
day.

But as long as we support it, we should at least also have the debug
support for it on sane hardware.

Of course, maybe we should just make PageHighMem() always return true
for CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP, but I suspect that would cause
more pain than is worth it.

But yeah, I do think we should seriously start thinking about just
getting rid of HIGHMEM.

               Linus
