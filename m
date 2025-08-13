Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3FD2C21D0
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070348; cv=none; b=EfpgugMFHsSe/dx1dhWZv4zI2yZ5POXMkXfX3FCXhJoriq4btsC8NI7mDwkypDdceib9KpYOqLRNA/fJpG3OVlAY/ytfZnpqm0sNV56ooo4ktceUl5vBtYhNG94+L3GnG78l//Yo0Wn4y40C639AqjNOXkwr53/SvYFLJGnZPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070348; c=relaxed/simple;
	bh=IHuZIPIubs/w3SJF5skp9Te+eH5DawaYvyi++z+e2+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CUMTTnwqFvmPwQnNWn+/cD/64Rl+5Bj+C9JC/gWdcYXOnj40ZT1OduO53op1xOFpp7DoRPmIWJYMmYkO7NqRW+Rw9vp4PTQfoZR7M5M5QJyBVIO3IHHgavoCb4AvkmwN2JsOuViKeA+T0wAPSgPMiI+PHcjp1dvhBqKDpRiC1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNPFUwNl; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNPFUwNl"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b7812e887aso2966132f8f.2
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070345; x=1755675145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5312UrazGm2nSYVWWroUOeaj5Kd6bEVW+F6s4R1WTC4=;
        b=iNPFUwNlBqgNSEiZ6QAOBCrHH/jtjgqtB7OKbSCDI5mVVfWpxvwNgdFszEhBpua9bL
         FmMMgD6NwekZQPTkMfAiEptakgZsb/s6Hn7xQwJopEe0AEtr0biPPaRgeqza/nv77uRR
         bsbIL62dgjBzXjPkcM822hEkhRLXspqMto264oASMZTSbhAM5NA8Kphs7GC9FLlhC36v
         OlXI1A/uL+7TRMNmPgqeO3hIT0JBAxwMkmRAIOps3BplNY/SMeIQvSqeR8tdYz8qZnKF
         z5mpjzauuKQPKfdOFDJ7xrnBkiB5OS81A6LTFKA/zNtjdG95Kpza8PlAfP9AYmFicUjv
         ZXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070345; x=1755675145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5312UrazGm2nSYVWWroUOeaj5Kd6bEVW+F6s4R1WTC4=;
        b=tHvYb0aTMyRiUHfgWkLIAyqzUnStUC1lXuH2O4K+K8KV3UKpEPo9w6ChZMjKCNGx+g
         2y0NcZrHZIY360nJZ6Uexf4zO28eLDL5HLivfqXoKpiJLDR4LUK/akj8ZecVp4EO23lT
         Xt5LEHIvDbsMLvkJj4UP5ApnD8L3RlE5qimi36SH5KLQvwXBkJ2qiTtjKmhJSUbzicOo
         jetIsfbSnI0SDgoZD/8jnhkz6SbKlO4eQ7jNfeCjoRCmFvDnOUzV8589wuOTFG4G9ZhO
         pQcc3lOuWh6neeg20FncZWDdE9NIiE/6Jt8I2PI2u1ELI4J949SzJaRR5+LPKVHqArm5
         9/vw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3n7r4IZdrtbjY4obUGSSC1ZHZxj0m8lEBMgp6X7Hn8v722pnXQkmm16bLrnekhHwAR2nkZBvyBGogw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0QPI1VjMAPxfq+W14S5aoMZteBViOMR4OMm+zfaxV+G4tlAEO
	or0yUFr1/V/zxj5lUjVPrHkC0thxCHGpg6fqoY0KNmynB7j83ey/ctDl9m0gAwqzg0DG2pph7MS
	t61Usdr5Ky5m8zYWaeg==
X-Google-Smtp-Source: AGHT+IGoPY0Up3k4B4X0DXNUDKXTeE+1fGEGc5eaPkBD/CJZX1FdQoee8fbt1gqhWP4uOguA63HM+AhbSh+cNrc=
X-Received: from wrbgv1.prod.google.com ([2002:a05:6000:4601:b0:3b8:dd13:ef63])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:250f:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b917ebf766mr1284367f8f.48.1755070345355;
 Wed, 13 Aug 2025 00:32:25 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:32:24 +0000
In-Reply-To: <20250812-rnull-up-v6-16-v4-15-ed801dd3ba5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org> <20250812-rnull-up-v6-16-v4-15-ed801dd3ba5c@kernel.org>
Message-ID: <aJw_iJZLXPml4Abl@google.com>
Subject: Re: [PATCH v4 15/15] rnull: add soft-irq completion support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 10:44:33AM +0200, Andreas Hindborg wrote:
> rnull currently only supports direct completion. Add option for completing
> requests across CPU nodes via soft IRQ or IPI.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> +        let text = core::str::from_utf8(page)?.trim();
> +        let value = text.parse::<u8>().map_err(|_| EINVAL)?;

Same comment about kstrtobool here as on the other patch.

Alice
