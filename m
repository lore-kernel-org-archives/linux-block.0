Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09112B15F
	for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938928; cv=none; b=mrYaSisUUPqhdNRvm004TLB4Qm4ZT9OY/ASKXpyXATIxs2b9RDUZyTfYKuH/KHtUDgC7HDODM+nq3EM3Y5zCAXZRhjgeQpsDF6GxrFDNGwbuCL/QBKW0L28gKJeO/2zbtv35ZX9YiRM7/NpDND+tYd7oF0DEGa3d6FwKtHmD67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938928; c=relaxed/simple;
	bh=4JrM6obTNl+TTmD9WbQnog507Wg3xKCRVbWqMRbgJTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cts+BZAoQMV5fz+9xBdCYLEF/HL4dbhb11YJBL5M/5E28psKiflPNgE5lPwKrou7w1mImXCBsSFFLHBAKFoI7Kr2azw1UEDEBggenNFAbJTfNKkWYHT/sMgmm8QKqy/RrYh/H2iabuUsIQjFNRVHLE9zcEaaaHNbbYzYNzh0hX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AP684ytn; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AP684ytn"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4703e4d53b6so1626962137.1
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708938924; x=1709543724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JrM6obTNl+TTmD9WbQnog507Wg3xKCRVbWqMRbgJTg=;
        b=AP684ytn0uruUtZ4O9nQ3FsT63n8lYTu+hq4RM7Mh6B2ZV8zCAiKqCVHzv4R7XcVCv
         KG1yjDVjf1i1FwtdIFEHSepox2EYtC6gyF9Az0LkEXYo29yxMhoFmPLQC+zyyUW4YGTL
         qwS0R6P8TgoVs00BsclAxOEGHBdGw3gqG4OGr4VvbEJeQp1zcixrhcZ9A73ln32hx3/k
         3UqpbFOlQC/Sstrh94Q0i670dmIVIPVn9HVHkmsNCCLSWT9DbKza4tbuYKje1tq8p2Y3
         XYKs55V/0l4TmxcCB1mc9/6oliPl0TuHOuJjWtcJFymJuZPrhB9bE33TzmlVbpUtS9C2
         JH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938924; x=1709543724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JrM6obTNl+TTmD9WbQnog507Wg3xKCRVbWqMRbgJTg=;
        b=Ztsjy1P60oPkQubakqhoCIoEC8OidlvnYj7M4G3aM/sumOIXjNoMhaIY4tV+hlcJkY
         +6IYtn/HGL8Qhusy4TGQlDpWLCJ5wZh5yYQIKTtsxHPfcJTkRjL2m1YMb1nN6D137B0X
         XtqEcnN0VqCJxzhdGfaL51+jOt7T8yLf5GfmP1v6uwBVE2FVF3CKYgwA0woPqmY0xfO/
         fsmUXH/BdD9hnHV74txYSQCBrFIPBsjB/IoIiFOB2YgMR8U8cDYTjAvPFEhchsNhwZEt
         zVmO6EUTNO0Se6JjmJr10AfdJIySOMB9nUaK881jfANAc7iw2MBPpL5hpKVcBXio5yZO
         s7nA==
X-Forwarded-Encrypted: i=1; AJvYcCWfHZZSLJFKI9bRt+ibtwO8tDl03tEaKeTDBRvj7aFLqjmbBm6dwMibSZOzrWvOiXcMcgbWkuvFOn0x/35CGtw4Bqij3o9s54+FoRo=
X-Gm-Message-State: AOJu0YwgsITcZRo6taWWkS8K/c0NDzMkuht/aUHsRqmxcirsXqnaMiW/
	Lqx0rVo9HcE8P+zX1IVSHVu+eJqeIEpXLIGXGPxf+46xykyX8OiASxtm5t6i9kca+nQCDbTRBek
	da0sD5KPphcsuCW0PrcC++ovs3la1PJ8Mrho4
X-Google-Smtp-Source: AGHT+IG0UsEDnmHxQRrz745aw4UlqWNyLvLKlXPrUyhs0dx23Srr+KTicp6LvTTAV47/MeSVZ9UVHkCM8Vt6BAMhVZc=
X-Received: by 2002:a67:ee18:0:b0:470:45bc:a78f with SMTP id
 f24-20020a67ee18000000b0047045bca78fmr4607957vsp.15.1708938923903; Mon, 26
 Feb 2024 01:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230503090708.2524310-7-nmi@metaspace.dk> <20230503120354.534136-1-aliceryhl@google.com>
 <87y1b7a994.fsf@metaspace.dk>
In-Reply-To: <87y1b7a994.fsf@metaspace.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Feb 2024 10:15:12 +0100
Message-ID: <CAH5fLgjQm72KmKBtcnBEXOtVqd=Gto5UGF7jrekx8f+7QXh_Ag@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] rust: apply cache line padding for `SpinLock`
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: Damien.LeMoal@wdc.com, alex.gaynor@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, gost.dev@samsung.com, hare@suse.de, hch@lst.de, 
	kbusch@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:02=E2=80=AFAM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
>
> Hi Alice,
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung=
.com> wrote:
> >> The kernel `struct spinlock` is 4 bytes on x86 when lockdep is not ena=
bled. The
> >> structure is not padded to fit a cache line. The effect of this for `S=
pinLock`
> >> is that the lock variable and the value protected by the lock will sha=
re a cache
> >> line, depending on the alignment requirements of the protected value. =
Aligning
> >> the lock variable and the protected value to a cache line yields a 20%
> >> performance increase for the Rust null block driver for sequential rea=
ds to
> >> memory backed devices at 6 concurrent readers.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> >
> > This applies the cacheline padding to all spinlocks unconditionally.
> > It's not clear to me that we want to do that. Instead, I suggest using
> > `SpinLock<CachePadded<T>>` in the null block driver to opt-in to the
> > cache padding there, and let other drivers choose whether or not they
> > want to cache pad their locks.
>
> I was going to write that this is not going to work because the compiler
> is going to reorder the fields of `Lock` and put the `data` field first,
> followed by the `state` field. But I checked the layout, and it seems
> that I actually get the `state` field first (with an alignment of 4), 60
> bytes of padding, and then the `data` field (with alignment 64).
>
> I am wondering why the compiler is not reordering these fields? Am I
> guaranteed that the fields will not be reordered? Looking at the
> definition of `Lock` there does not seem to be anything that prevents
> rustc from swapping `state` and `data`.

It's because `Lock` has `: ?Sized` on the `T` generic. Fields that
might not be Sized must always be last.

Alice
