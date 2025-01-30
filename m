Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADE9475
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229616; cv=none; b=f18F5k6jyAVbD8YWoNZnCEslIAhKajxK8mElCCwUguxAN5HkAArySBnfX5Q53Z00Io64Kz/4LJrlbrxI4PIb0fsSWFcv9BsWVatoaNDiYvROZ4A839rGRvClWB4GzT3GeBbrORfOYn24uUt2xrmjrpfDdraV6SOfptBUryCttx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229616; c=relaxed/simple;
	bh=1qRPeWJwUk6jecZQ1Nqw+IItMRbgIk71h7Wtu9diJXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy6UE3lxCli6OxGEQY6TZjxhBeJ5k/QlTeE8oSb/zJppargewMtZqlXo5OlOzpD9pISIDAxK04FG+n4flM9PelB8ozKhMsREBAjaw9LsdF+63SajMOhWt+zvFFP1I+Yl4TlTVm1dPXWpmwxQwfqhZiJbf0ZrguyUmw0fJE1C1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YxwGX0eu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YxwGX0eu"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso113687166b.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 01:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738229613; x=1738834413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=;
        b=YxwGX0eu9HjMWqrtTE0YNbkwulzknUL2z8jej+4saqNW4aQchWlGkhuUxvF/zy43/j
         E1yPtBNld1F9MDn/ow8he0lSbfFT2uDvpIsnV+LjJxzM3qQ0cnr2Hwkm0FARxc0Bo5IW
         64NMNdSce+hReZcJuCjTfYBr3EYQpb92EY56oETs1KwPT5nPD+e+BHZn5GY2Nt5GspL0
         5pTm8NchbYxRIHYcDwdzG39nXcbuiNfPXArlaRaoDmmkRED+Ku9qPUB2MFoTdo+JbFpF
         8idRQ/e0EO5J9NHiwFbTCUFN1V+YSXZEkUDuFrrWSIsJ5CUeCtkZb3L0lTrZFFeR/hpy
         PHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738229613; x=1738834413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=;
        b=a9p4Fm0OzECM2cL1KYXylceQwVqKfgiogVm8Z2408qUoEJ+FBZwagID26sOLYoFOIJ
         auUcpayr8klM8PC8g0hY5OJ9jY5uRAj0vZ8uC1hYXqQ4Xc5FLq+StyZaWRs7X1+pQaan
         +i6uOb1pQ84IxY84Q0qCBst+Kwi4hXQlb4c/C6YxC6ZQpmjU8uosfmb8zDkW086eA5VD
         ZuXgJhNkZG99amKDAeHWAm1MKEVoO2/Xdo2Iv7B+DhHxZwrCPiMF/1C1KVkXfnGdAKD0
         gma9tXHsVqAss+GraigiX5kU50oWu1f/u6DdBW1HpkV6YpjWecCV+dSRFoYza0C9LAHD
         02bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxfzvl+u1yUU9arPksmlzkr4J0/+RAmpsl1NpZojH8kEhlOdq/pwpDYZqW45w+hZhHuYQOKrKVS9Iv8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLQ7ws0+y81x0PozxMQbkaz8OF7j+oUm/ITCOxbwtyZ53FpYD
	2tSMUNc0ZQZC8oSfl1T0nRFokohkLXE965XqgM7VsdKvt4HAHIaZp/rmsTm5lK/a5ZpPMMyVBw2
	BdxOaVzcBROV7LdJB7bDPL+4BZPTAAvpNUqmR5w==
X-Gm-Gg: ASbGncvWc3ZOYyVOhKXmsjRvUhzuKGPQ8vZ9lPpl4uS9FhQFGa1MIkc7dm/8MtyTZrM
	3wYDEx+K+1LrO4/nFIl77njuo7PPiOsL9WTqDQBv7AvTwAyxRjjZO+Vo+g7686FU+Qkfw+kc=
X-Google-Smtp-Source: AGHT+IFLid2+WkSj6gu0lJi8p/7/70xJkyZVifghUCgkxBo7ETqsM3r+bLCKK8Tr5GjCVEb2p1okzGL2E2nx5E81PMQ=
X-Received: by 2002:a17:907:6d0e:b0:aa6:ac9b:6822 with SMTP id
 a640c23a62f3a-ab6cfcb3a5dmr652262466b.12.1738229612883; Thu, 30 Jan 2025
 01:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com> <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
In-Reply-To: <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 30 Jan 2025 10:33:22 +0100
X-Gm-Features: AWEUYZkybIerZJOKdDh3HY5vqE9uTDjGlhoRTLZknshJLSkWQTdvtODbWIPUCHU
Message-ID: <CAPjX3Fd3NXe-U5G3kW+TCfBYoguW9rCAtnNCRqN84dsimGR5iA@mail.gmail.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: kreijack@inwind.it
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, 
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 20:04, Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 29/01/2025 15.02, Kanchan Joshi wrote:
> > TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
> > SSD for data checksumming.
> >
> > Now, the longer version for why/how.
> >
> > End-to-end data protection (E2EDP)-capable drives require the transfer
> > of integrity metadata (PI).
> > This is currently handled by the block layer, without filesystem
> > involvement/awareness.
> > The block layer attaches the metadata buffer, generates the checksum
> > (and reftag) for write I/O, and verifies it during read I/O.
> >
> May be this is a stupid question, but if we can (will) avoid storing the checksum
> in the FS, which is the advantage of having a COW filesystem ?

I was wondering the same. My understanding is the checksums are there
primarily to protect against untrusted devices or data transfers over
the line. And now suddenly we're going to trust them? What's even the
point then?

Is there any other advantage of having these checksums that I may be missing?
Perhaps logic code bugs accidentally corrupting the data? Is the
stored payload even ever touched? That would not be wanted, right?
Or perhaps data mangled on the storage by an attacker?

> My understand is that a COW filesystem is needed mainly to synchronize
> csum and data. Am I wrong ?
>
> [...]
>
> BR
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>
