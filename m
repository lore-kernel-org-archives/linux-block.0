Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827F1E3795;
	Fri,  4 Oct 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060242; cv=none; b=rDAcHxonLahTrFHTIXDrpIa5N9nYLE79+RuqZxT9CiSFDqJBj7MAqhS7G94gbKJt5AhIGzfnxAkFi/sC1bn8oAEV5OWf5L8oxMKZDIiNNsfezTFYZU5CehDSs7bQwQtWJGVacUH51MugK53yhJ9Cgp9LKxrwmvrnERJLaRQ/D0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060242; c=relaxed/simple;
	bh=UNor5Daq1Hj/rkiA5hUcVkwjjCXkYG9ZGXwb/O6wnEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYOcemnbAYhhMPqMj+g391tcJ+fLBFASyC6ggTS6b9adoGTtsdTlvkgY++HLZNKsIljpnplKkGDfpMG4kg3/xyvXqsrjthk3ykYkOn0fMgKpXLYgcaHcgeZmBjHZlDHZJhQyMrQ3FACQcHXAWtOwDFUiYDRaeFSMqtKxAA0M9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE+xNx9X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE+xNx9X"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so6014672a12.0;
        Fri, 04 Oct 2024 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728060239; x=1728665039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtkEcDZJ4/Fz+x3oDOe63uDhs03xabv3JKtyFnIwGmQ=;
        b=kE+xNx9XGuXRj7jFZ4QNKwIaydI4+1Kjeid5+K5V8CUDdyfY3uc586pIlXYrUAgcIl
         i6/vM7/Pl15F/rnvyfJEnfNBTVWSavWJuzRg7vRNBBbkHmKMFvSIZO0b7OviZrUpQh0Q
         LWYtzvUB0PDkoeE/W/DBBOltg2RKN/mbv9PUp7M+PLejQFutfz2XHF+OcCzNMGv6MFLs
         TrFT/DSnpwsWApKlJQosUdrRuyY9GsrPLAs4ANQyNB+BLNP51A1WwqB+6o6+ziMXIFXZ
         i/8Qr7l4Strzl7bfX1U6uK1FvKYuRzvK6jlRaAXDexqbyXW3wHbf2rxnmRtBDaRGgTVG
         vIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060239; x=1728665039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtkEcDZJ4/Fz+x3oDOe63uDhs03xabv3JKtyFnIwGmQ=;
        b=q+xbh73H1/n7a4z5G1wPDfw2F+hm09ZJEQJJEpSbS1i634bli3S1y/JynCpTZjLPyB
         azaTY1FBBRngryJFQW8Eypp7JvWBoe7JsKQiGoiIETUDC32kw3LiYRZSy0sub0CWw5JO
         JEOrl4gcOkpqj2ly/4Teh84MARQCGqHSQRtmv9HkyueM9wG2tKF4TedTryAQZPHLJDAH
         7toTN4FlTLR1DSMoW2bVPMPnmLqRlsKxtrSkbtWfOGcK9fKzNSLQOLUT9CKEj3jSNC90
         rOt8Z5ps/RZ2/rxP9rdtHTkJxx2AttV97r5ZIvQOJGHDB3U+BSPnv0TQUHoOa1xHHhoL
         9IDA==
X-Forwarded-Encrypted: i=1; AJvYcCWCCOuMl+mUGEr9cgeEEpvwyo0YGQkvPVS/I7Dwu+PcPCEA/alPw8sW7cGUyF/UwHN3iXN3lpNFiNgF/gNn@vger.kernel.org, AJvYcCWpx6Uawv4/mtjH7nKHegdEgfwBLx2V5ezX0wRJWo5xh4bNXkPCNsGp1fEAiaCQIFwGToHHE3TobjFXwT4p5jk=@vger.kernel.org, AJvYcCWvqvskbSbTODaevg0U9lV3QOwjPUHskw6aBu/Vubdb3FSgiYBnbqa7rNJg0ckZ1chlahc1OvC8+ubOvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqz7L++/5sFTIB1Q/Xeo9INstaVDfepwE9AnV+YdbkRV5W+Axv
	B6y6AhfKv6anbh5Ui9mHcA1JUR1q4Hn05g7u1Rxcu6GAr4+/T220
X-Google-Smtp-Source: AGHT+IEc5rpr7NxwjdqznlXv24+kd6fq1wnlYKs/nn4dcU0eENpde0atM6OdSgWyadBJgkBAbdDd+Q==
X-Received: by 2002:a05:6402:280f:b0:5c8:a2b8:cab3 with SMTP id 4fb4d7f45d1cf-5c8d2f1e03amr3728528a12.4.1728060238589;
        Fri, 04 Oct 2024 09:43:58 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:c8eb:5450:fddc:5d96? (p200300dfbf2f2200c8eb5450fddc5d96.dip0.t-ipconnect.de. [2003:df:bf2f:2200:c8eb:5450:fddc:5d96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f450csm48681a12.97.2024.10.04.09.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:43:58 -0700 (PDT)
Message-ID: <9629a9d2-7e79-41ae-96c9-5fb26493c37a@gmail.com>
Date: Fri, 4 Oct 2024 18:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: block: convert `block::mq` to use `Refcount`
To: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004155247.2210469-1-gary@garyguo.net>
 <20241004155247.2210469-4-gary@garyguo.net>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241004155247.2210469-4-gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.10.24 um 17:52 schrieb Gary Guo:
> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
> 
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
...
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index a0e22827f3f4..7b63c02bdce7 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
....
> @@ -37,6 +38,9 @@
>   /// We need to track C and D to ensure that it is safe to end the request and hand
>   /// back ownership to the block layer.
>   ///
> +/// Note that driver can still obtain new `ARef` even there is no `ARef`s in existence by using

Do you like to check this sentence? Maybe:

Note that "a" driver can still obtain "a" new `ARef` even "if" there 
"are" no `ARef`s in existence by using ....

?

Best regards

Dirk
