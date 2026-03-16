Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92938F647
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658100; cv=none; b=id0wHHUBrTSiwkvUCQ+keI5JtB+gKoBOuVyrtd6fzGUYibkU/qfddi+Jgz62mmYgUPIpbAgeyn10st7DYgpseExlRRS4yFpfaqnKQLHQbpLWsCZSwPKJwsaQq0do0fq77+GS02XooDmA6WPY8xRCuuJ68WlbNE4bMJxGPaITfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658100; c=relaxed/simple;
	bh=3bxLVrLsrCrvMMhEGWK87vHhkr0D8+7PFfhtA+bwGjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8cLHRUIMge91JD4rx/wk+VGZj/cuNz9Kn8Bxh1weQiYQFm5V4YM3xS+69RRiAQB2Qu3+k1T8TmZFrE49XF1OiWWTHXGSl48ToAE9EDtw0I+lwYovDc6qORaOpDgkgdGR9MqZ5Qt2K+zOEg1/zGiSCnxhW8YiNV2vn5QhmNzyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwSk9/yH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwSk9/yH"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853040372fso41538695e9.1
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773658098; x=1774262898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUOGpPWcKDo+U5VR1NrHCLemu1A0Jfaz2D2lBYpe4+s=;
        b=LwSk9/yHUMJKVR5W0bFsy3WNk2egytwl02/TJdTcUQmZimdtMvdQLgloeVCTNh9KUn
         ZPCVuCyUIScFdHeYO/lXqB8PVvuAHLHeefRZ55wrWgKjTasldzGRAKORIocFBbHXrPw7
         6BPy7ctbcivTUjXGSfreImP0WIdQkYOKQZYH8Wa6D4QTJq9AmTY57EWzBDj7BbVTBifD
         4o2cHx0Oan0Nu9XqjbpBCi37RyVxNURWr4DN/gsT0zJG61tlnWD5WKhkqROGFIguNeu4
         /ZQlyxm4EG/BFBLCgRah1MSzhKb3bZ5nHnzT8MaP9Z40NUOaP3Dx7fdW6pL0EsRXF2RI
         I/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658098; x=1774262898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUOGpPWcKDo+U5VR1NrHCLemu1A0Jfaz2D2lBYpe4+s=;
        b=PGdYDdGDKQ8jPRNeuC+eyo6xzfbytbtBxcWRS18ybBkfZsYbfSogAqyxQhGISiqD4F
         0nb/s917Pk3+/qS9hXnvLkbX/wjUwGtLEAfBtgAoBS4NA0YkuyGTAXcVILXhJMhrj+gr
         41HFzNUkFSBSwvAkbLLdvTBnrCo7oPmKTWW8mmthizAEBUBCmrpa4JxQE3zGSdlCMuzc
         8t4BEYvF2C4/CRrWGofDg7PMpEtaqXGWbqObKYK7KexIAA19NA4oOTVpcXKEfoIpmwt5
         JAExvYUreSeGFP9YboBD7ewh5tM9oI71pBau+SceySNcIUGjHtHxBCyZvtklSmlY2I69
         7SHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqETfHI4dTGR52o4ZYfdD54Hye89Hr1FdG5kdenfXjhWcj5+7iaZ3Jm5jvZX+cLqBEiPNnIfXLR3wkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QVrmYg934rp1VBGQF3ZM2kTDqzq6OJfGYG0/UWV2IuRpRQok
	cN6mJZ6bTyFiglGOnqHcLkcqaSybS3vGvCw19b7yH2BqffyJObxSmukC3Cuyz4IGm+TwU3EE7re
	cv9e2uWy4Vd+poMWegw==
X-Received: from wmco2.prod.google.com ([2002:a05:600c:a302:b0:485:3b4c:3e34])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b14:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-485566d6e54mr215274655e9.9.1773658097378;
 Mon, 16 Mar 2026 03:48:17 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:48:16 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-18-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-18-de9a7af4b469@kernel.org>
Message-ID: <abff8Hb4FAN1e39U@google.com>
Subject: Re: [PATCH 18/79] block: rust: add Request::sectors() method
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

On Mon, Feb 16, 2026 at 12:35:05AM +0100, Andreas Hindborg wrote:
> Add a new method to get the size of a request in number of sectors.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
