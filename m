Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795747320;
	b=crU0TAIJvBzcgS2eVVPwCn5XpQTzjYUPmek11YCHtpGR8tQtOY1ZmveCVVdJmeVrbRNX
	 9a5xYo5QZ8JV/L+BvzHDyKo4o8uU8GgYoywDUbb0myBZXFy7Iyf+U2OrcqZX9fbz/TRPv
	 BterJud3dSLFrr4HgHRCsi/m78TNZ7y+11hPRBERdKjDIzkwuUAumVH2yNBxzI9esG49a
	 cTfpRkCmKOONwo+/zPDyvXkWQHZiRuGJtAbTn6mS/6HY7CWOtU7I7AnhybUc6kcHnXTds
	 5TUFjnBlzx2mTJ5WhrRSEuhGdh7wswP+JGjPpeNw+t9oOqBr+/yeJD4pErphh54MI6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mjTKmUue8uDRgqqOrMpuy+EJyNp8jfd045TOjApN2+M=;
	b=ZdFZXxnZq2f8oGPwm6xd6qBouo77AdYiqrY+/kyJYairig3Zjxncq86LCZcP/qQPx5EB
	 BvlgD6vcVddLFCSbEVgoAstW/jWMQeo78Oifvdb0RJSDaSCM1dKl+0yr3hBX1M2bFalfp
	 wck/3pQ0ZYqB/CiTIWIGOMu4di7O4YLhFeXOjIG+nAGw+7aN6UkalFWZk4EVrpvug3ski
	 NIo5LkUQjG9HxLPj5dwI2FNGKakcopB0W5uLwjv+4itxMS9Ptv4kXfn/eOQ9hUQcpD41C
	 qvm3WOdWZRRhVZjl/GPN/UoANuBrHMv1VwUFPRFcpHucLHvKJ7UPkPdPYx7kP25c7rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LymxqVqE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CB606A31E
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 02:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2CB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LymxqVqE
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c1f548f87so100808806d6.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 18:41:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795747319; cv=none;
        d=google.com; s=arc-20260327;
        b=Z8qbckPXeOOoM82su9QLLn3Hx4w6EPxfuo+4Tjh92tOSLu4wdRMt7LaCOwuxFzB4nf
         prBXAuP/SoFr1rsSCNSzB0tU5wPFQWA4aqOVpt69rhsBixOSiS83gS+zdwvUkv3jGBra
         MhZc7D5iJSYG3aZlpERpLoir24Ho5pn0heviW/p+Cd25ikYYyaZRNV5eL91IRH8qukat
         UHHnxVBFJnkI/CKjtSe7KYGtK9BunA+dV5ntoof6v23ZWJC2zZna8Nz/fKh1iDXAbx0e
         LNrb0UO1psr5KvxgPDx+RTqygzofCtbhBpDhk801zSVuiT6p87bLBkURjG8IT7FycIO0
         wn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mjTKmUue8uDRgqqOrMpuy+EJyNp8jfd045TOjApN2+M=;
        fh=zLdBfBsA9Lzo0M6Hi3EYeQQ5TMiveieWqRaAIpl5N6I=;
        b=qhcfbe88sVH7LcphTivbQ/GZVCL/Zldy+ja3Ga6nJYw6SUeO+OpkWBN+zhR1tUkSZZ
         5/xGzN70yesTQq0dafdKb4UYliihBAyeCNkhIU3m1CNIKgzDZSz42DHER8z1KgnJnvWB
         pwUg+Lub2jFcNVN+JQV2ZlcTHgAWHZTFRAllaQdq6pGUavzbH7H0iLWPwYVws9ZW0bem
         bz5TE4DQwUAv/M/8NpuvoehEtStcrqt5i62Y7HI2/FIW5USDD/L+3d+cJzJGnw/JAz1C
         KjXsLrMkUYYtIN0fQLzWog14c8ESF5D7R9oSue9hn8T5hD9jXpw5oe5cUg01TP6ZSdYk
         cgAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795747319; x=1796352119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mjTKmUue8uDRgqqOrMpuy+EJyNp8jfd045TOjApN2+M=;
        b=LymxqVqE8yKkfvLJxa/4Kw1dQnzxd5RBz0e9MwTAJSaII/nSUMUacLxA9zWn8EPWwe
         zpFBNAZV3BfX3VZc1Hj8PZ+ulZlE8v/3GYsYir0nI+k5hWw6F/yAfbVWLpRb+M+8ErMx
         iyQmK4V13fSsxWaCEGvkvPt8FZdL7ZVe5QDsG5E/dAsmYgUI6r5U9szA+GiibPhPtL54
         RXZWP0mZxAwCevEKiik7qpqlYgCAAvWBjlkp17PfAmqWk3eLX2mK06ZFqlhGMUYkP/1P
         Igik/ouRyJ1oa86D0IM+0Bh4bQFIK/+szJkBgG40sOaWrTlENmsGeXYvK8ToxUtAV3S8
         xt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795747319; x=1796352119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjTKmUue8uDRgqqOrMpuy+EJyNp8jfd045TOjApN2+M=;
        b=Z2D4Yu9CvCeFOl4AOMkv9BE+Y9hqY2cppk09iUm1BOAZWfmoLzJwZaQrLLwQTHPiUJ
         uqUq2ih09ynttEPP26afnubY9iyppxYBY/0rXLlQdnsG/262UTWmfzUHp3ptA2ESR9//
         fXnRuF4czGfZ+KcoRJ5+pir6TEthnhiAj7YXEfw9fC5auQY0FYyQWEcVnYejs/rfYz+f
         WpLfmHmRGa29ObQpvSecJ6c+893HOcoICPZH9OnO4TMp7IMjewEQwGv2EA5v1UJZ+cBT
         0HBfyXwee8OO6fPwCj7OPArWgPG7+uo9CBEYUp4lc8F5YvZsZdl96mj38jEhIfB4jf5Z
         iVDw==
