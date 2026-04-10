Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CB3A8FE6
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861062; cv=pass; b=fXkmgcl2DYuqBeq6pK6sC6QKOZHt/YbnHYtvdx3MS2g2rB7RrzinE4dU8Db0wql4KMW8b8XAwuHDbnqrOLBkE3iN+0CbtL7f5iCmA9zBZqrmR+MU21D+Oon2Fgyb17+i777QgS8O2GcNA4ieNpJ4L/yahKX+G31o2ZDbL6vz7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861062; c=relaxed/simple;
	bh=9uEB7s9yj+ASOrKrhec/cyiOr+yVA8dJm121d9b4Vww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t33Us1Qqgqs3vVUQoTybxNPiPzOZkuKpRxMxK3CIcKDU2iOpummNjh3vM2bI2Iyk1TXVLWZN/K1xIyjpTPZ91+M1UElb4I4HWQ8vZ5zqERfN7tMugEqQNK3jEBN2/SDNH/kLK++YzCsY8Dw1MB6MZo64Drr3Y0WC3X3SEK/9fMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saoyAh/V; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saoyAh/V"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c080efc1eso1523291c88.0
        for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 15:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775861061; cv=none;
        d=google.com; s=arc-20240605;
        b=SEutdKuvnlTHvtFjmiwBkYgoWHSkNkQbtME3MNyTJHQIiPQy1VVLmvcMdDQx4VDf5y
         bPOmJUp3FeCvCn2vsmGcVRlnuwGtCYeBGji96mhR9nNdi0TlRCNqIlZgnjwehsxUMmsI
         ijYUTbStZhTbi39NBS1g+eLm5MwVwNgmkb/NMp+1W4/1hz5VmoN7PhKGyyjRgZhgcgTB
         LFdKMzMsRSWnzaB6hlCPSa/PS3xOY/Q+bzWt1cHjQ248biV9azVtLIMafSXnVis8QfRi
         wNNO/lHXXH3zJtefAeFndVLSTA0aDVB4QV49TiHmRhYmMeULoaW3vS41SkOvR6RtJkrf
         F49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CXOtJJA5JwY7cQN/KaVyh/Nr5pbba4lT5eRSeELAKkQ=;
        fh=dseN09YBBrnSTrtXriTajUeIXdIkQ5K2lddskLE+oao=;
        b=AmK41A/SNuAYEijshjRoltRzMpCGnXBOsj1Y3rby24B+cDBB5+0j2OjUVnQKJXzWGT
         pke/k6lUzLPJE2I+5zMy802Ta3mUyOywuSK6faJ6RkGVUr+7NrTC/Wtx1CFC8rs+/7r6
         Fv/EcauxrGELsRvdcDcDKq9ke/Gc3H6WsLjCB0WJ8t+0Iz0pJu5y7lj6YUGMm4cbLu2U
         JNOTFLqNsaYAFrPlJ4IDsywo8X0DgejVZ4f6L68C+9fPzKyhcWtAU4GpH/ZD8cARKLhP
         xTYBe1TVLWU0gqIpWUjekwyP8IjClBYzxzkXpQ+rERijkJQGnaeF9nEKjylxRQMIX466
         YyWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775861061; x=1776465861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CXOtJJA5JwY7cQN/KaVyh/Nr5pbba4lT5eRSeELAKkQ=;
        b=saoyAh/VYWh1C29V6N8UUNH0esasDAlYvimQVLbisINPeCcln6xiwRrZDfFONcjrQL
         h5fljKhHpMNYIDiPZl3OcRRqoi8Af2MdEQw0UK8Lf1TONw/a7Bm92Xzpco777EB8OiY6
         a9Yg2HUe36mjHu4YigWLQiISWQgeJfZWxIUXJ86WQfy6alkkZyX0chM1ifoFTtwN5CpX
         T4ik69cUus0sUtWrPg23TpLSPY/1yrm9fuY+k3RXu+mtbUDwUNjgcmd6ujGzwNkSocF9
         jbgbYOxDkljFpHDKpywyapm4phkJpgiy0PCAFuEVAqAUbPcefB2z+LHZPOgQ/8Oz9Ke8
         VIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861061; x=1776465861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXOtJJA5JwY7cQN/KaVyh/Nr5pbba4lT5eRSeELAKkQ=;
        b=F6umvm5FruAyoP9mN0mxRcCc4OIr5Ueac7KuErK/3T8qEMekfHqwxvMDXBO7aIGlTD
         FqetKnbBwt65gmAYpMW9KD36LSLd0spfUc0gdNe72YjihE/c8l13IFWBLIe2CmsPfWX4
         Kxp5q+bOylSgD17FpIThVtW3q0mO1108UL7iAicsOtkZ5KXnuz7bIUoTnt1ZCyQXJY/R
         q2mEV5CwNh+k5GIPCnd0Uj/s+C6td4NQwlye4gS6uFtug7WNROGfPdlawr+nA8gLGkq5
         +BwzOxMWs00y0lIgqAp7Rd5jX5OoPD2gLmJJrlRGkermieGcEfssjPyH1QRrbWXInAH7
         gMJA==
