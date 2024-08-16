Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11412E1CA;
	Fri, 16 Aug 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798498; cv=none; b=ndYSpz+2Hzn7TvdXtSW9fSaRjt2SRgfCjfQVTO1gNw437hD2jDYPqbP6skYg6OVCzbPlDF65GWhfaQ+P90E+rXaxw3hd4DhXOteIEuHTXOoD+jhB1ZfcT1OETJ0WhdUMkqVEBlOrN/yKrl7g9wyEzHFNCRkjW/MRbfJXjljEqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798498; c=relaxed/simple;
	bh=WvPNUZCEHPz9cJaVSTq2oelh/edt3sSSDWtHYvoDZ0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtE3xHfWhOPwLgwZSn1HIwW6EtY3QoZtfXIYa1oUo4I5CFaktZGGxGNQv/ULmZBU3C4zzgXJM0tN2WQaZF6F7c2Up8UHGFwH8FLNkfi1F6QZtuerUT6HABQUcsIYscF4w5gDf2qhua9Ovdi8yOxWharR3BmNZ2QYy/41qYG+i04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPYfIWi5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPYfIWi5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d1fe3754f4so1337540a91.1;
        Fri, 16 Aug 2024 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723798496; x=1724403296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvPNUZCEHPz9cJaVSTq2oelh/edt3sSSDWtHYvoDZ0c=;
        b=mPYfIWi5LcgIEULDWuttMW6aBNVGCS0rSxwgV5TqMGIudnmrKILleiGFPrKMT4SABP
         KnggxEr9dq1daZK9O4HTLH7YSJY/ftX5/L5YtysdKvaJGREIzxCZTvn4j6PYKfmC7lCS
         THwQgO+BN0WwbKSrEg2o2PQhyl+8qUKy8ebFAHZr3wZXPXfwWvqJqqed2Wft5Lmh57xa
         aO7xvJRBU2O9Em+6NqR151Lk+kofxs6A4KO+1Y6uT/y1YY4aG5NhIY4fjYO8OhTgfSKV
         BW4NI/HKYWrnVTqq2dnoN3VkPf4tm4kVTxlOLr12TcmG5f+BSz3HBnuEht+tYPLNMhgH
         iMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798496; x=1724403296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvPNUZCEHPz9cJaVSTq2oelh/edt3sSSDWtHYvoDZ0c=;
        b=nwAvQ4kC1wiA5m+bKpDyQufgc3pNRZ5ZN+gsljproWD8guhTAeivGBBUcVWzoXIcbW
         GrMT+ULSh1SS9cP92wQIIuMWRChck0R2C+nO5JcYvsoQh8npXP3CzHyZFPm+B43YNtz7
         ILaXAwwQHGqo7DjVNSDvglnMT+d6dZv4cgmFUsWZaloGcLauNBrXpmKWZjJV/CIImvrg
         zvJRS1B4Xf/EEHNonziT1+wPXTNmrxMrHTMN+q6Uvb/uPnVm+Q+xyMf7Ib+yCFgx+91c
         uh+5WKRptyU4PI/1N5NSAY9g5ZDo7gCSD2rVJUXbl9PdeRMHh7H2vUYoJyo1LX2/2yzd
         FyMg==
X-Forwarded-Encrypted: i=1; AJvYcCUefukM3cpqaUZZsYyuXkKDipa+zBccXRVobLXaoenewCRZzZfOeFFZClcpZei/a5O2L6KEWXObR+Jj0DsHyuQygcVmKVULpk3K6SmPuFIVisZWdFUPYgGmSvLvKSiz0UbflFfn0CcIOGoHvO+F1ZuITnqFCyI3DKIa1uRCuPp5bIK3BCRvr9e/+w==
X-Gm-Message-State: AOJu0YwE0d2qPH0+tUiRbpK0HrYdOkP0wPEk7z+q16HLdkrEBKNJ5HKC
	oPDYPYD16FZs/jWYWFimkJKOgr5jU5CbXkpiGpzRNU3PoNDXQeIWiBTEc+MPq6RXIShpLueOmos
	noi4lxa3WurvCi/xdB8erJcwmFkPYjJ1Y1H289A==
X-Google-Smtp-Source: AGHT+IE7yL6G6QasJpooel4RglmlOwxtA9DF7E3JRSEVNLtiI4zHZMP3L5AMXjAgpclhClTu8I2H7q5pVDI74BDsaS0=
X-Received: by 2002:a17:90a:1f88:b0:2cf:2ab6:a157 with SMTP id
 98e67ed59e1d1-2d3dfc682camr2429776a91.12.1723798496317; Fri, 16 Aug 2024
 01:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-1-nmi@metaspace.dk> <172373175849.6989.2668092199011403509.b4-ty@kernel.dk>
 <CANiq72kFXihVGDGmRyuc0LkODYOv2jX3shP-dEHjV3k1sqFEKg@mail.gmail.com> <622e155f-2ad0-4f62-a6a7-c9c88903db82@kernel.dk>
In-Reply-To: <622e155f-2ad0-4f62-a6a7-c9c88903db82@kernel.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 16 Aug 2024 10:54:43 +0200
Message-ID: <CANiq72m-o=3FW2ve_GRHrT91go4OMt6tH3oQtOT6UBzwLutiqg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
To: Jens Axboe <axboe@kernel.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <nmi@metaspace.dk>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 6:00=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Go ahead and take them, I'll just kill the one I have. Thanks!

Thanks, will do!

Cheers,
Miguel
