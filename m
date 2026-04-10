Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB601219E8;
	Fri, 10 Apr 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824783; cv=none; b=MJ1jFmewb6yuJU3WVXzPRKHx4rkbUlyTfZaTcnkrfdnk76begrgLXpj3jJG5wJMfb0S+tQRIEnWlQt9NxVPKlclf1bNSiC1Sxtih83yQ+kY7bH4RefTCLaTvOsq5D+YMuRNViaOEGDHxed24z/7uRyTy14o7LykvB6ZoqZ/3VTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824783; c=relaxed/simple;
	bh=qmoZThiTK3w+s9DPHIz0TXgdSkCpMU2I05iVKf/6IS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h09sWq2tn46r4yNdvMnBpLv90yHkfWdshW0lsp4lsh9JcrPi2wnvGnUBbgJJRSUwmAAdZxRAsZE/2A1jI6AXDpBAIlp/aN9AHLv/xrR3OvPy9xwRSJ74R3SGTcwtakxsFj03tysiLPZRRqqLsxJGA36p01/PpF8s+OYkoGQj6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEy1ZIlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEy1ZIlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D443C19421;
	Fri, 10 Apr 2026 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775824783;
	bh=qmoZThiTK3w+s9DPHIz0TXgdSkCpMU2I05iVKf/6IS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kEy1ZIlAkhvNb/dJHuIXSOe3sbDBhbop5HHaDONi3qbFZQNYJkKCaeCDBGycupU5X
	 ZuOLseaeS9Jvh1gUxtVqY8gnuz3pKJVFjGCH7DKmJOI/2220lSyQH5c1nt9KfSbaHD
	 iRxzJTQ2/jqC2rVe1NXlUlKrXuv+Q3ZXVutejjOLJ5IH5XtpyeSOtipkFh4cRh/3U8
	 g3n6tIARChXj00FNB3jxo967mca0AoGt3oKwjAnhnrllLnFs2doXD0OT3qRcLVIy21
	 cANmH9aKnjRNqweMplVSxhAglcqY+PcsyeU1IPvS6RMiZ53UF5ENz5u7HrdNnUF9LR
	 WjJexOOI2BC7A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>, axboe@kernel.dk,
 ojeda@kernel.org, linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: bjorn3_gh@protonmail.com, aliceryhl@google.com, lossin@kernel.org,
 boqun@kernel.org, dakr@kernel.org, gary@garyguo.net, sunke@kylinos.cn,
 tmgross@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] rust block-mq TagSet flags plumbing and rnull
 blocking wiring
In-Reply-To: <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
References: <ne6CiAojHihZEG_ev_i0nlu5Pnr_zliA5ODFH5OM1m8muKLCmOMTquymtKmTOSHR9wTVYSki1RzBYq9rhtEUhw==@protonmail.internalid>
 <20260410090829.1409430-1-wenzhaoliao@ruc.edu.cn>
Date: Fri, 10 Apr 2026 14:39:30 +0200
Message-ID: <87o6jrvvjx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Wenzhao,

"Wenzhao Liao" <wenzhaoliao@ruc.edu.cn> writes:

> This RFC series fills a practical gap in the Rust block-mq abstraction by
> exposing blk_mq_tag_set.flags safely, then wires one in-tree consumer
> (`rnull`) via configfs as a reference.

Patches for this functionality is already submitted to list [1]. Please
take a look if those patches solve your requirement. If you require this
functionality in the kernel, please help by reviewing the patches in
that series.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/rust-for-linux/20260216-rnull-v6-19-rc5-send-v1-12-de9a7af4b469@kernel.org/