X-Forwarded-Encrypted: i=1; AJvYcCVQpd12tACrHFcg9kjR1V4aeG4TYKkoFtROtzfs0rNT269xQVQG55vQRbmnAz2aqMsJiAmJv6YIIMsG5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9gV49BTvl+qiHvioi41zwKVjoGYQvnb53QtIUjHlbkrK9BaUh
	/SJeXa06BnBUBWeocMDZTTEeJb+PtLT9WnqtxAiqjl5EnDjhYd+nke5IG9iJuYTpwm6piE7t5oC
	H/sb7iPBVGjj2I3prmGakx2DfxeU2M+FGqcCGTUwY
X-Gm-Gg: AeBDiet/C5eYj51dPTzCgVpWGdq1RaG9QBe8PGkZPW63a/WHUp4rpKvOi7dKXqq56o6
	SIEmS7eFQLjvwhNJJmvmF/5AysOHhOb04YnZsSCLabdnlypOwI4e3isXfdoOmEaopulLJQ4Deyu
	bbeUtN8jNIoYs91JMWQ9cSXZkWcE09b4e35NMVF3uODRtUMhYlg/tXnKac91jYIPHMJjTVxhhIu
	skskMIjGzitHqq9XbMHdLxaRMsoeu3iN00KGcA5A0rQpi32hjMmTDEsKCV/Rge/RNQb9+D87Jwa
	tv7o1mU1n0A4KPaFvv0Wp64f2Ezu2f8Oltjf4b2LlLo3AYPyTYyu3+l3S4OE
X-Received: by 2002:a05:7022:1604:b0:128:cdb7:76e1 with SMTP id
 a92af1059eb24-12c352f11f1mr2360408c88.13.1775861060138; Fri, 10 Apr 2026
 15:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402183950.3626956-1-bvanassche@acm.org> <20260402183950.3626956-3-bvanassche@acm.org>
 <20260409064221.GA8378@lst.de> <CANpmjNMUv5n2VrWGPBOzGg7-r6gf3hH6ZoJYtRsrntY8+_=fQg@mail.gmail.com>
 <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org>
In-Reply-To: <2e09806a-d5fe-4581-8024-906be7dca4de@acm.org>
From: Marco Elver <elver@google.com>
Date: Sat, 11 Apr 2026 00:43:42 +0200
X-Gm-Features: AQROBzDf3MdaoA5QLKMrlRrV5w-yMkiYLdfp9Q57pjiomFGZDSyw05aaitIeRok
Message-ID: <CANpmjNPJPz7qruFw8S=4qoF32snPW-RYrd_BZK6skR_y86CUZg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops callback invocations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 19:17, Bart Van Assche <bvanassche@acm.org> wrote:
> On 4/9/26 6:27 AM, Marco Elver wrote:
> > On Thu, 9 Apr 2026 at 08:42, Christoph Hellwig <hch@lst.de> wrote:
> >> On Thu, Apr 02, 2026 at 11:39:34AM -0700, Bart Van Assche wrote:
> >>> The four callback functions in blk_holder_ops all release the
> >>> bd_holder_lock. Add __release() annotations where appropriate to prepare
> >>> for enabling thread-safety analysis. Explicit __release() annotations have
> >>> been added since Clang does not support adding a __releases() annotation
> >>> to a function pointer.
> >>
> >> I have to say I still hate this with passion.  If we can't propagate
> >> the lock context over function pointers it isn't ready for prime time
> >> unfortunately, as much as I'm looking forward to it.
> >
> > Let's see if we can land this: https://github.com/llvm/llvm-project/pull/191187
> >
> > I think we'll be bumping min Clang version to 23 for context analysis,
> > so hopefully it'll be included in Clang 23 and should solve the
> > function pointer false positives.
>
> That LLVM patch does not seem sufficient to address Christoph's concern.
> If I apply that LLVM patch on my local LLVM tree, and if I apply the
> following patch to the Linux kernel source tree:
[...]
> ./include/linux/blkdev.h:1763:15: error: use of undeclared identifier 'bdev'
>   1763 |                 __releases(&bdev->bd_holder_lock);
>        |                             ^~~~

I just pushed a fix:  https://github.com/llvm/llvm-project/pull/191187

Can you retry? Thanks!
