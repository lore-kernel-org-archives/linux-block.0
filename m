Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834784;
	b=u7GXMiv0kydEb9FBG92XN5PbTkBMFhbVkv/yz4is0j8xfnicnH/IxZgYb2f7I62vwkeC
	 NR5M0WPv/QBM7kwIdfkeXqi5slMR8sHt/YWmQKt5mozSzXKUs7MhG/AtqnKxt4L86y8tW
	 8LmS2KULnR0JSqaNfQrzwj00kE2SAY6hxNKvMD89jJCpZn5s5JwG/j93+vFHbuofmHXCq
	 WOwJ9aW9w2G3ylDOJOXeB1HPPATJK+nQAVRw+SMg7OmCi8hzEFMrULfqxEQM+fzAlDsd1
	 43NULkgJifMzLPODZo9CklZV8xo8AofyiDa85G2V1awYQrUEgfA49DVA9e3Blc5AouQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=B3XjVPGi1d0sqXZUZmpjBaglDj36IEF4UV/CSJOQiR8=;
	b=BNhQCefLnTrY1m0AJ4mwD9OIHDHP5Fts49aO2hPvvQYhJWfoGP3PE0BrUiUmPibBM1Ru
	 GGm7QBn28QpIiDzkZBEV8M2INeImd4fm3OMqvmENrDa2mDcbUe1OlkDdh7l21dH/PHtNL
	 x4dbu+XwCvO53Fj1d7hUuWPuiSRnfqFrMcgmoEbq9+YxkhzK8iUXz4yRCvRCaHhksRRW3
	 nWdbwKq/20JF46fLWeHWq4SYUcBPW6TiHvPyBgkSpPh8Bufr04Drup7EGys1zmxQGFKeB
	 hpijeZ6tlMTx8Bm3avrS+WwNpOrC0RxCL8aPWIVcY6mEObjqvAgmnC90xeNnFKI3MGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Cr+VyVUk;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA91606A31C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA91606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Cr+VyVUk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f0464dd6b6so53243965ad.1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 18:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795834783; x=1796439583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3XjVPGi1d0sqXZUZmpjBaglDj36IEF4UV/CSJOQiR8=;
        b=Cr+VyVUkagr1zC+gj5lZErmLf5XArrUd08mF03ewcdXumJg3FG/J3dkMjgpAfjlg8/
         3KE25aEOk5gv9uxUi4bpZo1KB+2kEVWAz+23FciQrixoY8x18qeFKoTdfJIzetF7C6kV
         Yi0nJtts5yHZq5hI0jwIukVwgNUGYfsnzcUjhylbfvXNFaI/j9T13XT4s+5qy8rEevUa
         2Ck8qHh153GiblCyCIbtT6QWX/ZB+qloRCDFDz+Btqn1Lq5kEwZI9UGB2xolxq8BDHZr
         2l0FBrf9UYweVAjxGgfRwljBo8WK/6+Vfu1y0IgzLdLkdJIcCfKsJrzUUq3IIwaAkUEG
         4iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834783; x=1796439583;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3XjVPGi1d0sqXZUZmpjBaglDj36IEF4UV/CSJOQiR8=;
        b=IGL1GVaHvgQ4Y2NXRDWsSx5laJjHwR9ONwSiP3dTdoUD1AzPWyO5xc0Za4L3uYWZUD
         3wysBEZgV6U8O6NAJkL5ihUsddy0csbyOLHlMHl8aZgrwq8XmBKEJ/xn/VMvNybrQIcE
         z7iFGCACBtpKQY5RNElChff3dzk4V3QDG25DEq0q+Ib8mjwmSVuYiNByb5OhFxDTw5FS
         vpnOkFWlvT74fSDzsrRR4UP3hoYr2UHivBq1IfqcJu5ndl9/TwXa3sSHRB1DzSVqFi6Y
         2gkfgeQ2oF0Lx5fKHYlzfyY1IsRncRU6C1aneRj8Wyf/Bk2UkF/k1pTq4Ar3zcEvjsrQ
         f8lA==
