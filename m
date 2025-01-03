Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2281B4233;
	Fri,  3 Jan 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896711; cv=none; b=sjhKvRw2cP4pISKa5qBNOtA+46XTA3KmssJpP8oDzXVt/25N4Sj9EuYUmi/BKhHOdUywQcKkh6BuLbjNjLAc8dUjXvS6uXZ7+Y0BcEdhUNATH9v5C8GxY9mBVQAjU4QdAzf8zHTaY9goWP5vJcR2KN6IeFQ3neOlhXeTN/Rl3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896711; c=relaxed/simple;
	bh=vL8zDs9vvT2j0AHZ8aofhM6OxrOvk8EtkwYTL3E3/3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL9IQIN5VEwkC3fPNQBFaNgNkTD4DBDRxINdYA+w5GLir+ATFubxyLkmTOlrbB592cBHx1p05jhyEvdqCfXizdmtvxidiiku/sRJIDSUD1J+2axoUn4lxn8UZvvJ2N/vkk6dwskOxCk9L0kExh/2EAMG8ju+eNXRwfbTE4PEqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa69107179cso1978460266b.0;
        Fri, 03 Jan 2025 01:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896706; x=1736501506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhvKQFYrEHAPSyOkSeOFfnhuFEMUFCuy5EuswH6w1MU=;
        b=J6gfIz6tTUtllrSNaj72qZeepKo2TagKDGgPl8L6t2ODOrxnuPOA04EWLXF+CQrTz2
         19w3y4aZWJr1gTg5xz5QYTlROLLQa/RG2EcYj18ynmK0M3AQe5arq1kEGRcs9QIzhgq2
         qgUnTl9WOz0z8cp3tfvL0y8ZadoUmvzUDDlrSsjaAK8CwyhoKtH1reuDEyOrS50Yac7e
         gaqPpLFbu+Y0qderhiL5FtMRqGZygr1zfYFThwminAmhDeG+3ZA/a9+kbg3HsFlW7xgu
         907VHqGlsqrLU6GlgLcWDT8SDHeR8iCha5ASAlzcB32G9tSpzeJzyAyaOlJ//uUEKY2W
         Y7dw==
X-Forwarded-Encrypted: i=1; AJvYcCUTmZRM9OyZkOY2hPuJVEWd01bvOxXEe4umFdkg+ev7kWKc6X9SttO+TjmGXI6CoWP44zHtarxfiqe5Ew==@vger.kernel.org, AJvYcCVOU8dH0zT2jXaCKzS9hZfjv/aa+DXOS7C3+bpB/HgT1sTas4psYCxoWbHN7Z5KShrfwn7D3Kni3nHz3xKv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6R56HBuG2zwJTFBAFyld6Yd2Xd0XTn4engfOaRDYvK/B+i36f
	75pu0j/jyZrYNkm0t54zVDaUp2Vd8nq2VV94C6ARvezjwKuEBPbHqKjk081yugg=
X-Gm-Gg: ASbGncvFcMATKTVaz5jorZLcuPhijXROUeqTGsbYUDCVEkrGqNh0jdLUAMyG+IfZmeG
	KC25UzPZEQ6ILyOahhN+7c+4SBaVuLfTWOFzdU6NAxVFmdT/mX2j6NOPWKACfljP/rBSk03Zaud
	GSzPhlxfV3LM44/kRuhwJJTaHAZ4J+0v58KBJuWXjLzTPS4GH5T56VU6d3FOneRnCuT9rmisQvk
	UOSimwCs6ApInB3iqhY2te8Hbuwouf+ob0/L9IIoookzZJ6fAf/7uEIHivP3+OODPKG3WUXPl27
	0Ff8U/b3sle24JzDlEk=
X-Google-Smtp-Source: AGHT+IEUPiaMGp890myqJ7psHgu4MOGcR6lVOjAlefn9jbzS6cPB7xjEtHETuedq2nozlSJ2i1USMw==
X-Received: by 2002:a17:907:c20d:b0:aae:8490:9429 with SMTP id a640c23a62f3a-aae84909672mr3432582766b.34.1735896705481;
        Fri, 03 Jan 2025 01:31:45 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedaebsm19869872a12.57.2025.01.03.01.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:31:45 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1933144766b.1;
        Fri, 03 Jan 2025 01:31:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPjEEpnV2USubVrezfigCJv6hhuujSQnk680fCUOW61+/T0+prYdZbSWr8MtWZlPGyxCSClHooREmxPg==@vger.kernel.org, AJvYcCVzc/21a3Boep/w703hvNXwYlCVTx1FtmlX526s2PSgNc5hArYNfJsXkJ0/+JtIj/QocW4iy/3q9nUnB3Ss@vger.kernel.org
X-Received: by 2002:a17:907:7f2a:b0:aab:cdbd:595a with SMTP id
 a640c23a62f3a-aac2702986emr4003780166b.3.1735896704686; Fri, 03 Jan 2025
 01:31:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216.git.geert+renesas@glider.be>
 <20250103085652.GA31691@lst.de>
In-Reply-To: <20250103085652.GA31691@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jan 2025 10:31:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUw23VNeO44dPzwbzMnCBws+twM2JVm7mQ745Ey1Cq4FQ@mail.gmail.com>
Message-ID: <CAMuHMdUw23VNeO44dPzwbzMnCBws+twM2JVm7mQ745Ey1Cq4FQ@mail.gmail.com>
Subject: Re: [PATCH] ps3disk: Do not use dev->bounce_size before it is set
To: Christoph Hellwig <hch@lst.de>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Geoff Levand <geoff@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, Jan 3, 2025 at 9:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
> On Fri, Jan 03, 2025 at 09:51:25AM +0100, Geert Uytterhoeven wrote:
> > dev->bounce_size is only initialized after it is used to set the queue
> > limits.  Fix this by using BOUNCE_SIZE instead.
> >
> > Fixes: a7f18b74dbe17162 ("ps3disk: pass queue_limits to blk_mq_alloc_di=
sk")
> > Reported-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > Closes: https://lore.kernel.org/39256db9-3d73-4e86-a49b-300dfd670212@gm=
ail.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

> But looking at the report it seems like no one cares about ps3 upstream,
> and in fact the only person caring at all rather rants on youtube than
> helping upstream, so maybe we should just remove the ps3 support entirely=
?

I am a bit surprised Geoff Levand didn't catch this in his regular testing.=
..
Hmm, looks like his last Tested-by tag predates v6.9.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
