Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60D18FC72
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525884; cv=none; b=kU2WZ8WYF9ls4GQr0FKG52neRn4F50m906qTM9Ar48W20Zf8SsD/cBngMAEeq2WXbS7rkGtNrc44lOwIUBZTClTu0R1TgF8+G8QQT3vc2n9cB+pwjk56gsw0/ugeHz57uMCbFr+CW3QBmpCpkDW2p3UCrG/odeNJ1zv2XEnq60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525884; c=relaxed/simple;
	bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUkfuqWcMPF3VxFDDoB6qOdn/dbWRB8exr/Jr2sNxQnuBjlJMR947/GmJY35ZDUinDUwqso9WQ/nkZCZT+YRScDu0ObCsZsDrZdkz9tuTTrv3lStJliH/vhjry8XU9TID/J8ypd+89gl9PT1eiBobeRwuKDlrECoSzetbrftPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3K5WG7m; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3K5WG7m"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382376fcc4fso2381091f8f.2
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525882; x=1733130682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
        b=O3K5WG7mm/Wg/xhuw1n88U8ZiYPFBM/huCT0K5mNdAogN2McMQsT2l0xXqf0My0Qbe
         eFVsvzo+258sVQZricwUkvpxasVigyhIWqIiOiFIDAK8crBnZx8Ie5YsHAJlJbhLXjA2
         TaTCroHUd9zHLcbScwLaQtD1h/ohYJ+n7tBO/9qALh8HSLFq9566ftL87J8QjyCVEvdh
         Da1QY8jCqeg5Ncp3LSMET5i8jXvCyrCfDpFHEAxX78DgavFVpkEHgf2lK37YDS4alq7Q
         eiUOxHfxF1mnP4HsKmzJonJzGSRsrCdr4vb0DtiyO+6gzlyiYQbqR+LDR7ZIAQd/ms55
         c3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525882; x=1733130682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
        b=s1cmPVZdUunrrbQa7hAXhapdb9N7+16bN/0smAlBvwG8UNLFb4uoPYVk2/aZ+nD2dU
         l+cFnnXp+w7dCQZUFIkWMc36+1v3ByQkX0AvTPvTeabq5TIeu+nd/YbPYopLSMTJLotb
         +nmE2vIVQ0YFSIPX6CYOxFYudZLmd0hv9SNQJQQlwMEiN/2Hj0FmIXNkFZYGoZOHK4SQ
         Blpa6deVgQc2MiWahSEz3tgotKODQvh7SJoQh/J/bgQ9YTJGlLR1JiDjRB2b7Dg+RD9g
         K7d1+7aiedgy0wTraL2quR6wNzuu1KmxEg8rwKy9cOCmCyHu+sV+5ovt7ecoZWhQdD+I
         byXw==
X-Forwarded-Encrypted: i=1; AJvYcCVEjmixjdLd2eo22wU/49gyj+s8ZGu9SjYFfxsNznTtUfI40izAlpxKFXVN6M+jFl6Q31IvldbkjjhoXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAtJn8tKoJ61T5Td7E0b4i3+2c8SQSHi0FeBV0GV1MqJxJxgl
	Go4mSjeBLHT9YDa/9pZXX0iqU7qls3gSp3LFX/cqiAYAK59dzylisOlKi/BSCBkrSo7O8jt86Jk
	ubX/rxz5kHj/QOeS90SMUsO7SE8LxXp+a84uP
X-Gm-Gg: ASbGncvEw+RM2MEmSGQ9M1ox9eooykiFkiBigmAKX4cPI282qVhe7IwGQn0VsnKrOIc
	CSIayaX2nNSxsRKDd+dKaJEGs7t0C+w1l35996D0xSxDFRJvBj17XCweqKeNmwg==
X-Google-Smtp-Source: AGHT+IH8xUhObePFMXX+6uJ4DZH46fnDECSOgfgui5FdlJfDvg099oVJfy7l8jGXt9Hpo3OEBqlpkGLGHf9ruibw67E=
X-Received: by 2002:a5d:5849:0:b0:382:59c1:ccdf with SMTP id
 ffacd0b85a97d-38260bcbb70mr8904576f8f.46.1732525881617; Mon, 25 Nov 2024
 01:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:11:09 +0100
Message-ID: <CAH5fLgiOHnX14CtN2rtC8ssUT03ECLOAGNLYPfA5ELSch9fONg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: use the `build_error!` macro, not the hidden function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Code and some examples were using the function, rather than the macro. Th=
e
> macro is what is documented.
>
> Thus move users to the macro.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I've introduced a few more instances of this in the miscdevices
series, so you probably want to amend this to also fix those.

Either way:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
