Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08034524F
	for <linux-block@vger.kernel.org>; Sat, 31 Aug 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725136795; cv=none; b=Yire8OlPq8OcctilZWzslSG+ZZf9NaX9RcFC47ChJygkoXt4h66xHKgWF9OdaOe3i3xccNzpvFGWhIkFnNPD4F+OoVdVG1dLngxTLDMYqcnJRBbPSPcCCcs0juIX7BSgg0rYhkk6sVJxePise1Ue+hMoceeISoZ/emm41kf/ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725136795; c=relaxed/simple;
	bh=mhihS/cq5yOaJARmL30Y+Gh5dWy9WC7+8eDUwvIXSJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJD52aIga/2szHIInZITGrfJlMyElvQ0SWcZ64UJmO8N9+aQbRz9QhGr2DT2il4HIUIpAmzKeL8SFUwIvWQTGO9BTfKINMckLCh+NjpHz7Wd+RolDfkQFW8tCWLlwRixNGacPbxpU6ajCmLaAxuWi/DDiLIMxsfrxm3G60mIUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YEBP5jE0; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YEBP5jE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725136790; x=1725395990;
	bh=mhihS/cq5yOaJARmL30Y+Gh5dWy9WC7+8eDUwvIXSJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YEBP5jE0IYEUV60Hw037lc77KHJZwzDDHxm78wq7TxgcS+JSPCNcazPiDNXVOWvq5
	 bTjqDYk43hm2G4rl2QK5nqXxCXuITxXG72UeLRgK7btfzx3wGT4EWG/7mBrCGuPhT8
	 I6VITrTMgMuR+Ierw6S9aaPo27qCnmjXQhImT5rJspL8xqPbGVFefwQZ8HJ1Dd9mdu
	 lpKqgmmtynJKrrGd9ZUL0AGnNCL5L+TSXEaBHOO4ITvyLCtVU8zP2Lc5rNe8O5Ao7u
	 7ZLpCplR5iyBH6ydhpNw8mmWEvw/sfINQP1RoYW+vfB4utR2v7HNLuGq8fGP1lzqHW
	 BfhdNMWi/KHnw==
Date: Sat, 31 Aug 2024 20:39:45 +0000
To: Alexey Dobriyan <adobriyan@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH RESEND] block, rust: simplify validate_block_size() function
Message-ID: <309bd39a-0c58-472a-9fc8-6fa33d14925a@proton.me>
In-Reply-To: <005b6680-da19-495a-bc99-9ec3f66a5e74@p183>
References: <005b6680-da19-495a-bc99-9ec3f66a5e74@p183>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6f236265c923c03791dd415e2507f5f126f36b1b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.08.24 22:15, Alexey Dobriyan wrote:
> Using range and contains() method is just fancy shmancy way of writing

This language doesn't fit into a commit message. Please give a technical
reason to change this.

> two comparisons. Using range doesn't prevent any bugs here because
> typing "=3D" in range can be forgotten just as easily as in "<=3D" operat=
or.

I don't think that using traditional comparisons is an improvement. When
using `contains`, both of the bounds are visible with one look. When
using two comparisons, you have to first parse that they compare the
same variable and then look at the bounds.

> Also delete few comments of "increment i by 1" variety.

As Miguel already said, these are part of the documentation. Do not
remove them.

---
Cheers,
Benno

