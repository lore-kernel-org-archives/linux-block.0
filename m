Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7B209695
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679576; cv=none; b=P20QvcrSoO540x+vwe8R82KoAN2qEjfJmFpyH3XdVeMtFPn2zC3A5kqL5xJxdHR+jZwgCBjyVqddGc0OsN59VlSiH5yBOvNHSFAzDqtQz4c7kp3rRkMaYGZ7rs5N4AxQzwlRpnA+MIHsI9zV3hs18qLWFeMBabnUDGb3hzugzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679576; c=relaxed/simple;
	bh=AHE8n1YLEfuEjPXDpyIIy5ce2oRcD/56OodQgcupGJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCsq3uLt3EfY9pioTJoXWZQYFKiFf0nUqojrPuMgBPlpqhB+oh1OZaMKCv4fwU7tX7EpEGNRjOQTwdVPRsUZ/stif51y05stNLgvb4oSMd3dMp1L3mezxMHW7r5Po9cOrFZshGud7VIvkqOELEe8OaxKDti3odR276M+Y3rzmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXUIYZtL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXUIYZtL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21634338cfdso40179775ad.2
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2025 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738679574; x=1739284374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHE8n1YLEfuEjPXDpyIIy5ce2oRcD/56OodQgcupGJE=;
        b=HXUIYZtLxsXfbG20KzVWG9B+mpvkcPMW4soagFfdD4CkGVNvp52zyxOKN5/0fV3lFH
         CG2XmwTzXqWJkfZu9qtCrywrQJKI9F4zgHjRupB6FFfxGXvFBHYhlD6urxHsQF1FChjR
         isGFpPMeJTh6AHemzZgWKmfbyEDJPgazN3I7JbxJZ3TKT8tkEzKiwRxsM20RACpB0vUJ
         ZG0tbv/xDlqqjBoyjTT955yU7JhVAxVaBIOsAvOPfIDKRo+TfOzqi8wgq/41JJ5xrhZi
         N2mHyFotrkiIy0/thG4ipXPt102UEl8m51wqk0xPHq8Y6t+wfOgnB6yNKW/fEwm/zT2C
         h4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738679574; x=1739284374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHE8n1YLEfuEjPXDpyIIy5ce2oRcD/56OodQgcupGJE=;
        b=GeFBbtVEl13CIGac+nQz96EUIbAfniVRebBJ4rZ2RgvX4FRwfRwcvErkAuYL5VmNIT
         x7oFtNZe8LVqkDv1/tsk/z6PcYm6oF3sF1hKcpHzl03ptr2H95UzZCTmfNdEXwgVnX7h
         gPU/Qtx/HGqnFGSXpCo9H97fj3oeTqSoZm0PQ+Mw9XuBC6/Uym8YwQgHT4RO/LfcpG0e
         qGjgyx0xbQVqFsdRNLnHm/v3FzvGowxDcdC11GesONTcCkI9hJ3sqgazQpnqcSM6105/
         xQ1vHHP3Q1G6W97i2+WpLlrLdIlwdTRrB/+IyAr33JgZG4cR4ksaZdyJpt48YqkzZkYI
         i8/A==
X-Forwarded-Encrypted: i=1; AJvYcCWT+o4YZXuVwai0cG5eXkiK61vvVOeM/uOQsO0wmrJz16l4dAfJ5yj3llyAXFuHJ95RQJUZHgrGs1LZsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkfzzt7FkNlD1ULIGypJ4D0ybDYV3TbBDqHFmNKv81eV5hV50Q
	LVsCKNGrF88702D94Hnhvgc54FNt+OfOVrCiUiBNJU0G8AZGkXMBDd6xonvO9WOZqP/S0DbD1ij
	1BZ3cPRfg96p93yHjWOgk+7fvaHSTqQ==
X-Gm-Gg: ASbGnctUXhj29OI2heLo+z+Kz4yyPSancSkd3F5u+tMitM9MQdkzktBn8crVinAThkv
	cVTpaadd3BY0wZpx5jldET2GcgjxZCHJuSaAjRK9DFxX0X3sY60CWATBVlFSrvx/gdCEXaw7mXw
	==
X-Google-Smtp-Source: AGHT+IH3vVd6riEGsRqrBE4aHhNXyhxhrchDw5HzGe8jKbB52qqRwSTZD/4Dmul5uQvZZSKzKNHjbO4Hf5oSjdpcjgc=
X-Received: by 2002:a17:903:41cc:b0:215:a179:14ca with SMTP id
 d9443c01a7336-21dd7c46c61mr393300435ad.2.1738679574144; Tue, 04 Feb 2025
 06:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu> <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <20250109155119.GF1323402@mit.edu> <Z4DhK_JrkL5jn5P1@infradead.org>
 <CAOBGo4y_zo08BX=hRYsAQrdSfaLfn2kMci+Jk1R+B1-kjzsX1g@mail.gmail.com> <Z6GjS9rOmm4el9Za@infradead.org>
In-Reply-To: <Z6GjS9rOmm4el9Za@infradead.org>
From: Travis Downs <travis.downs@gmail.com>
Date: Tue, 4 Feb 2025 11:32:18 -0300
X-Gm-Features: AWEUYZkscOPBhxYDNpAHol17kAMjfOKA3s61yI0V9j70940P5SNZAGuOHgdbzls
Message-ID: <CAOBGo4yahoPO-PTvFEAWWcnkpvz772MhTpWT7Em6==Dt7erYDQ@mail.gmail.com>
Subject: Re: Semantics of racy O_DIRECT writes
To: Christoph Hellwig <hch@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:19=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Jan 31, 2025 at 05:06:50PM -0300, Travis Downs wrote:
> Yes.
>
> This is all about direct I/O.
>
> > So is it fair to say that for direct IO these types of racy writes are =
not safe?
>
> In general: yes.

Thanks Christoph, this is all very helpful. I appreciate your replies.

> >
> > Specifically, we are looking at behavior in a 3rd party, proprietary
> > block device
> > (implemented as a kernel module) and are wondering if these types of ra=
cy
> > writes break the implied or explicit semantics of safe direct IO writes=
.
>
> I have no interest in helping anyone into looking proprietary drivers.

Totally fair, and it's why for this list I would frame it as a
question of what is
the contract between userspace, the VFS layer, the FS, the block layer and
the block driver. Having that well defined is useful for in-tree
devices, out-of-
tree open source devices and, unavoidably, closed-source devices.

So I would summarize the current situation as: "It is allowable for any FS =
and
block device to assume that direct IO userspace buffers are stable, and if
they are not, there are few guarantees about the results of unstable writes=
.
The generic parts of the storage layer, and common drivers like NVMe block
driver, may today provide reasonable semantics in this case (e.g., the
unmodified part of the buffer is written with the expected values) but that=
 is
not a guarantee and may change in the future".
