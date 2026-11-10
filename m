Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794333725;
	b=LYqrx29uqW06TqyhXQOHjK/LbeSVb4ubEmdMXAJ64iJPowv4s5E2YqExBL9dpQs/QFeW
	 UiFEL+fUPE/FlxlCOGC7CwjF7eTm+Co1CdIIF4IdlYcMhn9lIGI1cduHWNp18F7QWoauz
	 EAMibMxT/hQEZFgWWSGJKcVdAMCytGlcnk2zk15qamaQnAj6E1qHkGa6x1PbdMqe9WNLk
	 7SGUTCqz7wVS2v520Yv1tR5zPxj24rO/k9K9h0PpGUpQYmXA82yhm2hs+OKCsCPBxNT/4
	 KHbGrXR0dUWHgcsIJwSVVOFCae+bh5YTcvJvNbeBUnChm8caHRfbR5efyzcN/fb8TPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ov9SjO/T2yWWs9oVvwaD92SGckXKvt5IjQ1wTzEwgxg=;
	b=exwoBV9gAiR/ZhbP8vVXZ5yCyyIPMrkmXN7audJAN9zA38QQCf17AFk9SNyfqImGYaZd
	 7o1HIDc8eHOUSDRyZ3oXZpXKljm2qH/t7MDl12hbbqy7M+PIJhv4D7WN+q6/edKraMTXz
	 Ora6AL7JgV2+sDJbgf/EhzHXQBZ3YsyPg8EZlVo+jZWrSJkFDgDD7Zt5G2O/DR3TO+/ry
	 cIQmTGKhkSUAmU8kovo3N9SEmPJxx3WOK+0zWIVPnRsjW8WDi5o884qTE8A6KdQJseRwl
	 sLBXwUVDpVP3A0+mQzU0dQULFCIKgHeRNxAIEiB4f0Gm1S4FbSGuiQfA68MkKbpBGbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yIiFmA9D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84FD60A2605
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 18:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84FD60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yIiFmA9D
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ae0a5c1715so8828391fa.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 10:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794333723; cv=none;
        d=google.com; s=arc-20260327;
        b=tCUwHoa0wx73pupCHmC6ZnwMO78tX+Ap8jWHEo30ChxJS7ernx2nthLI1mcEv+d4Tm
         YUOFaKhCDe9LyQB2vjn3PwuVfdOGG8meilKleJZx17C7DxEFiPyAjcYiPoV88CPoZx2a
         mw8z3LWBkoz3Bwi8toJBoxzt+yZ4EjL3ZcATP1GLZ9/cqG6Fx8bizx5sKCnxbBlojZNV
         co8mxc3xovKi/KL7tl+vmPx2nAFUSy2w/da3v4liiGeO2jM9+jK8TPBlIocWgvcIRqxd
         7g2fuVC1mYvyLpGu7fdHxuGROmrbo9jxA0kUjmgzo8H6onhAa1TxaYHO2uIo5tA+MGRN
         iPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ov9SjO/T2yWWs9oVvwaD92SGckXKvt5IjQ1wTzEwgxg=;
        fh=GoewIR5Qx1JiItYHzW4DmbvcoJgPEcSp2lddTgJfCvI=;
        b=AUJwETPk3p1zRTI5JqJ1RB22OLT79gxkz8qUM/2CjZJmxTub1qrwbVp5YRc8kUPL3x
         DffCR2/DlhQtO9Vixd31ukawKiNlu1r4rRdwqD/b4huMHzpPRk3jo8xj6oBq1fnRBk6J
         6ulyZ1pDIGmxI20RGGA+a3dPIMl/JFVF5/pDpsRw4EJG5ovq/Ztjx+yoQMSMdK3FnS9o
         PbKJTIXlQl49fnXJlop4pcoRtGkKDo50rHkeGEW3J9kYflS1bh/1wbywA9GZQQPHQggZ
         +0AhNcPeHzQ7yWeBG8x6CAzyqVuEFBcrll1xQx5uh3KZUgP1ZyV3srtVVaE4p6aSwn1v
         v8dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333723; x=1794938523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ov9SjO/T2yWWs9oVvwaD92SGckXKvt5IjQ1wTzEwgxg=;
        b=yIiFmA9D3z5Per9cwYWiRgX1E1XQQ8dO7gpzu/mNl29tY14A5I+dmBbGEEmnOeTg+z
         x6agUp3nK/NqxDG1HzM5BvW1umy4G3APXr9bF2XDOcqV8MUaHK2WiT4Dhz0fGpAVc7Dc
         jaQAAxVho7pFeM4eAApu5a89U/JRtzBFc0Ddt/ILc812asKgCL8qCt6z0zPHSLSJ7x00
         qthMBKEm6Gj4k1raWvg+TOfQjdlO3Ll3WyaRLJxYOtvyu+3X3tHDsyKN2QXsSPA5mFk9
         SBl9nmSwlAjnnZCbS6Mn5+WKx2zH9mswTF1/sr93YEUxysyy+jWAtBC69syVNjtvMmvQ
         qvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333723; x=1794938523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ov9SjO/T2yWWs9oVvwaD92SGckXKvt5IjQ1wTzEwgxg=;
        b=TYNV3DfefASJcrc+Yxc+iUCVmSIRfsZ0BUZKV7v8Vgjb+pYcZeeqciBdSu2DfSsn3N
         nygxqawBNlWLEfiWC406m5loKnR9etSDyLjjJDiIlu3/Y/y7fkk0gXcKKcSkRgLzv5Uc
         twh5EQmdgtQgaXtlRHS69bP1xZwd8tnQiBnpvgrzzPwg7Q7sQBIQqR9nJE5BIqBBUiys
         h5WBWV8dOuP7kfLA3WmSyIzWFOxzrH7txALZHQDvymoPG2H6ZjQFlUHxsdfm+yMrWH0f
         EOaHYn1iGywr6U5j8tvjbU1UOVYMMj4DJNKkyfFtgu6sNTjVoJbS2SlrEDm7t0YHHEVV
         xFog==
