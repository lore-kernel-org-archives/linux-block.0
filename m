Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F1439903;
	Wed,  5 Aug 2026 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930483; cv=none; b=odHmnnCJqMGWl2jUbRZSOKF4yjIKT+Q8xQvoze6RXG7zK7PnDCsNCw8paYrqO7Vb7SSr/5RPVuBYwHeOJL+3884MClziIQxw4ZaDGlkHrDJD1wks3HP9PDj7YNPbJR1sDH/sZskRbLzOGW7d03k89ynu2OL9ktJUqKyHA/hxq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930483; c=relaxed/simple;
	bh=/i23X/GCA0qH7i2TPHbNsGAzQOFTIgZzx9YRfnv2leU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LdacGZS4UhL6sUKQA+vHD846TteYVSqoNSM3LN/9BTZggT9HwnmZMGh5AnQoR2Wuf26jVyMdibE76k+MrVjMiXRUruAgjzoz67BElLIa2tC83sjpIIAGcw75rhSCgr7k2EKjXO6CYsVSDvxqyQdA4iFJmwoabqURWZIMaNVnwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKQte5ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKQte5ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3BA1F00A3A;
	Wed,  5 Aug 2026 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785930481;
	bh=K0ep+ZnNOPvfw8zQifj80jRcgTPYp36FlFjtfpO4Ds4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iKQte5ceo4mIljjIwbPBtY9OAVmR5FcnsbkNZv+JkIwe2ticCMtLCyaI7vgfUdZGy
	 UVV4NaHRQLmKJBEoLCrGKGY/YtKxrFP0+SlHMWCF6N9HKLZNIJkLVly4HPpBHgA5Bn
	 e8VD9/4ki5dR86ytYiABzmCi4INq/Axj3Lh6k5YMOsFW3ohj+VHn7rPhklp5rnIZHF
	 zNUkSRC+VivpPCQlUAO59/pnSrSKx0nGtUhAorbP5WjER15UyxJkuzHrY9k/6QEXgP
	 qQprlkyuesLcKf5JXuUKqZeCYIS8rSLc/ERyuua/qEazI59L26yE6I4j7a3oC4h2w9
	 g627mlPMpfesA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Guru Das Srinagesh <linux@gurudas.dev>,
	Alvin Sun <alvin.sun@linux.dev>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Guru Das
 Srinagesh <linux@gurudas.dev>, Boqun Feng <boqun@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
	Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
Subject: Re: [PATCH] block: rnull: use vertical import style
In-Reply-To: <20260705-rfl-vert-imp-2-v1-1-e6ab69c55095@gurudas.dev>
References: <tguZBuXyXFqmsEfvLLtcNT06DfKq3-W45Yo19lRFsggGLQgvRRa6wA6rv6ntiX1Q8nAgQj88-PDbjh2gLdetbg==@protonmail.internalid>
 <20260705-rfl-vert-imp-2-v1-1-e6ab69c55095@gurudas.dev>
Date: Wed, 05 Aug 2026 13:47:50 +0200
Message-ID: <877bm494bd.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guru Das Srinagesh" <linux@gurudas.dev> writes:

> Convert `use` imports to vertical layout for better readability and
> maintainability.
>
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
>
> Separating out patches per-subsystem as per the review feedback in [0].
>
> Tested via:
>
> 	$ make LLVM=1 rustfmtcheck || echo "fail"
> 	$
>
> Initially thought that rust-for-linux/rust-block-next was the right base
> branch to use, which is why I didn't group this with [1] based on
> rust-next that I sent out a short while ago. Using rust-next as base for
> this patch.
>
> [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> [1]: https://lore.kernel.org/lkml/20260705-rfl-vert-imp-v1-1-2f07946a905f@gurudas.dev/

I think this patch was already submitted by Alvin back in May [1].

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/20260521-miscdev-use-format-v3-6-56240ca70d0c@linux.dev

