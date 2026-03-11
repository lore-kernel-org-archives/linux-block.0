Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85483B3880
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219123; cv=none; b=DZQs0RVnYWoCnIK9NFZqtvV7+At7daH1W+Pj8EBD0SoSeZkc/201n/YmtHRJDeXGlKWU6vx/KenkGXzLYtYlS0l3R4LUaFqP37Vw7jgp5bLwhdaNoKANvtMAwC7RroB1LHe0xzqHfNltwiu45uzOlKnoTF5yXQB+wBeweIkcSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219123; c=relaxed/simple;
	bh=ZtkR/6l+FDGpDtHglLxcqBnGd6BfUT4Qoycq96cHnWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORSo4Slr3dgIWzZhGVnQ56Kyta4hodPNlVTEavyMjlpGw7TJnT5riCXbvBEgpqcuV/rf69M48Bc3NtQsXMgXgpx7AntQOjtbEKINEX4+kmn7rPqW5Xgx5vUaCnX3QadVcjHc+jB+79Y9oNHi7wKvXjyAmiePJhAW32tZJz9iUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y8PluYe3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8PluYe3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aea68839a5so6013845ad.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773219120; x=1773823920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZnBxRARk1GOlMuOs/V/aPIHcysR0VtufsaYuOm7MHc=;
        b=Y8PluYe31Ul0Re6jPU0OOSoZaEochRuN9dXphkIj8GANhTfXEuxZVLUvwJcDCwafYG
         di/DDPj0vRtAXQVdtX84SMUxsxz9i7fAn2GMteiqetZEghB9lQzD/6vf7Sm+dHG+yD7G
         iZ2M63b8SC56wfs76jIYvBKsn5a3VIHZXv2Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219120; x=1773823920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZnBxRARk1GOlMuOs/V/aPIHcysR0VtufsaYuOm7MHc=;
        b=E+4J6GYF1J4lX+zULw0QguZoeHyUgJR0OXmSfhRwDo+D2+gje36Ey3k7+fcEpdTQ7W
         Y4dH4Puu5PAeR694M8wUT6KYfrKF9KCMwq9eIjrNyIazqE8EKOf6LnXEY0rIkQItvgq8
         6hWjr6X1wlLgQi44ASBhpmBLlnsOjercaFkaLfsPQwByM7/QTHJVKBuoi/7DueTIUNA9
         mTzx+7B8wWjAzQ+GTijEzIxI8h5XCW6mJ4d/NbD8ZiuFEqgsa3KU5HvPDFlKZsEp2+KY
         Q0grrRhJIsT47z1ZwXOpZ0jfaBnh4Zxtf9LpOGrf4suXARpEXKo678FpVKju6TC71tTC
         wtKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaSNI92RmXJ2e/Kdnn2x4D8JYpvG3z6FbN0PYbtFlsqihJuL9Q8NpYm+DSgnc34aH/3KoLprYe2Yv21Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMpWQyblsZQpTJ9A1lVT9IT4hof333LO4cY7LcqI17aABOb/LL
	CDt+505PO1hf1mA7XTJMvwxmXhiBz+NT20c1IIBzECn8GI7UTSW8v8AkB8bMsKNsfA==
X-Gm-Gg: ATEYQzxtwjzXIqM/lsBxEmvMNYv08lP2aZ+2ICt/QGHczxAa27gpY6TCQaY8tTS9TAO
	a3JZGNbZxeUTGrQfcgcKDmhIvwlwAHwZcsMdnbqVS5O6xWtYJJX6eF517SIJTwwb3jWLy2NEXJs
	xU7BzZAOwSsvhijTjVRhaNKBZ7j25GRz4n+ls5Stzyr8qWyR1patis6XKbPH29CpZFvg69W14qq
	Zo4npS/QNDYnuZunsWFQpPa2r4gJ/9FcydKwvQjh9maO0iv/cVWCyHtWgVnb7zwnbiAmslYXN+h
	F9ttjApgRUBjO6gkxfR2B5PJ8PyKoRlJEfyzKvvbBMNQu7QRss6ikldtb+e5Sgg7ApZpwOtcChC
	/M6SPhKfD+QVG8vtnpYxGsI7ctATIWSfZmEwXF/Bj/weO7dMHXeAwN2DClRq+pxAnVYK+yUlDGB
	6jEDnQ+VlvStSojlSQoSmYwDeHJ783GbR6mkTM/nrLZDuOG1KO5ygaiuykOIo1ZP0=
X-Received: by 2002:a17:902:fc4f:b0:2ae:5f0b:fb1d with SMTP id d9443c01a7336-2aea197ba0fmr70161265ad.6.1773219120081;
        Wed, 11 Mar 2026 01:52:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:93a4:8281:fe98:426a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae362501sm17164915ad.77.2026.03.11.01.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:51:59 -0700 (PDT)
Date: Wed, 11 Mar 2026 17:51:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: linjh22s@gmail.com
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/5] zram: Allow zcomps to manage their own streams
Message-ID: <abEsgvG547veeuVU@google.com>
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>

A quick question:

On (26/03/09 12:23), Jihan LIN via B4 Relay wrote:
> This RFC series focuses on the stream management interface required for
> accelerator backends, laying the groundwork for batched asynchronous
> operations in zram. Since I cannot verify this on specific accelerators
> at this moment, a PoC patch that simulates this behavior in software is
> included to verify new stream operations without requiring specific
> accelerators. The next step would be to add a non-blocking interface to
> fully utilize their concurrency, and allow backends to be built as
> separate modules. Any feedback would be greatly appreciated.

So does such a hardware exist?  This series is a little too
complex, so it better solve some real problem, so to speak,
before we start looking into it.
