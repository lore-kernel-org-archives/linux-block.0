Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825A19046B
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209573; cv=none; b=BlrasR/RpAQz38mHTDhlO2l2tWO6NIwl2jtONvatqsiN9iYCFepCJwylN1TLdqzz62C0KgsTOImrK+kSteo9FyVXyMdQA1reVdJ0kv2iW425tTUVxLiyWYRKqSq6rwEmJzQROovQvECzPmzjBonAR2no52esJbYY9rbHG+CeOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209573; c=relaxed/simple;
	bh=hX4prB1rS1ph3HqURVsdgX5nADQOV9sRydK/J8HxadM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6Z/QLnm+JYt+F6EjBBfCFV3AGUQ4Z0HNzcwZQwRMoyvZUuHN7mSVBFHjnm20lt2QjvNBcqrGY49tPoDQYsaYDG7CsHEnF86Tzx/lAvQPoi6mjujzt9VFW572FmiwL/1ttlfgx32XFfsvNsV3yoQYmi/5VWYJj2JF0ZJ3Exw9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyQkc1T2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyQkc1T2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368313809a4so1831457f8f.0
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723209570; x=1723814370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX4prB1rS1ph3HqURVsdgX5nADQOV9sRydK/J8HxadM=;
        b=PyQkc1T27w9PziA7tP/pA51KoiOWraBSWzLTAb5pRiz69+Bwd0Az07CBpn0yBpHnCf
         t3WSJ30+BAbYFZNsap83H9nk7qRhLaAgjaBXbNrl/iuyX5IxH/zVROS9+i8YXzTsJ4oJ
         Bb4wxxQXHFzNWJZNh1qGBlYsl4VEA35O/ChT4y4pbe8+3A6cO1OFNlev525sThMsy0Lk
         cFQFo92cQ7m1gmJLGHBev+P7MMFJghIbDi9a7+SGF2qRAlqaNlCPh3snt1Pfkc6cTCU1
         Tc7hQZJhSfZGgOKSre3LzxU3T+nUV99fr2wpyvJ58ZxoGB7qWFXWX6ZahQODwZGJrFvb
         BxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209570; x=1723814370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hX4prB1rS1ph3HqURVsdgX5nADQOV9sRydK/J8HxadM=;
        b=ilEkizz4TbuTBcvuZMrZTbFWfal1r3dYA3RlubDoZN+X2QVHnfHA9jnjawOtdxJjN5
         B3RE4v/XptmXa0XVWHwwOGEB4KQNPEvKg423nCFQfjWNquvL/cR4z4x62f1ZxwWd6uny
         W57hYe/VdGnC9smsfMtzqMWjdjYiWGxrl3uSSosEQa7H8JhqeFH9ilEIrgWt9RpKlyVF
         cTWa3N0P/t1Gox3bkEKAtv3SF5qUvkbD0d4hif9uyR8WNdqGOmedANwsKiGdW5Nxi3Hk
         0qMsQT0KzwdvHeEuS3PTuWjOc7EMlKEQYPx8zxFg6yyTQZqvUFl71S8N/MpT1BjQoPIH
         fXpg==
X-Forwarded-Encrypted: i=1; AJvYcCUHlevdxPFlemnCSzbY9lxtY3iwdBB8SpL9bqDOtuumOY3j6/+XP3VusmP3MxTbTXoZYk5YkCoGFYlKM+P7Avv67TdgetTlP6kfPNk=
X-Gm-Message-State: AOJu0Yw8hfGKl8ZaE05GDaNFaLiJn9C5/7rD94oZahXF8UBQlEhs+g5F
	zXFaRJGFrnHGlQLv/UU6awcaSMJDMaBDbxPw0vSdc9CLah5qOM6sOh/504EzPqj7V72KARwkWVF
	MsE7QuW/eVaGrn3KUjaO58XtkuUEoDeRz4Kb5aOeH/2gV7VI3xw==
X-Google-Smtp-Source: AGHT+IGNzIaEFkMjqIqsgcveX2voN9uSFLP9w8tPwHgiFhpGT/YS3dCloVdYIRTwq0c/M+SghUXleXsSnC1QOnNSZjg=
X-Received: by 2002:a5d:66d1:0:b0:367:8fee:4434 with SMTP id
 ffacd0b85a97d-36d68d9de50mr1201834f8f.16.1723209570197; Fri, 09 Aug 2024
 06:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com> <7f38151b-9c9a-42d0-98b8-345c4513a8d1@kernel.org>
In-Reply-To: <7f38151b-9c9a-42d0-98b8-345c4513a8d1@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 15:19:18 +0200
Message-ID: <CAH5fLgiPzm=K5FWdLWdTW159OBedLX8-FU=S_u4Rt1HsU_xDqg@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On 8/9/24 8:42 AM, Alice Ryhl wrote:
> > Dash has ascii value 45 and underscore has ascii value 95, so to
> > correctly sort the includes, the underscore should be last.
> >
> > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module=
")
>
> I don't think this patch needs a "Fixes" tag, it's usually for bugs only.
>
> But it still makes sense to mention the commit that introduced the includ=
e
> in the commit message.

Ok. I can make this change.

Alice