X-Forwarded-Encrypted: i=1; AL+hErGCtbBRj/O0cruRrf+B9ErlgEmrgCrl+h9pehqxhpzbBEhq59kEqZCWj5wqYzxTvjizJF6iclmp0KmP4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9sGgEuQ8OqTNl7Ne+iATz8SZD+cCKQfiiwOKi2VhV5Qj0SN9Hy
	w3MuwCUi8RoBiRAilUd/FEp+JshxNOSRehJq1pzBNtH0LcIIW4cZixxsiBIeGLGi3+9OkdeFha5
	tQ1phtt3NgVsn14nH/gH+ibcgLIiRiJQ=
X-Gm-Gg: AYBFou27kEckb6cb/wBUHBOP+r/zGPnaJQAF/O6Hj7RsagGFS9EOMQ1wiEkFfoGBPZT
	iBL4OpMRdefc2UUyZOtLk29cVKtDVqL+1UwV7uNoiiIOsJBWZ3CHFQ+cB0w0DHstRUpdiIUcmbK
	eW89VbgoaJQNkiGGTwM8SlTPIqDE7/HkV2iemwC1VAS2LE93oOPyilyvdkJNvx1FYgg1CaieYLc
	PWnbohonvlXnlxE9eaFACpRSyQccVgUZxH82s6Wy6HyQFWWaAz8I8B13Ud1MEfTGxuevsMh/1B2
	NCXpdpACt7In0LkkhF7PbJqP3ojF6cpLCJGA8RmLgVaxOHeA9YH5OU7bbt1gbUceoNbSbPU+qGB
	7/kopePJvog1wHxqFPDobGJmhYfgWpIqIGOwIjlsuzhogUwqZrEENxQuRVmixfzzq/K2p5m4thE
	gPsIFLfwYJYLMPhIAPcBDPdwzdxg1kkKtYLWRohHi4v7MTMsqZjxMpPg==
X-Received: by 2002:a2e:b8c9:0:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3ae10a3465bmr680781fa.24.1794333722682; Tue, 10 Nov 2026
 10:02:02 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-11-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-11-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 11:01:50 -0700
X-Gm-Features: AclHuK9ip-psjuIqgfh78sIFIsL_WvHPuXVercH_1RHZcH6UZnfeuVyaxOhmKcM
Message-ID: <CAKEwX=PJObB4gDPtsOWGjW6FJD4dtoz0qDu9KpK9jzP0=N=d_w@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] zsmalloc: fold zs_obj_write() into zs_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zram and zswap always call zs_obj_write() right after zs_malloc(), and
> zs_obj_write() has to take pool->lock and look up object location
> again, which zs_malloc() just did.
>
> Replace zs_malloc() and zs_obj_write() with one single zs_store()
> call.
>
> zs_store() takes zspage read lock under class->lock, before it drops
> class->lock to copy the data, while zs_obj_write() used to take it
> under pool->lock.  Compaction and page migration already take zspage
> lock under class->lock, so this follows the existing pool->lock ->
> class->lock -> zspage->lock order.  We don't need pool->lock there,
> zs_store() doesn't look up the object via the handle, it already has
> the zspage from the allocation.

Oh nice, this looks like it'd save a pool lock acquisition?

That (effectively global) lock can be quite contend-y under memory
fragmentation, etc...

>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
