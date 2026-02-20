Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3D33EB1B
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584561; cv=pass; b=PyKm4LCpOtGaDB6H4nnwpQnEpUStPK5JBfHf6M02R0ugAmeYdLe80lh+bSSsJLUycIhC1r4RtO/WxU8ziMoVAJ+rK+CdAiHO3FCEZT+ia3v+CmY4EjV8r8fhhQUEqaxJwTAR19VI9NIwFdC67GPJlTyeC1Jt6IWzhHb1tpT3heE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584561; c=relaxed/simple;
	bh=aOLVDIR4WnlUw1nvqXwQwf234Bh2W6bojDklxd8Gees=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=covuS2DLgYj1SHC0C2sYta5H03v/Ho09N6aNT8bxmR2Do9J8s15LJptAVxJvLdT6iEBkUFpX0B9kR6k4dO0YKPIbV7+OuGcuyjrMIguUL0j/CV9D0mmiIThsurxef8KGExBzXroAg+/x8mFXbENBq4D04Kh0EhfN/uax2KSgMRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JABONran; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JABONran"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371119eacso18002495e9.2
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 02:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584558; cv=none;
        d=google.com; s=arc-20240605;
        b=RAWtxj/2YQqV6ctYh8sMscKmA4E4Vfz/LQc8UvuBGftqQwhoOykhGReR3YvEQ3LtbD
         8sLtbagejYwKMh01pAXg4UfTxHH4odw2jIRk9WVD8IpEoZLIKz1Og4+CFPh5rranSPY2
         dqaelbiSLenLX8YPFOyX3yAGh7p+qRknJ9RNuB3ILlPCMfqZNpP6RFfWsSszjEdfVty4
         6Sb7Ec2phiu6J9cQ9oJUfJfhY1e9YTcxaoyWqI2SXib0glt0ZwmUSPKQvZGNSfgTtd3l
         C7eafBc535d+d2Sp0NMSZPUZfQSRXJIQatBQPRU31lj/IY37JiJh3sV1ha4DZigD/3vB
         OfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        fh=x/WJe4AsQXGy2ItoJ8BCIFFxlNRJso0VzlndSMDjTzI=;
        b=UTS8ykN+7OtxMqwJuEcPNGneam+1eO70/LQyV2vJwpq4CBA1R9NToxreS+ySnfPtC7
         VzcTGyRfIQc0rEt11BAhIzkfDBjA4hwxWLmYqhW4l8do7pWJpjaI+rZw07s2q9yIkKZu
         g+9BmUrQ/NHFOg2vhORr0tRP1KA57l+dNKiGoseHzTMzkKS3Wmrv3r0Sgzp3BScMJJcx
         ufKjvfZxf8jwsyPKN+l6M5Z6j46jFaQ/7E8evIN0yFvoXQknrDPeYjwh6QJbtlE9XJ4G
         VKkbRL3V1OZ10D2eFmZS9dI4ACvj7dAi4FjnfdSGFa9lgeXAd2gxeft5UfgVL4FHGYuS
         vlBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584558; x=1772189358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=JABONranC/t/ZRWaTeXGCdbAg3MlyNGEm32nb8g+0L+PjkN0k7v4kud2f/Lc8HtI9p
         RSJ70uRPi9eRvWSiQdR4rSEaIEyNlubpm35GfQ3YOcWC3G9WcVSK61xAwUJAmv+fEQjH
         U0VDLzRhvDs3mprDIFVy3TKWENLnYZA8lvak3zCs19Vc7dc+4ymdsOOcoNXANG+9O4wA
         yAElmODqtzgqw7FDaasHWfeg3jDiHmL7dRWAknBHeykcq12ka7XVCsyOk7kCewg+AQ13
         iGKyafSskeM/uBbKXgMnW0Dq60qRd6tC6hK6mVrNBSjRBZQXO7HJmMLT1etJbZnXuKpV
         q+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584558; x=1772189358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=XxsFc3/Y33y5HHib0HsT3350dUtTTTPC+CByBQqHsdOxUbxm7+NgxNopyX9FnkQ42Q
         0tiwNAIKN3LAyuKxo9OvYsEeu9u0LwXpdRvRYHKiuWMBCzBbzx69noMTjWdh0j0KCONq
         l8q874KvskEoh5Gvdr5TKe+CFPj7xD4YAzkSWPM/ZKCw8cCvQR0c94EVEdzXBkGuVs/c
         zPpuRJAs600VIuHK82xNrMwiK2FoYEwouNtwLGUsM4RJILpmgQX/TyGzSVWgWunjamxW
         /ftKeqt3aZzhBLTVDPY4lNpY29cJ4RBLXuqr/bMwJ59V5q0299CZc3pSPD875iA00/vn
         buMA==
X-Forwarded-Encrypted: i=1; AJvYcCXKUwJZEmw+FxyP2t8oj7/XDpbwuMJTug38eT4Rns5Fl0leL3fEWl4Yfrl1oDCfuTnn4AFrVv7rnoEyMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygNnISNklkc31FOJC4WNAj+MwawYST5jqJ/SzRWapumQR/ORFt
	6EVDYmI/4ZPJ52i0B7/I9Yhmf1+3lSA2GR5aAwKeRgPJ1NEoMe48UpdZhns63Okkr3qYyHia27M
	Bcyt1/vAyJ4vXMlnxisBYU75E3DK6MziqSL+KG0jr
X-Gm-Gg: AZuq6aLTgrK85ITEHtVPDWyePvKfxBJZpMdaJxrckzNihaCWzV4Sakokx93UK7RuFVB
	TC3X5TF+QMy6H5jINWL9jNN18zjnNwllMx7SRSo21elsQaq32c/wpAK5qTveGz+LL49baLWwxNt
	8CUoa2bkwRjl99doFO2XwuS7Kd8A0Vfugpwz9b/mMmDt8VyKci0bwgNoMZOQl0UJs1VMmHj213e
	d7CHclBXGGZVmUz2KffKPLi3VdmIB6kAmbxmlPo6CW6cRN2IozTukOhcssY3cWKNQOlwYF+q1OM
	Zy2Vns4eVb9c1Zn1Ox21NyfzErJkIx2/x4c9dQ==
X-Received: by 2002:a05:600c:5289:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-48398b0990dmr130223325e9.12.1771584557648; Fri, 20 Feb 2026
 02:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:06 +0100
X-Gm-Features: AaiRm51MAhLW1OtRkAHOYwRwshfGarw67yqaE2vYRvgLvB2RCqsl8u_ReojFPGo
Message-ID: <CAH5fLggNQD+TbA7rXVB5w+O+qHcJcYC4u0b3W+mHR2DZiUe4eQ@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Add a method to `Page` that allows construction of an instance from `stru=
ct
> page` pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/kernel/page.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 4591b7b01c3d2..803f3e3d76b22 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -191,6 +191,17 @@ pub fn nid(&self) -> i32 {
>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>      }
>
> +    /// Create a `&Page` from a raw `struct page` pointer
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
> +        // SAFETY: By function safety requirements, ptr is not null and =
is
> +        // valid for use as a reference.
> +        unsafe { &*Opaque::cast_from(ptr).cast::<Self>() }

If you're going to do a pointer cast, then keep it simple and just do
&*ptr.cast().

Alice
