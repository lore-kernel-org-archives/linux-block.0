Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAF35F5E1
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417090; cv=none; b=hBQh9Sc5e/bFvdjR5C+Hz3YI3eUhLDYKJnOj1FikqvLPBGFgyj/v0YzQ0Z0NminrGBMFcsifGNxLNoVO0FksS7pXvxUzQX6mBjoDwB6MOZdH9KaWP0o1KvzwUCaAicV+RqE1muk7YWbNIEZ/xwnwo7+IhFCoptfvPyaf9sIddFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417090; c=relaxed/simple;
	bh=sIMg3XQR8uw1uh+SEDyvp3GjZOl4pi5tFZ8Bu1+rQ+I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Gi+m+GYWcy+dPiHOP4x6cJOPALVXSdmcswMNR9yGKlF4zeH0+LcGy6x2iME16cHYSFTY+Xi5fBUQQOVhvcb2gpTKc14rIZFNKbJthWIwkwN9ZE+e2lydtG2oXPmxf8mnQdh7Jf3FKz4KjGcyCPm//uRar/zqEkL9UaUk+rtkU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asCCqjjv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asCCqjjv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso20475885e9.2
        for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773417086; x=1774021886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIMg3XQR8uw1uh+SEDyvp3GjZOl4pi5tFZ8Bu1+rQ+I=;
        b=asCCqjjvPpJHSiJwK5+xvQMoeXCs8F1Hr8rlODbw0kEPQBrxrmVlBQFLcWXItHhIo3
         4+nSS5tMuJRGDzzJLORYp1mmvKCyKSjaCNbvb3wgMqOlAlZMHzj7Dn0/9gRrNeiA9A3W
         A3WWio+uS5vINaDZtuxZVET7oVXAvWGFI8l2VJ0mNbZlTs7dpehyZIt2hW92CkM3OzQS
         fehdqvMmockBP7pwN2be9b2D0zrrNyVvvE/RLw0E6ObqBGffgpbhdL5E669Pc3J5FAgj
         9PqaYVqnUfXyINDre+ZnvnCDuKg5v70QluFTDvTAnL6m6+MPrtlPykEbjj+4eSsUlrmI
         W6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417086; x=1774021886;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIMg3XQR8uw1uh+SEDyvp3GjZOl4pi5tFZ8Bu1+rQ+I=;
        b=b/XYGs/ufJv1gx+QsYOQdIuIjzmS5kloIjvI2kY0HKncb9pdcpAua2XABTl8QE9RfE
         IsuXVKNm2/8CTvrRR6V8LL5tXC143bUtKJc+JMZo+vm5KaKdtN75f0olzuSi6lQIswes
         //ZXM0JRREvNJNF3IKUskFC3yny1mBT7C8xKYA1TtJ0RcMWde4oBluvzFrafvJItOYmi
         Kif2IyII4NRzlnkwqDpxSmFSrSTZtOW8I84i4l5Lim4/AUztrrLTnItcAxsTEue5hKP2
         jlDsxQRhRtNEKtqFCOT8Q2vdP7UaQwi81EFqjHXhvdpuejfV9A4WA2oDA5tL5M19qp6O
         5s7A==
X-Forwarded-Encrypted: i=1; AJvYcCUNg1zzRUjsb7UkoFR4fGrSoHGpHxYAKaofdyrOMC0t+52yXXczZZ9r6VUYqYp7Se/TLWbj9SXUWesx3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfig0uaL2nVZiBWk/WTav8kGYI605upGa8vaZkf5Snngl9yL+H
	2TIB4H9rU3EOXDtgmBSmFBaOL+v8BkXaR8axJEpy1IxE5EVKyQ372bnl
X-Gm-Gg: ATEYQzyCDmfYLclOm+Wg8OWa08k0SQyX6G0+KFkD9c5ahMJypxDOjVOurkX0m0v9sKf
	T26X60/UbgfqQSqjILhB6Bq8opJpJ+AgLZc1R6vz6DZF7hlcIs0sAabJfYeylRpzaJ/wEsW5jpL
	E51YIl4ftDz0pPRWogz5jpB12H4fxUO0kHOEL17Bhzd6DH7UBjlJr0+rhczvxK7BTLzIDo0GrC8
	la9ow78bFCFFB/+Ps1nklntByWT36+YbWfIvRP2yj1TDLdUZZtBtktKkqnDDrnji9LTfokTzzhE
	g3pZTMVPF+gMy3yxu0HmO7KaQ+LwQApRzgZ4apTksKmm9PnLD++ipcQ6U57Wa5GQRIZzyNTS3Y+
	Z3R6o/rdfiVFfsX1ydZ2cAShHVw1wAWDqtVSiwAuuuT8y3lPWadK3HZHqNHShXqUmo6ICStFTvw
	/LNTUkThM6zEW/Q2T6
