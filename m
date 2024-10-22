Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464B1CCB58
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635818; cv=none; b=tFCulq6J3Bi1dxHL+7d9qp7HJpgBtMrAyMp1YJGJkRiMQOd/89K9Z4xaUjRv62UerceD3ww59UFddQcaKmSgE8p2pwDTgQhP4QGnUEZTjZL14uEizgo63DtELv8EyV9ChO+OCG3z/hSZUcG+xLtHLcul6IhjdzcxMmCMf6D0SKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635818; c=relaxed/simple;
	bh=CHhdNx1DPtVhW6EV0JoW7AEwmi+u88cGX+7nUFlqziU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r85wyNdiz4nSFRu4tTUlQ0DNa2SZ3p8N1YaXNAwcsb12IegwF8g8+f0i0MYOjfl1ehfpkoN0pd+UsuSxnp9UFLthbw4jFxUBrq1pwIFZEXZPqQk8GNaSL6A2N8jxjn+B/AJ4RXLLsZI6iooTbYEQN2iL7vm8Vi87vZ+TZL+Huic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SavHLhxi; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SavHLhxi"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b7d95a11so21289065ab.2
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729635814; x=1730240614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhA2wYt5X+6xbErUcsvMOcsB9pAsgLwkZvDUsTRyXLA=;
        b=SavHLhxi+I+FSH07xbsdwUxSKEJ8VMpoMBhcWWysdVN35198bnQFtHU9tOJyR9yptU
         5V9JceZyjk47fNKwZFIMfRLhh7UhowouQft/ghpdKvr+JOQpSdM0EFUqCS2YovUbVA+j
         HwgB1Eg/QaVOL78MsbEEy7NtBdFpn2il/hMyf0oS88KmXix/epS8Spx/JUIaPRHCVtTy
         HaT7a37YTaTMK2oBeI8ZdOw4JBkHMfh+d8zLJQAhdyHyH2PZe2YGdUNtM42FIGi2X354
         g3IpJ14SMcnniz8sagWEEcGYcJnq3R8+SUhIM4O7wpScUq8hRjwSa8XDmzecV4jXVYe9
         +PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635814; x=1730240614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhA2wYt5X+6xbErUcsvMOcsB9pAsgLwkZvDUsTRyXLA=;
        b=QrR3CqyGZWqLEVDWxFH2q8Q8zg1a5ZhdSK5t6+UI5p0S27VVjMmdiJkLsvTFMRpoMb
         843vex0ebuCIfMx6AYOnd0zkyQyADifxYssBtZIEJ1G18BcXolVC3ZZDJj7VHTrWrfL2
         sNEIWtJ6KFqOrz8bMT8ETO4LQIuLeF1czNIwivcBlcLOGMzWW482RYG9+iPSvY6X7PYS
         r6913eiuSU2IrS6c70oa4/9y0nwjdnukJii3hAiUVl0mXwG33z4VH1AIrPr9bpQoS2GR
         IYLGs8MKncLNHCl1agT09R4yHSFzyzksB8fFHaFHUqKlIGVaRQpSFfqjU6rxWZUIsGmw
         SIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXguDTOtg6MdXelTWz8Wcuy6STOxdefdcgbGxuBmjyCYT4l4XiW+TYdGywgc8lMtXqxVpSSowi+Jkl0NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHulFTJHuQmiQMgJ/e1yfwD0hQxoihjJWc1I1UGm/fqZviu86B
	QQqPRgCm/1EV6W/dIwyHCjxM+n3g5FIlaVVrI1qlNkDWmlpub5zWCm/fRTCcVkM=
X-Google-Smtp-Source: AGHT+IF1URWENUntDQK3IQF2oscOmySAOIRvWJ/fShmRQAFQvuvMoHolpboKlkjskSy5j8pf/ECWAg==
X-Received: by 2002:a05:6e02:1c47:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a4d59709abmr7583465ab.9.1729635814300;
        Tue, 22 Oct 2024 15:23:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4cd6b6a32sm6761825ab.70.2024.10.22.15.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:23:33 -0700 (PDT)
Message-ID: <de7ff578-193f-49fd-8871-d998bb0fa149@kernel.dk>
Date: Tue, 22 Oct 2024 16:23:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: rust: fix formatting for
 kernel::block::mq::Request
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Francesco Zardi <frazar00@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903173027.16732-3-frazar00@gmail.com>
 <87cyk8mhlq.fsf@kernel.org>
 <CANiq72nYKH+UCQQ8mHTc1Z7Spinp9v9hrjLzVyWHXaoeSShQTw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANiq72nYKH+UCQQ8mHTc1Z7Spinp9v9hrjLzVyWHXaoeSShQTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/24 12:17 PM, Miguel Ojeda wrote:
> On Thu, Oct 10, 2024 at 11:29 AM Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> Thanks for the patch!
> 
> Andreas/Jens: do you want me to pick this through `rust-next`?
> 
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")

Fine with me.

-- 
Jens Axboe

