Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD02DE6E3
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259972; cv=pass; b=YxQxiSor928Bu0CiAsD63qcISsksOVKyAXEM6c1XsbVqyWT29UxwdlU69diN99HGO0RHVslMv/jp/jvbsvZ1Al/fXy8/wCh1/l7TL7OFM50N0VuNGZ916Gbfcu430tnWtDblAE1kzChb63YGkrq/bWagaYgOuHdgvWBx5L+sKdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259972; c=relaxed/simple;
	bh=nP1NvqOc/BLsjRSt4bs81fPcPn+FsTL/JnkWtwig9r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuULo8NaptubEMn4HElk8UKoAn/TrDp1Q5+wFBkuTE4bT81RscjWVpkJiKh0PmgIss/N15wRnbzrQXxtaGdvuNY6eqs99USKmRPq6j3wJdkvXoZjYww9ypg/a2EvsF2Pny7C45nXKqD/NKEnaWO+LXgYqnT4VCNxjBR2DGb7knw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsM2rACr; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsM2rACr"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1110413f8f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 13:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773259969; cv=none;
        d=google.com; s=arc-20240605;
        b=fSe4VPxFrDZRtymkfNu9oyIbTZtNgHsGcgAiqbhznMlG9gMtCcwWNJa1hQMuYVy/Ez
         D7Vx/hkSBSd0DJQz1danQXXTw02VFA9iAr6NWRHJgCK6pBxtfgfBCgAIREGI7l36KnAH
         //MSYtSNvvas9mxkvRbizUr26aJrb05H0Tu3Pe2VDXVcpQTYoR7pwjYs8SE8HmUeQr+F
         WPbJk/T1Nf9IK8Ad0xVHEHaoidO1Y+lYjzetHCJnL1w3pd8N/4Z+/wGK1QL2CCVnIqCu
         V8F1fo/faeGW1vSOyiIJ9aULPjfhZ1FHi3Desm9f7eeyZCpDihnaHs0wQ7ZoKjS+V0an
         AlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nP1NvqOc/BLsjRSt4bs81fPcPn+FsTL/JnkWtwig9r0=;
        fh=S6RmOgiBw4O3RNZ7DCfvjLgPpf0+fWTTqcV/pFTYrmk=;
        b=aup10aJyh4yiCxYeJLMeVs/TEe5PQNFmaWxvnWTjm3NNaHdKqNp5uEVRnKA3KsYPjL
         B1hwBbvH04Ebl4xlD3BZ7Wcva4Awv95zUNTrvyDQl6Hg8XOr4Q1c+jt9criGMsIFFYlX
         MTaaazsfKrDH3il0xWyXXBZWnrx3Ho8B7kiVSWkTTyrITAp7wy4PnqlVg6iLOJ3pLfF7
         8+groc+WHIz12wDiRDlI3pz7zYpoez73Qe3s+nfS7HoliooYiBjy/p3w5Hv74PVXq3L8
         zc4VYyh3cQx1B6uzlFhJAHY4VzRj+QIuYeoPeovaXDmN3UU24kACBrwNg+Xu/jxO6VNG
         Ur2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773259969; x=1773864769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP1NvqOc/BLsjRSt4bs81fPcPn+FsTL/JnkWtwig9r0=;
        b=dsM2rACrDy87R1D0KYxUjISq23LaI5z3OWgjiZ34JybvC/M/2slyB5YQk/BzjPC7ko
         Oyh1fK1bdzQPESSgjIux7cGV0ewPjiiC1L3W4mtB/o6DejgjEFzZXHWNvd0vPWyKmKi7
         OBa20yw/EdliqWsE9r/h7xeXYSuAFlneZNm6G7x3SoPnntx+Gzvq7V3dOqQsDGai3uku
         iuNqCA6XyE3fzRc4qw3QRD8YTaLIZp2twSRSntj9Psvni7gz8ox3pd+Mq/UJgqH9gSHK
         8rgn9bvFCOnblw79NvQCGFvu/jaYO0RGU5Fqu4tlA1YyCaZwSHPAV0sby4sa1ktoxgDV
         vmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773259969; x=1773864769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nP1NvqOc/BLsjRSt4bs81fPcPn+FsTL/JnkWtwig9r0=;
        b=fPnpbAchyEnLB5gUJABufDst8dY57tR6HeAk3GvAS8o7L9ozQmHyRJYdV0yf21Hgsi
         1JV0fl+JSpdAsBlofrRFjvMZbfHOxYRT0dYXya//T2uOoK3gTcW9b4yRkIjjdvYYP7ti
         g4tCYoUm4i8grAGcuNEzUNms4qtmuxyO4w9uwVBkVKJMeMkbvRyIDuzmUu0v4cj0kTrd
         utoA9RWZZThuVe3nBKMs7LtlKM6hwKgIE3F5JKh+t/aKsHi9MVUYXYCIWCcx3zX5bQDR
         eq4ywBZXiWoBcw8b1H1iizq76kROycv1JFfScN7/huvZziIjmKLV8J/xzc00VP4CJnDN
         ce8g==
