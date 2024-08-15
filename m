Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66017B514;
	Thu, 15 Aug 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708189; cv=none; b=nR5+5L9+iZLLUN8YxeXlhOEov+LadFuo/G62g97UfoGQ73xg1RWwEkRjWTSK/Q8VX2g9u8QUc/jzE19jiXyGkN15TrfwT6IEeaZoWbMNgxa9OVpydVODWEzqr1L/3cq/94yU8hQTGFBky9Zqs+qPXfs2IjmEbZotvuCViPjLY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708189; c=relaxed/simple;
	bh=1WQ+V1rwunvrVBOCy985nKOLKtwmbwvp824MzTWvQMM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RwUYiedNejGiaQ6ApTobNfabcFOqI8d4QnmKnftWM/5iVXM65OIv3iALamwMBO+qiDqyN6aPZFZv7+Il2qr4nTnaDI1cqyrBnJW4HU3t7Upges5d9IkHBCn3FxcGOV30jddxiR8ReuBUYp8Q4dr/MH+xNB+LRXunkukS2X5i2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=jlCVqqG9; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="jlCVqqG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1723708183; x=1723967383;
	bh=y4jjx4ov9ERdXXuNywuzrIi9fwMl2dTAGEcLD/oQZpE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jlCVqqG93ZqGGSZDe8p8SnA6zXdn9RetrcUkwE1t1yLWvpkjmUfBveAbcDR7gUYqE
	 z/ApBjn/wMckj+7XQrSfS5YfRNl7o3jWiqwPbNMTdRdbamgQminqlMh6+UizoMU2zk
	 M+YKqEEfgHybMfgpC7vWSelVgDtcatPoASb9jVQiworSIFW6DW25m1PaG48rhnV3Xl
	 l9RV3sScezxDQc9WGH7f7cVMF9TRqeDQuK3gAPSPhMfD668reftpBVGH1Q5f0c+A4j
	 AR3Gz0qWw8LKwseWgR36MByaOcv2CUQHpSNz1M6FAw7jS52tfU40J6COvkBc+dc/+9
	 R6V1N0IFqj1GQ==
Date: Thu, 15 Aug 2024 07:49:37 +0000
To: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rust: fix erranous use of lock class key in rust block device bindings
Message-ID: <20240815074519.2684107-1-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: b01fa72057b7a3c584869de3f5d90c39a55777ec
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Andreas Hindborg <a.hindborg@samsung.com>

The rust block device bindings include a wrong use of lock class key. This
causes a WARN trace when lockdep is enabled and a `GenDisk` is constructed.

This series fixes the issue by using a static lock class key. To do this, t=
he
series first fixes the rust build system to correctly export rust statics f=
rom
the bss segment.

Andreas Hindborg (2):
  rust: fix export of bss symbols
  rust: block: fix wrong usage of lockdep API

 rust/Makefile                    | 2 +-
 rust/kernel/block/mq/gen_disk.rs | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)


base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
--=20
2.46.0



