Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54235979
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245942; cv=none; b=dMdrW5JUlct6J1HshLpc8t1aT8ztqBsNHwKqPmyYemmYxMYDiJA1wM8OmlBHlwJp/C/JaQyUPdNh0OQx6+hrfa3CS2yldJwUDsYLo+F7ARpMjst6pAfUtEuayzHASd7dtJeGZpbDKvnM2kCUr5Bqdm3sPtx8r6kdUh4Kr5lgO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245942; c=relaxed/simple;
	bh=qYNnASJXGgxVvYIwlxVKql8fQDStNuzDeqooYI3aAFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qycD1CyJ6cxV3g8gdHs2sdwmhh2MosqM6E/8UH0dEImOU20k19Q92aiIfh726PTkJVe+bLp5GtOk6niukru45brb095wbcy/sJUKzV5GQEhlBeT111C8G1SUeQO4fT9LQw9Yyew/ISwyFTcA0hThU+Bt2RArIeMX2z1tytxVTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOSQ28Bo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOSQ28Bo"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9edf34ad0so1032766f8f.3
        for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755245940; x=1755850740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=683V42xtEdd11uSq7e5NHFZBkZMDGTB8S0uZQebs/ak=;
        b=wOSQ28Bo158IqBqy/pWlDlFsgtv9lfDvzorqDQKoth20vEcitXK+2wDnxfOALv7fHa
         dUak24mcckjIEVFM9bPAPC022MTuZJ4EwkRnWUcpwZZT6OFgmlLjtuf6npzuc7nZwmE/
         kQ7mwFi+d6erloD63Pe0pXsHkhftKzd+JYmu2JPW9WyOOO87valTu1DRAqvWUdTNO7hX
         Dp5fSu8G1HNEmP/4D650Yo89oaUTs70BX9aAVdgZSe5lXVDC9GRrLGX25h2vOO7HU2eO
         3YXDFHABpy/F4j0G47HQA4kcyAsWXL/7LP8QvJoMkWU3w2A14KcBj8YU0rojYWDpgkyC
         Z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245940; x=1755850740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=683V42xtEdd11uSq7e5NHFZBkZMDGTB8S0uZQebs/ak=;
        b=ENSgEVOfOeMiOS+bY7JdgfD9Ue5oo0w4q89pLeMWnYDyGsMR/6R8YbB113r0yxzu/Z
         lpe6RNrI4rh+pG7usTHyUuk9BlpdJUpEycy/jBQBjK2ZCI7xNom7bAF2hyFbTEpoCRzS
         iBPvdXJvAOvGn3DjWdB46c9vJCdgG/gFX/aC4lSx88lXm6r7DLeXO6rCbY+6N56izrXk
         i8bd2rxBQ1huh0/ko27vJGpzg2kx0OeWhCUZvrzJIk8tnap42CFvkO9D832tiZ/DxY1r
         AszJYeqxciYJXrJYu7hc+VKp9SIbm6cOxUSPj6cqMura+zpG09x2a5vbNzW+CvXWtEia
         VMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyF4m2jEOCHvlOhS0Wz7LoBTx0oGzQXygdjFXYP2zvtu5+ooR49m3Fhv1eKA2tv/AWRmYqQU/WaMeHCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLm5/aRT0ssxBrUKF9EPwevnSdqTVy4/5SaQG2mj7COZo/ig3
	DGFtny/BNvoxqySsY/FzmhJh7D3jIKF4ym3GkoI220U0DGKVhb46zex8vrXuIjjzCtX7/TFSIVJ
	j0g0sNyebODyQFhMkyg==
X-Google-Smtp-Source: AGHT+IE+8bwfxGrPX5c+j72P+UldeW2lUoB6l/CiAAVFVMchFmuMTZGNT3nWFVg4Xnt+KARKO8gZ/bdkM0nin/4=
X-Received: from wmsd12.prod.google.com ([2002:a05:600c:3acc:b0:459:eecf:e14e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64e8:0:b0:3b7:89a2:bb8c with SMTP id ffacd0b85a97d-3bb671f5058mr803318f8f.16.1755245939593;
 Fri, 15 Aug 2025 01:18:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:18:58 +0000
In-Reply-To: <20250815-rnull-up-v6-16-v5-15-581453124c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org> <20250815-rnull-up-v6-16-v5-15-581453124c15@kernel.org>
Message-ID: <aJ7tcmOHfFmHgrY9@google.com>
Subject: Re: [PATCH v5 15/18] rust: block: add `GenDisk` private data support
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Breno Leitao <leitao@debian.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 15, 2025 at 09:30:50AM +0200, Andreas Hindborg wrote:
> Allow users of the rust block device driver API to install private data in
> the `GenDisk` structure.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>          self,
>          name: fmt::Arguments<'_>,
>          tagset: Arc<TagSet<T>>,
> +        queue_data: T::QueueData,
>      ) -> Result<GenDisk<T>> {
> +        let data = queue_data.into_foreign();
> +        let recover_data = ScopeGuard::new(|| {
> +            // SAFETY: T::QueueData was created by the call to `into_foreign()` above
> +            drop(unsafe { T::QueueData::from_foreign(data) });
> +        });
> +
>          // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>          let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>  
> @@ -113,7 +121,7 @@ pub fn build<T: Operations>(
>              bindings::__blk_mq_alloc_disk(
>                  tagset.raw_tag_set(),
>                  &mut lim,
> -                core::ptr::null_mut(),
> +                data.cast(),

Is the cast necessary?

Alice
