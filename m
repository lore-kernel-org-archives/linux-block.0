Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F114218B6;
	Wed,  4 Feb 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219871; cv=none; b=WaTx+Z1MvEF9mWS+rm8oJA0SqxuJPAgk3rLSlDJgHq6Hm726HdMXCUxoLVJyiP9Lighmiww0n7luRGoJzMuLNS8/19xhN4aZIDLzLnUwoCCFg7EAQxOO1z8kShO/cvpU+uHiKwIkVr4XrrM0UDRsmTnGwtho1wlmYfu1uhRKjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219871; c=relaxed/simple;
	bh=njzWuPzbKHbXrfvanK0wErBQpb7HTe1NuBwa0DB/VnE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mwyXubNyYd3QPiT8EkM5D2d5LuWCJcoJ1u7n5wqRxQiGt+ppcH3FhL/nZEFtwmVi8Ai4WTK7XK/g+KkRLyBIJUxBHfLvsxNF+HfiVIczaW0+CG5107bDOOyC/4YM59zImrGwV1bEWDxxL7cPzdzay7oVj6WAMuX1ZJ4OODvwG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBr30LtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBr30LtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71BCC19423;
	Wed,  4 Feb 2026 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770219871;
	bh=njzWuPzbKHbXrfvanK0wErBQpb7HTe1NuBwa0DB/VnE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DBr30LtEKnTojuKd7J1+fpgB+sbccKg9qCkTMMfwmwnq8KmSDDxmP+pEarvhEJsxF
	 4aOqerP5AamsMRT9hI0Vzv6vH+vi5F3ZyX5srZxI2hCyjD1S1PRxLHcXZAg4ggJbb2
	 Z4oP7qSLGK/MHR6MdkIzg2lLAtdKa7KFCDyV9CdUiwAKvzwcEorKFMM7sglBSGaOFn
	 C3fOfugbRFTfc7dfwzcco/zUMsDB//fQ5F94TmWaMljS2LOJdHma7aoEFpO/yoAAa2
	 eca60dsaJrUqZBkbSEX0Jgqon4yINjzlrxMJzftFBp13rS+9OqoHdfkMlcmZmgEOOL
	 6sbUZCVA836aw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 16:44:21 +0100
Message-Id: <DG6AKHUKXNO8.SS3EJRUSQO1A@kernel.org>
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to
 `RefCounted`.
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
 <linux-pci@vger.kernel.org>, "Oliver Mangold" <oliver.mangold@pm.me>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>

On Wed Feb 4, 2026 at 12:56 PM CET, Andreas Hindborg wrote:
>  rust/kernel/auxiliary.rs        |  7 +++++-
>  rust/kernel/device.rs           | 10 ++++++---
>  rust/kernel/device/property.rs  |  7 +++++-
>  rust/kernel/drm/device.rs       | 10 ++++++---
>  rust/kernel/drm/gem/mod.rs      |  8 ++++---
>  rust/kernel/pci.rs              | 10 ++++++++-
>  rust/kernel/platform.rs         |  7 +++++-

If you apply the kernel import style, those are

Acked-by: Danilo Krummrich <dakr@kernel.org>

However, I wonder if we want aref::* in the prelude instead.
