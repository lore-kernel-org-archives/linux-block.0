Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B92E0920
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843019; cv=none; b=ny3tbG9bK66Rz+2bARoJy3NzXnlOEX78bebc3mVyLwqVbiNb3T/98f1SXgJpTdCctCfOUWfQICeUFZpGiLYH/csNldyUfU1DHj0qF3s2WunQ5UwZTQBbocBIPUj92S3xDhDW5JZN2p2kz6U7Brf2X1b1pxuXW8EaV/wPsfgOAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843019; c=relaxed/simple;
	bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkK9bBZIfws9okvRrc5KulOB0rXMEA7EW3qBeh2uZEwpZSs/7ra/MDdDOHeFb/oFeWh/UjCHK4oihE29zDHLF05AsMUBlQpuGB4IwgnkTEpQ9miesFwRgsI+Gao23QkX0decip4gfNhWGthDWSbMYrz8dsGAw5Hb16w97eBvfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlMB7Dxw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlMB7Dxw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28d18e933a9so1487025ad.3
        for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843017; x=1762447817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=QlMB7Dxw+aVrAdbSUWU0bipn23Xfve7pppXiQG79QFpCrpXyoMO8KZBNoq7a1rtmbS
         4gxFGT15a65Fa8TM8upk3VOQqJZ5+VbO7fjKGR8abQX3rkTCSXPaP1yOnflhCMKpEgcO
         +3cy3G2+WLq6HNbhVZHDlbKmvgZoXkttFBiI1iBPqSF4RVCgoFK3Svji5aq7nLJBixog
         Qg6bDb6tpIU7GTKMq+Y0EHmyfgfwhq3mzPbmmjNlXw23muzhxx7hGoalRFR2UQShT5oY
         DTuB+/obSiIxwhudLi7GcUKBacHSmw/s5yKkiN+NVzuBoBzVyDMFb6ZQSdxvPFOE3n5C
         AreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843017; x=1762447817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=Od9nx1OLJjO2rUDFTJP1Z5eyg2yiMpqWnYP/rRpH62s1VnIJTiQKzJrLx39HxADgVo
         jEG+IpI0qdX9wtgwgSqcFGz7e3JWfsgbjEXfJR+1O4tDGBWXKxcnYLTCpTR+jDvuzoKl
         shCHtq01NWCaiw0q3fU/W2ayRqDfp1nff4XBs4cdbKvtZJurAtOWrlL7wm6Mo1tieACp
         tfDD/Ih7onKm5JEsjndh5Yyhm73pRvJGv1FFPvo2T4xqI1c3QVHATmnTJ3IO/jk0pqki
         1abjGAKbdq74D/5znvz4VJgNLzzdpRamTLsmcDQokckWOVt08vmAqOVnhmS1DcsFAoNO
         I1qw==
X-Forwarded-Encrypted: i=1; AJvYcCWU97Zz6Vh1o3cAcqmDgFl5oSACTI0+nDxVuW5rkVtNg3G+5TL4BRCV/OzjkheUayETxSo6nhgODqljTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPm9kEqxI3e0V8Zq6stfVUQyo+abQdMy13mPoQRuXnh+S9pHbh
	Rdy08SmcRzqUwOd62votFW7mgQPTkLVin91ZF7yTaorKvlxx1rECYiRpaGwZ2KakmXo+CGL4gan
	2NEk9a7+DSakM8MM4WNbukSedmHhJUwg=
X-Gm-Gg: ASbGncs6xvhO8Fcv5xw6KTf2wL+PBq7q7kWaq4WjHvMn4YySeeaVA8zFGCWkEv6zJS6
	SNQxvgSnXulYhU0N/IymvaYr+4NIGskstI9XLmwB0jclodLsV2b6h7PY2R1Ygzt7odsOpaQFo+p
	bwvNa7eqSxlIxeTSZoB5s5rFFebHxbYxdobYHUC/c1jfv5vhfcajmtheCR9yOSmpi2aflGUdt7a
	9cOeT2ux2D3/sbT/tI6E/B+TRdZYrWnJTPXosf13XdcHJaMVeUitkla4tz0Z3xczzDsBVAieJmX
	IuZneQK/4kN/HdGVY8NvLRPAv+THmBhtWXQjJko/mqEemsarX4Kv22z+wCaXpjij6M+KcrHJvbH
	sxGQ=
X-Google-Smtp-Source: AGHT+IHIwOHRSXqelvV1Sdf63ytImuxsi6mN867ttFRk6bB9U4Bt6FvCqQWaRN3cWMuEbnRRwlVbLx8M4DZOhZxBczg=
X-Received: by 2002:a17:903:234e:b0:294:b58e:6580 with SMTP id
 d9443c01a7336-2951a545f7fmr2497775ad.10.1761843017022; Thu, 30 Oct 2025
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me> <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
 <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Oct 2025 17:50:04 +0100
X-Gm-Features: AWmQ_bkaCQLlBdplFGaXs_s6rBEi5hnyY5mzRPNbjRg2sfBfQKwQOTLK3O0jQnQ
Message-ID: <CANiq72kuRNvovHK5r24kh23mo5wp2bpx-EjGMOyNBOF1YzukvA@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:57=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Since this patch touches so many moving parts of the rust tree, it is
> going to be a cat and mouse game regarding rebasing this thing. It also
> touches a lot if peoples code. I am not sure how something like this
> would merge. Do we need ACK from everyone @Miguel?

Yeah, any rename (or generally namespace/path change) is always
painful due to the flag day change, and thus ideally best avoided if
there is a practical way to do so (e.g. keeping the old name for a
while).

And, yeah, treewide changes generally need Acked-by's from the
relevant maintainers.

Cheers,
Miguel
