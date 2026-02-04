Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6F3D994;
	Wed,  4 Feb 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219697; cv=none; b=Zgh+u3j5aYTP/nbi+tqHdDmsHHpggvAirWz9TkSN4Ul0R2GqCoxUHqoair+P/Hcii8E/HskE9BiapCmX06wY74i5d6fj19jr2n1vtImWdGOx5XB7rqoaG/zjjp68g+VvmR2CBbArx6jdjgGr6POlgc7g1ZfkSGUnqQLwp7KDUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219697; c=relaxed/simple;
	bh=RmfM/AZglZOEG9CAOPaE0engWdOby0R8qOmmSRG9PzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ef9qVNbbIlZjYyUdJSWfoxCaEH4heCzoDaaK9YNPPbD1ElJEl846AJrARtdNuWHetFpmHI43z4NU+ZJrC1yOMxxVT/REUfg1yHkColr1gc7uTmvFuWs/e/YtdP82bAas6U0CGiRXOcF5sjyXYdUuFD3aavCTL9SfSA6qEUo0v7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YblZPv9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YblZPv9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E497AC19423;
	Wed,  4 Feb 2026 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770219697;
	bh=RmfM/AZglZOEG9CAOPaE0engWdOby0R8qOmmSRG9PzY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YblZPv9NZoOzZEJVNv8HA1+4sFt1ES94BtjWj/jwWQhsxY3vxHvf7DqTQjEjeqbo2
	 FJ58mPfgwvoLWUwCabHSjaw7P9XfHuXBYHi9pP4P0EN9anoZf58friJHJvHzYEZKJ3
	 YSf1Sg9av7M3sW/wxmVSYf+8H9OQTpsN4hyu1DXefDBPyPxBT/EDgF1GIkrJNmKzE2
	 /Pn7KQINq88+5nWE0xyysbbTiRv94r/J9PC/wIXx0LkQ+Rexm9iDVw8wj4CY3cOtm3
	 yjgIAK1AFaVnQOwfUfyNh0bCF4+GnX9NHHcHDgSINoTEsHr0Scg8O22oJZ0KOaSpVZ
	 FhpluNISWJfGg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 16:41:28 +0100
Message-Id: <DG6AIA0QK77C.EKG7X4NBEJ00@kernel.org>
Subject: Re: [PATCH v14 1/9] rust: types: Add Ownable/Owned types
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Asahi Lina" <lina+kernel@asahilina.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-1-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-1-17cb29ebacbb@kernel.org>

On Wed Feb 4, 2026 at 12:56 PM CET, Andreas Hindborg wrote:
> From: Asahi Lina <lina+kernel@asahilina.net>
>
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unli=
ke
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>
> This change is a derived work based on work by Asahi Lina
> <lina+kernel@asahilina.net> [1] and Oliver Mangold <oliver.mangold@pm.me>=
.
>
> Link: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-1-e317=
0d7fe55e@asahilina.net/ [1]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Given the From: line above, this needs Lina's SoB.

This patch was also originally posted by Abdiel and Boqun and I think we sh=
ould
account for this. I mentioned this in a couple of previous versions already=
,
e.g. in [1]. I think we should account for this.

[1] https://lore.kernel.org/all/cc28d048-5e0f-4f0e-b0f2-1b9e240f639b@kernel=
.org/
