Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C671F130D
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367158; cv=none; b=b4oG2EPuUqcFyuTUNjLhly4BzUYduS5rjo//06fikaAV8l5yZM+E3cmZyGmOyuZxPYcG+o66Qxa4IjZY1NTCvO6WcIGkKraxN8k3AABd8ER5f3VTC7eBfC1ihi3fj4SzrNDMYdo4HqGt40/GrZrCvtfrhvF8Mw0nUxc9/VcAKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367158; c=relaxed/simple;
	bh=en9xb+4vR1d1qHmpfGEiAM4eqj6lnh9amgRCvFZCoPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVp/xZLL+HUov5bhAli1T7JwFkYbdQy6JqzjVe7vGwHXj2M/LdfZIXBlW32qdjuMttkFv6uIAphXpkokuyyWEt0cy54bIZK1J9TebDNYRdEWvnpnNhXOUm6Ed7lX5vF3TWebCe97iCnS/TS1Jf9LmgSt7Qf0CuopOfTXesK1JYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ewApSYbO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ewApSYbO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43626213fffso8316815e9.1
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2025 12:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736367154; x=1736971954; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJwa6soGDW/D/CQ3ohXXjQgefQaYPFZAUIQrEzDhKr8=;
        b=ewApSYbOD8LfTD6jzWBmmR5F/QARDID1SuR0EV2pwk2qULYwBjoaOyyvigVedskR9N
         h84Zwl2y3DTwk5Kq3j9Y3v5C09h9U45ijveJkkesta/wTexCG0hT8bIeFGFUXFNw/KWB
         rKgl6rmFHZYbSvmGcZpHSRPKMe/z9GBQclcXVK82CbjavWPOiURUH01XOB+gGgltMd4f
         lBbhR+G9iLDndpAtaYqVvGBCGtzMDLJkVlVwyTyR+nMmn37jkqNy28MV3Ogae+Sirp43
         495c4gvUQ7PnwqxrJHJU1CaN+eSgFrrRFWMzK7oSCpLnynwVXgVbLRLXhTlVTvGpFKWL
         /4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736367154; x=1736971954;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJwa6soGDW/D/CQ3ohXXjQgefQaYPFZAUIQrEzDhKr8=;
        b=ZVarLdCISDqZ7B/ArnH4p9BAraRYqdB5mP20XMn3F83gipauJoe70PpOllasZ41GHF
         /CKE2wBohZh9iBMWRU0aKlEu+H5Hg1fBac5GRdTqDTtpB11qJJannqf3BromkjwJOPt7
         e/55ep+0WwZTzClXOKPlboqRV8oAXMGqqX2Gh+ZIaAtIuKBh11bAv/lvIs1gVaXoYVqD
         cYn4PTcr1aE1HhOTB3VxZ4dYNVMXRCxGWLcl/1GRS0BdDjq8C3r7IJFOI01ms1XkUI/T
         nl4Cz3K13QknhNcsSsuHSahwqAkHZFExdS5BJ1s2C5KB+67b1PIbKzlziKQgWSMs19MM
         X6CQ==
X-Gm-Message-State: AOJu0YyTpgalqWM47tjb2wi3JUHPHx7jkuI9DQArcZrRpscEGNLrys7e
	87tCQOe4iIrbQlJBDH1nswJYaeBrk4SVntcSYgNG92nH5L+PFHyJk0v0BvOZEZc=
X-Gm-Gg: ASbGnctfglz66L6MH2XnZWGNELWXoGMEms2AGLU3lQ9TqepXf5zjVQ4pITMXED22INi
	rXCklEbkuS8r5svXVEHjD/vFbXyawvy8gO6V2FNx9Ds4FmM65iEb987K018SzrPbUhczqeJWRFh
	fopJSrFSipYLBH1tlWgGLluErJwCG/zdo+QzfDuRthqvlIcCBec/hlNokXrQkX3KRJGwv6neTd6
	iu4fjjgSAYNmcWkkSu0JUKURhxktkiEeobIUdHszGwD/VPVu7B0fRVqo04cXvNESUUbInVTSfYn
	fGgs9LgMgrdDLkti/qgXqOjXUVYErD57zyPwMs0jZ6469bB/ysKXji1GRhzUhY4sQvTgoslyDls
	BxA46V2EFr/BA
X-Google-Smtp-Source: AGHT+IFFUuLRuyHyZbtVEf04FLbJfO1StakUQOTMrZ8DLPg3gAtYkaJGhzIv761uiLZWJ0QE8Q9mNg==
X-Received: by 2002:a05:600c:2ed2:b0:436:747d:55c9 with SMTP id 5b1f17b1804b1-436e881e867mr5509625e9.5.1736367153913;
        Wed, 08 Jan 2025 12:12:33 -0800 (PST)
Received: from ?IPv6:2003:de:3746:4600:ac00:378:25cc:9f2c? (p200300de37464600ac00037825cc9f2c.dip0.t-ipconnect.de. [2003:de:3746:4600:ac00:378:25cc:9f2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm32471805e9.11.2025.01.08.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 12:12:33 -0800 (PST)
Message-ID: <6f46c75da6f865b04d3038cae8d3bfc6460ad02f.camel@suse.com>
Subject: Re: [PATCH blktests] nvme/053: provide time extension alternative
From: Martin Wilck <martin.wilck@suse.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Luis Chamberlain
	 <mcgrof@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "patches@lists.linux.dev"
	 <patches@lists.linux.dev>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Date: Wed, 08 Jan 2025 21:12:32 +0100
In-Reply-To: <53p73kfx7akmecsc3sofrmga7o7m32gg2lp7e44nacxgwarfoo@u74aepo5erqs>
References: <20241218111340.3912034-1-mcgrof@kernel.org>
	 <53p73kfx7akmecsc3sofrmga7o7m32gg2lp7e44nacxgwarfoo@u74aepo5erqs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 11:37 +0000, Shinichiro Kawasaki wrote:
> On Dec 18, 2024 / 03:13, Luis Chamberlain wrote:
> > I get this failure when I run this test:
> >=20
> > awk: ...rescan.awk:2: warning: The time extension is obsolete.
> > Use the timex extension from gawkextlib
>=20
> get_sleep_time() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local duration=3D$((RANDOM % 5=
0 + 1))
>=20
> 	echo "$((duration / 10))"."$((duration % 10))"
> }
>=20
> With this, we should be able to drop the awk script form the test
> case.
>=20
> Martin, what do you think?

Fine with me, and actually, nice. This way we don't need awk at all.
Do you want me to submit a patch, or will you do it yourself?

Martin

