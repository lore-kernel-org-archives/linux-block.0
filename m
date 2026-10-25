Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922978;
	b=PeUPcg0NJLFOKzOfY3pqI08NOObmEKoM5jg4+fQviQqn7hDb3jUjmSCo3viLzfpfjmcX
	 MlBDRDTzTF4d+OS81WQBTLKozjzYp2vh+wn8caiSkOgskR/N57DJelUZeBEoOqPY7QB78
	 /thfu4c67/DRQ8fM5ZqfVgjq3p9nane8nNxKoRETd+fbvd/qGZZcl8POw0TTDrVsE6AJm
	 AaG9IUKQbEFpS27n6MfaA8P8SFO0F2ZMPNV9097y7ezN7NAFctrVS97DlzG/CTnNV77xp
	 fGH6bDGG9dqmf0S7g9prmIhy/TVvMkrc0csoUvjo6i8owKn9mwXniCRXdS9RSGEpNhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922978;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x9QnU2pBsGjIFmv9Euw9yPy4UBXfMcM3EXn/p1BGvaw=;
	b=sC4ngfUc7h6PMk/V/EUGuOZxoWKOMcsG2OWy1w8lM8YyemSeBsFrUlBlAePXxEaR5woZ
	 VFxH6uGpauEeCJydCvVN3hdUUoFw+X+RocCGqfCt6PLvf71Y8xcVD0ZN9DHMqRL3bwqm4
	 obdbQcIqrx6cU65gA8WpwD8GhS+oospkMLlKTg60f0GNRYUkjnP1Y0yB16Rkv+rytRBDj
	 d8hBdFCuIPKnPwRMuSH67qzyxNzthHtVEd3Qx2LI0CsDBhAOmrgYsM2nIXM7aItCd49NR
	 GlC5M62mzU98cVz8EVIc761bei4+YoXywMwvQ97hUJ82JAJ/AaMNZfMSxIBgAy3zoQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfkkbBlt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582A606A31A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfkkbBlt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3C91F031E3
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792922976;
	bh=x9QnU2pBsGjIFmv9Euw9yPy4UBXfMcM3EXn/p1BGvaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VfkkbBltC7bsCM+rryO+DA/DdspsX0PfPXpnFrniEqfAR0EmFYeVGINTVujq8fXon
	 9meZtkY8T5Kp/W52P+22vw7Wwhp+wsRyFuyWjmF8A31c2etBkSTZE5EpmdU5B654vA
	 sRjKNj4+4Jyuz+OLj4lEVKzwuZE6RxR5Ik395HfjrIY44KorpL2PKvjpyxRzAciL1y
	 IJS8Ldv9yyiYecnrNhVsTSWsL3KkXYdJ+r9aAphG44pFpYI0qoi/GNiBFzcyWJ3zR+
	 NhaoeDfPQ1knN3JHF8+4dMP7NXLFJl3YIaglTmUxLj+GqcJ85J6eaLA9IrwbdJnBT4
	 7RfD5/MuvqHLQ==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9178aabd30dso20785916d6.1
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 03:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNLs5UDlrqDoTAsXw2Ic7JIphvfFJL0vk9WXTr014gxBTRsXcATHhw+1RC0JtgAu/RFFB+6lCqfbUwhw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIFOQ7zynPiYVci2AA5ezCvHbU4EFqyoLwFboZer99HaSyeEndQ
	MF01a2Kw4cBdZrEGRsEvjOAFxylqC6oC+Fesh/IxPoOEiyjsT+OkFPLAI+2iWiOCYeipTZ3rMCz
	s81XXVoJzcC7V/Ez1vpy6HIk3ra0qZtU=
X-Received: by 2002:a05:620a:271d:b0:93e:c35b:2332 with SMTP id
 af79cd13be357-940ef9504b7mr498180685a.73.1792922975943; Sun, 25 Oct 2026
 03:09:35 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025021839.1542805-1-senozhatsky@chromium.org> <20261025021839.1542805-3-senozhatsky@chromium.org>
In-Reply-To: <20261025021839.1542805-3-senozhatsky@chromium.org>
From: Barry Song <baohua@kernel.org>
Date: Sun, 25 Oct 2026 18:09:24 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xxB1Dp-wFkw0bqF6hUtDERxmjZ9e0k01MYtaECvc2z1w@mail.gmail.com>
X-Gm-Features: AclHuK_hSR0uvsmfM9khVcfYjoKkHuYjN_xXHvZnCMI2yL_FlRUxprG3VMTY-6I
Message-ID: <CAGsJ_4xxB1Dp-wFkw0bqF6hUtDERxmjZ9e0k01MYtaECvc2z1w@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] zram: remove debugfs entry on init failure
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, 
	Bo Zhang <zhangbo0325@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 10:18=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Do not leak the debugfs entry when zram_init() fails to register
> the block device.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Barry Song <baohua@kernel.org>
