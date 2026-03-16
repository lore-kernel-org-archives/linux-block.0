Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905A374735
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652709; cv=none; b=LFWcuw+1+Dba8aP3euijWsbPUJATVBdpoM5pxw6WMpnnDbCtU46IUZuaAjiXs0YtfKFJzkqjLplnOGq3dBYUTJsUVtN5VXbFeH9oTIhWRkhAJBFWrfJcIKEYd5LzLx/F4shkY8PP/U+F+wvXAH/Bd0l/tOdohZEZCbP0F7F+WzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652709; c=relaxed/simple;
	bh=Y/i+Kp6k0H4GN3F29K5jC+Y2S/PowNU8GApKouEwjFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LP9nzAlD8j8N4GtAXpb638pZYGfgOlofBz8blUkopyOqGOd8s07qdf4Wz4JHkISZikcSXOeWYD2OhQ3s6wwHEfk7VQfcdzxX5SMhMTPQcr5NbZTmR9flrX1IIcx1LEENn5q/1Dyw2gNo8eMHi9z+IcokeFwcEYhAzl+B8vU7y4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNKmhvnU; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNKmhvnU"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso35697755e9.0
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773652707; x=1774257507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQL4a5h5hztheILgUGktpxEkb7l9DORW+uY33oC+48Y=;
        b=uNKmhvnURPyD1GOvmtDDOFbIxFTmBE9jsDPe3o6YzoukCPei5x0VTuCBFEY4Ty1Wyv
         pOtNaicB1I0yb1cZe9FDXtIyaQ0YcLBma4tcicPqh7O+/zmHgnPJHA160muxPxcs5k93
         ky8GWFlZ4JDai1y0/8o7V26WdqSQjDU+3kAs0HZW1IK0xr8R6AKNZSfZ/lACWLjTF0TA
         k7q/nfBqbgCOsYpSM7SzTi3nx2uq0EkP2p33tmXYDsBEhIjMNWxJnM+Lbhh+13GGqZB3
         Cf+M+Qw0Q4NKmp5T8sTWRnSeaERwFb/nQxOInF5gLf/NoMVrlspTkcljJlM3EKjSqPIc
         H3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652707; x=1774257507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQL4a5h5hztheILgUGktpxEkb7l9DORW+uY33oC+48Y=;
        b=ZkxTe+lS9HENaoNzBcCSK/3H/M8cVbij5kaVIkwDWkDnCI775gB/LZbo93aM7fmuSm
         CYYuNwKYIe8/vnWGPQQgQSC99U9u8vXPy8sLcJs5wqYn8nAiqznMDtEMs1Y+b4h6acD9
         7GoI6K8TZHpxrZQuWv6TnqttZREgao6cq/73P63KaI8ODmRTNsNC3h7HkWzbKcJRShK4
         rKu83tg1IseAwDH1cls9GVX33Gdmh+h6TZg/X4GHUEZjypagUqfQZhjIw2Q9cZJuMMt3
         F5XQlneDr8pKmpfa2dxf89hffoi0w26xeunGCfAfgiQTQmcmOLzMydwG09dcIw2DSrSM
         6S/g==
X-Forwarded-Encrypted: i=1; AJvYcCUWI4uckXh7CsIBPWa91gqqpW/i1TOatRWa5CTlKn+ojxpwp2KpIQlzWrj4BRpSXCb5sQsg9j6B4J/eVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkhz5bW90HIzmu1mDCVAYdSRxdwSJiUVptebP0nMn16dh/scP
	Zr+2JkkiR2A25+06m+CzIGF7jaxo7cfDHKzZIJE01msseqdz88z3BOfk111FD4DwRpxxhdOQNdK
	90oz/u0VcLUvRbXNegQ==
X-Received: from wmgi20.prod.google.com ([2002:a05:600c:2d94:b0:479:2d82:5535])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3588:b0:485:5d25:81a9 with SMTP id 5b1f17b1804b1-4855d258656mr167384855e9.14.1773652706667;
 Mon, 16 Mar 2026 02:18:26 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:18:25 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-2-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-2-de9a7af4b469@kernel.org>
Message-ID: <abfK4eji5jKSeO_W@google.com>
Subject: Re: [PATCH 02/79] block: rnull: add module parameters
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

On Mon, Feb 16, 2026 at 12:34:49AM +0100, Andreas Hindborg wrote:
> Module parameter support for Rust modules was merged a few releases back.
> Add module parameter support to the rnull driver.
> 
> This allows the user to control the driver either via configfs or module
> parameters, just like the C counterpart.
> 
> Please note that the rust module parameters do not support boolean values.
> Flags that should have been booleans are parsed as integers and compared to
> zero.

Since this is uapi, you probably should support booleans here. Otherwise
it'd be breaking to change this to be a boolean later.

Otherwise lgtm.

Alice
