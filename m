Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178282;
	b=WXOSC9hY3ps1iZvUxQ4YWKIvTZT/vREJq8lOrkUvW9ufc5IY2l+3EhzqoeBxZ/bM/dKx
	 SDQ0wH7qSrAwlVzTxVHTcIMZ5kz95D0yqVwR9nNhqk6iUNJ+W76os1nVQ7VCgfny6A3Cy
	 2KGQ2IGwn9JvtKGTYBuCkjjgQ+FLfVHaRlldLGT2xaI06yIMs75qoeQymVVStleIKZbVk
	 /gntiY2U8k84VG/6BbW890DHDHz/LMJWHTC0EehIml5zlcolAVcNkbNLBTC3fVg1Gv1ZP
	 ZzdNpRVw1zQ8v5NYTl+mmrWpXhFyS9lJR6TsBtyFTlYbWSAzpk/oyqnvGAlW4G0cy1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
	b=0cW7PbrD2XfEIcddQggQE6n3f7UoYb8f6TBCUb5QpnXI/5VA9jENDWuiRxp+sL+1Zr6P
	 Futd4tMpVlFmauJFP7f+WI6uqm1h34YT4wRzvgbYFBNlAWHMIuoUGzM6fKWiYVAZQjtRx
	 Ai8T6nR8k+ApXLk3ZW/1bwYsqSU33TeuX79cePykupWOPthSLZeTZ+OhB5FLxOUSXgmrE
	 SDuzvFoEipeJ7WpsrVghOI3kFP+jW4vmugnbEFHzKaVf89Vilg0zZ682bGjsfAkvFyE3W
	 Ub449ShBcaJxDwuOST3Wlrp9EwDeOT2z+tZUh4FO1L6RKpkCwYGIa+sfXneF9/pNLaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeHJH9Hz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB30606A320
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB30606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeHJH9Hz
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-66c70d59eb7so95408d50.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 02:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178281; cv=none;
        d=google.com; s=arc-20260327;
        b=oGZHLzw92+wzzRzDAFhC3jLZMwMgahg4u657wchzVz8M3Zpctcg53iLX3fumAApzHe
         mQXGL7GqPJpX1ZviLykFIHFvIPNCAlisP0ce9GkAY8NJ7qe2kLTvwafdmJbYkbfKPkLI
         L/1kELA6ww4Vnl84n3KH+J94h0N1r6KyY32FPTv+W+LmbOeqAdDNmg14b15ImobMkDgM
         IlULPbB3V6hxRPVobZosb5BpGFaCd7n9B9jiUaC/Z3u8V4xNLlw8PBRKpZj4ADT6piKG
         IjHLVIYklphCam9PLki7SevsjGx3m9tMoVcO/jAJCbV+vInw2YN4OeQT5ZF45S7GzOtz
         PfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
        fh=gne8D9lh9gDHj4yNw5sBtHDKfQL5Y1/nbawFNkBjdGI=;
        b=ovEUXKuYg933lKjJ+fQmjkVXI3VrDvSighEnomzNSg4xcpkVwNyd5fG7aWcMOjySbe
         BwqLIDGL0aDl2DSEEOZX2/zOx2ywmtE9W/Fqpusll6K4atn17b3kDazF+nRlNRI/D6sX
         0sLXPO/XIw3KQNfDEzCEWbXZELX6Djuf1dRdIkPrnKYeXHGgIFWGY2LUClpM5ms6Fb7s
         U3u5cKFZ5RDcSr3iYEAo0V+mx9gMLnWW1/cFHslrDYs1nRpBouUxmA+d0OykHugqav/0
         UeeeY2OeRJ8Yc3tW8GQl1DRveN+tgb9FUJg2PzCkzaPCog3GPJiA7kz1+yMb5rpscxLa
         Q22A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178281; x=1793783081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
        b=PeHJH9HzitfqkHwUIHziH4oDgPV1ijSyhYS2wKuypkLLe+lOu9OQCg4T2KXrMxSJZj
         ykW+O7RylgBeVYNscJ5iqZJ48jlNNNhh5Rbuz9fAsvvS0TIV0EW0QjcgjuNyhmWVvJw4
         FjPxtpF0pBkjnucpcDHDuSPGnO+Hy27FrzDtYFdzJWI28spm2h6kWo9IHKSe3LsuX/uz
         tuRLgGxD1DQX32ulW41HqIyNhcxn4mGnXUXwccr2adZ0vUr5t1zF1mVyAX4A3Ak5NcZ8
         h8K8FiQqeJ7ujG2qQANX6pRLM2r8U8qFiPxlpeHb7eK0xlk0lqtC+O7j/RAjDQWTKkar
         qfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178281; x=1793783081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7baAZch0AV2ZQpsltJrgKMT5HFebbDsF2TyQttQo+4Q=;
        b=BSbKybs9LELjup2CxPrzbLh56BhKx6SpihXIJZVz0MYRTKsPY6OD/tY4ID6sIV2L/f
         Vx1dDBGeK0pq0OyNOdEQJt3gLaEMQubTl0oHblTb+7evngo1aN14BjMA2dNEXMmgx9Oe
         jCthX7mnNILUevZk/Fr1QEbGtPwdZpFvF7Y7dONWTTFdrH5mQjxkYHaJzOc/WqffKgFt
         3hwvTE8eNA3yfmkaBd8QBM36VZHsivDQzdIYmwyAdYg3P49lhOMgnfpymXVCWo3toqZZ
         02Y9IdzBq8dizBgy4pNEeJd7Rb7ZQJdLI2cq8AhKyBu8Ow1Y1mDMP+JC25ArIa7nHjoL
         swnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjAiB3DvoBBi3nilTYjWtvHsISTGPECXkb/zJ703E6zLi9WzEzwkIYbSXFLWOiZoyg9SvOc1wR4xYBiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKghCLJsqNMJXcnlVR9j+w0M1bM6evcUCgNQjEHJ9XoqnngfgVj
	63ehiAR/FVYg3ychgvS0Welhvv9bRXEoipFa7/9YaBJ1Z+0Yx5jA/dNDYXNkP9I/vgbJtwhURsx
	9qSB9q1POWI7AujmcwsNIwAZwvxL2TqA=
X-Gm-Gg: AYBFou1XVEY0ye9JETvwD96gzlKesotUEzx3+YqMx9retyowGT4OPkEpB8vjWt4PAfh
	o9Udh2Wo9qUeTaOI7zC5SRTWTcu+qEc5JiC82HlS1sFClJApPFE5PDTlaj3r3xo9Od6D9aik1bG
	s5sdk2nVKpWUWD6THiMtEIMZ4oNwYBC3zcgmdZeeosTI3kXCpO1YTFtKRIiGnSUVZVPxaBKboNh
	JTQ4CkKxC9IPFCj/5Gjlu3+by2ENDu80FZj6uRvAyvaDQEbMciQD4jhyeIpZhNQ2u9JQfxJnEHe
	LSb4EDxs+7OHditX9tegOsQDFwtmuoBeT7fssnPoGTT3I7DbqQ2c5lPuf4B3X7PIuFunS5j6fAS
	TbbVRgEqAhQNqCKhaE5wfYFz6vqqcsygAW7UVBAIhdFrEsXRqYGFPhiak7A==
X-Received: by 2002:a05:690e:1699:b0:679:bd09:f46 with SMTP id
 956f58d0204a3-67a813f79cbmr815916d50.6.1793178280698; Wed, 28 Oct 2026
 02:04:40 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018081203.2431035-1-l1za0.sec@gmail.com> <20261018183707.23dba84df0a235e36de1620d@linux-foundation.org>
In-Reply-To: <20261018183707.23dba84df0a235e36de1620d@linux-foundation.org>
From: Li Zao <l1za0.sec@gmail.com>
Date: Wed, 28 Oct 2026 17:04:23 +0800
X-Gm-Features: AclHuK92W6eCjxLVFBVIgwy3cZtZtdZpLsiCnKY2XBI3u7Tc-5IEfkiWO_P6Glk
Message-ID: <CAAwbnpdgKj5hEky8ZRcPOzJurj6W_rf4X4nEkMsfCU2CfXJj0g@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-out-of-bounds Read in copy_folio_from_iter_atomic
To: Andrew Morton <akpm@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tal Zussman <tz2294@columbia.edu>, Daehyeon Ko <4ncienth@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:37=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:

> Thanks.  Boy I burned a lot of tokens on this.
>
> I was able to reproduce this.  I found that Daehyeon's "iov_iter:
> validate extracted segment for bvec alignment" makes the KASAN warnings
> go away.  https://lore.kernel.org/20261015061907.2713943-1-4ncienth@gmail=
.com
>
> Daehyeon's patch is presently in mm.git's mm-unstable branch, with
> cc:stable, targeted for upstreaming during the second week of the merge
> window.
>
> Daehyeon's patch prevents this reproducer from triggering the bug by
> rejecting the misaligned direct-I/O request before extraction advances
> the iterator.  Without that check, extraction skips the initial empty
> iovec and the following 10-byte segment, then encounters an alignment
> error.  The bio is discarded, but the iterator remains advanced.  iomap
> subsequently restores its byte count without restoring its position,
> leaving 1025 bytes recorded when only 1015 remain.  Buffered-I/O
> fallback then walks beyond the imported iovec array.  So Daehyeon's
> patch avoids the bad path, but doesn't address the underlying failure
> to restore the iterator when rejecting a bio.


Hi,

Thanks for investigating the issue and preparing a patch.

I was wondering whether a CVE ID would be assigned to this vulnerability.
The CVE ID is important for our research, and we'd appreciate any update.

Best regards,
Haocheng Yu
