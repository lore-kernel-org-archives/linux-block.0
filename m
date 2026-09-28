Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5D492E2B;
	Mon, 28 Sep 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589065; cv=none; b=QhAISK3FJvk7Z/x41L88T/fHGbR+uY05tDg2ia1N4gYXoy1wTV2pWMx+GPNjyZe266Qg5j66JkVH/rcxaMPL6MqnSkyngyyHOsRPr1pV3NN0VD3kdB+rvkj3AVxHogGkXhk+fjMdqUDmbMjmaDP2A9rE3jwFJ9uzWGKegupVGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589065; c=relaxed/simple;
	bh=HkZFNvVJZi5JgyWoWMmfGL1idQzOcVCZilKxiV/d2zk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u2HYJteuZO82Pf/b9nLG8eIldC7DsuS67s8apTEozjnpFHHoXMSp278woLhSunmlrPzTNyMfV7qHsKUmdX3Me3Nb3Q/mFQ0N2F4hjVFIShO0iKuzzzn1p9hIT58JIv2KFI8t8fc6ms2+cyyiN23jnq+TpKw+jRKduHpl3ZNSpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYrouVop; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYrouVop"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F1D1F00898;
	Mon, 28 Sep 2026 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589062;
	bh=1c+sQSyKhCAR4lRuOMTHtCw2Xtc68VZjOY4nipGxIwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FYrouVop5lT0NAZkNX7YOmU/Zp70JfQViGuZ5UJ1HaLPAvrqp61fXp9QVGOM5o7q+
	 y9j6isUUEG2aZXnSY4Nq4OJk2Y0jzpUd37CDC3oqHgkE11ooZ7NMSIS1dlX/5qqHm0
	 t4zI5CapqCdAOIZyNpTXn5JhouTI0JbqhdJRkyunGMsId1tHGJTeuxyGgzERD38kI8
	 9HNBFoFJiWGfmbn/xb4W1L7fC01rcEDN5l1ASsh9F8I1VcDh+MNkZUUHzk21r16a8S
	 i+XwJ2ZDk0YQ65m3YUbeX/M+d9OTgejsQ92VOK/o0hgJGl4JtMNrk7zKzE6F0Y4ZM0
	 dlNrK7nF0PRUQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Mohamed Osama <mohamed.osama189110@gmail.com>, ojeda@kernel.org
Cc: boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, longman@redhat.com,
 lyude@redhat.com, linux-block@vger.kernel.org,
 linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] rust: introduce DropGuard
In-Reply-To: <87jyo5u2nu.fsf@t14s.mail-host-address-is-not-set>
References: <Dch07wH15t-1WtaVQW4vdfmtJuwC_4-JLvrWSB8Pk4vfEHO6mQk1FpYG-tCYBllTB3RbpOXpdyNZp84w4PFl1A==@protonmail.internalid>
 <20260927104528.103881-1-mohamed.osama189110@gmail.com>
 <87jyo5u2nu.fsf@t14s.mail-host-address-is-not-set>
Date: Mon, 28 Sep 2026 11:50:53 +0200
Message-ID: <87h5j9u2ki.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Mohamed Osama" <mohamed.osama189110@gmail.com> writes:
>
>> This series adds the Rust kernel DropGuard API and migrates existing
>> cleanup guards in the block, serdev, and locking code to use it.
>>
>> DropGuard is vendored from the Rust standard library and re-exported
>> through kernel::mem.
>>
>> Changes since v3:
>> - Vendor DropGuard in rust/kernel/std_vendor.rs and re-export it from
>>   kernel::mem, following Gary Guo's review.
>> - Remove the DropGuard KUnit tests and Kconfig option since the
>>   implementation is vendored from the standard library.
>> - Keep the existing ScopeGuard API unchanged.
>
>
> Could you allow for at least 24 hours to pass between new versions of
> your patches?
>
>   40 mins. ago [10/10] Mohamed Osama, sashiko-bot@kernel.org, Boqun Feng =
   [PATCH 4/4] rust: sync: lock: use DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>   Yest. 01:53 [12/12] Mohamed Osama, sashiko-bot@kernel.org, Gary Guo    =
[PATCH v3 2/5] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>     Sat. 18:46 [11/11] Mohamed Osama, sashiko-bot@kernel.org    [PATCH v2=
 2/5] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>   September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH v3=
] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>   September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH v2=
] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>   September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH v1=
] rust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>   September 16 [2/2]   Mohamed Osama, sashiko-bot@kernel.org    [PATCH] r=
ust: mem: add DropGuard (in =F0=9F=9B=A0=EF=B8=8F ur)
>
> I'm confused about your versioning scheme.
>
> Could you include links to earlier version of the series when you send a
> new version?
>
> The b4 tool handles most of this for you. I would recommend checking it
> out [1].
>
> The first v1 has a link to a github issue. Could you please keep
> including this link? It is helpful for context.
>
> Best regards,
> Andreas Hindborg
>
> [1] https://b4.docs.kernel.org/en/latest/contributor/prep.html

Also please include the rationale for the change in the cover letter and
commit message. Something along the lines of what is in the github issue
would be fine.


Best regards,
Andreas Hindborg


