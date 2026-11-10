Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332553;
	b=BmlR1pavkcXvhC6lQas2PT4ymhASZ52JADQCAISJFFBlwrk495SDifWPU/0uAbPs0nD9
	 tdLeouTrXU8Qvrqsoj3QSmnI0W+Cq6GuksACJSkJJqoPVwjrt3Tbe667bZ8ixsxfFJ7e7
	 /nzEHWL39KXNTvBCAV9Ol+i/OIE0qP52TtMNojOV71o7kVRXAdTDhlXVKquUHRe1FBPmo
	 6R04wouzvhBiv8qllsooA6KwAIIzeInMgfzI/H0JMxs0iP7dRhYwpWZZRs7MN+zJqb23D
	 KtWk5rWZpPi/wuFZsIaiRRaJ1v3XKiMJutVUDs1qrGDuaVTN2zHmchSvaTRlYDT4pYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Km/1n1LHhDr02ASZV9qn8VhaPAsioBtH6JYVLmDFnWQ=;
	b=uphjEDEh0LhD+qD2hz2w1lavrl0o4FAhmBVGG+pEQLY4B/IHyvESeClmHxYkLXpcE6Na
	 ylPwGjnHl7hURb3aMPl/H0fZxBJ4o77SDLv35mWvVP0ARGsAy8ekHJhs2bQ4o7EF+Svtp
	 B1tHD7xUyVfBuCqIS6fECzA38Ym28r8aASygVXDPbZXNXwlK1+MsXUE1JRT1q72ytLV7I
	 50XKpbeG/3iN8x+4Dnr/3eZ5IYGCKK7P2FK5BMwDREXqNkq0tMpaG6ed+lP7AcYWCg2TW
	 9CJRieKFrVHfm5GoQQXv+zE53gcU5JSPVkq9X8/DAklKBd4/A5E7TE/KlSWAm57GWCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0q2clSQd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68760A262C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 17:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D68760A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0q2clSQd
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3adef977ad9so17180911fa.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 09:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794332551; cv=none;
        d=google.com; s=arc-20260327;
        b=hUtB9Yz6Q6Gli7GzcYJ6mvdDa6CbOTnpUIVdrIJcqbGxp0ijp0EfEpTzVPkOU1Hgs7
         lHcJC4spdQjvQ2+Kzl7+EhF361bEXeAR3mk3d6jX/8EmPmzGReN13W5IifwlonA33xc1
         lgzvh8dK4PnhA+T5EWaLUb6xV1VROaG7Mnl2z3UD6QozwlrQXtgeHv9xuevCazpvbjdK
         n8iVUt459i+znwj1bn3gtq07yF08vBs6PTtZEmGDBJw/dGL8G/i4qVNqDpgnEpslfjaW
         fSxB+55GWaYCYphdhYPfK576uBP4S2Csy2+QwcC03okZ5qYXgNDyXDCQA59zfGaAWJPs
         BqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Km/1n1LHhDr02ASZV9qn8VhaPAsioBtH6JYVLmDFnWQ=;
        fh=dF3P2eJUnpDM3lRsCuKpXLrNlk8pUnIwNTErYGxFVpY=;
        b=jtzcNIFgVst8gwXZfqSqO9RHtiz41PFTB1mi+ed6v7jj4FCqSjS5Y2ofrUS/i9lbem
         QUJNUU+pk3amnWgDY07unI1S1KK2IqpKtDLxwsnuuPKM2o5F6ot1vIGgsbulfJ6oQNiQ
         OZlcqJbCDapDZ8N/b4veIBil+vpantPKhiKGb6RNsrXtDvrIGh5GARMtXdB0ZME7UKB5
         8dJ4nNXVZ7/UOI5LzsD0J5odnk8p/IiY6W4oeCFar1zhfKE9HQRefPelplCH0WG6Nbsd
         b1PI3EDkusUHgScbxk/5sqAsoCrlTqNXqmQhzDwMgJ+7NqJ0cM3N5vdBX41vCo34FAEP
         Le7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332551; x=1794937351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Km/1n1LHhDr02ASZV9qn8VhaPAsioBtH6JYVLmDFnWQ=;
        b=0q2clSQdX8ZXdvOcyhWvyl/+Un60UOtu/PtASKo56ajfRYY8xmcCJvg6WNROL4CaLs
         dDO/+lMfgpxXYDzA8GBzWbYK79Oyj8Vb7QKai84sHrGnSHLQieMceEt0W6ca7Mkp1tWn
         zv0/wfqNjy9P5E4VKZKw2tkTXjH8NqnF0WTxIggVR3aq6+O6Y+GGpsgoDxf+cd8Pa636
         aV5mFJ0Vxrwy8wAq4mk3bnmnAsRmOeVUl4HHkpmBHstOLd3jTqEp/3OiyYdKT+IdCIV2
         US0/j9nih6jcmku34qzV0BQFVcLnjqr4AE7g1FX5A94s+i8tkEaexwmQDiK20U8VFdyq
         Kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332551; x=1794937351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Km/1n1LHhDr02ASZV9qn8VhaPAsioBtH6JYVLmDFnWQ=;
        b=kV+sVyXQ/qogB2SjIcmub/U9SQUNK7k8unp8zvgvt9Dpat5EU3dacvuxCK4xwdmqrf
         +DELPPED/oJ9zgOUWzgBjsgTfa9pJ7OTZhaYSjOg4s1j0Oy4xpODvLQCUsjS7vm4A0Cm
         TLVVUelKluBHzVI7xqDZVkWwgrIFCKMS88YYDoadfOxg6SldhmXOWmXI5G6/4gqnCqIX
         CvqQWgJhypQPOnuDIy6y4xYiMap1ePKp6o37ReAmWjG0Ej8JCFKJR9yRHd8ixS9g8RbA
         bqdL/4vKUm/ZXJd1dpkjGxAthdVAz6uK2WXH/N+UhE8DNu+OEQQcMNwvzHycRo+C466X
         M8xw==
