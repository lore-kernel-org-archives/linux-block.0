Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F44389115
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781347276; cv=pass; b=cajCmTYlNx8nulBjj0ZNqp9BWJqgGn8p8fuYLwtGZoPVEL0eTdeqnJSN/kmLhITmX3I9GFvOg/KLii6H1AGZ1ZvrygaXmeNlDPKQcQ5apxV78K7Y5JX+bTbvBTA+O59+noCASOkUKv2NlVE7YkUXdR1mwjLRnJ4birJthypCHqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781347276; c=relaxed/simple;
	bh=7k6tbN+HH+WkUq4HSNO/mcXSBNU1lROqmA4mfJkiWzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwxkJupkz180XN4uue5z+0uqfODUi15WrrXFatXAlUBkMEAMkItaQDuylNrsa+0bHBFtOLMjcIYisovj2e7M449e0a+g3CBDpOZiedsNbuBSHaIjNaugHFW5l53cgafSfoGnjyMf2qTPhEoOo8AvgP8yB8c5UTuaMDbMf+c5gqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hggXMU4p; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hggXMU4p"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-307b668e1f5so158993eec.1
        for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 03:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781347275; cv=none;
        d=google.com; s=arc-20240605;
        b=TcpwIZEUk6toYmfyvKw33NWpRU8Sl/L63F4LxuUs6IIG30FFm+DcEjKrYTJby5oeGN
         RvQIlZwCLKlFyAl6P5ZUkvioVj7fHGPpyrFkgnkKvMPTLMdIj24zqHSPDREexsLCL/Za
         NidZUXsCiiCNBxn3seR+6xoW205pCboc9lsR7qAkagNq7YlmEMgqHhASKfLxKW3T0jHs
         LuxDIRVs0aKEUrZHBNoBHJh1xBuC2g29p/CSKbGcvGc9pPDJEHjKqLI6KlzIl/uT8tJb
         6y0d8dNKKNrK4/ZO9TK8WIZ2n6zv4Kqiwu7MikbSlty1A41AIRiBvuPNvkUhmsyaBGaO
         sZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G548kc/xuN9FYSMWIgZO2PFN4NWhwpWrdwSftDKzZuE=;
        fh=MFqtzJVbCKM4fl1Aw+IGaUHQBbywyTHrkh94TiQlC3Q=;
        b=b4n8YEjBWjDP2Y5JMo5KWrKeMdxm+8FcRIImmHSNEW+vHAip+V81oEJKpTtd5ktoJW
         Q00M/cChWcEomDVKXimnFxVGylGdlt3wsIkTLc0DuoUpUZx3QqfZLiXrAwqTTaIntUS9
         +57y2QDPtwxyqslg4wXlXpKSAv1pDKW2KoqYQtTtroL+C3Am6LVIvWFF4DOGxoJZ1fyM
         x/ewk/nxd+IeFJ1wE67yxKxeMx2+We75pPSyuevQWLBy6Open1Z2foxJYYPRWMUMUmyQ
         nwBOPklZBWcAojKBodttoGOXaVffqWdgv3oZiSVYASZTXz6j/MfkfgiUxXG1H7iOQJLL
         I+0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781347275; x=1781952075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G548kc/xuN9FYSMWIgZO2PFN4NWhwpWrdwSftDKzZuE=;
        b=hggXMU4pAdKn2lZVKQNgKjiSta2uifLDJ9Iw/l48crsFzrm3pbnbxxy1To2ak1jByT
         FsTwmGAtFUqq3xR5x2gmKgtlDFR6VIyUeIVUhyC1mv0lSQ2DJYl9aUHrq0Tn2vgbhdyD
         64MYLIERBYdof+mNse5jpRn3OOFgL83vhqj8wJobew/GLHRIadj/qPqfBvx2f+gu22cB
         G68l/HyYn1KEFja7mTg3a7a+gg9VZadaOpmNwO+Rv29lokcfcSpp6O73hfztkdCDV+Iq
         SuEmMC+UyKiLEGR/ETfUagX0rgZ1wJCMFxhRnmJd3XM3po15eqBiGDd6sa4rfqHAzYSQ
         mLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781347275; x=1781952075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G548kc/xuN9FYSMWIgZO2PFN4NWhwpWrdwSftDKzZuE=;
        b=jWkHC19H5np8+pCnK6UZPkUTbiiOJbXlUUKv/IzsLolpDNM4IFmrAf1vRBSY0FAnNF
         gaVXkUOOswwzjEouoaxsWoWx57ntL+CexjkgDZyeEXhBXIpc3ur0pQyuZTSfvlquyO/8
         2WRNSyAJnvXgQ/AnW5HgHvwID2d8dohfvLzqMr4VXzP/mMvaUThhCfwY8LhpaLilS1yQ
         qxim2wwdagh8Z/tCTvnthjKeNEyGuzQatgaADUgId4kRvGXrvTGTeUmDxT1H1poBPAug
         O5UbGmfz73+yM33zPCecWDbLkuzwRZpfQmpbb9ZIVvSHA/f/WGSgckm7C1rlsA8UEFG4
         X00g==
