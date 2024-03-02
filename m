Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064D2C683
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402837; cv=none; b=qyQOruENJtUXnfjRS495rCRnbgcdMEDyGU5//XGNb+hrardsTns/qa8aW5jQXsDWvP0j/blrlx66e6TlAT2Ohb5SezjVZ235edEXzkZBcL7Hf9n9EnQr3adk5SWYnLCS1qblc+J6nANYHTXgDSWMj1Cu9+X2zXwxFPpafoHeiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402837; c=relaxed/simple;
	bh=oPp+kEJm2yuQWRduHCnpZa6W+Rr0cKGzx+MpiFA+B7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC6Fj6Yo2wwSSyUkyiQbKlCbVBSx8IEUVn8L2brKiKSOzk4Xv2qW9DgyO0gVYZXjB19CeQh69aKW/VR+E6eU1tK8BPJNlRlC0cUTCM+h75l0BElv+NIYMSHUVNNIaRLiAta1VOM89dRXBDze9oO9vXT6y/y3tXSWZ0ZFBi/6UxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Va5mK1kk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Va5mK1kk"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a43dba50bb7so456089166b.0
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2024 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709402834; x=1710007634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tgHiAUIVGDD+1DgrVyftk8s8h5JugoTCX2MAvO9xGEU=;
        b=Va5mK1kkShfJWAA5000tIo2BJtIjL+hFA5s1FL1F0n0/LSU6agWcql4CKyMLfAuXso
         LjflulPGxe+td1IanUSb/ZAHRY1O7hye9Ky/3g5+AE29DMOifYoupGKPKy19HesvhUw3
         57mLO4fPwvsIeqISDFUE5Y5MY7+FS5SUSs2zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709402834; x=1710007634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgHiAUIVGDD+1DgrVyftk8s8h5JugoTCX2MAvO9xGEU=;
        b=KLkN0Leb+FFNDmg8pJT82UQwXrLxJ/oKQCKbbDoEIa/cOcfDVhTF6Wknmmn7jw2bRr
         aJoPuOtiBoKfPuxBusrNNw43TgdTlQ5thG1ZsVjIRxE2SuXTaJmJLu+CmvesBt0lJJzb
         EfStk+3m7FqB/dmNCqRzaWUoeM+5iPt12gRpLCcCfGLJXJbPsGoV8c2glf3VRAhtvjdE
         wp/hj4DaGFDXVeDELwJCBeXh0NUhejDmMDNL7MrvzpDF8HkW7Z2EFu3GSGLejKd5ld9S
         uBWKUaYzuNOKjs6shXK4zxxNWs5dRlCIoj/LjU+p2gafwRfKgF4KlX7MBh8cD0QDrvVr
         I+cg==
X-Forwarded-Encrypted: i=1; AJvYcCUir03ioR/GPkPHwe8w7Zs9K8mdwteAYDK5TWZx3S6lp1LPWrg0PYF8cq2vjrJnXmapO240Ko5+bqXqTzyJGcgGb3zK8BT4xl0F/SY=
X-Gm-Message-State: AOJu0Yztryw9vd2+wIpHMGQ3ynvGVaVIIaHI20AEgaAY4kPFh5wqVpmN
	aM4lcb8r1godKYuFqFojtMdzse6uQWvWHEEzpcw/1SjxzaAHorFjs5wqsnoVf1ixIH2EguS61ea
	xBquoOQ==
X-Google-Smtp-Source: AGHT+IHWAN70QxzACpgF2T9LDXGIPRImAzvsvRMOKLllGzAuN5GoEU98GoQHzXY/VUeWnyt1OeU21Q==
X-Received: by 2002:a17:906:35c9:b0:a44:e3db:aaf0 with SMTP id p9-20020a17090635c900b00a44e3dbaaf0mr1072651ejb.52.1709402833810;
        Sat, 02 Mar 2024 10:07:13 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id ub27-20020a170907c81b00b00a440ac20f06sm2961328ejc.167.2024.03.02.10.07.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:07:13 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a445587b796so338444466b.1
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2024 10:07:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDV+T+rA1AdLELd/ZvufOkK+Vm/wtQQ7Bdmsg9dHxkBKMVZC0bmWfX2kKXyOObe+U+dkoE3iCKv3BL7/YdiK9keP0NbpxYH5sj8PE=
X-Received: by 2002:a17:906:2c53:b0:a44:f370:e2ce with SMTP id
 f19-20020a1709062c5300b00a44f370e2cemr785292ejh.16.1709402832627; Sat, 02 Mar
 2024 10:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
In-Reply-To: <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:06:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Message-ID: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 01:37, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> I think this solution has two impacts:
> 1. Although it is not a performance-critical path, the CPU usage may be
> affected by one more memory copy in some large-memory applications.

Compared to the IO, the extra memory copy is a non-issue.

If anything, getting rid of the "copy_mc" flag removes extra code in a
much more important path (ie the normal iov_iter code).

> 2. If a hardware memory error occurs in "good location" and the
> ".copy_mc" is removed, the kernel will panic.

That's always true. We do not support non-recoverable machine checks
on kernel memory. Never have, and realistically probably never will.

In fact, as far as I know, the hardware that caused all this code in
the first place no longer exists, and never really made it to wide
production.

The machine checks in question happened on pmem, now killed by Intel.
It's possible that somebody wants to use it for something else, but
let's hope any future implementations are less broken than the
unbelievable sh*tshow that caused all this code in the first place.

The whole copy_mc_to_kernel() mess exists mainly due to broken pmem
devices along with old and broken CPU's that did not deal correctly
with machine checks inside the regular memory copy ('rep movs') code,
and caused hung machines.

IOW, notice how 'copy_mc_to_kernel()' just becomes a regular
'memcpy()' on fixed hardware, and how we have that disgusting
copy_mc_fragile_key that gets enabled for older CPU cores.

And yes, we then have copy_mc_enhanced_fast_string() which isn't
*that* disgusting, and that actually handles machine checks properly
on more modern hardware, but it's still very much "the hardware is
misdesiged, it has no testing, and nobody sane should depend on this"

In other words, it's the usual "Enterprise Hardware" situation. Looks
fancy on paper, costs an arm and a leg, and the reality is just sad,
sad, sad.

               Linus
