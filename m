Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70C39E9D5;
	Mon, 22 Jun 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121559; cv=none; b=CzNDTDKLfbe2TeBVgtoKIcF/vMXOdyec3Km1Mk0jdtxXSQN7ldIGBGz/L59fALmBTVrS7okvgXHlfd8G6q5lxuqLpQzQFyG9JSwvbFNicyupTj7FfrGBWeNx/KfygPRxGucrNZnZWZkwWMo+ed+kJAd0vaOzB6UlaY2vJ5ZzHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121559; c=relaxed/simple;
	bh=pzlTDdFESsE7RaaUvivHsEKLw5TRfF5WWmPB/v8rZbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biODvWjAzyy2oFz7DaNtssR2RO3+FwNExJ7R0VNxIasjQF+jBem+uod4IZk/VH6+UtQY1TIC58Mi5g2m49op6OoGRqJSdQz1dfHSH+wAgq20HDIwEckpnP6wQmK4LotRew6UdpispLFkzIpWsc08zu5QmsS5L57ZbduQgRljDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMtRT7Nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMtRT7Nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093211F000E9;
	Mon, 22 Jun 2026 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121557;
	bh=pzlTDdFESsE7RaaUvivHsEKLw5TRfF5WWmPB/v8rZbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GMtRT7Nz4xU+0Oo9rpXrt98aMdSAFP4j02WIV3Aqx8xhoCLQMbrIhI2uAG9Pz6mBt
	 /0fgNHbbXP2210Xv+l2fcJpHpKRmL60k2pOAfMK8RsZ9zQVroVELH9hwWJJQqDJufs
	 4sRBz3us8YLJ4f6kOInUTz61BYUJP3pzkqOKAY7d9o3x4BspJr4/vnijdxph1n/xOD
	 v201sNPqhWti1KqykoJWtvGeL84ImOnmBthlY9SqrKgBwLZU51njKVw6w8RHGqCUAm
	 xq83NfJgOu/bodCtOmOMEWCXqnezyjdEHM/7tcTWDJp1paAZSuL/t+LcPbm+zK2dqE
	 S0oE0j9WDedmQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v3 4/6] rust: drm: set fops.owner from driver module
 pointer
In-Reply-To: <20260622-fix-fops-owner-v3-4-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-4-49d45cb37032@linux.dev>
Date: Mon, 22 Jun 2026 11:39:15 +0200
Message-ID: <87jyrqewxo.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alvin Sun <alvin.sun@linux.dev> writes:

> Change `create_fops()` to accept an owner module pointer instead of
> hardcoding `null_mut()`, ensuring the kernel correctly tracks the
> module owning the DRM device's file operations.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



