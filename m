Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805634;
	b=n8vBIAMVZYKmzSw4+B267zSW15fIrCqgPtjr8ggfoRaXl6tCcz3E+dAqjH4+u5lajK7a
	 JJjmBY7S9g33GxNsuPhnKjZfpwWoj/2OFCAoO2QYBKga2++G0MrFfYAl019j40Fyx6Iq4
	 wo92mWKYy1Yym8+JVJTsdIvxwqv8tlxhZnJ1sluhLqgq2WlAdYvplnAAvboh8y1Kzlfod
	 RXPahypbzXFe7Ow7L0WKI/JNvk/oSrz2XR8mRVR/Cs8fI5rx2uOjtQBhuFGl3j2rTBOgp
	 3q4Nl6CHg/b7AGIteEgnS8rUI29rh7BG7+cqHLzc4m/Hs2uMlRZrAiaXldBEy+ZvjyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bsy9XaBxFwJHELGQ0D4AViTHM/99Y7dZx09auKzIQcs=;
	b=k51KAdQoQp9X0I5nn3i8CSsOr57uR5B3g36ym5C2Xt/0Ol/zRa3b9A9pCkTtNQvgbpCE
	 JXJU5jOn55+t4U2ZETBQgD+jPXleU+nJFRTMzrkgw19x1OfWo3s2Yqx4Fe0M45MuQlIst
	 0VO3Tx1Bh1ns8TwID08b50IdiZymyHHJMg96ggHgdyPxa5vJN52Iy1u1/5NJIArnX3916
	 pNPGjQ2TW2x6PciCpozHZyme0DwxX/Nkn0t9wv+jp0f5vzuqOlrouQxG5Vn9Gr4tsarte
	 TeT8X4rrxjQWCGnkyuDPqu4YK7ncp7fbQCBhLibk/63fVN86CPr9l8vBRs9eIHxtj6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcJ2KeEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAC606A31E;
	Fri, 27 Nov 2026 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcJ2KeEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8501F0089B;
	Fri, 27 Nov 2026 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805634;
	bh=bsy9XaBxFwJHELGQ0D4AViTHM/99Y7dZx09auKzIQcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcJ2KeEY+WsprTbktROaNUEbsR9BdSkjKAKXmTnzIO8rFMTkh3iYEkaV3wSOVhdPv
	 gC5OX/hlyxEefTZSgjK2joNPH5JIFis886pxWGQNJdJAy3UUAR7RWnlhE2GEARioTR
	 Y9yfC04rXcZ8BKaCcC153AoJkdlYgwjCGt24JR/hLRJdyzTVYQxr+1ZxjYQiOuERC8
	 r5gzT1hqN2ZHAIuilHNnzEnJFYjbVref7HFe5cZ6csne5mQtNXzXAseZjZ7Ywgfvso
	 kgUOHjy2QEUKspiPnucDdGlpl/0/5ztOs2NdmIdjWme9ZdAuJYwAlp5QF8DAQ1w5Z3
	 8DCeNrM2sKKTw==
From: SJ Park <sj@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add mm and block lists to zram entry
Date: Fri, 27 Nov 2026 10:53:46 -0800
Message-ID: <20261127185347.87793-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127031658.2049871-1-senozhatsky@chromium.org>
References: 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Nov 2026 12:16:38 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Route zram patches via linux-mm and linux-block lists,
> rather than through the generic linux-kernel.
> 
> While at it, fix a DRVIER typo.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: SJ Park <sj@kernel.org>

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68811a0b7916..3f10a5772b31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -31316,10 +31316,11 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
>  F:	Documentation/driver-api/media/drivers/zoran.rst
>  F:	drivers/media/pci/zoran/
>  
> -ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
> +ZRAM COMPRESSED RAM BLOCK DEVICE DRIVER

Thinking loud.  I was wondering what is changed here.  I found it is fixing the
typo: s/drvier/driver/.  Maybe good to note on the commit message, but I don't
really mind.


Thanks,
SJ

[...]
