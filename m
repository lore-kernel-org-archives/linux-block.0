Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6813AD18;
	Sat, 15 Feb 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739639913; cv=none; b=ikA15+cbJYS5SfyYzu8qEUNOuCb832zVeV9I13vz3NnB5bwC/mYsF1IVfl0ICsugX1zQ2W5Ydh8DLR7ZV8C7J7jZZkvURDq5t7SK+sVR5mwPcO6hZ6qGvnL7bAPizUr3AyLVszoqOF4AnDYx5gYQYH+kjAdbihlGEiDlP7U9gnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739639913; c=relaxed/simple;
	bh=syfhYjdXfwB3WFjAvZ1Lw4ojSBHHmfK0NVQrluGAilM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfCp6LMtq0o+s3MhnhzLAfTh5rVnA1sX2T4EmUl14mNldbarfm4zrg5grOqHOLujI7DHTnboDVQeXFriJfWO9UaLnDnbe6E6QGfCW2bfbxzbc9mD9jGbqSY0OW4YeNenrD+Fs/OpHpagPE5+aDWl9KoVr9yLQaMluvUN2dt0Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUbxtvZs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUbxtvZs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa48404207so6267254a91.1;
        Sat, 15 Feb 2025 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739639911; x=1740244711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y3rRk+gn9//zXPLARWtdRv3yS/t43lzQ1DoeFoUszLM=;
        b=PUbxtvZscBFYvGqlVRzbQJMcXvAUwnVZ12985iEXRnYrZ0pLCLylhCVRiTQlC+sn3V
         f4xl18qZQt/fAB3VzrExqyT/xPg0DDmq/Fuk0ViBlS4LINxLqPkJQIE9ZSQCUeSRQViT
         O7lXF/QHU12xK/NVZhz7MIYLAYSp0dT9L9zD9zo4HNl+s3xNgUl2xcCDyWTUX8RDlqHA
         kXA6Q0mOGW/vpFCFcDhpT+B9X0vXk96hUDcIYZsb9tN/6zB/MLA/lA83HCbYuSYaG87q
         bt9epCnkpmR1YRAfK8X9yY2tnEZAp/1pL9l2srmLlyuCBbgonTT+ffM7cWv6be8KcvmK
         dNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739639911; x=1740244711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3rRk+gn9//zXPLARWtdRv3yS/t43lzQ1DoeFoUszLM=;
        b=tK6HD1bH4PbYwPQUET0gXBb/AyhIi5GyWLJ5KBwdFExKrWQ1Pi+mAPStv6uK46Rrkk
         Bv4Vv23cPQSEOwTKnB/q9JZ27p8ohYYfkIEKYubIFsyTvV+ZZDq3qd4yGihuIWnGlL8u
         eWKkrm/SzawsPbtLw+JtXjNsOW41FwYcp7xLegVLxGSEk9BAFaUzg4urSUZVuK4ocN51
         BNPGwvuJupSCBv5q4zn2w55gOVp1RSJcYQNqW5NNDMHqMVT+siB8yeMalqyOfm5ix+ZX
         7lJtdHhf6LMjfVbe03fi/beOGbMKWftMSsVVLY4qIZF+mV250dH80wHCLqw3lycU0dlG
         CPJA==
X-Forwarded-Encrypted: i=1; AJvYcCUIvcu+YPqtUY9gXFCCZU4fbdjUrPQ4dTqpVS2OpR/9tCoD2wk3qaeKw2pn/0UC9QfLT1yvv1UACjh4@vger.kernel.org, AJvYcCWMQnafKdX41ER1Uvawb3XsJzPj+4OTflLHnWvWU2koxYeDtDPcMi2PIARWRp/fEgW2FfeuJWEvIlppXw==@vger.kernel.org, AJvYcCWvOsci/KHTWPdjYHMS60RwuyCZzOkSTBTvnJXpo/E9YNtmV8hlernRiEgcNppHoiwnAB6/+g4SVkww2ojP@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqvaajzt/SY19JUI2MAuAh8JtptxJ4ypPrXkDxKIdqdJk7JEK
	5wO/Wz2TZ8KmVlZfcKgvw3GHVVIRZAU1bDyUAk65vj3uzw0c2GX4El8PMMOmEbP0cjiWd2qMK/y
	bSlRHZ3eqZ3CdRZhoDr/m3yTrxc0OxP8x
X-Gm-Gg: ASbGnctlGWaDj41BUTPPUh57GhW7GTliHl9vxeTbdjA8SP5d4yM6cePQXN8c5/FbCPW
	Z49W3sBTvLwb6jV6yjTBcBZYPEqDgMeN7ez2XrOwoo8tb6Cpl27uiSYF7Aej2WsZaY+jIGFalaX
	P7pW9d2J7dTz2mZ4hVUwKKrKEC70o=
X-Google-Smtp-Source: AGHT+IH2zdiRa2ZNSD2zK+ox8iI7QVeC+t9719g4kVI01lpqPix3B9a0iXWsoIjErPKlDujuZJkGpsthWiW4G/CyLPI=
X-Received: by 2002:a17:90b:4c07:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-2fc40d1245fmr5580596a91.2.1739639911180; Sat, 15 Feb 2025
 09:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
 <20250214051432.207630-1-me@davidreaver.com> <CALYGNiOU3vPAyvsNv4rt=qZRbZFVZ9iAe+kzPzGKkx6_L3wG5Q@mail.gmail.com>
 <864j0wxw74.fsf@davidreaver.com>
In-Reply-To: <864j0wxw74.fsf@davidreaver.com>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Sat, 15 Feb 2025 18:18:20 +0100
X-Gm-Features: AWEUYZnG0tSbZyT1TSj-Wscf2JYcJrjGbDJVy2WzG7qo0-hz7fiqnDHwTzWS3hg
Message-ID: <CALYGNiOA4K4PQcJTk_OwkHOamW-Am_gKSUZoog41v+Y_+qEQxg@mail.gmail.com>
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
To: David Reaver <me@davidreaver.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 18:39, David Reaver <me@davidreaver.com> wrote:
>
> Konstantin Khlebnikov <koct9i@gmail.com> writes:
>
> > Wraparounds here are slightly more complicated than simply 32-bit or 64-bit overflows.
> >
> > Internal time counters are 64-bit in nanoseconds.
> >
> > Values are converted into milliseconds for printing,
> > also 32-bit architectures truncate printed values to 32-bit.
> >
> > So the common trick: delta = (long)(after - before) does not work,
> > because the time counter wraps around UINT64_MAX/1000.
> >
>
> Thanks Konstantin. What do you think about just removing this entire
> sentence? It is mostly tweaked from the old text that was rewritten, but
> I'm not sure it is particularly insightful. That paragraph would look
> like this:
>
>   All fields are cumulative, monotonic counters that start at zero at
>   boot, except for field 9, which resets to zero as I/Os complete. Other
>   fields only increase unless they overflow and wrap. Wrapping may occur
>   on long-running or high-load systems, so applications should handle this
>   properly.

There is another case when counters back to zero:
device reattachment or reinitialization.
The device itself might be the same or completely different,
but statistics sampling will see only restart from zero.

So, maybe rephrase that counters sometimes restarts at zero.
For example at boot, device attachment, or counter overflows.

>
> Thanks,
> David Reaver
