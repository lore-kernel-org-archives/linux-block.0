Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063E4248A0;
	Thu,  6 Aug 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007295; cv=none; b=pG44HjFfQACB0KtzlJYfMaRpIGsSz/JS+9rCbxONIU4ja2T7Wol8VBKXQNtsHz8QC79gYv0tBLlB6YO8WgePPdA0hop+pygyv8KVQ50CFaIY2rGurnO5x+InQBhTwnK/Y/wVHyrMtgZgiEDEwIFnBkY0nMlWOBVKaTMXbhw0PXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007295; c=relaxed/simple;
	bh=3bicg5ORZDq72OfBoeTcOeYRJc6o7mFDrz62Q7IALxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CI2U+p8R74d4vWlOrJZMRuwCW8Y9mTT2BJYR7ooHnKP0gRii0a6WLfDvic8m1aA66SLl4l82d89L6u9AEI/ZOvUyP1FS7giOrrbpA54C/8XffffdjNlFrl49MhUNATQg04VbMX92ri5SmWIdO9tHpxLc9cvJDUbqseX023uUPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBpzU+3H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBpzU+3H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FFF1F000E9;
	Thu,  6 Aug 2026 09:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786007294;
	bh=c4YQ4eAwJRsD3hueQPNwT8y097gGy2FPUFHvT2YMrGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nBpzU+3HnAiAV9v6gVEL7FlftXr4KwbfEqTPr2E/7q4QCgdiR9nM9YaCU0bHMV/rT
	 rtyhNqdg9KLtU1vYmvbkYlLhoR1APKVEZQcEKlOlrjL7lC70FSpZVwoevXV2vSBR0l
	 F6/OfCgojtwcea62VNOUmaukYzpLddwV0Xp1yRAOvX1tU+Egsso894Y+uD1ygJQo5H
	 dYHEpu8toipmJl9wTLPnvyUXAFI4W0N5UKdClOqEx7NR6sZDx8S34R8Iv+3XrsZMRq
	 3aKkj38vq18A6Fs7lYzUHJ+ELfIlUsPG1whyt6mNpE3QwX2k2cKUk7zS5PU/tKkLow
	 qHSEPCbGF+7UA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Adarsh Das <adarshdas950@gmail.com>, adarshdas950@gmail.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, axboe@kernel.dk,
 bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
 daniel.almeida@collabora.com, gary@garyguo.net,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v2] rust: block: set GenDisk
 block_device_operations.owner to THIS_MODULE
In-Reply-To: <20260806083655.23161-1-adarshdas950@gmail.com>
References: <20260805192020.107601-1-adarshdas950@gmail.com>
 <HxcdCGoRqPsQe1B2W6AuOT-Gsob7jMsUKVOjssQEAOVChpwJ7vPp1bwsGiQ9PzvRT-tq6HvhO98nEw64UY90NQ==@protonmail.internalid>
 <20260806083655.23161-1-adarshdas950@gmail.com>
Date: Thu, 06 Aug 2026 11:08:05 +0200
Message-ID: <87bjbf4nwq.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Adarsh Das" <adarshdas950@gmail.com> writes:

> GenDiskBuilder left block_device_operations.owner NULL. Pass the driver's
> ThisModule into GenDiskBuilder::build(), heap-allocate the operations
> table, and keep it alive until the gendisk is released via free_disk.
> Update rnull as the in-tree caller.
>
> v2:
> - Free fops in free_disk instead of GenDisk::drop to fix use-after-free
>   when the device stays open after removal. (Sashiko)
> - Install the cleanup guard before fops allocation to avoid leaking gendisk
>   on -ENOMEM. (Sashiko)
> - Link to v1: https://lore.kernel.org/all/20260805192020.107601-1-adarshdas950@gmail.com/
>
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>

The reason `owner` is not set is that we want to keep the vtable const.
But with Alvins recent series [1], we should be able to set owner in
const context.

Can you rebase on his series and see if you can make it work in const context?


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/r/20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev



