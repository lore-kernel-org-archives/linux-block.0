Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69761396595
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663256; cv=none; b=GZujPUcec9OttPZ55ZO6+GRBhYZL94IkTWHUc1SOeIuyvcNfuBuU7xPj50l0/KEqXLgLfwWjFSvhyhO5wgcxxXFywC0qbOOpDEQcVUWEBO8fbADOH4iVzWVSApcT2Xbltd73Q6nWXYyKRrJiDj1kSFb9JqMg6z0xaGu0plY5K/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663256; c=relaxed/simple;
	bh=g8GaV3hlfBHoTjjCvqr/4Va/2jyatxk9/l1Nn+6OTaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HzdOO/vTwa4QKKeSZ0Jg3X0sk6cWLrdKPwRqwuvKXLpMXYrOmmFRYML/xZN0nIWVH2Lxq33KWjoni7OtHgmFs1T+Qd1pu96Wl3AK6ZLsXkY6R+muuxIFFwIGzy9+XJfEy76oncd1wmPPvrV9Ti6SGYdXOtwDgD/kUo+JRVGqDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKzalTe5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKzalTe5"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-485389bf0daso30780975e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773663254; x=1774268054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7q2+A+kkZoyV3rsZQKFhC6jq2dbqO9RaZzFL/EKyo0=;
        b=MKzalTe5cMEJnDN5HAlmLI1ENwn4C99NhEkEXJP/9etqTjx8Psrj+LrUnOxl+ASIYy
         xaYpeb7SmEkxNgarhW2Obw4seQt+zikM4udWdv1WnrOVE0rAt7kdDvaIqmNotuMIaQsr
         uV+TUddQZLuZawdkzrMbcAU0A43yFs2kFVgYL9379qCobRQvs6WvdEor1sNijZluPl6H
         2RM/Ck5YZURb5ZZzd+KI1Lmz9YxEB8z+dflOGZG0mL4bEXTrt7VQTCO1MRp2SoauD0NK
         MV6XJyuYb4yX5OeT2RI8VE1eoQl7pnwGloKz7rlbN+OG2fiXRNAFtcy15KnkdU4DyBGu
         q8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773663254; x=1774268054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7q2+A+kkZoyV3rsZQKFhC6jq2dbqO9RaZzFL/EKyo0=;
        b=oA9M9sNmeUKSOFylMrZBTzp9cT5WnCwm9YdHzPeEYvwXeoF3LL4YO7F6pnsd6n7DS+
         9F67Scxr+85FaxvU2RQPqcfBetlLvI3iwFvcaFkeKx3xiMg0mHy/S8G+kbeBO8bcZoAv
         BLbJePb31/w3mP/AinOmtWABb83Vb4oddz9GXfEkGCdPw6I2rtttQK+72FsN+b89RfuT
         iZprBK8ddLdqTV/u1oPIODQdhpoKK+rx09Rw9U6vnR9N/0ZUlY9sKTQ144JoV6g2Wc0Q
         2nwjO4E9muMU7AX14wXxrGA1EBY9ENXW8ITZtQHod1Xxj4KpVSf0v15EBLelFICBPHxv
         n+AA==
X-Forwarded-Encrypted: i=1; AJvYcCV5qIrigIB2qyuYgcEWOzdK0s6MDfHIRHbD1fMEpdy5dmFj0uEBHFEqedSo+Dy5VcqKH3MfNp1VRXpJ0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJIEo7V08rBJTCYW6esGmJ8ovy9dvikaGXuPZJweXJnRr12rI/
	tS+srk/SHKxoR+iaZXM5lNCMJK0bOOTq/k6MmztgI+hdcmZGdI6a/DI471EjHlTGiQl2QZPu47+
	GC0JNC+QAmYCnq5zksA==
X-Received: from wrs7.prod.google.com ([2002:a05:6000:647:b0:439:f5a6:f90f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d5:b0:485:3ff1:d5c3 with SMTP id 5b1f17b1804b1-485566cfa3cmr204531455e9.5.1773663253523;
 Mon, 16 Mar 2026 05:14:13 -0700 (PDT)
Date: Mon, 16 Mar 2026 12:14:12 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-28-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-28-de9a7af4b469@kernel.org>
Message-ID: <abf0FHWkQzbnOtqD@google.com>
Subject: Re: [PATCH 28/79] block: rnull: add partial I/O support for bad blocks
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

On Mon, Feb 16, 2026 at 12:35:15AM +0100, Andreas Hindborg wrote:
> Add bad_blocks_partial_io configuration option that allows partial I/O
> completion when encountering bad blocks, rather than failing the entire
> request.
> 
> When enabled, requests are truncated to stop before the first bad block
> range, allowing the valid portion to be processed successfully. This
> improves compatibility with applications that can handle partial
> reads/writes.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

> -#[vtable]
> -impl configfs::AttributeOperations<13> for DeviceConfig {
> -    type Data = DeviceConfig;
> -
> -    fn show(this: &DeviceConfig, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
> -        let mut writer = kernel::str::Formatter::new(page);
> -
> -        if this.data.lock().bad_blocks_once {
> -            writer.write_str("1\n")?;
> -        } else {
> -            writer.write_str("0\n")?;
> -        }
> -
> -        Ok(writer.bytes_written())
> -    }
> -
> -    fn store(this: &DeviceConfig, page: &[u8]) -> Result {
> -        if this.data.lock().powered {
> -            return Err(EBUSY);
> -        }
> -
> -        this.data.lock().bad_blocks_once = kstrtobool_bytes(page)?;
> -
> -        Ok(())
> -    }
> -}
> +configfs_simple_bool_field!(DeviceConfig, 13, bad_blocks_once);

Squash this into previous patch.

> +fn is_power_of_two<T>(value: T) -> bool
> +where
> +    T: core::ops::Sub<T, Output = T>,
> +    T: core::ops::BitAnd<Output = T>,
> +    T: core::cmp::PartialOrd<T>,
> +    T: Copy,
> +    T: From<u8>,
> +{
> +    (value > 0u8.into()) && (value & (value - 1u8.into())) == 0u8.into()
> +}

This is in the standard library.

> +fn align_down<T>(value: T, to: T) -> T
> +where
> +    T: core::ops::Sub<T, Output = T>,
> +    T: core::ops::Not<Output = T>,
> +    T: core::ops::BitAnd<Output = T>,
> +    T: core::cmp::PartialOrd<T>,
> +    T: Copy,
> +    T: From<u8>,
> +{
> +    debug_assert!(is_power_of_two(to));
> +    value & !(to - 1u8.into())
> +}

Overlap with:
https://lore.kernel.org/rust-for-linux/20260221020952.412352-22-jhubbard@nvidia.com/

Alice
