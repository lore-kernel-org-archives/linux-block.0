Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA270AFE
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227974; cv=none; b=s90GjspgCTqB16F/qCY0vgvgjPMTq7Lu6jtvVfaIsvhpahojkrEHKBrfZY8KMks2b7N4IcyzVYsajWslLqhK0Ufvsa7uG9MHYfDudm2kZGlMU5w20kZc7LkwXlh1+UoUjl6Y7pzS01+B+yoPzDor14900TgX/y6ygRRLRNZaNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227974; c=relaxed/simple;
	bh=jzGj5I4LRuYklOQyJfNOnG7oivOkxoCVa97TajgQgCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPABH2insfbr7fp1uatLsZ+33z5NdZjz57CRPU8cXIrI6VfNDZLBllmui66x6pEqj3uRfDLPFyXLmyirSCO/w9qGjBUiMVUZ0cg0c9oe+vx24UIg3HQ8H9RnjAaA68zE2yAvERn3vfYxzBn2//BshsQN9Ag8pR41drKDO+KprAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z2nu0BE0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z2nu0BE0"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a446478b04bso70525166b.3
        for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709227970; x=1709832770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=Z2nu0BE0b2qIues+0tbS6E5AL8obdL+PkIbExF4BJsmfByFxdn5EkWg9FQrOE/Okzd
         8wDe/jEi5fxM4e7E9C+t00AhzyndVTjcvZjdQjN/1Daqc+qbRO6oLZ8nFgcViQx81hdF
         ry4vmXpqCsLzv1jO9S9soDdIQqE3vWFiKL9jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227970; x=1709832770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=TumpjBNCZOw3doDhnRhCB0z3Iq8ycuXunoieddpM0A1bbWSobdDnLuOjIO6SZhY7GE
         29FWaHpdDq3tsExjPDUELebfqdjKhT8z+Rc1q8BSCXm6dOVTRSIsBTAj52xkRly27bTe
         bA1xpYdJhQl8OvPT84IIvKp2IpfzohrRogKsb0k54Gs/ZjMuyfqpHDWOHvFR2pPX8ae5
         LrywRuA5El9kYBeYGwDL0TXfmiWPyWesQH9Xr6rG3YrbAIbcEKoTLky/lKmb0ehGhkoK
         UxkLLKATfMuVOgLVweE6SiVLaIqM2PiIk2Pzrbv0qsHv2rcNZgzFpUWOy7a0e2E9M1oJ
         t7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzhw0wRS9/tbMbmGAXuM4hfz/FZHVy+aNlT3XkKvfZvOBpqGqRlGHU4psLMzVGW+W/kTEeBHnLRprWVgBxkljwIE8+ZV64e5cH/2o=
X-Gm-Message-State: AOJu0YyCP6sE2zAnSeD6jDZuYyj89cHOFwAVON+JsM5F8XEoJybmV1pA
	UCrky0Lca1TqTNRW1GflzmN4Vv62KAcpRiOByao8jw5JmEQrkFm99HglykRdoAQh/rLNtEuvcnG
	ksyMXOw==
X-Google-Smtp-Source: AGHT+IHUIvIf/QWDZIXfvF+tbwexLOI+sH088EXRMB8FTC7OSlHrMOTkg/uPUS7AFA786LGV+jA8cw==
X-Received: by 2002:a17:906:b84b:b0:a43:a628:ff31 with SMTP id ga11-20020a170906b84b00b00a43a628ff31mr1971142ejb.26.1709227969734;
        Thu, 29 Feb 2024 09:32:49 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906a39300b00a3fb7cafad8sm883293ejz.39.2024.02.29.09.32.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:32:48 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26fa294e56so231250966b.0
        for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 09:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGoYJBmc44Ecz2VfYlrb//Pj0PuxoBIJowBp0cm5qVg3w09+aAtEWvGUNyflVjD7yH6duU5v8vk3wtgHTfBnc0Rfxki0KwxFOlqUg=
X-Received: by 2002:a17:906:b78e:b0:a44:176e:410c with SMTP id
 dt14-20020a170906b78e00b00a44176e410cmr2046490ejb.5.1709227968058; Thu, 29
 Feb 2024 09:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com> <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
In-Reply-To: <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Feb 2024 09:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000e07d49061288a5ca"

--000000000000e07d49061288a5ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 at 00:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> See the logic before this patch, always success (((void)(K),0)) is
> returned for three types: ITER_BVEC, ITER_KVEC and ITER_XARRAY.

No, look closer.

Yes, the iterate_and_advance() macro does that "((void)(K),0)" to make
the compiler generate better code for those cases (because then the
compiler can see that the return value is a compile-time zero), but
notice how _copy_mc_to_iter() didn't use that macro back then. It used
the unvarnished __iterate_and_advance() exactly so that the MC copy
case would *not* get that "always return zero" behavior.

That goes back to (in a different form) at least commit 1b4fb5ffd79b
("iov_iter: teach iterate_{bvec,xarray}() about possible short
copies").

But hardly anybody ever tests this machine-check special case code, so
who knows when it broke again.

I'm just looking at the source code, and with all the macro games it's
*really* hard to follow, so I may well be missing something.

> Maybe we're all gonna fix it back? as follows=EF=BC=9A

No. We could do it for the kvec and xarray case, just to get better
code generation again (not that I looked at it, so who knows), but the
one case that actually uses memcpy_from_iter_mc() needs to react to a
short write.

One option might be to make a failed memcpy_from_iter_mc() set another
flag in the iter, and then make fault_in_iov_iter_readable() test that
flag and return 'len' if that flag is set.

Something like that (wild handwaving) should get the right error handling.

The simpler alternative is maybe something like the attached.
COMPLETELY UNTESTED. Maybe I've confused myself with all the different
indiraction mazes in the iov_iter code.

                     Linus

--000000000000e07d49061288a5ca
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt7i5gtw0>
X-Attachment-Id: f_lt7i5gtw0

IGxpYi9pb3ZfaXRlci5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xpYi9pb3ZfaXRlci5jIGIvbGliL2lvdl9p
dGVyLmMKaW5kZXggZTBhYTZiNDQwY2E1Li41MjM2YzE2NzM0ZTAgMTAwNjQ0Ci0tLSBhL2xpYi9p
b3ZfaXRlci5jCisrKyBiL2xpYi9pb3ZfaXRlci5jCkBAIC0yNDgsNyArMjQ4LDEwIEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUKIHNpemVfdCBtZW1jcHlfZnJvbV9pdGVyX21jKHZvaWQgKml0ZXJf
ZnJvbSwgc2l6ZV90IHByb2dyZXNzLAogCQkJICAgc2l6ZV90IGxlbiwgdm9pZCAqdG8sIHZvaWQg
KnByaXYyKQogewotCXJldHVybiBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNzLCBpdGVy
X2Zyb20sIGxlbik7CisJc2l6ZV90IG4gPSBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNz
LCBpdGVyX2Zyb20sIGxlbik7CisJaWYgKG4pCisJCW1lbXNldCh0byArIHByb2dyZXNzIC0gbiwg
MCwgbik7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBzaXplX3QgX19jb3B5X2Zyb21faXRlcl9t
Yyh2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSkK
--000000000000e07d49061288a5ca--
