Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611567;
	b=D7lTmHiruTQ+9tZ3OKeAgMBL4gcgY/cMCbaE8ugzaGMTKKdh1IGksvcwUyFGSqAdfnHt
	 ZSEZ7YUTUffXuITNlHYIpZ7iO3QjsgB/xsyoC0Jf72ecxDFIjHOTBOZcZxMdz7eqtaYhS
	 imCntFkaR/LO2vcivR2Nk6X1PfqkM/9MPPQVZSYWX07WF0ovgohCoTE9WSJU3YvvnOm8Q
	 Zp+Dwnhq7wNz8XTW0EB6w7WI0IpmLPhWRFIwX5YUcjNV/yC/aJjIk9QfDTq5gqyecCIqT
	 5+1wF27UBOT+H0ZYazXdTPl+syIc0ItXk79LhTLM/RMjtNf5EGGqi08p461e7+30LkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YRlB5OBhhM28Y+vl7fzMqT7+sIm0k71riKegwxA6RV4=;
	b=EqCsMnEU2tDRtBbWC01Qns2NdKWw2vJ96IoId6x+HY4/cdGWBnardby4wYahMcfbLIEU
	 umgVqPkCA9EJKWewqDD+k6ShtIQSP4tkdC150unMivOQdWKaeWUDtQEMeeOg30mne/ZrX
	 2ornGJex7ejUe2ZMliQYGKRjisJIhP/O965mbfL4P+buZgeOv65WQAMNO+m5aqEY4yJP5
	 xrLXRNGvIpS/yP45c/VODE6iTtSYNlBLDnMGwx7wWPI0dLNz8E23uyvybyEUvVB6K1QtI
	 dPxMaZxkLyrUpjziE7I9v4CTCiBltwrdCQ76kBEoaSs8p3or38XkBys1YV66LcAUGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlbA56of;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3160A2636
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XlbA56of
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8AA1F00A1C;
	Mon,  2 Nov 2026 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611567;
	bh=YRlB5OBhhM28Y+vl7fzMqT7+sIm0k71riKegwxA6RV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XlbA56of40o9cn0+8WHSnhf16RFkXkK4PDbHMGiAuco+9umApW3LxHkGSu3Yx4ie0
	 ShjeHtDGzP/wFNbvkVGASe3TYX+TWz7bW9tvVM1WrzIJJak56Iu/PjdSCj5bDxxHls
	 9a1cJTRbTy2D0emTA7IDtMbNuBvd290vFlYEScf3KXmG8SzYQvmExBXLalWOvvGCzm
	 kDBBULpnXkQtje7Yc6isqWyK3FfIO8gEVvbw/xqpPPuKpWowvP7PZzfkIXJ9YW9CO6
	 OuQXf48Y999hw4zIe2AWj2Xsz7LI6Q1ZVJfXV9DO2yQjZ0FjSv/TlyblQOCMUE+asB
	 bsBYxaQhua+xA==
Date: Mon, 2 Nov 2026 10:26:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/3] null_blk: zone resource management fixes
Message-ID: <auhXKz0wFbPu8Nkv@ryzen>
References: <20261022092158.2248831-5-cassel@kernel.org>
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
In-Reply-To: <20261022092158.2248831-5-cassel@kernel.org>

On Thu, Oct 22, 2026 at 11:21:59AM +0200, Niklas Cassel wrote:
> Patch 1 fixes writing, opening and finishing a closed zone when both the
> open and the active zone limits are reached: null_blk fails the request
> instead of closing an implicitly open zone, as ZBC-3 and NVMe ZNS
> require.
> 
> Patch 2 fixes zone_readonly and zone_offline, which can close an
> unrelated zone, or leak the closed zone count.
> 
> Patch 3 cleans up the code that sets zones read-only or offline, with
> no functional change.
> 
> Both issues were reproduced, and the fixes tested, in QEMU, with
> null_blk devices created through configfs (memory_backed=0 and 1,
> CONFIG_PROVE_LOCKING=y).
> 
> Developed with the help of an AI coding assistant.
> 
> Changes since v1:
> - Picked up Reviewed-by tags from Damien on patches 1 and 2.
> - New patch 3, a cleanup suggested by Damien.
> 
> Niklas Cassel (3):
>   null_blk: fix opening closed zones at the active zone limit
>   null_blk: don't finish zones to set them read-only or offline
>   null_blk: clean up setting zones read-only or offline
> 
>  drivers/block/null_blk/zoned.c | 63 +++++++++++++++++++++++++---------
>  1 file changed, 46 insertions(+), 17 deletions(-)
> 
> 
> base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984

Gentle ping on this series now when -rc1 is out.


Kind regards,
Niklas
