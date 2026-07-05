Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBA377EC5
	for <linux-block@vger.kernel.org>; Sun,  5 Jul 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254158; cv=pass; b=hnJiMPET0A2g446Z56DhjHpt/ckYDyy5bdWnsaUgkhMwaGjz4d1g/A0zMQIMbBg0bm95eHP9C8EHFQ3bPwJVBM3RJVNqIDMto3U26WypTFpoQTWIdoOjn3nl0+NXaq++HAsN+A3N3jktmkM3ltHG5n0uWszsges4L4mVxFaOKEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254158; c=relaxed/simple;
	bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KknYbSY51wZQdYBoz0ypVhYTvphBiecfNn6xLWXeNrk2iauU3Z0kKAKDi4Etjua7lzzWk4kPrc6JM1awmxWpTj85E1nspo/1EoStJe72M/0yJ5pP+9UVF2nqrZ14+Y4QB+grKw7YQE7g13mpUkEccx5TCrlTF4/UmGvvwLzHGhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhyjfxyA; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhyjfxyA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-380a02c71e2so761422a91.3
        for <linux-block@vger.kernel.org>; Sun, 05 Jul 2026 05:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783254156; cv=none;
        d=google.com; s=arc-20260327;
        b=ipZ96txm4dDkLW42NynCJEaaGzOsPQpQQI8YixE31dLZYzPGJ73I3VnuK+HQnLDZnZ
         Qqu9fN5X7mOSjX+SHvFeEspjQJP5L0MhJr8UqCbS6glwhPH3ASdOvLegAXtznUPDnJ1K
         HXuK41wKOz68PFLDqvDfL5KYPYlN4Vinrg+F2GldQsp9/RJr2Q+gakSrDBAYkaPiSCep
         41I0uuSafDmTw0bTTnct52K1aFMvmzC4d9EAIgbnpaiqFlsavBLd9gNn/0o6pOW8tVOD
         kqVTCe7K6pggd5+3oKoKC3AW6kB8kTnMAEHYQNtC2+uyjrwcSkzb1a9NQmOSte+4pw7D
         0hPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        fh=91v+P1s9fm2HYxY2ce1J14eLhGyP066DKtJsQfFghtk=;
        b=dhY3GdbXtWEzaZYjiTRVreD1sHImJ9x4KQGFyUOVrKvx5OA2S+yBuk1KTKgd73cZjk
         EmZcjV7XxbOTdgb/N3Yo4Nbyps3l4FU1Gds7cAiQHsNY6rrkoRYJkGC5RP2WF4PeF0Eh
         EOUtlX+XUMuR4pfFrxKhu3E6t8aGfWmeJT/G/yayV3rGgAwFNeUqtMP3x3H553j1PRaJ
         K9BQfYqWVqOWIseMcpuLYGd/cBMXLZ/5k2IoFoAICMrgGUVDq3OcYRqpWh7uqvAXtKUn
         XmR4S97CWzMkkMwM98D1ei6ax42F0lmt9otN9+694vT7ys93OSXPEI8ys4CUUIvVJo/S
         xd/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254156; x=1783858956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=QhyjfxyATsOCVoQS1jHI7Mibm0pDUoc6hvz2g2DThUIjMUZJYAjaB/pjXj01gPkIvn
         PfUDF6VcZ+4vAS7mRO+8Tu3Lek9RvxtWQm6vEWu+ZDOW5AK4Z2AeTmPW7czcovGoyDq+
         ZVfrkt65J2lj7P8VTHHGIiyLDSOzsCql4fpQd+xA3DHo+FO0qg5BnVIv89TaShPzevFS
         Feej2fjYBtwo/K6so4aFuH7GfGlzqB/U/o8s3WKhvQfbIC106TCgOzeeVrhGV6CfgDRS
         fMD5LzSJzRbtv+Zn8VTyus83i47Pak+MLGzJSR5JcGngV0B0yK2vCcDoH0cgBqVjL5KU
         +I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254156; x=1783858956;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVZuwq26LJUbjnXW20W3nbICqbmkh5x02bCyytPFsmg=;
        b=kEkwPyqPuu/oQabUPmkBKQDv/hYBSVxpg2MwYhsIpFFTZLgCVs/wLtDNrPv7y7Tmsz
         CL57NlL8UD8djriVXs/lw5xK1PvEEuiHYLtYut2BT6hSAzX2IVIQ8dRvsBuqn0PtsJ3N
         C+TOI16jVvWHypoeNorUMH0xNexWAbk1E72ABg1Wdm2xnq2jL4bEiE2r5tN97EaFr3xS
         IxHzfEzD3aOzEqtGbYqB++ZYrS8qSto/6ZUhTnsYcqerQt/3EKj2wZh+F3cKDwUieAWk
         uu8wYLoyujWnGC+Og629U2pvsFdRYbGk4NmLMJ8Zy5ZiTRY9/REjXQnWuTJICybHMioj
         un9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrba6pU+v1NXTgJKBwwOv9/aQ4UdPo9alwjIL2v9njBj4NprL8Us9yfhZP5rFvW1EWrPgOlkCAIWa5EUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbNTgTKtAn7+cwQI73pSx4s+I1fVLdt90xddNW0XQfBOy5C6S
	RkDqf+1f16WcPyhnILix7isYXrUV+Vm43bAnDmNdETytkS+CE2p/KaGV4XDRZl55sMD/WyVit26
	/K9KwEM8N2EdZ/WmhmPZkeopCfzo2iEQ=
