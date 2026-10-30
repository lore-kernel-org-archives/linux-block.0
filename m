Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333638;
	b=MKvRh/f0jNk9nT/TftN/dloiZ8SfjctwiffONbrSFNRVojVXiPKvbwBNd9IsarjfH3zU
	 oo/55Rff9H39bIPprXw6rcvxsRxosZs+MsfVMfPmXhcMzyQWXlRkY92Gh2HTHT1/ju2yA
	 /+mq2pj+hqygyVYqJjNrigMNs0I23FPrAy1n0V/oDPw66O0WOwzr2Aw2nSv+JW9dncxgb
	 He6+IW/heq/Ig963vQXo7LRT0hq5w3muEUW3n3OBk76bgwALEK2Lm4vRRmQg7MeadAeJq
	 3pitK7jgn0enkZ9YxeC4RFZ1BOQ4GhVWXT9MnAvVcFZJLta1nKWgJ1c+NnGfZETe+4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cui/fkfgWpCfLIzu0sMbQtqdSWprMFO0xjMUt+zFXCg=;
	b=hoM7zjkK6+kiGiZbfl3HjrJHKnKgsPDYUFG29c+ptCbhyWvjpJP6K9FccNTLSLu+Tl4t
	 sSHeiq1myxeh3pmE9dDQbRepI9q/1tnc/W6yprW20+r8nFYpzkNJ3NzLm0z8ZwT+rMUS6
	 V+9eDNNv7TIG28C0f66jjulJswpYHf36OncZQvbsOAqV/twTSMtI3tKGvr5r8VjR0KGVW
	 T8NIPmotoneAQj8WNO/8p0EHVuGmkDWJwOFFauloKm1pIspLcRvZ+y4biqk8znknzUvsp
	 u/9pcu38u0IE97OkqQfAuQUF/ARiqi+Lvzqz7NR+3SaNXeauXgMa+UtXLcV3fmF/AdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Wz0HzG9L;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12957606A31D
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 04:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12957606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Wz0HzG9L
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35829219da8so1701663eec.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 21:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793333637; x=1793938437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cui/fkfgWpCfLIzu0sMbQtqdSWprMFO0xjMUt+zFXCg=;
        b=Wz0HzG9Ly9LIjZaB3SCPFuZ206HoWn737xJUnImVrGdvogShozN4wr8BbyZQisWRQS
         LqQqMM3VHPYz6UgTh8QkSgXm27oZ1sA1vCqR+m9zDy/exrtYijqNGGy2y6wYXfGAxQO9
         mXYohP7FCQF6SFNZJMuJfhkaY8TEwtVMdDPmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333637; x=1793938437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cui/fkfgWpCfLIzu0sMbQtqdSWprMFO0xjMUt+zFXCg=;
        b=FRjC1i5W7GDHxn6ipo51lMKHrAGYqzPsPbbTV8ccuZ6LIx/wHnEFDYLiVQi7oNYFDa
         Q8rs63Wt7wpAzNEZxC5+yJCvtARKPQ9CPUtY4Jc7T5MInlBiR/daLck1ZGvL2zcFJ/KK
         AilW8Z4BuIpZW3FB5a47I3fstzcqsFwO+oCbPyM9IqOKQ8MPAJPpLQzkskJFfB711DFv
         v0z4iABlY8+oA3irRWNEh7du0jJ8wELFcgI7aVXycixWjfqniDNA6jhgTdP1zwvfvgW/
         Ov7EIk6Y5waiQ3jrfhpS8wNQqJAVH2bhSVLj73v7VlkcUd0pFV2Y+kRyer/uG50V8j0d
         kSwA==
X-Forwarded-Encrypted: i=1; AKwUvBx8/Xn+kxsPNnM4ghc2aOIp2m6p2Foi/P2s8o6+bO434Uot1DBPrgYdA0E28ce/9NCd4yr5eC6kuoyZKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8JEdlIMEROFGdtHhOwSh2G2Tv7SlgjT9hLImAjil+agb35TX4
	0eV/pPt7Be/flv2YGdsI+c5s25ZePgTjKUmh2uEFzPv4xv8sn7ewlZUkfPMi3ocsww==
