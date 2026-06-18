Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CD3E9588;
	Thu, 18 Jun 2026 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785107; cv=none; b=uxzCeX/Zj/ixhgzSzb6epBTRtGsvDAizK2EFZ615smm1408ijg3QAT465vc5UM6nFovHhuSmKzbbaucqNYrqV4ZuruEDlLT5F1jqJDz1niVk3qh+7fCk6TbID0P+eRkb7ByI9hZQ7dkXJRJlOAYyUIoqiCJykm4x4sOx/gfjXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785107; c=relaxed/simple;
	bh=/IMHFCTpEmbT0Ogk1LeIliz7VqNHiat4WqgNfPhAoMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNTlX/kst3J37Sp4XXUMYB1yqGHOgz0cuwatW15AWI0eAVGi+OVHqBLBdLI6nKfk+pRD1myvbs4ZErecEVhGdwU/0DwdO2ML6tuYFkWPxk869nEx30aSfkCuTEzivTDh06G9Z1vQSxe3fSXThF2JiB78xVz8YQqJI97v/LXUVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Sk2fni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Sk2fni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0D81F000E9;
	Thu, 18 Jun 2026 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781785106;
	bh=/IMHFCTpEmbT0Ogk1LeIliz7VqNHiat4WqgNfPhAoMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=U2Sk2fnigIIfCCreUea8OkXmiOdd5RIh66lLcOJcr/59X6/gAuq+RJwoA4CokLAS6
	 b5wtJWgQB4IibAdeZh9tM95pttJYCc71yKnIh1xj5mA49uxJhGrVcBBVnTG/SdmdMd
	 gLmnUDVKG7cfWL1wNLXP3iZSyo5q1urY0GN1JXC0V1LY74iQiyXtq4DhZ1VhZqjsb/
	 II9LC0+wBVMdxCWEEFehp3uCRdMEf7eBb1n33QiHnGXcbxyMYMSZ1ZGXuj9a7p7Lqv
	 s8DwSiV1yYg+n/I7ElpP7FJOqbayB0FQ9M38f3pF06U3wiQmvZDUgFMl975kDRVPWk
	 xOXY+DDSlpyHA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, Alvin Sun
 <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 7/7] block: rnull: use `LocalModule` for `THIS_MODULE`
In-Reply-To: <20260521-fix-fops-owner-v2-7-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-7-fd99079c5a04@linux.dev>
Date: Thu, 18 Jun 2026 14:17:53 +0200
Message-ID: <87cxxof3f2.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Replace the `THIS_MODULE` import with `LocalModule` from the crate,
> consistent with the move of `THIS_MODULE` into the `ModuleMetadata`
> trait.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

You need to squash this with the previous patch.


Best regards,
Andreas Hindborg



