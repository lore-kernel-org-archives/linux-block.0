Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DA1991B8
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960061; cv=none; b=RMz+0pZJ4fVXis8MBmxWsGGkKP4p+WJ91FnABWz93ntzO/EIfzBoydpXEoGMBNWGWEetMMID93hONpbS+Po9Fut2XcMo5sdwrR/jrHz2z6069e6IkwHlwyg6yeNCHEIRm92Bh8oUSwkVbhar4ODN+7mu/NhoL2Maz52jUsXTExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960061; c=relaxed/simple;
	bh=ds/YaksKodiez8Zs+hfwM7ZBk1XcwUwsUC/7ldUhHZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0+zVg/lP/CMpLUv9/XDCsERhG9tK7VVr+aI6BMt7vAog/UDeNoYnn8Hem0Ie+cfEU4qFuq5m2D0pq/MGzcW5+TV2fuRD1q/G3ylxvleoVHBv2RYbEESLgxrRriH3q9fdmDb7JbtFZHPk5X5gMeZ2Yqw6RajPi5FEPyqRF0kiC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsCNMg34; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsCNMg34"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d4241457b7so1110656d6.2
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960059; x=1732564859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds/YaksKodiez8Zs+hfwM7ZBk1XcwUwsUC/7ldUhHZA=;
        b=lsCNMg34fjio/3VLQsEsLTwVBQX/drklfETnrL7RJ9rPXUOI2CasssR32I6TEnzQDM
         OYjpKnX1qFPresUVgTew/GlxQYk9XI713mof0p7xBh0l+uHEDHoLMPbIAuD5VsDDhdWN
         DBFjOC0bgEUovvjkq8ailGgvRr7pkYEpzRiUJuxk2bpGt/X0TNDcltCPSbCYycNFtAW2
         J3L+Pfp3SqMLfN88VuNbs1twZTpOgcXfAUK5HYLMAmM18T7pv4h9WIYeJdPCA3MWVVUA
         J9cWIDuoTRcundWC7NIARM9xXZiRIDSUNzcXOr02TQTlPi5NwnZQDunCZAAZnt+H9xTQ
         4ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960059; x=1732564859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds/YaksKodiez8Zs+hfwM7ZBk1XcwUwsUC/7ldUhHZA=;
        b=O+s2UY3U2pLb9GbJlz5eX+BsdPpAo5Lp6eqU6df+5lP6WZPOq6oC+jkqb6qZVE/EpE
         UZk6nDVpFrinqtzNIz++lbUY0K2rf7Nx1RlEGGi+UDqaLLP7/EDQWd3LOZS1Ikgnd4cR
         2vgkP5NDvLhQQ1RI8rbNCd8TqX+TKUC8Jn4XP5HXft4hnMtlX+quQ6mcl7oMECUA0KK8
         UWsMVmt15RgTVjzl+eBVU++D2KgMKmMGql9Wykg2bipB1zR/53x1TNhQ618RUmGIBH3/
         45a2s09cSYhI2GSwKvgiRApAM9NQnpVCDmv5u9yrWE86raTcU/3y0FPQWWpy8lpdIHSf
         kypQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhedcyjLzvP4BhD4/RUo3xt83tXbx2INPq1eJ9PZlKYjswk+aYAM0sRv25/cPdG75j7Be5mqssDePKsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfMugjZyyoAL8R/MyDUOg73DVawITssqVbZJkbgf0Jeyy19fd
	TEqkacDlEe9IqEtr/JiQashP2s/GQokcHAXUUbqr6n5Z3Mmom44X2Em/0C5/p/aE+xTbd6vtiaq
	MSkLfQRl25vMgAYe5JLCBrVQ29x4=
X-Google-Smtp-Source: AGHT+IHExeWlIeaJYluBXMfYDlgn6qQR1BihZybz7fjFDDXNeCLjGh2+lf0VyzNMDIzsYGkruM9G3D4Aph2AFd54Vho=
X-Received: by 2002:a05:6214:5299:b0:6d4:f14:eb99 with SMTP id
 6a1803df08f44-6d40f14ee06mr168124226d6.45.1731960059238; Mon, 18 Nov 2024
 12:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
 <CAGsJ_4y+DeCo7oF+Ty8x9rHreh9LaS9XDU85yz81U9FQgBYE8A@mail.gmail.com> <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com>
In-Reply-To: <CAGsJ_4zojYeEqgTcH-sKek9LW0pYOUoXcrzOzjoMuzMMODujbA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 18 Nov 2024 12:00:48 -0800
Message-ID: <CAKEwX=N6eTd7_V56fgNLBvs52-R0t0YaxXT3jWT7dbhnywkTcg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, ying.huang@intel.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, bala.seshasayee@linux.intel.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, 
	kanchana.p.sridhar@intel.com, kasong@tencent.com, linux-block@vger.kernel.org, 
	minchan@kernel.org, senozhatsky@chromium.org, surenb@google.com, 
	terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com, 
	zhengtangquan@oppo.com, zhouchengming@bytedance.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 2:27=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>

Thanks for the data, Barry and Tangquan!

> On Tue, Nov 12, 2024 at 10:37=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
>
> Thus, "swap-in(ms) 68660," where mTHP allocation always fails, is signifi=
cantly
> slower than "swap-in(ms) 21763," where mTHP allocation succeeds.

As well as the first scenario (the status quo) :( I guess it depends
on how often we are seeing this degenerate case (i.e how often do we
see (m)THP allocation failure?)

>
> If there are no objections, I could send a v3 patch to fall back to 4
> small folios
> instead of one. However, this would significantly increase the complexity=
 of
> do_swap_page(). My gut feeling is that the added complexity might not be
> well-received :-)

Yeah I'm curious too. I'll wait for your numbers - the dynamics are
completely unpredictable to me. OTOH, we'll be less wasteful in terms
of CPU work (no longer have to decompress the same chunk multiple
times). OTOH, we're creating more memory pressure (having to load the
whole chunk in), without the THP benefits.

I think this is an OK workaround for now. Increasing (m)THP allocation
success rate would be the true fix, but that is a hard problem :)

>
> Thanks
> Barry