X-Received: by 2002:a05:600c:a009:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-485566c6a8cmr64527765e9.2.1773417086025;
        Fri, 13 Mar 2026 08:51:26 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855638cebcsm56339885e9.0.2026.03.13.08.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 08:51:25 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:51:24 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>,
	mm-commits@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Message-ID: <28175752-2775-476d-9485-499335a99aea@gmail.com>
In-Reply-To: <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local>
References: <20260307221931.2848601-1-objecting@objecting.org> <3cd25de5-3737-49f4-aa8b-eaaee471af50@lucifer.local> <ee644e1b-5759-477f-8aec-35c91a5a938e@suse.com> <20260307222154.2848660-1-objecting@objecting.org> <667b75ad-bce9-4997-8ebf-8077952c2797@gmail.com> <20260313-anvisiert-gemeckert-352414e3d58d@brauner> <20260313-halskette-annahme-94e782eb4ae4@brauner> <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local>
Subject: Re: [PATCH] MAINTAINERS: add Josh Law as reviewer for library code
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <28175752-2775-476d-9485-499335a99aea@gmail.com>

13 Mar 2026 15:48:32 Lorenzo Stoakes (Oracle) <ljs@kernel.org>:

> +cc David for mention
>
> On Fri, Mar 13, 2026 at 04:33:49PM +0100, Christian Brauner wrote:
>> - first patch Feb 28 under pseudonym "techyguyperplexable", switched to =
"Josh Law" only when Andrew required a real name
>> =C2=A0 in https://lore.kernel.org/all/20260228114939.de7d44de38d907a9b66=
32480@linux-foundation.org
>> - 142+ emails in ~2 weeks =E2=80=94 37 patches in a single day (Mar 1)
>> - All trivial/cosmetic =E2=80=94 SPDX headers, comment grammar, spacing,=
 const qualifiers. Zero bug fixes, zero new functionality
>> - Carpet-bombed multiple subsystems =E2=80=94 lib/, arm64/, staging/, in=
put/, etc.
>> - within 1 week of first-ever patch, submitted MAINTAINERS: add Josh Law=
 as reviewer for library code covering all of lib/ (locking.c, iov_iter.c, =
rhashtable.c, etc.)
>> - Email identity mismatch =E2=80=94 From: hlcj1234567@gmail.com, Signed-=
off-by: objecting@objecting.org
>> - Formatting problems =E2=80=94 top-posting, line length violations, pat=
ches not applying cleanly
>>
>> So I mean, one week to Reviewer. Even if we're being very generous here,
>> we need to do a lot more due diligence going forward. We can't just hand
>> out core components like this and risking our reputation and security
>> posture.
>
> Thanks! Agree absolutely that we need to be careful about this. Jia Tan s=
hould
> be instructive.
>
> Josh - there's nothing personal here to be clear, this is a question of
> procedure and caution.
>
> More broadly I think we should avoid assigning new people to catch-all
> categories anyway unless they are well established enough to be involved =
with
> _everything_ the catch-all covers.
>
> For instance adding people to the mm/* other than perhaps... David ;) wou=
ld be
> crazy.
>
> Also - Andrew - I think for cases where you are the only maintainer but i=
t
> impacts others, you should seek acks proportional to the scope the MAINTA=
INERS
> entry spans - in this case that'd be a _lot_ of people - but that only
> underlines that we shouldn't be updating such entries anyway.
>
> In fact - can we just do away with catch-all's and just make sure MAINTAI=
NERS
> entries are established for everything?
>
> I have ground to stand on for this as I personally did it for mm, althoug=
h we do
> still have a catch-all (not sure if necessary any more?)
>
> In the case of lib/ a quick fix could be to figure out which files are no=
t
> covered by other MAINTAINERS entries and adding them all to what is curre=
ntly
> the catch-all?
>
> Cheers, Lorenzo

Well, it's already been merged into linux-next, I will keep constantly tryi=
ng to prove myself as a trusted figure in the community, and I am learning =
new things every day about the rules, and when you talk about me making "tr=
ivial" patches, I also made some medium sized bug fixes, yeah my start was =
just "janitor" code, but I will try to prove myself,


V/R


Josh Law