X-Forwarded-Encrypted: i=1; AFNElJ/n6PJPIJ1QpyMPIoUWMPDNyJT4tuDJpOcsSKCMf1a9FQAipB134fycce+FI4CT4hzJmbjz78AZY92O0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAS4LqAUio8Ha8ImfES7J/0eMMMmD1TGLyGQVu0+DqHCY59kI
	BopjW8oq3hV28NDvGj/oAnHruOTHaans54XjNzMjzkwsTzZa/9e8s64HwwszeEHYnsdDedCLH0H
	OTo/IaBDAa/1v0/q+ZjBq6hWPBa94pHo=
X-Gm-Gg: Acq92OHsKp3l+NC+ttYspEIcLsPn1K+dGABf93jGiW9zwG/sNPsVpWSQgIaOd9YILOB
	ulgtwb36DY4dJIesszHA6FkAibbi+ghpm5srCKye5PQ1C8y5PYstLcpXSokoCUZ6gYEeKYBOude
	iyz8Ke1rog2Ebj3ffk3ibgEUPu+rOFeemKLdnS+aWE0+RB61Yn6NDemnqCpUQtDLfCz09kzgMoL
	tjOx0Spgnfv3tMLwlsUonMyVuK5GsU7Xaiy/GV51bbTqscKT2dU60yY5QjIHeTE2Bt/M85Il7YN
	2Ogvpx8WVX5oTZVzSAzZfTMQj4UwERzPQgIhNvilexZfPo8DxaP0JyHvJdu3j4iv/LG2DEkoF1m
	fUS4SFfKaUNeqDbEEBZ0OklkTKgRIVVVzVA==
X-Received: by 2002:a05:7301:1e84:b0:2d8:7302:d3c with SMTP id
 5a478bee46e88-30820037738mr1755166eec.4.1781347274604; Sat, 13 Jun 2026
 03:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
In-Reply-To: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 12:41:00 +0200
X-Gm-Features: AVVi8CfjPkD66q9qYEn1K64zbUlvP5cZCsx1hvccWsDn4EDiuxrat-r8eY-_Akc
Message-ID: <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs attributes
To: Malte Wechter <maltewechter@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Malte,

Some quick notes...

On Fri, Jun 12, 2026 at 3:29=E2=80=AFPM Malte Wechter <maltewechter@gmail.c=
om> wrote:
>
> +/// ```ignore

Empty /// before examples.

> +///     // This will extract "foo: <field>" into a variable named "foo".

` instead of "

i.e. please use Markdown

> +///```

Missing space indentation

> +/// Expands the following output:
> +///    let item_type =3D {

Missing example block, both at the beginning and the end.

Please double-check by generating the docs and looking at how they
appear in the browser.

The prefix of the title should likely be `rust: configfs:`.

Thanks!

Cheers,
Miguel
