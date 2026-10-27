Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793081698;
	b=ZdPrZT2jL7KrKPtIvVMg944wUQqt16kQOeuxZZe6byi01Ah0M3b+5hddj14nwGA82j61
	 OOM6m09FQv4AtVPADDpxjBW2RBUrfoztxR5gOyku2pWU5PI8kIVJmYpmlyb2OW1T+zVi0
	 Trl+FRCtBE+QS/ERZ0DsKul0nSXJsNtgJhuKa5QYu4wwNP3fl99GEFkzBLF2m26plnbRn
	 +mML93Q3ZhRpykcGciLiwEjzWiiWCrnXCPDv4cI3D7HqUxt5BcQNnYBc0VE9aqPT0QvO1
	 DesbVHxjrQMzO9JkdrnstHa3E2qnBp6t2/QwzXBexssSBTa33CyfQ5v/7zLkQR979xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rvHLijNBU08aEIcYebs583tqrtn0BZ2i7XUXNkAlzGI=;
	b=NJCLlYE1/hlYoaZ59r3ZlCXo8W3GYzwXfVrBjzRKAGEg0nS3O5WRH3P5LPSJDOLAy79n
	 1W9VY0H/Mwhqc7ajX6eE/+5Ifcl3I9mr5E5OXOTFqOgdCctCo9AYuzfNeYiTB9Edhl1t/
	 kXcLYMco3gdFUt8v+LsP2/NMSUZes1TVrSw+6g/uyKrI+q8cW1hCJYwa4flIckzwCEPiJ
	 C8ROC1chs4M0vd0RCfmlPlYp48LtPbFgClPZMS3s+rHbYY50Yg38vnWXfnc9o0WqKrAVs
	 p2QsDmRcjHrAFMrWIDqP1hscgii2tITzgYS5NhYFyt6d+JhC4fyYb5OhbjMf3hRVfog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jItwf6wq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095D606A31D
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 06:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1095D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jItwf6wq
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35fad13ca97so432386eec.1
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 23:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793081697; cv=none;
        d=google.com; s=arc-20260327;
        b=kLFiiQZYKxb6HKxoCd5tjsiW6s8d5Uoo3LtCUoH7fsgLehQmNE10HxnoRBGlSWLDJ4
         cAxVFIRGysD3Q/FFLeQ04/xkjjyCkg1W0JzzIjkKyZViXYqM0WEI+ai08+iqmMcUyDvs
         hz8kAR5dJKq2S8FRu4p3AJ2IFIaWeO3Mp0MkGj4hRXvsRkFfX55EkYZW4A2UzbZPzpOK
         R4FGhWqEldWqGL5hFJaXCjX8UTaWnJWxSJpyOMRoIsZQKTXr6IMd0tfpQZB3sroGaTgt
         DF03hwc7cL9r7dDdiqAUNgr77lKYigKoEOE7nZshZb1F5+XYse4R2NcZR8n35Sn0svme
         GJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rvHLijNBU08aEIcYebs583tqrtn0BZ2i7XUXNkAlzGI=;
        fh=rwx0oKtqmXNZmf40GpIcXBk3EWE6GVhJHiPkGf/jzBE=;
        b=B1SKZJm5KQFqYCPK14TKfstE1hnLms0xQQv5euhlpLdpxKCvWy/68VWx9H/2GDPcMd
         dejDiv3R8tWymyn5dQWWMETV27OQ+tVIXFWlTA2Pv5sQYUW+5tM/FLbQyW70vBHyHYcJ
         vjl6pwzZqSi8Dq/6Om44EWxDXJhip3f3g10LaN+4JCqVidqc8sHw9H7BSMd0Wd28N6oI
         DxDIQLxiQjyOFKYdiFud9ru2pLvd5hIxKCzt7U5dV2ALC6kn+S+kkr/uqGYee+J8hVOy
         ISIUJJksYQNRALUweiwHp8Lw4Cd+J7vNf4yUtPeeCxZdaED66/OeXdqAVXf0NpLXTH7o
         G2rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793081697; x=1793686497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rvHLijNBU08aEIcYebs583tqrtn0BZ2i7XUXNkAlzGI=;
        b=jItwf6wqDUSf94XwxDxeQl+DqCP2yUlSmpnBFAewrBuQ9WoSKZ3LUH3J7OY4FmdDA3
         grsrS1uU9Vr0fPcMCoM8UsrKlCu0jD3oaV0DArXfgjA90WOyuVGtWcGfVp0OIk/qV1wu
         NufDk3Fk9VOJA9ZtMqpfndWcEIEx7LN9rWgTDIV2CoBIHHPd413KPpPfN2O4jX/u9bKc
         YhOFtOI4cFEqtPu4kXDrjSCO+3VGtD7OmsVdLj8mm9y7iKm38eRUitF0EOcVe2cr7pdd
         /iTqj9YQrH4lX/Z2Jh/uVdCc05fPDuPnba/8au/PI2fUW/Ax2C24+wGnW1JZbWY13xOD
         t0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793081697; x=1793686497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvHLijNBU08aEIcYebs583tqrtn0BZ2i7XUXNkAlzGI=;
        b=m5x5rg+p5lM9IuQW1heWGH7y1FwdDCVtIldn//cAH2ZyC5KgwIit3UxOpqnR6ExotJ
         E4wstXVW0y1kYaX1rPekneD6tCHe9lgnY9MObXQWIuDqX4OV5LWxcwG8tF+VbiJDBlDU
         nqCGMlFo1/M0UNr/UQa0gzFesihH/Yy9lkxszu6vwDx6pDtQMNDeaC1KlSnB6IiKb0kz
         OfNSpK/Iv++RPTDerOBrOq78K7kJRy65zKaV4SMh/owXa7N/nsu59RR0PBsAbfaZS6OQ
         84LoWtNCJRdpVJa9e9b2qNxrZIwmSKQqvLIDOJLv6F/J7qqNVL+CyVhbFHeFJgS93Kbr
         yBQw==
