Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE342C4FD
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450865; cv=pass; b=o/Ek8vwYHwAdOgHRBdeiSF4GLYXFPFRPNyO8+FmYtTS3dBot/64RiF18UPUBnMmrybKnJYU1IVYww8gTx74T34arnn4cRzGvlxWa2sk3GkzSxyXbNjN9XE23LkgJ9SMP4rMKdTnsOus2qe0wFY2tUcGgb0C4J77eWmqNtBbBQ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450865; c=relaxed/simple;
	bh=ql8A3rtHM+NQUqrzlSVzJ05Y2ne9Oefs6MH1bVuRUnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb0/4oyRx9/GPOaVIiFPK8tHwLIDMFnCn4TM9xCdOofotLiB7+DgOM89ND1ixiEossvhmb96wqHRwCWQsRdHPpNMBrxztzXnmvSj/INvDUxTj1p9DmiPiMzjT8/DMLVruvjXbmYjYufMRqX2hsbG1LJApY95ICghbOzBwF08TQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgwV61aI; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgwV61aI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf110997efso7175525ad.2
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 05:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786450863; cv=none;
        d=google.com; s=arc-20260327;
        b=nXQst64HpcDdcR1gaxQdqkNr2MpFfxq8/zuCjr14NQT0PphabbYwbJ8ffsENaldeR0
         2Hmjx+QvqSgOorDqjVhAcM+ucPhZ7oSMLYRaesCmYyv3CK/r3h9dar6uRvZrNtFsPG7a
         GMytd3kUHDS1soVok+fJLHXESzl1R4QRFgXHXYJ5qKOdcsIS7gJgTa/VUBhMw7UK6S2t
         bgQYTAaesDZeNAvzeWAKukmVi/b9tBBaFfDzrKc4yIBZZMEstqJmtrC3UkuMjaapRTcF
         gRsfP/e214GwkOg97WD0SkxLZ9O9kAZZxwXYr0mNP2yFmBHLHzTpGXYypu5FFpKzEnkB
         zeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ql8A3rtHM+NQUqrzlSVzJ05Y2ne9Oefs6MH1bVuRUnM=;
        fh=rTzmfz/GKSxLdOmwpw1K7xtX7AUqJ+ier/0HAede1QE=;
        b=m9DTNfe0cf6dvLsXqaSp3L/QsI6aIL0I21+qD5eAMkjGMRcNjrOlX0s6bsH6DJcuNY
         1LNeSHEz5Vp9SE5K0tOrHZIzxTrl8GcmEXUJv5kEPCRSVosyT1JB2ohjhQUoCI2Vag+o
         lpFq2PlNLo0/pXZoOSpiYGOY/h9mlj4wEofaDVFeviK0wKrMPf0W3qAcoOrxd2aAmD+G
         Br/xPJ3Fn70YcqhMBR0ejq6dlsXF/k3UYhx4BgEwRnMxSSOObpKdDhUtIGY0BK17sMk0
         TMElVG8reDDDNKY5du6jDiBhfakvDy+XO3c4KQqiW9NiAwe73oJW5kIJEo/My3YytUOa
         IAgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786450863; x=1787055663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ql8A3rtHM+NQUqrzlSVzJ05Y2ne9Oefs6MH1bVuRUnM=;
        b=jgwV61aI49T8CTwsNMQgTMM5NHJSH/+xg8JK+oxmoZXXwZDq5+ARrVFHvzTex1R5pF
         UcbbuDK14RET/luK8VwV5Ix+5cIEit19wGH0A9LqMEkSc0aRYWrvMdhhIywKt3NJIzJ+
         xipa4N+KZYk0BrxZBevyJZIIeed8y+SUH9fG561eDxKXVzp3/HUM0C6PHRzUfFrAWy9M
         A1Y6O5oLvEN/4ZgP99ztGeo3T/Cu2e5a08e5Iv/1XAx8aFvhKVBvja7ilaULk8eHoS5B
         zn9SFM5odi3KOhS20wJ44Tu/EEqNCjcrqOa1Pp37qjqchQK+iPwh63+T1JmVeG1aO0pd
         awog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450863; x=1787055663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ql8A3rtHM+NQUqrzlSVzJ05Y2ne9Oefs6MH1bVuRUnM=;
        b=bx1D0YG3KXUTnSGY5oiqOQZj5s/b0Dzsawo0SGfNkdNfTaqG4C/qZUhakW057kpz+x
         vU0dYHBd2xpaMAelpAnrvvG91zdFP1FsJwEKWWj/s9yWxOYulc4rpRcSS/1luEKS7lwb
         WbFCOHtCq9y3MS+BQJjFJw+1HJx6XnyxH0HlROoH8d04pdoG7RncQHxJs+/aPlWVtU9g
         HZ/fJ81EA3Q/uaLVPaHi3xZqAnYdT5eZJpdS5lb/eLVAWzkkLJ8z+WCNJOWBPUgMCza7
         CQsxAsWKxioKKQCOYyUzSf46CwdluoVHk6++XsVUQ3n16Dz9ZjkumAad83+FDnMDlaga
         721Q==
