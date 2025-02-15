Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F714A088;
	Sat, 15 Feb 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641629; cv=none; b=HwnVykdlmbHn6bJ7Yzl0P7xrBkzmwxGZU15a/DPqdWHTQui7+iGpY3F0OIavgx4p4okHagjFkMunVz/DaQTatNnuBlyYpQOol8NECblDtVDz7t1hTHDhMY/v9khTm55EcdTAvdp6jnxoALakq+e0+Pwp4UEnh7CpqNjBbCbK57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641629; c=relaxed/simple;
	bh=oOBPZyyf52OdQZQ09D/Uy6cKj+j1H+ji62n2n3Y6L5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY4S3+36bbvAc9LWdoBjGigotj9TF+BzXk275CFPy2ms4VDWXAsCoslaClqIFWL/vetj8B6x0DPOSY95c3OFNMclxNAaYwWBwkjs17VPhcb+0wTEDG3wwYkqhHuc2fVBlc5+vGn3okQrFuPkjAeL+HfBw8w7bx71hMjbbRRM2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxt7cq6o; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxt7cq6o"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc3a14f6fbso1632347a91.3;
        Sat, 15 Feb 2025 09:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739641625; x=1740246425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CHrwj55hYujOmPPJW4dyiRQCDEbehB4pQNXkrWCsbOQ=;
        b=Uxt7cq6oOeeoIfvvKKr2ON4bZ9UQ9+Vuzk8ykgsZStuXP6j+herXXn+38EvZOo3BPq
         7bBEruzLLNH4L9z6P0t7PHpcnq5sZ12Edv8hafLDnSBAS2wEqSLQkh4Y8TPMRSAZl6Ls
         VgAN9YAbv9Bp7SXoIA4vO6JaiSWA6o1/BcHJ4F5KhcTyix5yxmuktw6u18tSoDSmuKex
         qz7pCKr4NzhuKf/fMpzpL0EO5JIXbgRXSCssMLjxRqj8wtkhPwh3XwT7p/kIRKw+4RJU
         SnVsUN52wMjsCRbWVz4jO/0iBKK/6pgJ5qltYcOrqsaGnaH7UB6VSohXTOyo7pEvc2X/
         rmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739641625; x=1740246425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHrwj55hYujOmPPJW4dyiRQCDEbehB4pQNXkrWCsbOQ=;
        b=N0aMt4TnnZ5fzZIVQTF43uXxUg+iYF2Yte8II5OvYUOOW5FNNr++TzDDy1XnsMAJj1
         kJVuRniucHejj+uToa3zE9AKLJX6zIllHcmgj3C+jdmWyzAgiUo+6QcfbRuwbpKlixoG
         LeQ7NRIoKymARiBNvtijpaL/G53Qxnef2D7qgh1pPJYR1Obb1nXqjdmOhEAG9hmtDKGm
         MueNR5ZnQd36Hq0rL1tshUjGLibZM+wmm/aVWlHk/XdQbWzGyoj33T2Raszn7XLkC9HQ
         C2MAeYPAxArJb8se9QNh5NjjfDwxyBZx1j/aB4BXOBVXn19QRzULJJjRAA5qPwMSlQfT
         t1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl0uWf/W0EnOkuTZpVzUAgbQDILsNktUHhDl56z6jzTt5jzHta4GWLy5tKlHijN+T/c1SKwlTIhhncpLYG@vger.kernel.org, AJvYcCW25ludK5QDMfU4BcV9Y/iBDcuH4ZWE9EVOsVgWv3+RKWFYwU6+zK9Dt4avTsnCRKq6/y+5nDNzvGmk@vger.kernel.org, AJvYcCXeZsatyI7rXD4igyae6c0aaInLf2Mo640V4/uTAwAx2h4L7cP0p/BTn2qh24oQm9jkQSqHxh0tmfaEyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HUFLkEUhjE/UOf+FWKymeUG2kWjEmJHlAtE1YW5SBqfI3pVs
	xPggsX/s8LRvlMg+I2QK0S1RXG7J70kozScO2dpm6jrw+bg7nLI/Ry8hkBeuyJR3y0oodv4M/VL
	pwIMBYe//C1iZoaltUyK0+XMiZkI=
X-Gm-Gg: ASbGncusgsYfnJX3H2PCrLnK3SJh8agI/OgKSv6RuiuC5/MlEE47woLC314bGlzF+N5
	ZbY2/IwGHXSupdi2tU0tp7YLlpmTv+qzhGy7kQ/r/xG848DHcWFo9MbyVSzAMzszEL2DbR5eYMc
	m4EVD6s279cAgwHOkReaHOydPP5pI=
X-Google-Smtp-Source: AGHT+IFJRuWHJHr54eFbHJDxTgNotc2rEcXtrqXT/iMZy9OZKRszwKqaS2xKBSQCdrSRsd9LOw3u5xR18ErArCUkClM=
X-Received: by 2002:a17:90b:1b46:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-2fc40f2348fmr5047864a91.21.1739641624796; Sat, 15 Feb 2025
 09:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
 <20250214051432.207630-1-me@davidreaver.com> <CALYGNiOU3vPAyvsNv4rt=qZRbZFVZ9iAe+kzPzGKkx6_L3wG5Q@mail.gmail.com>
 <864j0wxw74.fsf@davidreaver.com> <CALYGNiOA4K4PQcJTk_OwkHOamW-Am_gKSUZoog41v+Y_+qEQxg@mail.gmail.com>
 <86eczz3yln.fsf@davidreaver.com>
In-Reply-To: <86eczz3yln.fsf@davidreaver.com>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Sat, 15 Feb 2025 18:46:53 +0100
X-Gm-Features: AWEUYZkkSgAesRnLhbdfwgOPAyqQW6W9RYGSmpBBqWRBF_NAPrJzIwsm_y4Z5H8
Message-ID: <CALYGNiO1sbk-Z8MU_axDBWK7U+edw+yEU9mMTDDS3j9Uzj81qQ@mail.gmail.com>
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
To: David Reaver <me@davidreaver.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Feb 2025 at 18:30, David Reaver <me@davidreaver.com> wrote:
>
> Konstantin Khlebnikov <koct9i@gmail.com> writes:
>
> > There is another case when counters back to zero:
> > device reattachment or reinitialization.
> > The device itself might be the same or completely different,
> > but statistics sampling will see only restart from zero.
> >
> > So, maybe rephrase that counters sometimes restarts at zero.
> > For example at boot, device attachment, or counter overflows.
>
> That makes sense. How does this version of that paragraph sound?

LGTM

>
>   All fields are cumulative, monotonic counters, except for field 9, which
>   resets to zero as I/Os complete. The remaining fields reset at boot, on
>   device reattachment or reinitialization, or when the underlying counter
>   overflows. Applications reading these counters should detect and handle
>   resets when comparing stat snapshots.
>
> Thanks for your feedback!
>
> Thanks,
> David Reaver