X-Forwarded-Encrypted: i=1; AJvYcCXWkqElxOeC0JT9w/9s2nOIqHPflfqkUNqy0d2y71O8KCrTf9iQNlXprRqvSM86CHfDI2O2MwNO20Oy7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIWF8IEdHhVuPrz9uNIXF/Zkaq44RWdzPMXRIWyqAOF47MfTI
	q7EpkzIUDUcsj52EvxXn3zcmFwh+QJf7Zh04k09rFpCzDk6oi3pPKP+dwFPGD7X7Cpe1yWR+1un
	oWgGNPo9sKey4/KP0b3sY946a1GtelO4=
X-Gm-Gg: ATEYQzzu+9b/XpTWFWHTfqKC32Cnao9qkGi+71xXEUcUx6gM25hd5OIYo0un5/R19ed
	KSfnWVyRwcaDL+VSz42j4c+RmAYjqj9ccyrBX+RXBBKjUk7dWJ1PHIdUVm71tsVb2ntIUF81RFC
	JGa+w2qzKA36jbzHd2NxSLfJlNjWijq1xZKoFQG+rjWAkhdyIU3945mMS61B0NuvkqzSaRQ6rQo
	/aDB9NZmJFtHR5lQvtutJv1oSWq1B8i7AbYzYfPX0Q6/HkSj8hRka/fXzB7Tkgedp11IJfVDoA6
	ANPk7DDN4SOBvcAiTdGnKKLOUXLDh8W/G/06Eew=
X-Received: by 2002:a05:6000:200d:b0:436:3761:583b with SMTP id
 ffacd0b85a97d-439fe1ae114mr1772929f8f.27.1773259969202; Wed, 11 Mar 2026
 13:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com> <20260311195153.4013476-4-joshua.hahnjy@gmail.com>
In-Reply-To: <20260311195153.4013476-4-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 11 Mar 2026 13:12:37 -0700
X-Gm-Features: AaiRm50vmWrxfv-dA9KM1wtlJ0teEFH6Vv3NdFfrMyDjG2cjIu8lXoUvFKbqS94
Message-ID: <CAKEwX=MJwk0_zqtfkfgUcyBytedYNzSWP=tSA7JotApenSA4Dw@mail.gmail.com>
Subject: Re: [PATCH 03/11] mm/zsmalloc: Introduce conditional memcg awareness
 to zs_pool
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <hoangnhat.pham@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:51=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> Introduce 3 new fields to struct zs_pool to allow individual zpools to
> be "memcg-aware": memcg_aware, compressed_stat, and uncompressed_stat.
>
> memcg_aware is used in later patches to determine whether memory
> should be allocated to keep track of per-compresed object objgs.
> compressed_stat and uncompressed_stat are enum indices that point into
> memcg (node) stats that zsmalloc will account towards.
>
> In reality, these fields help distinguish between the two users of
> zsmalloc, zswap and zram. The enum indices compressed_stat and
> uncompressed_stat are parametrized to minimize zswap-specific hardcoding
> in zsmalloc.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Zswap side LGTM :) And for that:

Acked-by: Nhat Pham <nphamcs@gmail.com>
