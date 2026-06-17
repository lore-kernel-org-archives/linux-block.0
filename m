Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D063CE4A3
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690093; cv=pass; b=AzuwBLtivAsdsV0gANc18gheSOHqhSce8UoijCvfZgfrJFT98Q4tmw+ISI+kYlxaQapXcuRPnIrCPhHWQWnGBzlVy5Q6M2wX415vlx35SdodrtHqIGsvDlWc3HEHS/LQ1wGavsN4kp8kW7omlqnp+BrEMkgNitvDn6kPdFFS/oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690093; c=relaxed/simple;
	bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODzeDld0WEffQn9Kwmbsxs+5A+PpkVm7Vj1XthMZ7E7kHVIt5vs45WgijFw0wY2z1VU//xomS6TWa9yc5OT00jOfxnZhz9DFDgQfzS4ccpOU3Kz6HLvI38/P+V298LjaW1r/JvvSi+KM4A7vQbawz99ohXTiWpXvMbYUrFZmcrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5uxNMeG; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5uxNMeG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-460166910e6so2987449f8f.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 02:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690090; cv=none;
        d=google.com; s=arc-20240605;
        b=AeYMFMvbVuPTxEeWn5G1DyLWFliw+OdSZh6g66gLBLuRxiHFrDcavVH66fW7yKLRpZ
         nKLYEv/+KDlqZUeD5PJJU3Fr5wSaTGbiYYoRBTZV2HJT5a3WP/jgjZI8UqxP052g+VSQ
         +DeofRSMmh/utPHv96JNxPgxvI8WLCvxPEtoz22NESYU3oAj1JP02aYOYZrtz0+JviYn
         dwrqA/jWqfYL8mNRPZvECzB844gDaP9YfyTiia8d14LQw4fpjNbmsPfV3Fl4ENL0rOdp
         JgLR3SgwchvnhXsDoLKmExj1397OiQ0GodH29y45Vcx04TefezyaptcGpte5+ZOMnM4C
         nfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        fh=rw2vd4q2loQAM3Mo+IDj/cOKuAkAqv9iJ1A+mqf0R9E=;
        b=Qp7rNcxJ/P7SB7O/AM5lB5jzotCE2ocC16tvgp6ln8M9QVgwPmfl1Nyfiv5eFK8QS2
         c2PdElIM0qvxs9l0+rf4roKxJTPuJdaUEWUP9TeN5mXIYKU6i4Yn0LhcDJmHaRrT2ce3
         d33Kzv485QG2Mr9EGFqlJWsDLxaUnJsZfOtYilYaGjS3w0SZ/A5a5P3NLPa/bPLMyw3i
         XmpXseDmR3891VUPTGclA9Gudx7pBxk6nsPuMZ3mSVx7grPaoNIs6BOGUv5rooe1IZxk
         s8GL7ZchrSjuMnxiV/7v8CKU6LY9TaHtBwZUhPrk6pDBeAkFdxd9VjH3juOADESdenrx
         i1oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781690090; x=1782294890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=P5uxNMeGcDIN8llkO0LerOZseMvI0xoedivCJ9FZTvVkZQDpB2XH0vEThBBsXiWG9u
         sffI4uZumgWiX1nzBNMDek3/+k765xSl2pY7u/w/2RicT1DEfhmO3fV0tSyaaYwcGcUW
         sDIXq7Nca7LlV1xIEunZuyJ9m1LZ+oEW7N8dbZE1czoJgFmOXyNTjsG/v55Westq675s
         acUzZoCXnMYEzFXbS8+neVOK/fnhKQe+EzbGYwDbJeOrcvNmrqkC4agNzuQkCHFs6iTV
         ZeHsur1G/4T4lhO749KNW2vcfZXCrVawQX8QPjkJVWTDVb+5i/q9LvGGwrB4P6paWDbi
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690090; x=1782294890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=ffwtfG1zc1Ffqhepc1G3CHPELb6GPcduzIrI/R99XEA2fypTboOxb56akz7OfEx/92
         9j3ZPADdUMEgr7jg8pzfPMMNnml44qLusFjuWROEV1OELiBnM2iRz8kznSmuhJ/uGoZ+
         I/drSRbrLw5+a7034GYGH65K3T+Bjm+HuvviLkYXlbFUZS7djxMfW+YE1KNa/YgKwVc6
         FkwdFQfxxbWMTygFyOzejKogIk0wW4N0IqCWxwoVJdEXkAQE8wwp0+QkrXqIESY/ATnj
         BMkiQkJAdlUO0+9VZRZmy8DPHHJ7WqbzVkOCQt2KKkMq6HXWvnR84q4AGa6HvNE2hFUj
         c4Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9l8Kr7J0Hao4uE8tULHtsM6yRVD3cLVhHSDLSwmy1PyOVsheGLtejrVljzJrM8Y3hSo4yJu50F8s9wWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCb2s8aaAgg1NKGAska5m4VMNnjyaQ3pB75NNCpkgbIq/zAs1
	Y8aX5AxKOb4U8J0xlPrITfVEZGRfdjTpC6slzjccQvNTRYWazg5HPDfP01Clv2dVCZhYGV3R/wh
	w/hrLXvRJBPPghYK1xWwJiYTMbbnBr7ZKRoGhiP9r
X-Gm-Gg: AfdE7cm3do1SjQViupEiklcY14nR9rHwsezbAzkuXlfFq8TCDoKLrHpD8QNNLHTPDVo
	xKL2akyygKXuTYyNHmK912AukBnqXKHOjAsc+xINowKYDf8+btk2j6/6uF/VVJ5xgmtOxd9H6uu
	yxRi2AaUPHR9pXZ9T9/8bscBjwGm5OiiBGkGctK3wR4rILJH43LTAI8sIf5pCOn1SU03F8JMXUQ
	M0qpZM2krqrfNhGKHbwyGILDQ0Z9pNIU7S490BsDEJEbIYjSMC0twU4N/zSlaSVZL/S2aL+8pFO
	Y5oZvDurl1VqxGrnXMcASNo+yIrCtmQGVXDvQLvkHBHiTY5Lqz0KiFy4m8Y=
X-Received: by 2002:a5d:4a91:0:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-462376a4df0mr4361735f8f.19.1781690089839; Wed, 17 Jun 2026
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Jun 2026 11:54:37 +0200
X-Gm-Features: AVVi8CfPlpZsDlv9ciJ6wpjG8CPXMs720UTUcxwfh8qgpqFIXUpU1m_9T99wYrA
Message-ID: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This will not compile unless Rust Binder is also updated.

Alice