X-Forwarded-Encrypted: i=1; AL+hErFVnubyKqLEsCXY66qpRyOA8epEiX2IK3aeVCzCPTMmFwhp6e1008dLlGK2v4qUb/IJgMdBECabjOnETw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ebgWoOO1cJoJpfAFnfWPPi/tyC03F/9blaU4EH/6+/JROr4lN
	tnLQ+yx6sWHV4XJEBfdUhEUKwmPXmNaZG++POXbzynrMn26zvsfF69ymUTgo/Ht0o2IBNWJi80g
	iVmZ9G4Y=
X-Gm-Gg: AZFdTZfPlWRJ2Eyo3ZVVZsgV9/HuU2dzMZMKvI+Pg/5vXGDHZyAMqWitjsxAD/sSjjp
	qIST+KKbBz8I5c86NTWwJIlkQg4qBFwUaVRlAPKYSw/2HGEY+k0DOV33VQP0HtA9fX0Nc2bYOHE
	2l0+nOly4wmAnMT7vuEkRMLtG132sbdkgvShyy4cLwiPAJxdw9dIm0JVFpkjqGIuqe7J678XkJl
	IT0YMqiCyT3IOc4thL1dCKRwGBSuHqnF2+Sk8u3Rir0nP0udGcmU0rxXZD2PoLW5HPViXqgIt0h
	4sDdrMz/hHK4UTA9Yl6c3On52TpE+kFVnGlXJo4EWKHKIljh6hmIfjXNaOZJfpJPRnikM7lYi+M
	I4DhwnKLLoJHLl9Az2hy/9I6Ukp2tNOcxbMhpPk9xpVt7MAhpKhzC2N56VzK+rkHRL0wkQPXPsf
	Dwq8qBgxIqCoOmEW4GiCzlGO0kmk7GPmdO/yfIUm5HSXyMljgALudiUGMgPkKvkoPorJ7hB3EzH
	lc+ROFlN/cSZtXkRsdpeAHJCXUc0Ko0USuJIPmzWLL9TyjIzhJS1xVFjTtUWwk77eT7+Lyug9f8
	mPy8kEIlxMVTN/rHNbU7plTNMtqKCe9vLEYyId4gvaAK7c9PnMtBsNtaYI1+6FFy8bPW27h1/tM
	BcOuqBKUM1L3aGOvqciMVVU2hFAsvA9C/6aqJwEMbFKHuwtnBY/hS/+T4nodLSz73ueE2dQ==
X-Received: by 2002:a17:903:1c9:b0:2ef:fcd8:df75 with SMTP id d9443c01a7336-2f03f18847fmr296857175ad.36.1795834782691;
        Fri, 27 Nov 2026 18:59:42 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0d537a522sm57771515ad.47.2026.11.27.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:59:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
References: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 0/4] drbd: assorted fixes for discard limits, bitmap IO
 and resize
Message-Id: <179583478160.90611.15435460552982220308.b4-ty@b4>
Date: Fri, 27 Nov 2026 19:59:41 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 26 Nov 2026 15:52:53 +0100, Christoph Böhmwalder wrote:
> a few DRBD fixes for for-7.5/block:
> 
> - Assume a capable peer for the discard limit before the first handshake,
>   so devices stacked on top of DRBD don't latch the 4 MiB limit.
> - Fix a lost bitmap-work wakeup on weakly ordered CPUs (seen on aarch64)
>   that froze application IO until the connection timed out.
> - Two resize fixes: don't silently truncate the device after rejecting a
>   too small peer, and refuse implicit shrinks on resize unless an explicit
>   size is given.
> 
> [...]

Applied, thanks!

[1/4] drbd: assume a capable peer for the discard limit before the handshake
      commit: 69fdea8a039d6078609e0aaa7efafed4b34c7251
[2/4] drbd: fix lost bitmap-work wakeup on weakly ordered CPUs
      commit: f2d3c2a06548aed8def25c16e772ace4774a3896
[3/4] drbd: resize: do not silently "truncate" the effective size
      commit: cc547179b6fdb93dac3cb8813b57460cdecef9e2
[4/4] drbd: refuse to shrink on resize unless an explicit size is requested
      commit: 86226accf58873f70163e34820423ced87a8d980

Best regards,
-- 
Jens Axboe



