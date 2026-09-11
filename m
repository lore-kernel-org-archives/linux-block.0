Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9146AA73
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117716; cv=pass; b=QVsDeJNjcRqA0+9LQpF6JUTVO3jfwe+fE2HRwcU1lcZ6kjexltct4AS8LvHhxmvWDWf71P1eg72e2srQAePyN+b+VEFOcV++YM5bdHd/oIceAeVoHFkie1Y8SiGaDDEti/VqwRj8EX0m2fg0AfqT7peMghE2sFWjk8RktYbvBGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117716; c=relaxed/simple;
	bh=9AitBb1GHyxUD8itXAfWQrOndn4vr+DMbiE1kW67HMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ9GP2iGsQv25ZpuzelHIb2UhAqJ9wCmPmI1LMBYkyKxHd056m7NJqqfuF7F28Y9LI2/vc233hWR1I2hKNTXetKF/0KTNRvE6hSRdc8uYnxnpKltgTYFa6k6BPCmjKu36upDiJBQt+UbrYG6VmKaq84sBlg2Lrj2gfCeMTcFsdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntc0+0D2; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntc0+0D2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48586861639so277432f8f.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
        d=google.com; s=arc-20260327;
        b=igSJ+6roq9p8GyLkrci2p1zriNImSjOuKrWE+Vz5djfcH6LXANKkbtK/TvZ7dKC/SS
         PltxIbv+sH/GLEbCNUz8SDR5p+Z6aEp9383xXJFe2Jk3J0p4ED6pDX4ThcUEr+Y5PWk/
         dcuGpE6OBHI+156eRPNgWk/m3WUWN84IX0+L7J0GNRCoxR5QJCVym8srlTiS/ENQi9j4
         YojvDcEqlR4NSa0CMA8LB7PHcPP/tbhC4pL5XNkLnHtQd0HdIsz04znqYcAkWOBybfpq
         iZoz7LCdn1XRq4OmbJrPcEzJckHEXjMoEQLL8SiTRAaHEaB6Rt7LUL5ZEJcFxSlf597+
         MUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        fh=u3cLgqrTCjMXx14V0xT7/CkZd1K+egpi9dI9kjvxyxI=;
        b=NDAQebkeJm+0zwZYTsOttvdncdLZK58zme8ZiSfPBVmJ1+nF/SW12cyNDJl+yqfiWd
         ZNqj7sOAXro5C49szOuXFUrE7BiGND5e6yA8/yBfS7OLdmhSJgRWPZ5jlaCDTP5BpqMt
         QFzDj141+sRoD/XE0D1R2q2RjcTBbEqUsgYn5X8CIUMzsNnkd9NDqlFAAeNHuVA3xLDs
         h6w0Wau4BzZm2gkzIPQoRy0Bf09COOcufAYwrnuDx0uSDWOhcP7m+y8rP36bujffMYaq
         mRpywbSvJIlUtHsOhcolFTuD8kDzxR1erEmUidoQg8YjQEL4BrfM6ODDX63/L4m/yGR9
         zt8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117711; x=1789722511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=Ntc0+0D23+YujkzMEy4eJ6nXRpHFOnm4AtVkxEhi5vnpCexhU7KW4PmGmKyNMt+kZa
         TPGlSB3IBPA9MiD4PQN6ttGdFWT2WqMR0/+bikrH32dyf3RHlyaDpdo24c0XMpHO5GJU
         lDTJahlTxAMonEnDUsydvsqrYYCX0kfnhBDCQrNCn+atyDFTDkDtjvAsv2M6xPLh4eMe
         a/AWqeYbYlOAESo9Wgc1GsNr33dNbudqVttD6Sl4VuL4rsbQ/aL6gINrZx4FRE2ZMT3U
         4K5dculSYJThgW463pZtuOMCZuRhxZHA32PPtyLFovJ2VLCOKrv7CixBauixl/iB/3rB
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117711; x=1789722511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=j3H9DSppe+ZE8td4XRQ6uhShmO9X4+gyZGMXSs1kXNIvB23oRPaxwi5PjiCum+U27M
         Ns/tcti0Awufw6n0+J+79PHqC6a4iEZ+QG1UoNEbJSuRCtB6YledCNcQxMetYbXpQB5L
         Qf5l+MupWGyQrYTBDz2P3XUtz6vyMSUKY5vfqhsJIYQMhBCck5PbZG3jJChFpCNKk0Gw
         OWOxZx5ajfJRt4/mxMcUUdyykTqq5lufWv3hLecgGCVHTYjzg6Jc/dmu8ulFhTge7qeQ
         y/RUCHSyrFUkge+oWUC3e03JOuW5dO6WhbyyuV20PhkuHdXoMfDdMIbF7oVTGbgDjd2f
         uhDg==
X-Forwarded-Encrypted: i=1; AKwUvByD9+LYSqnJretWoRy1qShDDC3ot15B6IMBAUXCgBuB8PAS+eSlPQ1FjjGTx6+bznDxRqkT3xV5Wyo8aw==@vger.kernel.org
X-Gm-Message-State: AFuF++nI439n3UzJb6F+RgxfSqH3HbeLI92ttnEY0/+04uNfeSviNbu0
	+FIENg0fK0uEmjQaU/IhkVJWnLJy3KoIrAMQ+zm4rciVypOWp6+PdCnt/mLrtVQ6EOvtH4Si9n5
	6gpyp9bLYi2KkJfTlhT5FfMg4YnwCJY968MmpS8Be
X-Gm-Gg: AYBFou1CvXJgl2e4XJp7CSelVK6f1PHgsWeq4F/9a3HMccjVlO5u79nkzWl4HNao8Ot
	Qx17dob2IvKXKugPi4g99aGjDgtYPZykMWn/htuIs0X6hCX8yfbM4qbEpUQSFQ+SOEkmMrDTVcj
	yWjS5xRmpF7PDVcFmEGVXi1By864YqKt9rpMGsbmiglytZdsKzyiIOkgJufH6SXSr4vmXQx0uk0
	K9OU11BK3vKUSws7TTAIOHGnMW9vh9Tp+c1NLxACeRUDP1i+zK/yXx6AxIhDDe64dBhGyuVViu6
	vaM9qriBWFdN4EnFP1sVpUH3zrKFqS3YrKjXwj6w54NdEtNnBTkbDkzSMTuiajxgz7cayGUYl2/
	jbPftlSncgXhl+utPOprzJTEcFQyRPsIFP7vAPYEZEJesop7mUjdP0JPBAzw4Ul/t
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice
