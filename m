Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63F35CB81
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376566; cv=pass; b=cECpgRdV7yLQMj5AidKZJrImP+fiyTFFxT5jo3tnSTT1z2DrAu4hDxzsMGUqwJojvpwNxEUFORzYRgJiwUgEHvqkj9J6unlJ/wMuwgpv7WBnQKj1df5buF/BbvIzzPOUggo8rF66i+oaUEsemmRLwog9zi8nCLsZ/yzT9v+o9Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376566; c=relaxed/simple;
	bh=t7U1I99fQ7pWNXqxEpLpcP8Md7ce0CpoXzY3AJaWl8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed19WEFZaMJ05vVV6gADVFBVIoBckgduhE6nVJUfZyZJTfR8bw9DI0gv50xPxpB6gNd3HBAUpLfKwFopXIy+Blw2wrOSZvdvEHPmDieztI21gORRVznHtoOjITuk7avUDLNQSjKpesxFzRMR+GR8BCKwvjG+f8dTmlltwtCWMwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzgz0Gp7; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzgz0Gp7"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12dc1c0b724so263689c88.1
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 04:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777376564; cv=none;
        d=google.com; s=arc-20240605;
        b=T16BK47Vnx0QHFWDUSMOaIg/LwCFj8UQ9SXt57U85q66WUA5yVsI6gJxmbfBYsFgyj
         cwJVuUbnmdq93wvLMO8XuTaCVaMk/FzFG1hZqZ1WwRwQzsTm7p6A9MxiuK1kBYQuP6Mz
         TitRF5u/EgzqIG/IHq5fwo2Tz5YjkRn4vVy0PHrz0P/Oqe/KVOAhchYtbp4AJ4d2c5j3
         qd6NIni04549TQRBRzR8cqdqHGpyvBwoK0XXsBvmLhUaYYtK+3Gxep4LT+1L6A6N/k54
         UmNxXvmVBL8cxKmjAAeO3gOIxrEauqH73QPwNfz8dMXBWuh+zpBAcRHVSbb6F4mQY+xF
         aLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t7U1I99fQ7pWNXqxEpLpcP8Md7ce0CpoXzY3AJaWl8Q=;
        fh=VjmGZHjr9RY/8/bVrxrdWrJGPAMxzzo1xPhLwes2DJ0=;
        b=AO98VECFSijkIRjk4Yr/94MjRtP3mRCGhLsh4oAzjwwu7tn9Yco3Hk2EU90IIAvoMS
         JQsZFqkLkfqq6Uftw7V5rMa6doKw2czpdi3pmOgv+RB/WI/p82uBkMIPsQz0j170AMoH
         cf86Y4TgFJTphEs8Iw9Afu45sRKxVyB0z2YARlaZwaqqTarlt8DRWeHFoTs9X8wiOw8F
         NaR6G3BM7ADqPNWMH6M5w8gQrny4ZWS057Y7DH6zT52LsAT/gRv7jK02WyS+K1vxciJQ
         5+7/A9KpGNsm9uMwbAxkE5q5zN1safy6K+PrG6E1/qaRxX7XaX8nFTVqPBWHJ8IwriPs
         cBVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376564; x=1777981364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7U1I99fQ7pWNXqxEpLpcP8Md7ce0CpoXzY3AJaWl8Q=;
        b=bzgz0Gp7SzHaDTrVuX/4T2GPvJAXbuRrJAQiyBULDz8uGKybNXb1pKv5hCXLpQBWcN
         AynOQAD/K0dbkyLxTSmnXu9W7OJ/dz0ivnEMtFNrLWhnky/hDFBGAdJjrq/NvLA7y2Rp
         ThrV9pLYi037TUggq1BXM0bkaKu98vG85qUb2twD9zQzYBzGQIRLCpQg4rM+t2i1e0aV
         9+UG82BFYHWJOGl7/BDLvmPK4w6MkBVh06Bd2f9SkSTsoYwKMeCHLBh6GzPhqTTDDHW4
         thIfRP0l1DIDRbA54D6dM78WIkKG2K/ur3AGaOEMHncMFJn3QlCFowwijFc7Lf/TF/UP
         Bepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376564; x=1777981364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7U1I99fQ7pWNXqxEpLpcP8Md7ce0CpoXzY3AJaWl8Q=;
        b=ADos29ACb12KK2NDNFXsaUHVy344svtLMmfRYz9mP6a68pmtR3p+uoVBwmLEQmRAkQ
         Ewp2pR4r/l3HjEJlNnHbKRUMN0VjClySslnQY3th/wyTZfsrgRh04XHwTnxgRCoOPcaj
         7euHTvlbqgOrnl3a8bOlCIIxXzVwzTRNmANvgY82uYNd7QL0LfkXQoACiJ24yS/UjjsR
         Uk7xFka9yCZ5aydSFDncHjKQvviBszcpBTIpPZj2nQm5cs6npfUyfeAeF6zOSE4WNx27
         DkWZP37B/OjeNVindKalHXdJ5XmUHxX/uNDtqAUkFNVEW1RUytjndF+LKKfq9rV63mxt
         diIA==
X-Forwarded-Encrypted: i=1; AFNElJ8xjUdN7En95b4oJiMCTRYKv/pwfUVcYhOc4sVnvcTsz34MM6+1RmCm3cxXsiYl7bLWkHoz/rxJ6rxbiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJdV8vQts8IxVTSh11HTlCd7XECrCleiyYyWBqaslWfZQwXqe
	QytzxDC/o6Z2JQHmql/y8DEI+G1aO1/5QwY2nwe/KcOXH1DmXkFSSASf7dIsvAxdbSc2PXY1V6O
	W9QudVqOREYTQ7U0YlfYBiJAdh6zciug=
X-Gm-Gg: AeBDieveUWrJMUb1XP+6aztZKkxKWRov1vgLaDdISnulyO/D80P14iMvHUSy26mkn6x
	XAao/vpRzBWhAVH02C/YPJwkgCoxn4B2faTynoaPorO16mKMfmKhY/Jli99H3gqu9bDTVS86S7n
	52ONRnxG6Lj5hqIYmuyA+SFbIbf5Ev8dETXL1XPhylwJCVYf/6/XdSLMVYAGUDU+FDxh1edqy4G
	mDmE10TqNywrmj93foy5fX3gAz9xaxayMjOqLWRIZJgf7C5Zxm9MW+HlW5HdIBwUz4cml6JbT3K
	s95ETqpBXMeWalErf9zT+V1y2X7+l88qwBgHTCZ/Qunn2cJ9kLXir1mkCfUJ6hg+bTWNFsXOT4K
	mGcnCYla4dDK6vI+xXFPbFp7XJOMfySdH3f5IF5ecpcGp
X-Received: by 2002:a05:7300:c99:b0:2d9:94b4:a1bc with SMTP id
 5a478bee46e88-2ed09c5948bmr550045eec.8.1777376564511; Tue, 28 Apr 2026
 04:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-fix-docs-mq-req-v1-1-260079853836@gmail.com>
In-Reply-To: <20260428-fix-docs-mq-req-v1-1-260079853836@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Apr 2026 13:42:31 +0200
X-Gm-Features: AVHnY4I_JrD0gOPQgIr5jL9OggUWKIBHYEwQJ1j4f5vRyy16Ar2QjhP6OJ-iFXA
Message-ID: <CANiq72mN+tGZ+AMoxVbok5HwnHFMsmoZ1bpwPmSvN6CbC-Z-fQ@mail.gmail.com>
Subject: Re: [PATCH] rust: block: fix comment referring to states by wrong labels
To: Hsiu Che Yu <yu.whisper.personal@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 9:25=E2=80=AFAM Hsiu Che Yu
<yu.whisper.personal@gmail.com> wrote:
>
> Fixes: a307bf1db5448 ("rust: block: convert `block::mq` to use `Refcount`=
")

Since this commit exists in stable kernels, and this is visible in
generated docs, we generally tag them for backport, so I am doing so
here:

Cc: stable@vger.kernel.org

Thanks!

Cheers,
Miguel
