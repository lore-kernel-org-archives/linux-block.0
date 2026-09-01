Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514559B56
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254011; cv=pass; b=CF3RiuA6j+xLbEhJvWaV8ldUXD7VJOPDQ1lWflz6oj7x1fpDGN0qMLsgOdADkxZy2ka23EpzSe/ICrjMfKzrLC3n84A8scczeayKrf9FMfpcNuwgKl1BmPgnSFqHd35vl6j0AAQFMY0o73x8IMoWEvapOY2XSnf+YMH2b9deV08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254011; c=relaxed/simple;
	bh=vpZBEto8PoVWCX501jJbndFd75E0wS7eccM0P5s5MNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFP5kjn9PmeYE5Sm2Wk5Z6O7fgiWTcN2FSaca5o47uVJUWYLF8A0mrwF9e2R0S1n+5Dfuot9Yu1stYV8tfYW5MOavOQ6KYl5z8uRzTfclAkeRIVSvmsVJDosLuzs51e7sx9JAOcRc5Pw5fFW2nVs7GskcWS6E+5Cz5v3iIh/GtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ+mdyBN; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ+mdyBN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c7962bdcso525972a12.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 02:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788254008; cv=none;
        d=google.com; s=arc-20260327;
        b=Eobkk03G6SQ3QnR3X/gtA5XBG9qkGKa3ngExg+ze1HI4FTA9zaLrULthp1fA/T+LzI
         9f75rUMrGC3l3tBvp0v5+DxlgiOYdWIfj8dpuZZcR9Put4jz2IhQWYmTVHDnwUc3SuHj
         0BO9oihXDWGup61rAqyQhzoRg7XVQR4sxZ9eY0I2TsySYefS5fmU7L8xYl3Vy92rrQO6
         ROle3cam8Y6xOIgUwjthse0EJJYhQzZAH/lMSfq7D49yJYHJ3VwkeFhQi+VlIGoH9Lmd
         xFcb1RANbJ7KvkJNNpjZmXYg68uebUezVlZG8/Jc+PMk/sTjEB1adjrTLMGV+cksPwpK
         pUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vpZBEto8PoVWCX501jJbndFd75E0wS7eccM0P5s5MNw=;
        fh=+/3AkmUdVyoLg1ANcKaV3atFMuMtH/eG1BveTS2WqsQ=;
        b=iO033ykHj6PcmVJRcjXHET/Js0JmnIzkGSKL/Z6LDi3JVoHtNsjtuzI+NqvH8ycxy2
         Q+h2ZK4NchV8jxmVExbMfolHdBxN9JL154dEpQ6HP+jp0WQ8A4ktdluAI9LpSDqQYwls
         awC1NHpE5/CCxjLiigXQ3fi86JrASM04Kixyu95iQGB6ykGuCeszAfFBDRHy5JCBu9n4
         NEfmS9TKtVOIfxNqnxXFDw57UOH+yYeSJ1NR3GyQNu2Jb/kRXE6EsDDxKWv1fQQlfUpB
         CgnDqEKTseRQDCYyLnX9W/upLV90RvcjTu7LQeDyfeKmSYjuQIwMF/Dm68SICwXHLMG3
         Yr3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254008; x=1788858808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vpZBEto8PoVWCX501jJbndFd75E0wS7eccM0P5s5MNw=;
        b=kZ+mdyBNwGXPB71ZOD5ubeRlNeoMjjm1324iN6VVXQkvPXpBZOKXGwe9aGz315/qq7
         DhFxQcy2jAL0m7AR6gbdouQyb+NdCmCFlaCQCtUec7n5mwftziRlyOtGCLtRWjHc7P7Q
         E4K0m4plTvyvZZ3YfnZDYbx1hTAaSP8TtJkOBxL1yG/WXZRN7LMS8RCgfLMHKeNU4EpE
         ufK18YM1bMOtoyS2wVU/J1IYbcNahUHBv/MFeymV227UYQuzT/V6xGcLvluPmBXfVfbb
         g2ZZlMS7h08VS6Pph3L85s/aXi/xtodluv1DN32yg0Xr+nJKxQORiav+nY17CWAIG5YZ
         CT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254008; x=1788858808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpZBEto8PoVWCX501jJbndFd75E0wS7eccM0P5s5MNw=;
        b=bSqR16Ma6X9Km+cWE2UxUiQCMMzHwfbzu8flWHu88UByFu6oWA0+lrsVM0OiSzOU7F
         vOvV2LaRo2cMeA8BZ1HDl43S7p7V8uqcOX6OdyrBH0bUYlzpgaWSIAmS+IixdDwmIBsh
         vlsW/T4cWjD6wn+PVdPoBmEGizzZQ/Cy7Xw18up+Y+PyOTPkt9MXwSES3fks3dMZtz0y
         4wFtlU0gFP4kBIq6809sEwXHdrHCFRTxY0NWSD1MHBgrH75IlWT5b/3rQfyjgyDIpEiD
         yIg8AAirBXCUCns0YIeokP9iZqscnBJid9hyWYKkgsv9JrUmiF0cwYgfRGYEj57cMGE6
         c3Pw==
