Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3338F953
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658477; cv=none; b=iSlVBYnS8UoJFrvPME6weRw7eEs5r3BUeqXWGzAu9ahMi+6afR1nE6o2N5zuJpLGRPCfQIKUg2R92rvc8IgihK71s7GepSAmV3+lKfkRL1/FqDgIS515b17l72WJfQC4YpOw3YBYXj/50ViR1uA5GNvlwZDuwGgC6yPL4zNCHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658477; c=relaxed/simple;
	bh=ZSI57h88KBCxyATmpw8R75Wzmeb6Dt8kMCMihmwiOJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UJafqq86MbKleX+JP/jCsHgGgglXgJ3vUPgQ8hS53+xuRqGQRP9zDR05zq3qyaf+H7XyjXbZVD1g8i2l5nlXZbnBZUHFg3z+ab4Xnlhn9XVTQVNkdcR+gpkCMg7uenHsvFbXFxa1heSAaDSHCJl0NFRgLEgpu/0Isbl86pSdQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUm7EkC0; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUm7EkC0"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-439c112b1a4so2853338f8f.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773658474; x=1774263274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/+9kuHNGmF6mJHiC+r6rqWEh7NXnQhAjyYAhKBwFD4=;
        b=UUm7EkC0smY8AI6r0gFfAX3dmR+zfBU0h/70NgfUHYanSmk3KUYOiCNI60MYsgT5N1
         OYKV9x9EqzxevWisNyZpzi6fMj6/0GaPtDE/roOK9xtAT0L28rMQSE+Co5GgoVdMIPLS
         kLK4bMaeGTMtifXjF/4n/Z+PPNQhr2Utey5IlPuBrFSQvnggXDsablp3N2O/vnhyHr8H
         ls8k/8fJn7S/qSr2ktBr7022G+X4oWlS4thYXxpftnjWrZOQYpast3yt/cKpH9nW4N2X
         xJHXnNqLwvRLUNqJUJu5BgAhjyDU3NiHN7VeK1B0gEM173eb7ULNWbEX/Dt/SNR8S5r6
         Bp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658474; x=1774263274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/+9kuHNGmF6mJHiC+r6rqWEh7NXnQhAjyYAhKBwFD4=;
        b=L0hfvw7ZduMSFOAHZuvgBrU0du+9oMCcDcd+oUz1sfixQHv9SXC2IoD9Ct1tRulTNg
         8j7iylvLVK5CDJ2dClJgEmb/2WOXo9o2lkpH7MPWu1/bD1oldW/4NMvW8zznXtreWYOd
         gumZy1zVHWpZ5K7n2d7iBVAkBM/f+a7KTSeDkHPcJZZ4NE5pjDpWx3PfDSzSfwNVG20T
         9MOrsspG8TKzR7MVVBNnATq5KdixabW0+ylt8Aqgs+FEWr+lNy9nAHbjZqwOTyM4q9Dg
         bbzfalbRCwXMcJXQU0KkmdSr6TZ7FIkJyCKsjQGwtYf38MJYsA+82GLGOdmTccoDFojp
         j5DA==
X-Forwarded-Encrypted: i=1; AJvYcCWqdFJia5e3NTTYt8zgl4Lp3QV1D8Oj+dKnRf38ZjHzEaaI2bKNoeS1CBgFplfO5wZCXh8tGldgq/Eabg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLI23y6l138DFrCjcuHpP36AUKx7tUmzNkMOn2WI/qSf9a+1be
	hjV66jEfLq9NBCzCkZpHPwRPafbJ9uhuKmIbLQaNvfNNcPrKVc/K7Diodfa7Ij3FOoi5aoRm+DC
	3ezihdzCQH3xtdTY4cA==
X-Received: from wrbee14.prod.google.com ([2002:a05:6000:210e:b0:43a:397:db8a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fd4f:0:b0:43b:3bed:154b with SMTP id ffacd0b85a97d-43b3bed1827mr7373388f8f.40.1773658473980;
 Mon, 16 Mar 2026 03:54:33 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:54:32 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-22-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-22-de9a7af4b469@kernel.org>
Message-ID: <abfhaH_aOBHijWGe@google.com>
Subject: Re: [PATCH 22/79] block: rnull: add no_sched module parameter and
 configfs attribute
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Mon, Feb 16, 2026 at 12:35:09AM +0100, Andreas Hindborg wrote:
> Add support for disabling the default IO scheduler by adding:
> - no_sched module parameter to control scheduler selection at device
>   creation.
> - no_sched configfs attribute (ID 11) for runtime configuration.
> - Use of NO_DEFAULT_SCHEDULER flag when no_sched is enabled.
> 
> This allows bypassing the default 'mq-deadline' scheduler and using 'none'
> instead, which can improve performance for certain workloads. The flag
> selection logic is updated to use compound assignment operators for better
> readability.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> +#[vtable]
> +impl configfs::AttributeOperations<11> for DeviceConfig {
> +    type Data = DeviceConfig;
> +
> +    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> +        let mut writer = kernel::str::Formatter::new(page);
> +
> +        if this.data.lock().no_sched {
> +            writer.write_str("1\n")?;
> +        } else {
> +            writer.write_str("0\n")?;
> +        }
> +
> +        Ok(writer.bytes_written())
> +    }
> +
> +    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> +        if this.data.lock().powered {
> +            return Err(EBUSY);
> +        }
> +
> +        this.data.lock().no_sched = kstrtobool_bytes(page)?;
> +
> +        Ok(())
> +    }

Not using your fancy macro. Also, TOCTOU.

Alice
