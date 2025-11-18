Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530D285041
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450689; cv=none; b=oPKRTAvSzsygedsS/V+R+li7MVaQlgpVE8aUAB3lhwNdILFyR6aoUr7cE/RxeWdu0BN4xWD7ueWnbfmZEw1Okh33MIaHbW2BHdR12edF5fWy30n0hJgikIiRhIyQ9iXVmt6glPg4N4Vg/4ldfu5imltqbKLNXV9aPU/UWcW4i2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450689; c=relaxed/simple;
	bh=so5n5cr9aElIonXCbQhZ4BKrvhg/pXX154iuVxvsx9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n58spjR5NPEogf2ssgcFbv3IS5e3ZZluhVq7CM8N4T3IiVLYsA0PXod2ymyru3nLrQHPcGg5SksJQA2yFvQfgZjPPYm0THLcg+gFO+ly6iATXCMAk07vEPWSbEj1dIPrbNlyj+PO3p/hlmNiHZ1LAX+4bAouflqoLocJh4utRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgAcAJ/X; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgAcAJ/X"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3438231df5fso6155675a91.2
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763450687; x=1764055487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lihc2OJI4/BmSBI1PeX/M2RvoYXLNnpsu4dGzRfakuc=;
        b=YgAcAJ/X6X+tTEh+Hn/lxWnEl+wPH9uQoru7wlrUaxXpaJ5oKfpkHy3/zPf6e177tf
         y6J43teAQItS2xDReyOoHMinDLdqCpPpZ3VK9O1KngadTlf8vyVyQFNaPZ+GftE51/jD
         i2Jp6NEmlAxYaaT0cnvfYIjUOneyqHj78J4yvnh0Yu5sDNtxMx4vz4pQJNGmMAyG7JpV
         5zNduoVov9egdtRzEqnkDjTRyFmduTqmrRuR5E4xEz9fSVcCpq5P6x5V8FVWOGnbOflF
         z6ErS4RKLZNAJDjjfcwHl8qSBkzx1bmMSSh3MJHVQL1u7vPG9PBDhZ8xnxqEFLgZWPvY
         3Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450687; x=1764055487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lihc2OJI4/BmSBI1PeX/M2RvoYXLNnpsu4dGzRfakuc=;
        b=p6tlqdfl2WeXwobdhwXjnNILtela4q305Jq6uFK+U1zUbGD+0MmidmxF+MYgf2Nfda
         5L1Ip+U8JI+j5gli2wBWw8jaM5m2emfnSHQKQTHII87TdvvYRAFbHs81nj97salBUQlK
         4f3ZOG5mcj57WZwHGNiC/zH5+FFnPlelVpHgC3BQYAbyRS08xl7sXMFaOEXpodxPOvsA
         KhwUokIlb8AjXo2NqUaZ0uNY+/r81493ewLNTrVwsm5xD7VHR+nNCdLlhUMeUlE83sQN
         hqzOAbLAIGoo1AFepxOYyyLwPHdZ1/aqnj9y39UeealUTmbLuf1AJWCCBBBYFy4SBRJy
         LY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfboLSGy925+ACs+/SkoVgzPJLemQmjKNlL6SQNNWDH9VlC6c2RiJQjF6rg58JwdnQ4vnHGcMoMA8q7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQp6w3U8AOurCEM7zooCAIld3Il+anbr3H71PldYdrzBCd4s08
	yWNapMKOS0cAKtNoDlNlYBgyh5wK9SSGE1VgGnXyXg1XT57PoG3EEsbzvB5kyWyt5TwPL7yP77P
	/4ATqJKoQIAKjjCynI6ncQ0jM9ZbD6xI=
X-Gm-Gg: ASbGncsu3JZQ9zZsydhLvOngHcVE6/Uq9SuSVfzT6fGz91Aig9HKFxcYeaPLLVP91ga
	v+xh+5ShE0ctM7uJpnnC5DX+5qKXAJTeg6ho91WkFiPuk4Vp6XSJcxoF+8tV8A5XSpdpdRaVWO+
	iqZkwgYCsZ1Z/MZeo0J7MJAxu/lF11highvKsuNJLi4bgzHhxR94XR1HjVmg+SPYXvcd2uDvCZv
	Y5SKYNKcKHElFTCXlljY+Ju9T290Gu+dwKC8kNBa6lyiAzme5q7aJiiZoWb9ETRh9I+drHeP5WG
	HAiF
X-Google-Smtp-Source: AGHT+IH4h2EdLWs3cUze55kfQ/fAbQZwfPYmGKNCQaoANu+WS3EJRo7hThxa1dJd4YaZwjzMOtpkKPQdyuAKIkH67GA=
X-Received: by 2002:a17:90b:5904:b0:32d:a0f7:fa19 with SMTP id
 98e67ed59e1d1-343fa52bd87mr19533123a91.17.1763450687151; Mon, 17 Nov 2025
 23:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118012539.61711-1-pilgrimtao@gmail.com> <aRwNVAk1dnoJwYSZ@infradead.org>
In-Reply-To: <aRwNVAk1dnoJwYSZ@infradead.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Tue, 18 Nov 2025 15:24:36 +0800
X-Gm-Features: AWmQ_bn81VoueHJPRDWkYRYfkrx_vkJ5_Aau5OnNUhFEG8hv6new05NLSyUz_9A
Message-ID: <CAAWJmAZi=CA3sysb5N8rLL3qUVWz1tmHSpPtFuYPmEb0F+_UOA@mail.gmail.com>
Subject: Re: [PATCH v2] block/mq-deadline: Remove redundant hctx pointer
 dereferencing operation
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:08=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Nov 18, 2025 at 09:25:39AM +0800, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > The value of 'hctx->queue' is already stored in '*q' within
> > dd_insert_requests, we can directly reuse the result instead of
> > dereferencing hctx again in the dd_insert_request function. This
> > patch removes the redundant operation and modifies the function's
> > parameters accordingly. We can eliminate an LDR instruction.
>
> But you pass additional parameters on the stack.  Aka you're causing
> churn here with bogus arguments.

This patch replaces "struct blk_mq_hw_ctx *hctx" with "struct request_queue=
 *q"
without introducing additional parameters. The total number of parameters f=
or
the dd_insert_request function remains unchanged.

--=20
Yours,
Chengkaitao
