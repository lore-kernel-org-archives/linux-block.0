Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E927B342;
	Fri, 22 Aug 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864937; cv=none; b=HE3S6UHx0PgejcUn+vvz1CqcK+CY3pF2cbj+dstV/esZeenU7LkTBX+Wk+kwAt6sRZ7gm9h9D5BScvNY6pst7ZS1AstNfaq4cMw9V0LORAjH9iLk7nVX/qqm5UCW9uMlp87HvNMP9iXAecwo+FWGRLpZUIJEfqdu7NfEGz/PkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864937; c=relaxed/simple;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bIkOuXusU/aTtBCuHru9Ue8MIhMcCakJKK6peO9PDSlmOxKHUKNKAjcfj7YuuOP7l0eZinIhprqkodHRd222PSeL4fHwAG4dFgtoCUQ2PDyq01jczva7iVOCpEY+iStcZNk3aWuIEs6p/I98DmztSWdSPS/VqdyisxOYhNtfF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYCC//FR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYCC//FR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770F6C4CEED;
	Fri, 22 Aug 2025 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864935;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mYCC//FR8V8cZUti5WHy2kpH5EUTxhD+UlAfCBG8k3Rx+sFsOvDfTcexFXVqgrESZ
	 MEp/kFzVNtlza/TyOaCXUPFoUm4sbLXF8avrGeJDT3bHMnw7tm4rdAP+lAdqVxliIJ
	 c6EJLL00FaJ+vjU1AEiIWf7GotMYi140WBI+A4z87Xy+BNXiqt3UmW2s+Gqb4m2Xk6
	 aqEI2qxcSMLVu+O/ZTu1bFiQrhXAoLhQlDr4JKWHSbTxvCETgV1P6vFPxJb6x48O41
	 k+sZy2w2hGc9shHW1YydUJvwXa//D1IYCbdOF8XDlCi1czGFz0zWdfk8S9zY723Z3L
	 KNU6heLoKrZ/w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 22 Aug 2025 14:14:47 +0200
Subject: [PATCH v6 11/18] rust: block: remove trait bound from
 `mq::Request` definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-rnull-up-v6-16-v6-11-ec65006e2f07@kernel.org>
References: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
In-Reply-To: <20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoqF87ZTCo8Y+0upwu+bueiC9OFcHfiqh3v1P29
 IbqTUVgBy6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaKhfOwAKCRDhuBo+eShj
 dwS+D/0eiPktBwS1xwnUslpGJQUXrEkaYlXdV2dxbIahQ45Fu3stw92O101FyaS5abHHqgXyfQ+
 d7s72X0Zz8wchnQlB+0MnFDgwQ+FE5pFoVCnM2J5I0YHetEQGZ//BHFUioaRV7QpjdmabJblx+p
 E+DUmUVbI/S60PahhZSR/+JpfyAQDX3a2EyzLO3oh+fQ9kIrC3XXuHvCtlg0eWkABETNWV0H12a
 mOrer3SwhSqvBpXj35MxznHNnZSVIPo3fj2nSka6WFCHxhUJqJDEvgODbzgOFIMc+uFw60qN9Hp
 uBzjFmHeeXiqrUuX5M9HBsJNiANxDaDdhGylaMgFpYVVggMMJ9JKY5Ji+QTr0qG3u5mcg1IRK+A
 kaW2J16t+VqZnYAeqFb3K7GRtDunN94cgFVDTfPfYHQizKZvik40Oqfik2Pt4lDzP5VN7GEOglX
 yLZvwkTzQsXfpQFY9ByUA0rOVx+0FzfJ7kgA0jDJ3PhF71c3gS4tniarMiXlhqEswWaGHf/SwKi
 5JWxK+utV/XoQEoyGpfOHlPR/ldcnTbqzPogdSbwKpJIyhGDxLDsol+UK9fiDAU7KqyPGpaa0Vl
 VIoLX3BB3crUAER1nktwrxg0ITeEiKpnLV+p9C5Jxph48ufUkorMGtet/WMPo6UsMP37/T00KN+
 A2jVFhqa8vDpJGw==
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


