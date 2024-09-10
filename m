Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AA191F82;
	Tue, 10 Sep 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975067; cv=none; b=FPE76ADP6owOqfuOeAG7YPqpLzhjgq/k05JSaaD61IWMzi/Z/YCMYxyW9HxepvfO8JFTZX7ZhmMKNix/BqF99mL+wMf0MFt7eXQRrfdvCKAFB0G+BSknp7n3dNY/Jclu8Eq1Nq+Jd0cYY0qDNxdnxDXVwYjMGbDdDTmeWFF6mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975067; c=relaxed/simple;
	bh=8IM2BCYuDlqVMcITEL66ApomB9Uwz1TwgljKzkwZa6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=outyBThT/VpfyaZxT8HUj8wRO/wUqF1ZCjZLKfkVC1iIDtq7KQoDqn6KnXWZp3NBaHnMv8OY2+XnrLACZn46rOLu8iALOcXYr8jg9tYGWO7D74t67THH7IfzxJ9DLnexOSLKa71wS7N3AHViDN4zgtEyASpkd1K91Iv+/1gLuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRTl8kps; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRTl8kps"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d19bfdabbso466742b3a.2;
        Tue, 10 Sep 2024 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725975065; x=1726579865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IM2BCYuDlqVMcITEL66ApomB9Uwz1TwgljKzkwZa6A=;
        b=hRTl8kpsiYHcdODuckoXrbq2rv2dC2H2P5Siea3qPfoBj0g7r3MNx4xd53cA3iEFNa
         Q2Wn3GYdD4zAZdNT7csA1RVPu1vAcX09DLS51KfzYw78n5nJ11i79ZhrJQRqhGPua95o
         pZARPAbqFzLV5U5w/iBa18n8bmISeKjnGlzSniLFxG13C6s6buYFc3j+4BXHVvF4enVf
         t9wtrO5z3R1XoLLi8ftq/mVLdMUJAyEzxT3sgNSmLtVSchCZFLEUewIOLKESyPp7ajRd
         cWujBl7ZA/TLyEIvLeidCNN+mscXdDv4T1GdOSPKwneMnkY4gkKkjVIwR3D1LXYPwzk+
         YkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725975065; x=1726579865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IM2BCYuDlqVMcITEL66ApomB9Uwz1TwgljKzkwZa6A=;
        b=o4LlNGqKoOe6cfANVUmzhmbh+6Uyt+yXnYUsKW00Jwyg8a8K4cvblq/I5DH7YCMfp0
         jqMy/0JBhhPBbH36E42R3Dr8jocYSVOJnOu35v1je2m2i1hK5ZM467GyEhP2acAfTz/q
         yFed77iE7c92sUzDlYdd85/NwUJwJBHPyGTe/ihNsPb8X5dmN9Oz6KMOD1qFgHGXaBAd
         B9cUVdDg2U+kcrxongDHMzF5RJHXgv4k2vxocjxwxnhSoDriD5e9rFdzMENaz4sgYQbh
         EAS9m8dyng1JMTGIJJpIC4OwzNI8vWn3taP0XC+PUVybBxssqHXxcaq6UiPgCc1dLaxg
         bCvA==
X-Forwarded-Encrypted: i=1; AJvYcCUqRWRdDpshx0rpg3BrVqYjtbqzz1boDewnEnBZ4HwAsPV7v1e+iOwZaTsKEThLj/yNEDNg5xB6qW8WfJs=@vger.kernel.org, AJvYcCW7kl+2LXksBBzSXvBC0tHL/GX13hyl+LXsotzIKmGPlRlCl1i2hN/Sh/T3RPz6yvot6e85Ow97fd1kFGKWsKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNSACw7OTw0qxVOo5wzijYXEsU/l+j0Exj/L85xUcFdmHWgqv
	gZbRyipUaUzgRS8stnILcwXchAsyeJ2WENU6owQCntuAfTb0Uzvpk+Vfo9+IptkvNgjlEAb39ck
	2B7MjyQNl64y1geMfd2Xh6gJZYFo=
X-Google-Smtp-Source: AGHT+IEbU5pdhaY5wWJd0ty0w7X1YM3B6QiTtxg7gWGkmskwR62fRuRjoIpcsk1GiEWvJ+WOfd/1vR/Sc5ctfx2dqOs=
X-Received: by 2002:a05:6a20:12c8:b0:1cf:217b:46ce with SMTP id
 adf61e73a8af0-1cf5e19e26fmr474676637.7.1725975063957; Tue, 10 Sep 2024
 06:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909161749.147076-1-hridesh699@gmail.com>
In-Reply-To: <20240909161749.147076-1-hridesh699@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Sep 2024 15:30:51 +0200
Message-ID: <CANiq72ni=BZX4QxG+ouK-m-6C=D1J1xgYNdOMEUMAUUnzuZ3Kg@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: clean up empty `\\\` lines and improve
 rustdoc formatting
To: hridesh <hridesh699@gmail.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Matt Gilbride <mattgilbride@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 6:19=E2=80=AFPM hridesh <hridesh699@gmail.com> wrote=
:
>
> Signed-off-by: hridesh <hridesh699@gmail.com>

Is hridesh a "known identity"? If not, please use your full legal name
(please see https://docs.kernel.org/process/submitting-patches.html#sign-yo=
ur-work-the-developer-s-certificate-of-origin).
Thanks!

Cheers,
Miguel
