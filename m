Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9E2DC78C;
	Sun, 15 Feb 2026 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771199111; cv=none; b=rDknqMC7KnxCf/2xstcl8BQzhoZTuASJ9Jsn6HwYQxB6IwCkxMir/Zd29qt6kf7QiRpG9hPY/R4HD/+wChjiXfELVguzFMLId/qNtvM58n/ZH56ieftffLm1ChKtcRtIIIetLeLfwT8rhPuOL+vp5P/tojmawhVfNC539b+YkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771199111; c=relaxed/simple;
	bh=FcDAFyIoSJaDhVyJTabIlJqI1bmrr6zZRJxwKKNDg40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbU+qe14gJf25uuLPsytf+tUq1WorqJ00wp1zX/3IlwozbnAyPBCRxy+HxR5mCExM2qdZsL3nQ+au8TJD8Mn31N8IQmcyOfvHKO7Lk4ayP4b2ng2ba8z5IMWivT4EiDsA29Yme/Zg1aQ9S+Kr1YSpIWmiCl2RtGooFwHwavq/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soe8zXn6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soe8zXn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DB3C4CEF7;
	Sun, 15 Feb 2026 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771199111;
	bh=FcDAFyIoSJaDhVyJTabIlJqI1bmrr6zZRJxwKKNDg40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=soe8zXn679EKVPAfQOboI9UKqjiwgKHFnpwMsPiql3Z0Cp4uolzIcGA63n0dWlUni
	 v+qPLX6rDHuSPYzKLN3fyKIJ84tjBld/cc7zxKlQUZnBU1YaAWfU6xW21PSXjNEkWR
	 PKyKHPwVvd3aL/KN+5GzarN2RqK8ZMDL9L/O7E/AJywo2HxXD4veGhulcUU7kSE7HQ
	 Jj2dLopuXrIhd/VpyZSA3vPRx3z817oU/sYeLCUI4MNX1jZtVq5TU1FV1zTOmFPYUX
	 EdF6XVVdzjSZ98ZZZvysqIfKodNx5FnnQ3YSREKCwLDg85oSBi9HbX8aViHSXnszbH
	 IaTsNTXXn5TvA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:05 +0100
Subject: [PATCH 18/79] block: rust: add Request::sectors() method
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-18-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=FcDAFyIoSJaDhVyJTabIlJqI1bmrr6zZRJxwKKNDg40=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklgsVbgdhxlxk0yDLpeTpv4EyLGu60tCgyVLJ
 RCBjzOxsoaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYLAAKCRDhuBo+eShj
 d1DgD/9LxN6RNRd1ZiyiLppcowV7i8sFKLIcLYPN0DyIf83awn5nqKner8IfCM070jzWJD+F3ET
 /AOVeXvIlsEuWxVewLuBSAOVLqSD79pFy2WwJHGIHxqDhnnI274ky8vEQ5PtuGDsdX+2luQPsB1
 vlVkNT6W7n2PShGMSGwr79Zo/wOpki+BvZWcdSR8lCaZcx0NyRkfTXasZ+e92N+p4yAlKGBzU62
 Od2r7Y5Cb9sEX6gL9LYCfryExzrBI0dthwX/SFDoginP1MTOv6l5kaVZprm8rAdZK8iILchC6kE
 QuJQLLEQr57MHeJ7pya234ViDpfixkQxKx7TQOp3mF7EjuyrD8x0P7aUMZVraD4F9uKI37DgRr8
 pqxz6cwV4s2QFOUj2+Ta1GhAXIJvFG7WbDrLLftihFJmFyqP8EsVODQHnRkEuLtsnMvo1B2qTRO
 PXAlfOVUuLOyq2gWoUZIzIYmHy7x0hXnK3h7UFiWI+BqkOHk5LHzh9EHf/UVKGdOeA5k3pvkoNr
 cPHV/K2fn9jhs7Co1fIZ5S3N/Z8/4UDU2gHnSR+Z8aWs6UbdQEwbpgja+WzVrNfWNRqKhc5XRD/
 wsHSZPMm4RR0SQdt/bjiCyqE7epA/R2/icuO7IxzjriDu/XqtzVVojq9x/qe+m3sv3nTHrnmQga
 BCRJn7OhpUjcHTQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a new method to get the size of a request in number of sectors.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 0dd329ae93dfc..9d11ae5651983 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -144,6 +144,13 @@ pub fn sector(&self) -> usize {
         unsafe { (*self.0.get()).__sector as usize }
     }
 
+    /// Get the size of the request in number of sectors.
+    #[inline(always)]
+    pub fn sectors(&self) -> usize {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        (unsafe { (*self.0.get()).__data_len as usize }) >> crate::block::SECTOR_SHIFT
+    }
+
     /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///

-- 
2.51.2


