Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6713A242
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952071; cv=none; b=rLUmm4QlCkwesVUNuND3CycIaQVoLGkSEyPhxQGxdvkFoFt9/vc5yQRxXJ2a8RetSc62+lr/lUs0PoYOpzMo+bjPBdVLv7gdXXvw+TVKfgS3R6pGYo3WmxwHILFDnjdr7xYL+KAiJZJ0fsKBbxd5CGzCMhVuprQkmkCwNxyuc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952071; c=relaxed/simple;
	bh=Tzupit/7jNP49QkdU+n8i+au8MHleKVz7I8yNFSGpyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHrpDZo1t1eZvJ+QAG+Y33QjhEGj+1hu6GooHhw+hXcuCWcbwvhJlLc1chhUF1uPu5H1DcLc3ROCKHhERtF5afR/DyAhugqZDQPixy0ufAt5bSemA3UrZQKehUy6IJgQybdGwtQLg9f/6Im+6FEbx3ellUMQSoSbNxzYtBzOQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fIRuZs94; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fIRuZs94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725952067; x=1726211267;
	bh=Tzupit/7jNP49QkdU+n8i+au8MHleKVz7I8yNFSGpyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fIRuZs947rgsw2YJdY1DkPsT+rjYra71BQiefVgwdAx9RWaTfNdx0Z/DDJRJX9B/p
	 hDBx0rO+nsmSQ0gmsF5uD07hbnMjK7HoR8EqCQnq3jVM5DMC4GxXsqGMpcpH4vy89c
	 YPH9FcGFB65HovM52HgdP/v+x5EKhBAuJZ6Nuni+v1aV/P07WmTkhIQo8rNXtDfaHA
	 sCfSjVFtebGEvryfAC3bZPWqe8ykB6Po6zSCWuxSjt7xKTasqikMp+bMX/wjzvvw3C
	 aFwVEG1YlvKRAI7x97PUmwiAJzqtFQwDMdcHkSvlj+A4AcZbLziT/AYeKDzKhYdaY7
	 9+wTnDJZgM2JQ==
Date: Tue, 10 Sep 2024 07:07:42 +0000
To: levymitchell0@gmail.com, Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rust: lockdep: Use Pin for all LockClassKey usages
Message-ID: <f56dcef9-5dce-45e7-9de8-b12e2e723ef3@proton.me>
In-Reply-To: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
References: <20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ba27d37648ef86cf0db6638ab469fea20779d898
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.09.24 01:13, Mitchell Levy via B4 Relay wrote:
> From: Mitchell Levy <levymitchell0@gmail.com>
>=20
> The current LockClassKey API has soundness issues related to the use of
> dynamically allocated LockClassKeys. In particular, these keys can be
> used without being registered and don't have address stability.
>=20
> This fixes the issue by using Pin<&LockClassKey> and properly
> registering/deregistering the keys on init/drop.
>=20
> Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-1-nmi=
@metaspace.dk/
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
> This change is based on applying the linked patch to the top of
> rust-next.
>=20
> I'm sending this as an RFC because I'm not sure that using
> Pin<&'static LockClassKey> is appropriate as the parameter for, e.g.,
> Work::new. This should preclude using dynamically allocated
> LockClassKeys here, which might not be desirable. Unfortunately, using
> Pin<&'a LockClassKey> creates other headaches as the compiler then
> requires that T and PinImpl<Self> be bounded by 'a, which also seems
> undesirable. I would be especially interested in feedback/ideas along
> these lines.

I don't think that we can make this sound without also adding a lifetime
to `Lock`. Because with only the changes you have outlined above, the
key is at least valid for lifetime of the initializer, but might not be
afterwards (while the lock still exists).
So I think we should leave it as is now.

---
Cheers,
Benno


