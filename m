Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3B351FC9
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935392; cv=none; b=sSOD1tvYpDdpsfNP77YyP9pX3bGxOtuD9rFzVX3MkmKMxrl772leJpHkA4VuOQVA77uafe17dUCwKz3JKx1LOf/NUBcqfun+TqurvURh9P2KgkvC1hocNQYAWWakMIWKk4rSwnthMLlIa3sjxC3US0ribW5NwgphlOC3FFY3MzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935392; c=relaxed/simple;
	bh=GcWNr8ONcdUk3tv3RdW5BzwUDCvDbBv2CleRoh2qN1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFiuzr2YU6r6Jvfu8jzJLvVeolMdpPojBsUjriAWuOGdRpBUzt3/b14XvtW6YH560Iu11XAIygB41bvOyrOO2dnwhZ2rpTrZVLUIm/jAe/+qXbl5SRsOmz+fovPKyzYMyIlswMn5ECZo1oHZJKctQxD57Z+OVeFdADKYVcQDngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Llr3y5I+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Llr3y5I+"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bb66c96a1so645196a91.1
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761935390; x=1762540190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=;
        b=Llr3y5I+97HxllqBCRtK5H4f0aJsmc5PViNZgIIYZiMPpVXG6Y/BxrJFjL7X3Dc2Vi
         h1cCj6yLOulY66SZyjfXdkCrDxWYQmtLJCZXzlG6OOhYrg4rJRp6MqFH9FS+fpbP6BZ4
         w98oW87ATaOMb/UaHNM9YpMv0gTbuFkuUhAqeoMyun4zHTiIc3bHA3dhr0qRwtDiIi05
         8cOegTxHcTAkdfvToqqktqX7wYia7JvYEnPVvaGFDWbXgQN1LyJ2wk+1HlbGU6git7Eg
         SIk6OxqDYCvJ4mIlsFXF54miGNQiskdLmGleOjgx8baXX20HlAtPahV3vxAo/lBTFxEw
         C7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761935390; x=1762540190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z55zmfhPZ/JH3r6Axk9zdxLaTNVRfIBYZwVYwYMTc5I=;
        b=ipginPMG1r3ONL1ps+0LSv8nDgD61oSDyk7xWKZkaAku2fHnn5A61xPzsH6GxnfSXb
         qy4MFV6FxXU1aLZD/kGekrJgK3d53gVnTRNLYqkTLnpKZk/XJqKMriTFRkeygjbtaNjE
         LjPiszg66Whe5FuikuEkv1jF+peLRo6pooIHRsYMKFcq28XViT8rYEFV2i3jMSmvFJ6v
         gmOCpx0O+q5L2RyvZePVtirT9khp/X5/daESdzTbzHd/+Qn2qXtx9hQzqepL4r964WFJ
         lxDQYVXERzFRxFU4k4X2xi8Vb7ki2I0+gGp3VGQYXrWtgV9KSJ03glxC+xwblOwazH0I
         eMvg==
X-Forwarded-Encrypted: i=1; AJvYcCWeui++fKW91lc3iWZ9g4LGPZfO1I6eTa03VtrE5peYkzvNJZGyI7pEGNUuJyxvVRwBEdKGBF7L9Dm+mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bWnP0yHO9PCIap1wjWI3QPuKAG8w91/my1mfR5/PgEolHD23
	MokdjWFeA4hDtsy9dehBrQ3zsMqSqdrVnIYOx1FKWP57SnNBCaR3Ldh8bxOyojILT8YrYovQSo9
	z4PVhfJfNh1JWT9NNKyaIXF+qO0OMopQf8d4FL+A+Sg==
X-Gm-Gg: ASbGncs44P1RJ0VfQQ1RyBzuFKTheraCNzqyxAerhfce7IWOJikSdF57ps8vlr51KUC
	eNWlykqrGGkfSr47EbaKui7AUfhfi7KHMn+5paPQhO4G+FVqDuVV8FA9e79v7ylOqQxBmvhlZkL
	44iMrdKrnxSpQqUyAe7QOUlU3xUXroTAiVrDkjRqZQ6c8ApfaUb7NS2ogmpEi3mOA1ljJfzJxML
	Vti1nupgEwuBEHKUvJ3l0gdnRG//dLShwTQX3ETzNgW4b/LAHIjQ3kmG8RB0kjBnjiSscctNQO6
	HO2UqyzpnPNwegYpTwIPgFm+5yLtvw==
X-Google-Smtp-Source: AGHT+IG4bOkdfsFJZblcFZ6qJHvTEYrpwiVlyRYTXktlwfAYyq7KD0P/FbFEhEndkdVv+NprV5snVBt3nCQR/grG0qM=
X-Received: by 2002:a17:902:ce88:b0:290:aaff:344e with SMTP id
 d9443c01a7336-2951a36c31cmr37241305ad.2.1761935390144; Fri, 31 Oct 2025
 11:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027020302.822544-1-csander@purestorage.com>
 <20251027020302.822544-5-csander@purestorage.com> <20251027075142.GA14661@lst.de>
In-Reply-To: <20251027075142.GA14661@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 31 Oct 2025 11:29:38 -0700
X-Gm-Features: AWmQ_bnD9cmB_he1htZLcay_wVtXtWzu-O7fBpjGn-Ny_vwA3iif2bU7bDu7dec
Message-ID: <CADUfDZq88mkARUOx-RQw72dwkTc2EB+0KiBtC6BL66e4pgiZxw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> > +static void blk_cmd_complete(struct io_tw_req tw_req, io_tw_token_t tw=
)
> >  {
> > +     unsigned int issue_flags =3D IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>
> In most of these ioctl handlers issue_flags only has a single user,
> so you might as well pass it directly.

Sure, happy to get rid of the intermediate variable in places where
issue_flags is only referenced once.

>
> In fact asm most external callers of io_uring_cmd_done pass that, would
> a helper that just harcodes it make sense and then maybe switch the
> special cases to use __io_uring_cmd_done directly?

While issue_flags is mainly used to pass to io_uring_cmd_done(), there
are some other uses too. For example, ublk_cmd_tw_cb() and
ublk_cmd_list_tw_cb() pass it to io_buffer_register_bvec() via
ublk_dispatch_req(), ublk_prep_auto_buf_reg(), and
ublk_auto_buf_reg(). Since uring_cmd implementations can perform
arbitrary work in task work context, I think it makes sense to keep
IO_URING_CMD_TASK_WORK_ISSUE_FLAG so it can be used wherever it's
required.

Best,
Caleb
