Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B732D46A9
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070051; cv=none; b=kIZKmSN/xyGhvzJaAjtsVu8E3XLvHGGmY0sR1k5+Ljn2rWbE1wuoNF/0ZTia/LoQWYvQCSLY5s0iUM2WSDIvSJ4EqSbyKvdtf0mSa29X572wtI9lM2HfB1uYRMzxUCudZ4lEWEVvuA49Iz1x3kLpKXxVHjPI3y7CZ5eKPeCl+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070051; c=relaxed/simple;
	bh=YHoUjA/8KX/MmU2Uv6aAwYiYpEqz2AMzsIp8MSWSjbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AknRRkt/qJHlrMsHHPbDKiZ+py3L9+jsjF+dM7JJAUUcYV+CYS45qghG/gKp0Qx6hxVUKpIBphDXq5vZRejbNFm1IXZOZ00DxSgWnTzWy7heXA+p2ISc9I+8lv0cvebgcc9ckbHdqb/9uuE6Pu06kzY7hGplW4E873bGnvAQWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZyHJlpG; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZyHJlpG"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b788e2581bso2984095f8f.0
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070048; x=1755674848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=17SD2UwpWysDD6vNNdHlWpNPy0OKiiXdv4ame2mkJNQ=;
        b=MZyHJlpGz9zMGijGFCBzEXHlCgGtWADe8YC3voZe7lM2yuhL6lDpgB2qzTBDxnXSNy
         xIgFsy1yopvy+OWjyWEG1krSQQvThUDHz1hmCHipVzDENcS/4k7/Ix6cgW7oMECmlxK+
         jlrJL6is7lJk1NvHMPKYwWeJ7o9l4OPvJR+9J9dkuCkpntKHxpJ9Hlca14CqmB1jXp1X
         L0qKsyi3/qfBEDDDxpSPm4pB5ccoLvBkn4LS03kS7krhcwKZAvFH6eItTnBFQ0plD/XY
         zqkIklJJi2kCLyzj+RWwzTq4s1K9kJWyHs7CzrCSVgq5RSETK1QGFW64eLWXj0a0tNjS
         u+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070048; x=1755674848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17SD2UwpWysDD6vNNdHlWpNPy0OKiiXdv4ame2mkJNQ=;
        b=Kw1/o/a5Oh2j0LuhdP8L8b8IcE7lliuk3Ax5FCAWALBEn8xAogHHIYV9jPOMiOtZ2P
         ORpxKh88xcJZZlx1alPnYOgiLEhill87vZMeiCjfEVkTbvOeXTqsE44vKHGQ45zGlx8N
         prRDgzeWByIFvCJCkQHKV0BLM2HRIrw3F3Ljd6mbLfk5c2eb6WkVpHvRz0+7kUFCFuGZ
         sY2Ba2WPrNcp2uyvwT/G1whmazR6xS5amHNIn1VgxoNRL/UDVP5itooguYmmBfnii454
         cb9MilZexSKfdWUu+n2T10JjBQBu0e+hSWepkTuE9fxCbobjKVgPV9WLtX2VrdEvPii9
         E+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXv+sL6HI/JP6mseMS7QaJnnu40zDlzARQjhykrQLJpkH5GC0Ke9SZogB93ygecnX3ZDDpwQ+7eX6C4eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlyBAmm4WyQ+DBKMcr0IsxeBJagXJcObrFWyrqMbhb0f57jbU
	+0KPdXalZbCC7RBwUCPoA13hRrMCa6lrNYAf9/jtIP54UBI/Z3QedLo71HghREsAFsXLeR/W4Nf
	Ph8clFjTiLYETjjPzRw==
X-Google-Smtp-Source: AGHT+IGwdUHoW8Y7DCJnE3LmPWgw+RTDGRfKlKIp2l/UIObWW7mCAH6YZMY5QXAF8IY4M8lipLx+ulfYnIu9PdU=
X-Received: from wrxp12.prod.google.com ([2002:a05:6000:18c:b0:3b8:dd81:b66])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:250f:b0:3b8:dabe:bd78 with SMTP id ffacd0b85a97d-3b917ecf44amr1294514f8f.54.1755070047818;
 Wed, 13 Aug 2025 00:27:27 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:27:25 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-11-ed801dd3ba5c@kernel.org>
Message-ID: <aJw-XWhDahVeejl3@google.com>
Subject: Re: [PATCH v4 11/15] rnull: enable configuration via `configfs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:29AM +0200, Andreas Hindborg wrote:
> Allow rust null block devices to be configured and instantiated via
> `configfs`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Overall LGTM, but a few comments below:

> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
> new file mode 100644
> index 000000000000..8d469c046a39
> --- /dev/null
> +++ b/drivers/block/rnull/configfs.rs
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::{NullBlkDevice, THIS_MODULE};
> +use core::fmt::Write;
> +use kernel::{
> +    block::mq::gen_disk::{GenDisk, GenDiskBuilder},
> +    c_str,
> +    configfs::{self, AttributeOperations},
> +    configfs_attrs, new_mutex,

It would be nice to add

	pub use configfs_attrs;

to the configfs module so that you can import the macro from the
configfs module instead of the root.

> +            try_pin_init!( DeviceConfig {
> +                data <- new_mutex!( DeviceConfigInner {

Extra spaces in these macros.

> +        let power_op_str = core::str::from_utf8(page)?.trim();
> +
> +        let power_op = match power_op_str {
> +            "0" => Ok(false),
> +            "1" => Ok(true),
> +            _ => Err(EINVAL),
> +        }?;

We probably want kstrtobool here instead of manually parsing the
boolean.

Alice
