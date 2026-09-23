Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E857F75C;
	Wed, 23 Sep 2026 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194519; cv=none; b=h8nxo/DnFq4crJDggQv6ndUkrj9I5xvmgt8eFDfe9+jIoPRp3Tb97yaDsGZHU3b5n/VqFd25vVSTxpLNeXc5WrjTGzIbpqmD4XMOpfFdW6kML4jj/KVGqzy5qezXKJBIUA2sxqnUh5LjjCoblQLFBr5ecVvHmq5dNGfYGNLxuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194519; c=relaxed/simple;
	bh=mFOiJ/bjdpQlNjAVpfknx/nBkPybPE28skh237cAfHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JcG1fjmZY5iz+q9Bp02os4S3Nel1Kgaobu2KUwDpg1iHawMlRM8u/kvCjcPtKr4pD5CcpoYxJ67Hm9cSp9xV0DIotzUdbuIb6qHAeHnOhxHnxniHU1U3XbZ+epMkMQuPapdF65uKNaYWX3sz9JwfAhaj3ABbrSNbPZIrEDCJ4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH9VTGwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH9VTGwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067881F000FF;
	Wed, 23 Sep 2026 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194510;
	bh=mFOiJ/bjdpQlNjAVpfknx/nBkPybPE28skh237cAfHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XH9VTGwT9X+Z3N+QltaAKEtHXcHh8B4kr9slZ3/0QTVJH0g9dzAVgbjy/A+qu8kz6
	 0GI9x6ig4Nxy5205ORdybOOCQ2S3wgIO/plGS3l5VUMa+jTe7/lbUZx6g/XHnrXfhg
	 rKzUaPopBfej6yVUZlXYBVXNS/4kxW1UntPwvUhCijO4q075hahT9ISQgyJTGwpeWH
	 mmha60q36P+3q8uVy1PoY2ESVXpDHQi2d3ysv+udkqgH0cj8CYMPjMe0UPW4HD2GIH
	 p5NBKL6/tlW6Q6vrK7oE9u1jAPgUAmwFoGC52nvUCEWkRG6cRCCrvVnvlWYxg4EBDq
	 iTIpj8P3+KbNw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Adarsh Das <adarshdas950@gmail.com>, adarshdas950@gmail.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, axboe@kernel.dk,
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v3] rust: block: set GenDisk
 block_device_operations.owner to THIS_MODULE
In-Reply-To: <20260806104027.83940-1-adarshdas950@gmail.com>
References: <20260806083655.23161-1-adarshdas950@gmail.com>
 <20260806104027.83940-1-adarshdas950@gmail.com>
Date: Wed, 23 Sep 2026 22:14:52 +0200
Message-ID: <87fqyz3etf.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Adarsh,

Adarsh Das <adarshdas950@gmail.com> writes:

> GenDiskBuilder left block_device_operations.owner NULL. Set owner from a
> const block_device_operations table using this_module::<M>() and update
> rnull to pass NullBlkModule.
>
> Add ModuleMetadata::THIS_MODULE and this_module() so the owner pointer is
> available in const context. Rebased on Alvins fix-fops-owner series [1].
>
> Link: https://lore.kernel.org/all/20260805192020.107601-1-adarshdas950@gmail.com/
>

We merged `LocalModule` [1]. Please use this feature to set the owner.

I don't think you need to move the operations vtable.

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/20260811-fix-fops-owner-v10-7-7e71776f9dbe@linux.dev

