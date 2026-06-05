Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8083242B0
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663240; cv=pass; b=OVf6GYDC2LjyyiLqcnLNcd5W7AFJmpR9t1LAtHSeV8yws4e5K/31+IL134l/3aui8FwV9+GLFbZ4CSzd4uTwpXaj+Lk6owv/wv21m1y0nZO78Vkd3mS0lGtiS6FaFaosFyihFj65a1Q+R1oVdegr8ec/Wf6gWUd5/jLV41EjKIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663240; c=relaxed/simple;
	bh=GIXcFcRgi3IwWQOVI/nK6qDCIPKWXANc/7q7PF48oRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1JP5/D/ApO4TyAAmIDpwrs41SHYaGXi9zMLG2GxfXxuoWU9/kA4tzY9bgqyNLW5EynqmBX0hRgS4FruuQUvj0ScPMJcSLdd/um91fgVr7Lqim2uVvP92znih9d/7XiaLBJZXf8uVyexVufNngWg1H90F8XT2RmvvOW/nDvGvCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgHChW2L; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgHChW2L"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30741f821cfso218714eec.1
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2026 05:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780663238; cv=none;
        d=google.com; s=arc-20240605;
        b=E5NdKv+tkmkd1bithOeg8E/YTUXWl17K6jTM8cht4hUejkc5xnMaiaSE4R+Hx3zKtL
         3IxUI78wP9S8ZD5uNSk5QTvCasVLskA7korItFJKGC0Jd5dNsZIYngagWwOR59P+nTAE
         KoyR+Jn9r1GJs8sqAFyNXtvNMwGs56raa8ueD0KCmrtHHWnBcFAQVzw080X9Ol2bLgrD
         VdeLIaAFVTMv0+ECtGpRXTxbdVjMYJ5asSCu3izIoFstZaz31Xf5CRLX77OhGl47jvMz
         axtQ83pTbWNu/8L50bKygmlZv7yClxsYto6Nn0076TZeYhvJNgQTJcaCIa76ZmL6c19g
         s/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vq/SBizJ0N1u9CvM8MVgScgVED4Ezs0M0slZq5actaI=;
        fh=CLnm1BfgRP8+XPUvVx2uWutAL6LxkO5f/ZbdcFty6rA=;
        b=D7tTGZztSF6BeEFNJd2FCmG/NQkMUjNzN2sQGbY1xT/5vXITZR9AqCzcvskA0+PX//
         WxAbkHDLWjP3FVZ4wZFrZe9DEgRU7RDXUxAU4lxm98f4k/yT0rzuS4ffo3g8whBB0W0l
         70TuzaY7hOVl0TyaBzCsyxDFnY1+fa76+Xj2GgZ8yeL9g7U1gSVKdvm2/YbJ77it+x1w
         RAnlDBtuKH5G5mVgCBXTJL9UhCjpNuR9P1codv0Lr0YtEnrcnWHeeSbhE4Ey1UwuUP1O
         wPFw7qc2CBL6yHt9gWTI4/9OddQgw3PYO6ayefw+wX01oMvNjXQUuxFZ2uREQvfHGY9E
         kezQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780663238; x=1781268038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq/SBizJ0N1u9CvM8MVgScgVED4Ezs0M0slZq5actaI=;
        b=HgHChW2Lz5k+KZ6qvbicVzH3oMjz901ZwEx1pPW7/Mk15J59b7MD2HBsyEy4YHj8Xt
         fbDTBvrkVSbD9gqMItSEZ7tzeegMRL0SD/RwkA696qbtryml/cFcBIhHvdAHw2xiIuj8
         m+gIx1X1HHVdT5p3K4YnD93AwIdukp8FyEUqhY4hs3vRo519AQblYSM1c9tADOFeGLzF
         cp4tvQcztaQZxqD5sOwITrwkPUtcLR4t/3dfIgjytAuYpoJ0wCX8baCsMFM9bRe12dSy
         CUxkq82gO2CHf0EpZiZUX14GBcWbhNEBgumACSWNugkGnLeXiZ3M/Q9EWEmjUhTFhmZX
         YqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780663238; x=1781268038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vq/SBizJ0N1u9CvM8MVgScgVED4Ezs0M0slZq5actaI=;
        b=FEZppH08VbD3drqLKynvMTmWi9oNYtF18/OUK/pponFq2rjJt2hfGRjySZwBsvqFiT
         M8SFWDHnDk8S6tRknXqt1MAIi+bAv0nVYO/4M8xm6WpfpnWCS9T6O6KL7OyA+TUCOaFa
         DbAj85G2sN9VjRX9bU2eDaqeDwYvuDjQIcRUieoHCJVwRGLTS86U6jmbXl6zpzQRft0C
         QLfxNEHagIJL3omyDBYRNkdKaFqNJjT/QmcWNwUUPb4bYYsCnaVO4ImK0cgprTNWU8Ic
         Ndqz6ghWKP7ubuJLSaFllOfAVqB01lFyul5xkUOq1jxntXtkZcv+14QW3lRzTB0Syh23
         FOXw==