X-Forwarded-Encrypted: i=1; AL+hErFhc2SF0mkCCCdYHTJih0IqUK/oSsXNXIjQtN12ZxggOTS69+8XLfXPbbIeK5EZAOojLbEMqcOOlXo01A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8I0X2LUW27+zK3IhmdhQxNDEL5u4i182EMN91qeXIJ32INJjyI
	W5IusjCWUKRNFwzURK/jVjfSEZMMBWGs+wqu8DtqCJYFdhnxOvYZa0ZfSES0U89osa3sHUVxn8J
	5F6kSkDxQUGrlvwZu2fFHcV6f91bt38A=
X-Gm-Gg: AZFdTZeImJ2SaaN3tRiypp9bKehot2fHaSBr1AZXa+88V85YPdg2b+MDRdh6Z7MZ2Jh
	YnJvg2jvxkpNqimACz+/YEHVAumH7hMdsQhtv32Hb4hCytUpNZ1m5NlURJ6gKS4dujlYkYjTjTL
	3Z8duYzuZapp4k94QIYyzDD8s8Do60+qgPUtrEKDFucLpb5FTN90xab+Imo5x3xj5ZfhE+JXs2v
	QNJvzSd/CfEQCZoor8ZDTNTEMZxsIiD2cqcYa7Hahe0CXxkCzP6MTB+Tgpdl7KMCygAtxnkhO6B
	5q1pdTiicyxaioE84SrUb6asCwuOFa8Op2A9HQZ2RpMW8pnvZ8mzBYm94rKovbppQfYB/R9ATKf
	xILz8vGIoqZj+epsRCI+9Zz9fkSF+r+Bx+HQ/
X-Received: by 2002:a05:6214:27c6:b0:921:7f88:9af2 with SMTP id
 6a1803df08f44-9217f889d57mr115043886d6.16.1795747318873; Thu, 26 Nov 2026
 18:41:58 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261127004411.109585-1-artem122novak@gmail.com>
 <awjaHB2ugCG_F3Io@google.com> <CAPufuhb9txcosy48VXtfxwnC7Ct448J=_HbR00JnZR1QG-NfHg@mail.gmail.com>
 <awjlpLnyVmKRqhmQ@google.com>
In-Reply-To: <awjlpLnyVmKRqhmQ@google.com>
From: Artem Novak <artem122novak@gmail.com>
Date: Thu, 26 Nov 2026 20:41:48 -0600
X-Gm-Features: Aa3M54qy0vNlqas6YULOPcsNSCZ7uefCUSENGQM7ReO8lLzeNpabTmpK4rgiuJU
Message-ID: <CAPufuhYd8daR2EPB=fE+g=Bejt=85pB3qvmOBdA-QzyO1Qx-yg@mail.gmail.com>
Subject: Re: [PATCH] zram: validate decompressed page size
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello again,

> I would probably prefer to do nothing about it, IOW rely on the
> backend contract.  Most of those compression libraries are used
> in other places in the kernel (f2fs, squashfs, etc. etc.), zram
> is not the only one to rely on them.
LGTM; I'll drop this change.

Thanks for the explanation.

Artem


On Thu, Nov 26, 2026 at 8:11=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi Artem,
>
> On (26/11/26 19:34), Artem Novak wrote:
> > Hey Sergey,
> >
> > On Thu, Nov 26, 2026 at 7:19=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > > Yeah, I don't think we should do this.  We only ever compress PAGE_SI=
ZE
> > > buffers, if some backend decompresses it to a something that is not
> > > PAGE_SIZE and doesn't signal an error via "ret" then it's a bug in th=
e
> > > backend and zram should not cover it up.
> >
> > I see.
> >
> > I thought it might be worth having a defensive check here,
> > since allowing an incorrectly sized result to propagate seems a bit slo=
ppy.
> >
> > Do you consider this useful, or should I rely completely on the
> > backend contract?
>
