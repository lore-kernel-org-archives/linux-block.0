Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E78390991;
	Tue, 23 Jun 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237189; cv=none; b=e5UVgxMYDLEFTOp+wORUJx7WMu7DscsZ3h40kjul2GO7q4A8qQB8JyTbwfBy0zugsUal3y80KlgrerqslFQwnaut8zIMwBw5dD3dQ6P0RPiiNqsCVToHOQMqOyphp6Lr5TuSqaPe+v14cfMytJJVeuxgk2dN/LyJsnDKf9t+y6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237189; c=relaxed/simple;
	bh=E2rm2AmDMNS3fPDLaY+Hd1im7cKJ8qFPnxcfWIeR0r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+/ZLJc8+R2X5sRK8NN3h9s2j7e98otaszFhyyVH/qS2wbODTz1Qa0ijbb0bhi61Iz9QXAKz0bSkViUPbAH8/4SyhzSwE7STQzQAxBEtaLntTcuMeOPAnU24KxmMNxQCw69XHbsVdQ6A+bE8k5f4lDBsz6WBX1Bm1DtbHoLqu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=IUwcPBUm; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="IUwcPBUm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1782237176; x=1782496376;
	bh=s4Is0q7DP6LQ80r/3dZ+cvP75TsKFlNwA4YLWr0Cmjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IUwcPBUmckP5rXwZanc2iqSVRvyw2KiD/T2Pka87Rr9k4JwUwaQxuj1ie3YNYlWKu
	 5SUso8FzI/8S2nwliVNmKyy5T6vNtzQOOJYflWqR4gKYe/zJeoLkX1HssX7w0KrrYT
	 z5a8Xo2nG83wDO9cxhI9ynMlCnHSVndW/Ik3uZsGUjQPd27/DkqV1pdBnZ3kjyDvuw
	 hdo6xjK3+Bn32c5Rbvy9noKj25u2gjwfNJsOcGOE2Qoat1hu7dE7fElB44u+harnIi
	 XQ9bAQvtPyKSzo8iph+srCyfCU2kULocTMHVEXB5Lq44IPfTpcHPWSVdV2JadFB+qu
	 nf58a6hspOA8w==
X-Pm-Submission-Id: 4glCMd2JVcz1DDKr
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <sergeh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v17 10/10] rust: page: add `from_raw()`
Date: Tue, 23 Jun 2026 20:52:41 +0300
Message-ID: <20260623175243.83672-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Jun 2026 22:11:22 +0200=0D
Andreas Hindborg <a.hindborg@kernel.org> wrote:=0D
=0D
> From: Andreas Hindborg <a.hindborg@samsung.com>=0D
> =0D
> Add a method to `Page` that allows construction of an instance from `stru=
ct=0D
> page` pointer.=0D
> =0D
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>=0D
> ---=0D
>  rust/kernel/page.rs | 12 ++++++++++++=0D
>  1 file changed, 12 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs=0D
> index 844c75e54134..d56ae597f692 100644=0D
> --- a/rust/kernel/page.rs=0D
> +++ b/rust/kernel/page.rs=0D
> @@ -214,6 +214,18 @@ pub fn nid(&self) -> i32 {=0D
>          unsafe { bindings::page_to_nid(self.as_ptr()) }=0D
>      }=0D
>  =0D
> +    /// Create a `&Page` from a raw `struct page` pointer.=0D
> +    ///=0D
> +    /// # Safety=0D
> +    ///=0D
> +    /// `ptr` must be convertible to a shared reference with a lifetime =
of `'a`.=0D
> +    #[inline]=0D
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {=
=0D
> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared=0D
> +        // reference.=0D
> +        unsafe { &*ptr.cast() }=0D
> +    }=0D
> +=0D
>      /// Runs a piece of code with this page mapped to an address.=0D
>      ///=0D
>      /// The page is unmapped when this call returns.=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
> =0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