X-Gm-Gg: AfdE7ck0fuC/gw2/6Z7LXGdNFHffyUWPjBPKoqsBVeaTqyuGgS9hLvbaFHZX2m6NHpH
	qz9X1uJspKKdhQ51wq9H8WCsFTM/WHklx6HJZwgBuVUJEUHb/0Hw4ngtgJk53QtpOD9cI/emjA7
	zuTESXd9BxVjnFjk033S7meKSrZWU2fDML8lEq2hnnpZX2A/BijlCG7vCVkP2oiqn/nkbKZ5ImY
	UWwJiVUGXdf6htF3LB/l+Jr6KVsvV8jYfZNu1kSyAxnlYlGdJhugBWGoU95Ssl6zQ4IjbgD6f61
	O7vE20DPHnQSO+IrAxHamc2Qj+XXiUWXBrl1EqUgZghWm0pzAj+PO4Rp+2oxrFVbanAnty5hXyN
	G3hRVLZkkqRmp
X-Received: by 2002:a17:90a:a416:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3835a16bddcmr2702118a91.4.1783254156186; Sun, 05 Jul 2026
 05:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch> <akmnh0AKFfu9-OYn@gurudas.dev>
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jul 2026 14:22:20 +0200
X-Gm-Features: AVVi8CdKZk1uQg3RyoO9gWWnGdg1D5rtqZ5BcTTqS2w4TtsLqn1TqMImL9QufHY
Message-ID: <CANiq72k0zokLC_L2wPJRDb_CyvnJznOSKUgTaiHo87GT6Pwyag@mail.gmail.com>
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various drivers
To: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 2:38=E2=80=AFAM Guru Das Srinagesh <linux@gurudas.de=
v> wrote:
>
> Miguel, could you please indicate if you have a preference here?

Gary is right -- it depends.

Generally speaking, it is best to do changes through each tree;
especially so if it is the kind of thing that may be prone to
conflicts.

In certain cases, yes, I may take treewide changes, with Acked-by's
from maintainers (and very exceptionally I have done it without that
if e.g. it is trivial enough and enough time has passed -- trusting
that people trust me to do so).

It is part of why the Rust tree exists, i.e. as a fallback and also
for convenience in certain cases.

I hope that clarifies.

Cheers,
Miguel