X-Forwarded-Encrypted: i=1; AHgh+RrthQjnqXFG8xqydgw7N6OyBik1zlaiemmTNhjEP12yS7SrlRH2huhVwKU/EoY+aDLdS4owXPmVZJZc5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BcEpQ9oyikj6BUI/gfKGMOFnwE/cOm6wRZHzy79kO7suuJYk
	zpZCSpmnRzHi31humv7pS37jf1FoaSmpYBwzJtnsJZqMHjy2oK7mHTFAGn/6h7KnR8IwQSoaRT+
	hxg45IwXlyxvj/0O7zPghIHTRc4YfPpA=
X-Gm-Gg: AR+sD132DnXtLLygdtPQWnOXLxgTVuHkhF6Su2/G/KcGvTXPzWN37W/wHr8OgfojWCr
	i/MQfFkYXa8r1on9f1+KK+rSfn9C0Gd2bLhV9AHt7GnNYZUG5RaR/liNIh0tg1GV5csAPmTjS1e
	EY5BTN25KaZrNuV48zEs/W3Tmcvt43h37NnTN5CCrZCAma/sBWxf8efAboZb1czuAqPhQqxtKC8
	TneFndYj+qfkgzpYW2rLTrZSACdW34+2CSf9YWkgAAr/eLEgnw8Rup5PSQa4qWzvk2AvBZCtLL6
	sPixaYLi4YxZUIZZB9HTM/9l+2E1Iw566l0QxOkMgNhvW8q6A+P05PYxlg7wFkYJXlNDAQPKTRW
	9rnsVV01Q9/vaOXbBJ9aVj/ucNdy4zLDIjs0ZVAvDx1x9MN3LMvO1XNE0rcixG7HHZjjAICY=
X-Received: by 2002:a17:903:234c:b0:2d3:b3e:711f with SMTP id
 d9443c01a7336-2d3176158bamr22126975ad.0.1786450863209; Tue, 11 Aug 2026
 05:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-gendisk-owner-v1-1-c0fe4a449ecb@linux.dev>
In-Reply-To: <20260811-fix-gendisk-owner-v1-1-c0fe4a449ecb@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Aug 2026 14:20:50 +0200
X-Gm-Features: AUfX_mwgX858ISyRxSrju8_-iXIGhuGuoOPR0M9UUR6UmwVl7OxBtn1Y5PK_2mc
Message-ID: <CANiq72nmthEu5HQG9B2yOgLvhEJ+PMO7OBG-ki2uUQiUTTgciw@mail.gmail.com>
Subject: Re: [PATCH] rust: block: gen_disk: set fops.owner from driver module pointer
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:51=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> This patch was meant to be sent separately, but I forgot to send it.

Do you mean "not separately"? i.e. in the series?

I asked Andreas for his Acked-by.

Cheers,
Miguel
