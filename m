Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4D3542F8
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773652467; cv=none; b=axlB0h/qWMlwenNAz+J0MnwT3f90xcUYrLkfnpEQZUWiMh7IuJBvgQ9Qg2yTPFq8KU3DtWVhaXVFyOXp4WlC6NtMyepVZMwOe4XXAsEev1LCA5TtOYbyQNMofCDy3yN/9K2OWka2vb5V2gXjQgJ5Vs/ktSiH4UF1RC442+sDgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773652467; c=relaxed/simple;
	bh=ikmGGYWkAH56065Y2c/wbwl2+qwV/Q7HqVV+o1Es5HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OaPn+gXmuTpJ/H6IdGOGckqTDvZmO63x3P1rf7Od+0vU/4a7XybN8T4iD6Bv/5HJysAeu4iuaGwTVinu5wWZRmZycKrPIcJ5dFS676Rp8yEc52f/3Ti1/6fiFpG6zGojmdC46qfWOtjlaKqv7vg0/FCXguFZr2W3iIterjsUmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax4h8Nkh; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax4h8Nkh"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso54301635e9.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773652464; x=1774257264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2x2io23Ni1twKL4u8xriZ4A7jtPDDRWW6RQ292OVzw=;
        b=ax4h8Nkhn9l+oEazue0W/TDN2+26bzw7zrSDTyzmhIX/U8NabGrkxpBAFLqzhU013+
         D4QfwdWYSsUMn/TflZKNNn7CowlXoIFAqHl8lP7j9HKPn+Bo0uDV/HIRd+RSPFmOBMHi
         At7fixh0mvSsvzBzJY29iur3T8XT2fIMahh4hOBgVUfHdZqa5SpaA5DA7W0I1BNTdqwY
         8iWwgH6d7vyFh8s77ARaurMOdeGpPGdySQOF2u+rrQq8IQ46LI6Od/9h9sC2Gfes/zx2
         3q7EdCk607CFwRMnWf00t1u7dOlDxcHFoHV1rWeuR0d2LJMqTJRZwO8YNak2eMbGLgYB
         FCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652464; x=1774257264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2x2io23Ni1twKL4u8xriZ4A7jtPDDRWW6RQ292OVzw=;
        b=D34qDJ8xCAQTrykhGid8jAJB6T4+OajFstiXAVCApO+/i3tqWnCUi8hWnlxk+E0zcX
         BFWpQog4jXrRFDULR9qqglr8N6gKWDMPzNn5rMJ9Zblx26eWn+6RxxEoRmoSWxIO4mC0
         3URvh3mMmTPOqbNYtGAUbcdrsswQm1e5Hq37vjIZAyJAmcR0Ue0QDDGqeoa2AuzTF/X0
         Q0VEpHFkURRKUBm1UMt/y4U3ZggUYadnl2I4uCIdx9HlB1v1zOwHlqMoGufqsYkE5z/f
         u2fyB4s4IqZvI8SmZzf6F5KgmCZ70TG1PDsUQruyD/YIAY/VmxvHSdKrL8hRgcyC6ftT
         W/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVOC5YB5NRu6Lh1k1XDiaGa1mStk4ljpW3QPNN+coikecTk9m4tYVCqRu82NSvJ80cjH628zesrlxHqrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtb+/rAAz/boEbv+EESN1fam5bTqZvCJ5FDzGwRwUZz7ckLjy
	zd9zESJRCELywqZ5AhGqbvUuhu2r0WnS8t5wj9dTb5n+FyVUDzUQwGEQ67RIhQ7M9JbeajCIvFZ
	4pXVzGgINC60Ke6lL7g==
X-Received: from wmbip40.prod.google.com ([2002:a05:600c:a6a8:b0:483:7f25:eadd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:644d:10b0:485:30d4:6b98 with SMTP id 5b1f17b1804b1-485566dd75amr146115915e9.15.1773652464242;
 Mon, 16 Mar 2026 02:14:24 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:14:20 +0000
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-1-de9a7af4b469@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org> <20260216-rnull-v6-19-rc5-send-v1-1-de9a7af4b469@kernel.org>
Message-ID: <abfJ7MRwufOS2sxE@google.com>
Subject: Re: [PATCH 01/79] block: rnull: adopt new formatting guidelines
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

On Mon, Feb 16, 2026 at 12:34:48AM +0100, Andreas Hindborg wrote:
> Reformat `use` statements to have one item per line as required by the
> updated Rust formatting guidelines. Apply a formatting workaround to
> ensure `rustfmt` produces the expected output.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