X-Forwarded-Encrypted: i=1; AL+hErFbAWkPSQ+vzASWq06iWHBS5MimNEJdugh2CnfS8pyNUPzGXJMVBfPy0En0y2uNb/rkRRvvBB8IuMavjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9pvNrk84R43paqsRcQbPG5USS/7GkT29uZyBOiYpMrYMZRg7ZY
	q45X3f4LPjlw5BRhy31WW31fEgIkLvyyzh3v68szvLqShqsd93/lTLq7v1WlcsTPcGwBsig57kD
	+dpuqIBy2sItdODH5fZz2DktJSPb/k0E=
X-Gm-Gg: AYBFou37n9YuMcSpnJGE3PCuyd3uNJ1rduzLGSDcj8FOCS53510RtFG9ka6+LC6n7aj
	ZHyC3YH1zXrhjow4Ob/6ohrJ+bAqmwSJmOrXBH64a1+BqXM8GS91/H1wTJaFIAvKuEUxrsAFzE7
	349juE0M802ry8QftUXDd+RJWvG9MCkH5FPYtQ2p9hrHYeW38y3DkAeOhgRrNtkeWg1z5pTT+H2
	e9S8DK77TI6mos9iKulQ/e/gMCilSxkGzj7B3A9qgtKUzZ2pVNGsfZ8uVM2H0KjHe95h8vLxk4T
	uW0QDxCu0z2AnrDjWJ7ZoG/B0c37xxIIOFlAzODO8txGPTlr8v+xTHs/6HI81i/3/gpKVluqvWf
	0BNsmgV8zQcZOyPSxlK0gI4bOLDYZhSOVkmI6lWhRDdbiyxt7yfjZSzpPMfE5fp0Fxbkc73wSDc
	OUjeXR1T2BTSupM78DtwFWUBsnMCI7+8/IGLzeMvcOmglCRlO5/cXA
X-Received: by 2002:a2e:a5c8:0:b0:3ac:e4b6:b93d with SMTP id
 38308e7fff4ca-3ae0960e26amr7913321fa.8.1794332551177; Tue, 10 Nov 2026
 09:42:31 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-8-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-8-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 10:42:18 -0700
X-Gm-Features: AclHuK_zSUkyB2sjWErWCiaaONj2fSjizGjk85ueR6Sb_actx7ETkPPr0xK7p08
Message-ID: <CAKEwX=OtCcMak2gshXXDpiXiVK7v0H+gXQpQ-4D4BNvWSbvWHQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] zswap: do not free the entry if its pool is NULL
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zswap_entry_free() warns if the entry has no pool (which should never
> happen), skips zs_free() and then frees the entry.  A subsequent patch
> embeds zsmalloc handle into zswap_entry, so zsmalloc object will point
> to the entry, and we cannot free the entry while the object is still
> there.
>
> Bail out early and leak the entry, its cgroup charge and stats instead.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>
