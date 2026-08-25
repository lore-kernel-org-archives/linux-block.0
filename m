Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3E4457CD;
	Tue, 25 Aug 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664858; cv=none; b=o7Wt6+YfTbbFufAJmbSVFNTzfmM/KuonLHS/NYy8COVQT64bVRVOkyoev+4oBJmxsyPTIq7jajhx4M78eKvCLkpcL1Fb3isxuXDFpQlUzq/fsp3cY6P4RpWZSEXRsNc4aWBWDRFsysGIHDcYjZOuh8i5R/aPaAP2d6Eo82/tIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664858; c=relaxed/simple;
	bh=bQTnxbZNXlZHRrc0dy2kQkH5StQvedCJTJ9ufOgx3qQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Lzxn6V86Pg57ZLGhQl2vd6F/In2zGr+A55chF86xShfiqcmIImelPS/SE2+d5LIVp9mKgf12YM5oEf4QX88XvxbBft89pHXYFpAXMI11HnZpbts+n5pNxyRYsUu2zuPXePr6+zL9uutR1O5ygdyeEgVH7aH/IZ3PeRowLDTL8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4RbNxx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4RbNxx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8EF1F00A3A;
	Tue, 25 Aug 2026 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664856;
	bh=izCY9jl5ux+/xwp3G6xz7Y4XyXtp+0iGLhW/GtYSXuI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=c4RbNxx99qdAIlVUMDjcrwSrwiTcf+KRMHIyspQT8BsnpDvm2SZoSKkm+P2EHu2Ro
	 gI13x+I9KOAEC8fKB/NPiJ9JQfUbZrz1Q8dpZtAjsHOHUJjrnpFKnlZsA6R14/1+0N
	 82zFG7K8e70solKEqr73wvJixiwXqaACm5Se9k4RlhnfvVAh+vYk1n0SoTM/0tcPfk
	 aB+O2kumYbpwHuGdwNbv97z29ZGkJLRye5zustBansQZHpJNIXodNyArBYXjhu5rqd
	 5TaWL+Kh4tR1pQylB8IoBYRj1utmbnfcXvy4BBuVAzQUtRNTk3OxHbvukx20ZBNsTl
	 mpoZu06r840Ag==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:34:05 +0200
Message-Id: <DKY2ASIS7VLQ.3LP3N33T5V6N7@kernel.org>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin@linux.dev>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Ira Weiny"
 <iweiny@kernel.org>, "Philipp Stanner" <phasta@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <driver-core@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>, "Asahi Lina"
 <lina+kernel@asahilina.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-4-490735672187@kernel.org>

On Mon Aug 24, 2026 at 1:17 PM CEST, Andreas Hindborg wrote:
>  rust/kernel/alloc/allocator.rs       |  19 +++---
>  rust/kernel/alloc/allocator/iter.rs  |   6 +-

Acked-by: Danilo Krummrich <dakr@kernel.org>

> -    pub unsafe fn to_page<'a>(ptr: NonNull<u8>) -> page::BorrowedPage<'a=
> {
> +    pub unsafe fn to_page<'a>(ptr: NonNull<u8>) -> &'a page::Page {

Of course the mechanical conversion is fine as is, but while at it, mind to=
 just
import Page, such that the odd page::Page thing goes away?

Thanks,
Danilo