X-Forwarded-Encrypted: i=1; AKwUvBzhBTmVq8vqP703eRA61JrE+hQindlynj0dxMggIxdw3PXv5gHj9lw/qrn190+xA7FADSH+K+a3+FlwGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLRB7ZzaXxjfbJ4f7saQyM24ewp+hZQUBt0w1AkNBhcu15wDktV
	E6dgTKGBc0b6hESWauqzHF510rL3Ii338JwM+UVGhRcxt6SQ9t7G1zS/G+OkwN3jg7xqXXPWEuu
	1m7cf4sOZ0uDGdzaMir2EzcOHkOH3a4UK6L77iSJ80A==
X-Gm-Gg: AYBFou33wSVwj/8m3+8/L1SxqN0grAKmYaBtERB72h0T7YBS9MyNP7SP0dYODtpvY35
	Xg2G7y/opoLY0MNgjTuQ765dD2spWgVEYPsxVX919usdxAamELrqTYP+5KH27Mezq0XwkzSNM++
	8j+UG+0e+8gsWXY212HLrIJ875/zi2kr8ghCdOiDiGUAB2p3/U/lKAVYtH2efEFFtdi+EQ1o6ee
	X6IViFYe2yEB1Y3HgC+5W3nVMFkaxZywOBWzFcyL2JRjNRqabdpv2lZtNq9CJeJAXtsVyIgX/Xs
	01g7dV2THy5DJdmND6aSF7DQlAyEJdv1dGTQzKQCuypHmHjR8ILt9kiM46yVQ5PyZRWogZ6tE+V
	EshKBg60SWdGY/jnmcYnhGS1+CfYGnl8fqn/cllulU7PcLfGbLx9SGUoZTOfQanRw7Vi/fgHA76
	r1uF/C
X-Received: by 2002:a05:7301:6408:b0:36a:a10:ab95 with SMTP id
 5a478bee46e88-36a0a10b95dmr3472715eec.29.1793081696914; Mon, 26 Oct 2026
 23:14:56 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021093332.17334-1-mzx199711@gmail.com> <20261022062513.77372-1-mzx199711@gmail.com>
 <5c7b9f30-893e-4127-8ffa-3d5b7224674f@acm.org>
In-Reply-To: <5c7b9f30-893e-4127-8ffa-3d5b7224674f@acm.org>
From: Zhenxian Ma <mzx199711@gmail.com>
Date: Tue, 27 Oct 2026 14:14:44 +0800
X-Gm-Features: AclHuK-OG29MugfEcwXyYV0jzPDDYGKVBguIF0ql4PUVRJM1kKeNGt1FKOzmfZM
Message-ID: <CAAth02B6UyRLaU+eKmLNueeh1N5Ecu_+Tsz-GaXj=AWZ2bQkbA@mail.gmail.com>
Subject: Re: [PATCH v2] block: fix recursive i_rwsem locking in blkdev_write_iter()
To: shinichiro.kawasaki@wdc.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de, 
	syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com, 
	Tal Zussman <tz2294@columbia.edu>, Julian Sun <sunjunchao@bytedance.com>, bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi Shin'ichiro,

  As you mentioned in another series, this is a known issue with this
  patch and has already been fixed by:
   https://lore.kernel.org/linux-block/20261022062513.77372-1-mzx199711@gma=
il.com/

  Thanks,
  Ma

On Fri, Oct 23, 2026 at 12:19=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 10/21/26 11:25 PM, Zhenxian Ma wrote:
> > Drop the outer locking in the fallback.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
