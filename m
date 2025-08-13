Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2862ECEBB
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093041; cv=none; b=cov8BpC8a5gSf75+POicFn8/Xy8xVtxi9+5HFfoF6bktW31w3oqIf3blRWY7ummMqGPf/aCRGfx4v/C7uiBajGG9Zn4TZKwPdoTlYoMgr095ZtTtlqWVMaIgBBC3KyeSumG/ZjfQNcRZU2JtWR0LcFs+TuD2Usmv+WsrRe42ZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093041; c=relaxed/simple;
	bh=Th4SgWJ7uOrhbJgJsJ1OslYEWLKNV+cmdvYGwrA7T+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8+UGrDeWogBp5nLGoySlMqcqINFI3hGhQXiplxmXs6oVKkfmLmSz1SZY2vkV4siX9v1kTctaF0vay5bcrtVAxAs/aO9xYZMK/vTM5djK3vuZVFBM3oafQ5dRIqzSHL0gZHn/TcCR5GTmpyB5vzftrpQ+pffisH/+rOuOYMGR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+4Fmtxn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+4Fmtxn"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5434576f8f.2
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755093038; x=1755697838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX7HsBZ1OSxtuZpt+0fUOkrMNSmDcBAX1JrxfwqVFSE=;
        b=I+4FmtxnFZLEaXk8+qCr4cn8GcUsrpVhl4TiAG+MPNs8IX57z/AcyQEpg00hcDrFbL
         6QN1Td2nkXBXLhfbpumDzK+Kudldg8zC7QeyMPl0mybfOQo1qs+HSVrs7Y78+JvIe91D
         TtSkW7BvWI+FeHcne4eHWKHCcS2wkuFi7yVQJv5erTVQuoAWr4xIK8p7/r/QSgsa/UlK
         x+X0vb6wjhl5DQPSGnuTXbnMt8QQrTDvDRPGCiZr1QhAUZdwK67p6ILt/08l4XHmWIwy
         nq1DL4C3Tn7AIevyMll1XsvZLbe3EVetsdPeKPcmwEA2MIDwyDTjnFcdqnO5ltwqUDTh
         YpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093038; x=1755697838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX7HsBZ1OSxtuZpt+0fUOkrMNSmDcBAX1JrxfwqVFSE=;
        b=u6I9XyhmpkisqRyLTnlp5pYImac3I5pT0ucCLSwO4Ie8i94ZcTLpxPK1idJeA/fUFE
         NluC4H5gQ3+RQdNUL5R1Avnwe5XvohcfD8Glm/YlEoLgXi55U4brfm1Bfca+D1N6jgnn
         BkY2tHiLshB0lBfDS8Tdg5IJ8Nr7gKE9tJZseKpfqshwVpKGnoAiDlmZ/KOLyxs/cl1l
         1TUuTpaTREhDEUIH2JCpjhcvNfVsu4U+WGGIkEe6ix8+VUTdEfmIlha/Hthp/DcNP8Zj
         WJRkHnIw3qXc9bjeAsh4SW2EKZHGlSbyyryqq1ITIJ9wI2coDiBHvC+aX0Wr5cItc4Vd
         CJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCX+MTgHjvioD9RJEbqpd1IhZjyBKKaXzia57wkkO3zjT3iYGhRAzt9U890rFGJLGvCF63ZRYWoHYF+iJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB0RW+g01rrAziufMGFwborQYQUo1leJ9ehBrxP2InwRLBB0X
	qbcXVviXtbP+5g2u7dx/3Jpipl/qZoQ9UdMZS0AIuTsB1DwJa8p4PH3UnJBkk1Lt4gKXvAQIA3s
	TWpcK8FPFiFUhUxtue+viZ0QNj+4OYVaNB8mFvr+Y
X-Gm-Gg: ASbGncsGm7lw0AhxuwVdQslSbQnoNNxv2WL8pyuaYJ9DaK+C//ilckiWC+tnMYCTrrX
	2/bHds4NkslNHyFEBM5OcYWoPDZV9OBTMXzGwfROQ81YLyh5mhzxWt257S8FQYENgyUdbdZKeAe
	f4tNF/I3runs84RlD/BzoqC06Fytg4L4E5coBjB5yPLLOePf1Zp4/pv2GdBRBRKmORd5/OUVBqT
	7DfMoiOLU777mu0JR7mnQUS93H+6qAGHo3Gj3dRWd275Nfi
X-Google-Smtp-Source: AGHT+IHh+vA/07eWR9Ebta9w7V6pVGfOotLmHgLP9XCK0PEzsGlKp04MKCCBaqBhhNesoViqmXpEfMe6W8DHSs+xG04=
X-Received: by 2002:a05:6000:2005:b0:3b8:f358:28b0 with SMTP id
 ffacd0b85a97d-3b917e4ee33mr2691536f8f.25.1755093037572; Wed, 13 Aug 2025
 06:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
 <20250812-rnull-up-v6-16-v4-12-ed801dd3ba5c@kernel.org> <I-QXOGdDtTAVOcFvHZksoPqkYUZThmxrTUNw1h_MEGXdk_X_dc2txQdKJPMLz-yPmqL956iydAqVD9D5aL2SDQ==@protonmail.internalid>
 <aJw_I-YQUfupWCXL@google.com> <87a543fkh1.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87a543fkh1.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 15:50:25 +0200
X-Gm-Features: Ac12FXyzo-eVyDXufLE9G-NGeZ0mHM_6CqrztsTkjyFXCp398EsRl9GEXjBkjqs
Message-ID: <CAH5fLgjezWnFLaEKZkfvb9ko0RHG-c5g6yO0KvOJ8nyennEXOQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/15] rust: block: add `GenDisk` private data support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 3:47=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Tue, Aug 12, 2025 at 10:44:30AM +0200, Andreas Hindborg wrote:
> >> Allow users of the rust block device driver API to install private dat=
a in
> >> the `GenDisk` structure.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > Overall LGTM.
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> >>          self,
> >>          name: fmt::Arguments<'_>,
> >>          tagset: Arc<TagSet<T>>,
> >> +        queue_data: T::QueueData,
> >>      ) -> Result<GenDisk<T>> {
> >> +        let data =3D queue_data.into_foreign();
> >> +        let recover_data =3D ScopeGuard::new(|| {
> >> +            drop(
> >> +                // SAFETY: T::QueueData was created by the call to `i=
nto_foreign()` above
> >> +                unsafe { T::QueueData::from_foreign(data) },
> >> +            );
> >
> > This is usually formatted as:
> >
> > // SAFETY: T::QueueData was created by the call to `into_foreign()` abo=
ve
> > drop(unsafe { T::QueueData::from_foreign(data) });
>
> I don't really have a preference, my optimization function was to
> minimize distance to the unsafe block. Are there any rust guidelines on t=
his?

I would say that the unsafe keyword just has to be on the next line
from the safety comment. Optimizing further than that leads to wonky
formatting. A similar example that I also think is going too far:

let var =3D
    // SAFETY: bla bla
    unsafe { value };

Alice
