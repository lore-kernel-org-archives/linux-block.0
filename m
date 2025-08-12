Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AAE2E2F00;
	Tue, 12 Aug 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988354; cv=none; b=godBE3j/cnI1gDqZtTsUqE0WXb96vJb5ul/+kwLWT/oEFQECc0qN8xcvRbKppFfAOGNAtZdlDi+di5fGAXpl8JXW3pCq97A8Yr1OniV6UdxK6KOMEKWmslz9GMYHOV3XtLAptwlcPhVkAcsKEJqCPHMAOSrFI8Ih0Dvkksm78Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988354; c=relaxed/simple;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xk0D/oiQ/AWuckeOhkzznrb7rysisnKfE/tLUwN6oI+xJPhHG78R4Ox1X7e5idgI/krjSSOBuSBn+TT/s8zcmR7mouRSzX4GuhiC4Lbi03xEZaSmg5zczczEYplTH+IDxXBiBXZEDtQMvRJzek/t1ryj/GYsHQwnDpxhe9Awpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hziF534x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hziF534x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5F3C4CEF0;
	Tue, 12 Aug 2025 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754988353;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hziF534xKIukfDVBUdhLEz8L1eWhWqEWvxSk/gqPR5farO2zONUtbp0j18yPz6EcR
	 Co3lp85+TiMsc+/RookxNKrmTCeC5pxd3oY+2nvuRDcj85xGH9s9FfKkM3EFkv3xPS
	 9yvlwr8rrKAVWCptnCN7C7oVcVpBQNRRc8qYeAAsMKDAXcp4x0+qF1mL6YidYztYFP
	 jPukN2DJK5g9gmpVOUO7NIIUl8JrEPOG+Da2tnj61SLB4IN+/7HcmVt7a9aX6DSkal
	 +Rstqk4tf6eTDqQ6r6DsKe1n4OyOdk97seL4oksD54venthYpl7dq4sw9h1R5btCVU
	 G/QgrvixhmlHA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 12 Aug 2025 10:44:26 +0200
Subject: [PATCH v4 08/15] rust: block: remove trait bound from
 `mq::Request` definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-rnull-up-v6-16-v4-8-ed801dd3ba5c@kernel.org>
References: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
In-Reply-To: <20250812-rnull-up-v6-16-v4-0-ed801dd3ba5c@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBomv8jaZeO3dGdonKT2i5C2dorwO/9Ab5rVdZhZ
 GBmcUjGHDuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJr/IwAKCRDhuBo+eShj
 dxY1D/9B3vYO2SWWAL7+K33cg7E0I6P3WY9aXa/oJp9smSuJnjclyPLyLb3Bxv398m1C4irON19
 YYnAvHETMmI1RTlLbczokubEIlFfnxz4DLBnLbCVhemXgfkdmqOwQZXW0REr/J9iJkouRcWDLVu
 fAguXT23HDNeJs0bM7uLkzMrLVniLYH2PjqMZrQi3+IV3U9ImwoBxuwEm81VY0Ly8S4qONZXdtl
 gnfYDc0TbpcNH9xBxvp0tDVe7PJWdDApcmC8/A3UssthuryCKDkrr/fZ649hPerRubZ3bx84JT+
 uqxwaUUL/B+7iqpq8zqP2iDFg+H4KJFO61LzJ18icMmsIi4ozUbCFiJWnZxWGERRSDzGM+AtMUT
 D2vehgPtBuyU4bemn4v5EmmwYeahklonivMd/3FRJFuLGKbeEUkrO+psMC1QDvrM5eHfA2AfLYr
 uzUYDAhSy2Viw3B86DMt+6g5nAPxi6fOZ/O3hrvqkg5pzLH6ILC0Z8jUGRVKKx/FZ9Yki2JkPBE
 zGSwydIXDQPNdEQ2BBcxeKNPzUAHpAoH5/u1kZ7oMLx76iPToviLLvLWNnuBiJyWnrHzvEXCR0u
 wl3GQY8G03x0FLw/QnDaOwxeyiurHaD1Kf3S4VygL74nuPQCS397vcyFALGRp/ia0Pi/w9RMHT8
 pjQ5hL5tgtob8ZQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
required, so remove it to reduce complexity.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394f064a..f723d74091c1 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -53,7 +53,7 @@
 /// [`struct request`]: srctree/include/linux/blk-mq.h
 ///
 #[repr(transparent)]
-pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
+pub struct Request<T>(Opaque<bindings::request>, PhantomData<T>);
 
 impl<T: Operations> Request<T> {
     /// Create an [`ARef<Request>`] from a [`struct request`] pointer.

-- 
2.47.2