X-Gm-Gg: AYBFou3dLMyofh7+zZROjFQeuvJvcv1qEuTeOwDX3MILQuuy2qQLIPL2wDfB5gs6qlo
	XfTSkC/ScR2N3DOrXCt3tt4bSTRjAdnONNHCrBTlMnFljnefythc25TSNTnmpgEI/4/rF7cQrS9
	NG/ckixD7N1vNqjCjqGRdKHsdQdttvrOtFqzg6tKbzFkNCEr/4Lmq0uNC+vX5inoI/kIjmusdfz
	octIwCgSur6kizzSA1IC22OlFOKZs77qcF0yAm86pWKEuw8suRC9ta8S0KqaATfhp7SMC4Jbn4C
	ZAlc7GP6PQZtHBDW2WY6OGqqRy3JoZfjTvVFRSW9JC3scmUQkIzvpsCu7wkUI3npbR+SBdIr615
	h8aVq+tmA5sBMMx0OLIAs1ubcRpNI6+awFz5zNNVc15Ko4tNEaPdenk3vdf83uYjQFfrwKjaPjs
	tkHjZwn9zPB81rtIN+d4sZvC5itbau6QQBQOkuaUv45Uod5V+NupwDec/6z+C4tvr8lmT8vTAmD
	lgXS0pfGBidTJ3srpTUjH19FBuhHNTYtLVjoL04wiimf1BENIpjPx+0BHyXLnbDMOWLMvTxgosE
	FDhQ0jyxuQvKnN4+eTLiu3Mdy6/irXAB9cMZkP4M72zh3xXmoX9vau6TZaoLSjuId4lo2Q==
X-Received: by 2002:a05:7022:eb50:10b0:183:942e:8493 with SMTP id a92af1059eb24-1ac5a67f97bmr1611157c88.11.1793333636971;
        Thu, 29 Oct 2026 21:13:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7476:5b7a:d979:2d91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm3485807c88.0.2026.10.29.21.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:13:56 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:13:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brian Geffon <bgeffon@google.com>, Barry Song <baohua@kernel.org>, Bo Zhang <zhangbo0325@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 00/15] zram: redesign zcomp and rework backends
Message-ID: <auQUjtWYOuhf_M8T@google.com>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
 <20261029200205.ee2a4788b8fdba4a75c2edd9@linux-foundation.org>
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
In-Reply-To: <20261029200205.ee2a4788b8fdba4a75c2edd9@linux-foundation.org>

On (26/10/29 20:02), Andrew Morton wrote:
> On Sun, 25 Oct 2026 11:18:16 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > The series has a number of memory usage optimisations and fixes
> > that result in savings from double digits KB to triple digits
> > KB per-context/per-CPU, depending on backend and its configuration.
> > More details are in the corresponding commit messages.
> 
> Thanks, I'll queue this.
> 
> >  drivers/block/zram/backend_842.c     |   6 +-
> >  drivers/block/zram/backend_deflate.c |  98 +++++----
> >  drivers/block/zram/backend_lz4.c     |  85 ++------
> >  drivers/block/zram/backend_lz4hc.c   | 105 ++++------
> >  drivers/block/zram/backend_lzo.c     |   6 +-
> >  drivers/block/zram/backend_lzorle.c  |   6 +-
> >  drivers/block/zram/backend_zstd.c    | 133 +++++++-----
> >  drivers/block/zram/zcomp.c           | 298 +++++++++++++++++++++++----
> >  drivers/block/zram/zcomp.h           |  53 ++++-
> >  drivers/block/zram/zram_drv.c        |  71 ++++---
> >  10 files changed, 546 insertions(+), 315 deletions(-)
> 
> I've always put zram material into mm.git's mm-unstable/mm-stable branch. 
> Because "ram", I guess.
>
> But it's a blockdev, so I'll henceforth carry it in mm.git's
> mm-nonmm-unstable/mm-nonmm-stable branches.

Thank you very much, sir.