X-Forwarded-Encrypted: i=1; AFNElJ9hfeQnFbO8QFlUAtxM64tqiaW56RoB4wIiDWm5k08+zcy96PQ0XfPRR+kJ+nPzSfkK4KiZPSD+t+D+fA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzurDI+wKZ8Dj6oXrJkv2o5YLdGNeYix6s7BjGwmsheUkV3a/S2
	OLZjFDS8I2G0rEfTzUzxBDscZBWw0mS7SMTtTbwBgMdeoCZYYzsYTewcPjVzB1v4ABjorL0ND7w
	a1D1my95xx/HnbEbrRDovBknV9t+Qb5I=
X-Gm-Gg: Acq92OGRcczWygzzmk/1dazG2pv3kBtXMHPrUBzTEzMlLTaQsm6omTmNqCWGRp9+6Tp
	JO/+rvVq7pK8JClzl5W6LPEr/Dp1E14AQaNg4ywGM5hjPLrGOegCmHI2RJ0KhCoi4E2P76hbaKR
	W3C+dgD6APP0wic20CJJs6WmtkHcLm9yinSbF3BJXjmkb5j+fpWbara6/vy8LSC7VNzWBUu29m8
	wY8XU9TGa9EPIgpgXfy8S4Un3yzt8TmcNRkwPqQt+4tMuBIcEDZTiWmCYh9GKDmHBAvZ/LwXpYF
	6PPKBjAPEoz6wXSO/J4AEU7Tq8HjW1uz8opRYrcgmDjtHvKM6kmDSYAtQADeX0hljyWKlWwhurw
	b1eIGiL3w4GokiePsATVKQXMLxzpHPoybEQ==
X-Received: by 2002:a05:7301:6781:b0:2d4:62f0:b2e1 with SMTP id
 5a478bee46e88-3077ad33bfbmr804716eec.0.1780663238163; Fri, 05 Jun 2026
 05:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <20260604210704.41751-1-ojeda@kernel.org> <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
 <CANiq72nGo=F5D7b7Hx8A1jfAJw_72Np+UpRWBRQoPLAE+RAPpA@mail.gmail.com> <4ffdbe16-61ab-47e8-b696-e2fcf9a26385@sirena.org.uk>
In-Reply-To: <4ffdbe16-61ab-47e8-b696-e2fcf9a26385@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 14:40:24 +0200
X-Gm-Features: AVVi8CdSI-2V9LiHbf7DlAJ-2V_Zlp7bblv2hdXO_zi9OaBhf5BufpYbUqI7V0I
Message-ID: <CANiq72nKDpzd9BTPfQ-NhWgcTgWdE=spED_n-idv1Jnekdo=Fw@mail.gmail.com>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to disk->open_mutex
To: Mark Brown <broonie@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Miguel Ojeda <ojeda@kernel.org>, 
	akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org, 
	dlemoal@kernel.org, hch@lst.de, hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tom.leiming@gmail.com, wqu@suse.com, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 2:04=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Oh, bah - something turned off RUST in allmodconfig again so we lost
> coverage in -next, sorry about that.  I'll need to work something out to
> make sure I notice that happening and can do something about it.  It's
> kind of worrying that this keeps happening TBH, otherwise rust conflicts
> are likely to result in broken builds.  The dependencies feel really
> fraigle here.
>
> Had the rust builds been enabled for allmodconfig as I had expected the
> tree would have been kept out of -next as a result of this.

No worries at all, and thanks a lot for testing it, as usual. I am
happy to be there as a backup to catch extra things.

I Cc'd you since I was wondering if your new `LLVM=3D1` build should
have caught it (I thought the GCC one wouldn't, since my understanding
is that we lost that last week due to the KASAN+RUST patch).

And, yeah, it is fragile... It is quite a complicated set of Kconfig
relationships, so years ago I also ended up in the same situation and
early on decided to add an explicit grep for `CONFIG_RUST=3Dy` and
certain other bits that I wanted to ensure are in place after the
config phase.

Especially the toolchain side, i.e. the fact that `CONFIG_RUST` gets
automatically disabled if the Rust toolchain is not found, is
particularly subtle. We are considering finally changing that to fail
the build:

  https://lore.kernel.org/rust-for-linux/20260521-evolve-to-crab-v2-1-c18e0=
e98fc54@chaosmail.tech/

For you and those building with Rust enabled it would be great to
notice when it gets disabled by mistake, but I am not sure if most
maintainers (i.e. those without a Rust toolchain but using
`all*config` routinely) will appreciate it (or rather, tolerate it...
:).

It may be too soon -- I considered announcing it in linux-next and
adding the patch early next cycle to see what happens, but I will
probably take the safer route and ask in LPC first, unless you think
it is a good idea. Any feedback/suggestions appreciated!

Cheers,
Miguel