X-Forwarded-Encrypted: i=1; AHgh+RpGfVt7r+pi4rMxytSoKSmwgRPX2W1J+Pqz4ANLPY9GEfkL5egt0OlTS38sRiKqm0uFrwzGbnybGDDiTA==@vger.kernel.org
X-Gm-Message-State: AFuF++nuO7AEc0G8tBM1j5GAMRJoCCPBcQlkhaLkghq8HxNR0eDxieNL
	lE7HxuqjHU1Jry0HyXyXgu2X2DRqty3tk/3dv3axneggLerTQ/d9zt4kbA3zLLlPbSQIkdPkWuV
	ZOtFClI8NeL/O6VkpWZiBbgZM9R7sYp0=
X-Gm-Gg: AYBFou34NZ7u5sdKyRKSvPOVIriwNZWK1FoeF1qNlod1VHsu6m0ZNwU2Pdf4kt9neWZ
	FgYsFH9qEe0iCixIKw1ZBhqb+yXcv73m5hGuY7PpwerDjoha9VTWssaQMyrejfKvjsaUqUHWi6D
	HMb/4LFNWazni8p2IIXx1dRbNmgzi35KtGBQyyO56nCoIxILrLhElYeDeGQGy6oGv1itIqATtt1
	9t0X+sgwc0GgvpmhBe2FKbhVTZjoVVxgqW3okDCyZrlrkHXxxIHME5VZx+f+cJpsWUoYx5DB4Cs
	Qjbqa5hWINTWuomuHBwTNwrYtO6UTf/Fi7Q1dRel7OLiusbKvcKqMoF6s0587CwFYjJluqfVZeT
	/rpCFLiM1AGJPYwcN/7kLIdreJVfSu6VaJgIkkvQAX2s4nlRq/am04y3cW3i1bJRoeUi/ltc=
X-Received: by 2002:a17:902:c94e:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d74ce5e476mr262988545ad.0.1788254008481; Tue, 01 Sep 2026
 02:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eqzS1cYG2bYJ10oFrfX_D7UVNqb_NuK3wsMUUEXpdBj7yCtzD24WOzI8zIKg2FlD04VFp_R9xt65fGmEqpt6QA==@protonmail.internalid>
 <20260831-fix-gendisk-block-size-docs-v1-1-900546005799@hotmail.com>
 <87ld9mxxec.fsf@t14s.mail-host-address-is-not-set> <SN7PR07MB9708ED760C7DDF833BEE80E1CFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
In-Reply-To: <SN7PR07MB9708ED760C7DDF833BEE80E1CFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 11:13:15 +0200
X-Gm-Features: AcwNN1WeTomQFbbl4m_DFvxroJZ1wjKX2oKzXiA5vqp9Wpi2S2v6pF4_O2NjrD0
Message-ID: <CANiq72mC6uUrjHQ7Cz41o_=+YPBobf5TX4X43WfDhObaCRBM9A@mail.gmail.com>
Subject: Re: [PATCH] rust: block: Fix GenDiskBuilder block size documentation
To: ai qubits <aiqubits@hotmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Sophon Z via B4 Relay <devnull+aiqubits.hotmail.com@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 4:00=E2=80=AFAM ai qubits <aiqubits@hotmail.com> wro=
te:
>
> Thanks for the review and the Ack.
>
> Understood. I will leave this documentation fix as-is for Jens to pick up
> and prepare a separate follow-up patch after it lands.
>
> The follow-up will add a helper in rust/helpers/blk.c for
> blk_validate_block_size(), use it from
> GenDiskBuilder::validate_block_size(), and update the documentation to
> avoid specifying a configuration-dependent upper bound.

Note: I don't think your messages will be accepted by the mailing
list, since they use HTML. Please switch to plain text -- thanks!

Cheers,
Miguel
