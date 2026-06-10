Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5031F99B
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075298; cv=none; b=E4Dc+VcW6ZRKgNRUliuuEtEDFVwPF8JE9bwrWtXOCQAsInZxG04reoE+9pwuQwrDEekd9GkIK/QstWqMJYgOaYSXDhExOZVDX7Y+cUUNoJ3JY5cBlpvFjhyvudnAvz/Bc2uqAVYClltoC7P7r5NyVQfKj5A2Np1jiEcDv6BIIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075298; c=relaxed/simple;
	bh=TFiWa1rmDutUcjN10SiRILNiRj4mDgrPIXrEwbSEiIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILQq/j3MDjMPD0kJQmSvOUZgnxBheYZlSoWGxLrm8pSUEomGVQM4Ybrq6o7Z6EzJdgu7NfsALLarR3Za81HSd0MmGIUAMtp7YY7GHom39kG9GvoGKWs7hJNdHU/yV1oWeNaQbAAFH0Vcf4tPALLynOBM6SPgz8XNTKTOrjSsIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujMqllwA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujMqllwA"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so55724715e9.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781075296; x=1781680096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2yBT45LsQrwZS6wwOfSrpTFpnj8Zde3n5eqn2ah4Ag=;
        b=ujMqllwAmLcqKdvryCC+/cmjQ3mv3BQzLcfbdO1E/ClpHo42obXaE40bxD4tpwCmtn
         xVk8hBrdnaUr5jRk1hsAUNCv+gcxIIwV7wIOspPnz9PUjInyPW9dMjNe6oeVLC7mmQ+G
         q7o08AJqWRLqoxCMW3irPdTVTWaNOR2JVlwkEZL7TeOV+NZeEzlzUwoHI507OwCc2K8l
         CUIz2X+oWnkOVvykudmfiRBQifq0pqxWuHWihHn+tWVLcGCp/5sG8+wZ9KoH3ZV0rYpe
         fZBoc6HG9fV9q3lV5VAqn3k9tlYBgqw1/5SAeGLsz3kGyM5E4azPSkgbo8hzKnJxA4+n
         Bzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075296; x=1781680096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2yBT45LsQrwZS6wwOfSrpTFpnj8Zde3n5eqn2ah4Ag=;
        b=FQWX6krBLzXf1UWTq+BVE+tttz2mfF3eNi/pJ1m2S3wyf+fFXli9erteK1rDPYnEJD
         FGguYqgHNuzWxn30q1UIOAEFThG2JQ4R/3p52EAQQ9rOcP9XPYlpotdyJsAKTVktwSW5
         006UfTamP748CiBr2Ntf07p5wTuvm2kRYZHdfKtoyeBesWqX08mieQ3ANptNpUFDXARA
         XTgM5zK2ZnOEXj6Vwat0L+XcT2FhHhhbE1bxILWS4XUCy0DMJ02x2JFsb0FTRVwVRqax
         B8CCg/wBa45RkcamFA5Fg7GVRbimi9rP6TvC8fysSsXKHHH8xp65hs2keKRVn3iI7YyB
         IQCw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ihughp7TXUkDTx42pi8FXu0LBuXpyZ5e2UDmqt81YW23iXJ6j8hiCbHqpLYX3PXMe286Q0wEf+iIrzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmkryNxjb4fxzeLOMGQ3zZ5cPMcMO3H5J97/2SbstONLcXKbA
	YaJ+Yyj1O37iiFEqcSG0762+ZQRQKEay7OIms3pzciY2Z0nA/Kb9WL08pa0PpXhpXtHVZXZ9fXi
	BRjOdOo6Vrlq4JFaaOw==
X-Received: from wmbjl6.prod.google.com ([2002:a05:600c:6a86:b0:48a:7f8c:a95a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190b:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490c25ff35dmr400245265e9.23.1781075295394;
 Wed, 10 Jun 2026 00:08:15 -0700 (PDT)
Date: Wed, 10 Jun 2026 07:08:14 +0000
In-Reply-To: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260608-queue-data-sync-v1-1-0efff051aaf3@kernel.org>
Message-ID: <aikNXs-cmeqZn2Ky@google.com>
Subject: Re: [PATCH] rust: block: require `Sync` for `Operations::QueueData`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Jun 08, 2026 at 10:24:34AM +0200, Andreas Hindborg wrote:
> The queue data installed in a `GenDisk` is stored in the request queue and
> handed back to the driver as a shared borrow through the `queue_rq` and
> `commit_rqs` callbacks. Both callbacks obtain that borrow via
> `ForeignOwnable::borrow` and may execute concurrently on several CPUs,
> since the block layer runs one hardware queue per CPU. That means a shared
> reference to the same queue data can be live on multiple threads at once,
> which is only sound when the referent is `Sync`.
> 
> The initial `GenDisk` private data support omitted this bound, so a
> driver could install a non-`Sync` type as queue data and then access
> it concurrently from multiple CPUs without synchronization. Add a
> `Sync` bound to the `QueueData` associated type to rule that out.
> 
> Fixes: 90d952fac8ac ("rust: block: add `GenDisk` private data support")
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
