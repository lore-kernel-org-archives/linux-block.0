Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D813749E0;
	Tue,  9 Jun 2026 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032437; cv=none; b=Tbb9ZpAnOv6OIm6qJy33/0m4/3+f2kZyPZ/3QpJpnyfrA/jBE/+8cniUJm/8e6hFUNHek9bPWgqrnNREl/GjvIWKLXNTzhCEz4FuqtG7jSruiFLAkROSuCC9woFumT/AhPHafzsoQ7HuO+Rd+t0KMdlkul7GnQhEIr0vzz8Fvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032437; c=relaxed/simple;
	bh=WeYmUyzlnXNFxatIkPpAFWbysNLEuc10mgSTySvU0tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ylte/wn0bTZ9abEsh6dPaeBcW+W7EOlk57QeGpSJ2gtyv2zdcosAovquvNzDakRGSjJ2q23Exrtfm141l+hvaXCtBBcZwUjxQI4K7Bgt3rIFVp5DonnOXUrrB2PwWiOlo7txsuWc53XdVmFSuuMPk+VN1xqC5KoMnt5Qz0UP1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfcOINeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfcOINeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3FF1F00893;
	Tue,  9 Jun 2026 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032436;
	bh=75VKKvc6NJYD5SbM7TBq2nTJ46z7L7NmdWlGRZUewiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kfcOINehWKcp3xHtTXGSLHWSOG52K0OZctFq88FEdbCXodQGd98cSiTeLARe08H/I
	 WZdb4CcyA44JkRtJQOnH/HoVzi84FyydSlaaxTVzXONcu7HTe4IMNMs9m192s1V4OF
	 1QhvpFsnOU7Th4JJa/thaqDZrlpgAfjaUMzEFoGsvpqs0Hm/qDgndrXyKY8tDQy/IQ
	 xQElXKLaImnBu5kviUwfTySaGPDXwGWQfFcjblEEUttXyW68n8jo2WCSM1ZxyGYD6y
	 W7ZYebArVcSCDN5wNYEE3mToENk/qla4+cSl5PVFg5tTDZe7McNe4oS5YEC6wJdRqE
	 Co35lL4onwnaA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:07:48 +0200
Subject: [PATCH v2 09/83] block: rust: document the lifetime of `Request`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-9-82c7404542e2@kernel.org>
References: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
In-Reply-To: <20260609-rnull-v6-19-rc5-send-v2-0-82c7404542e2@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Jens Axboe <axboe@kernel.dk>, John Stultz <jstultz@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 "Liam R. Howlett" <liam@infradead.org>, Boqun Feng <boqun@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=WeYmUyzlnXNFxatIkPpAFWbysNLEuc10mgSTySvU0tw=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGS8pbk0dWGZmS3+sy2e+s65BD8zbm6UgUtCy
 OvQvHcZviCJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkvAAKCRD6UCkIqsW9
 0GOND/oClSp+fyePfjxASjbnzpRkbpOcYzsPIfJIFLzOEbuxRBKqUBX5gb6z9iM9ekAtle7EjDm
 LgmLhm0/UWbN/qEG/RzRfvXrZkkzRon67UBiFRqCaTGOdCAYMbrJSuUyxdCsf3Tr3lU2rundNb3
 ZxcH9LxUz0Bt2ojKj+vWsVfflJtJzKjap3viiFj8LecPgipAQqexSqDuIn8JC4hOFb2MuvCMuBY
 1j/QRQ/ZH5DxEfl9E172ZsadOzLm4CNgQeHRznsTqMcqi5iLdG6u1SJ6ReQozO53l0/faq7WhdV
 BF/L0lwriH76mvPK9gueQ4jM0vFUhD6CwrMwHHvEzgq1oSJNITpx9or18C6Dr7o2/AssXrvOz7I
 hc1I/qc5eslTGSkvxp1ftgksTj+cp0ckdVu9Hoo9Ok+UaB7cUHnFxEpmvRj7/x1Z0AiiFimQaJl
 uyLRyDmCazphHvIP3oZ7CwYBfed03bT6/5vKQfqWZQ3nZCShOG6Lq2WKTKkN4NCBGng4/TOdJ3q
 prIb/yRoyDjqzavaK/zyHafEQsUdcKTbO1lzIhC7McNRlpKUf5bt16+nGRdSXbEgfVPiKRd3c60
 vARab+Z3NoVCOPqseBUmafgMa3ay/XiiOb1f6d14r9Jv161VFFrwaww5vGDsLalB+c7IHagEWly
 JokXC674ET8kROQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The `struct request` objects backing a `Request` are not allocated and
freed for each IO. Instead, a fixed pool of requests is allocated when
the tag set is initialized, and each request is reused to service many
distinct IO operations over the lifetime of the request queue. It is
easy to assume from the existing documentation that a request, and in
particular its private data, is fresh for each IO.

Add a `Lifetime` section to the `Request` documentation describing this
reuse and its consequence for the lifetime of the request private data.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 1882d697dcf3..a6e757d8755d 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -29,6 +29,24 @@
 
 /// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
+/// # Lifetime
+///
+/// The [`struct request`] backing a [`Request`] is not allocated and freed for
+/// each IO. Instead, a fixed pool of requests is allocated up front when the
+/// [`TagSet`](crate::block::mq::TagSet) is initialized, with one request per
+/// available tag. A single request allocation is then reused to service many
+/// distinct IO operations over the lifetime of the request queue: when the
+/// block layer needs to process an IO, it assigns a free tag and hands the
+/// driver the associated request, and once that IO completes the request is
+/// returned to the pool to later be handed out again for an unrelated IO.
+///
+/// The private data area of the request, which holds the driver defined
+/// [`Operations::RequestData`], shares this lifetime. It is initialized once
+/// when the request pool is allocated and dropped once when the pool is torn
+/// down - not once per IO. As a result, [`Operations::RequestData`] persists
+/// across the many IO operations that reuse the same request, and a driver must
+/// not assume that it is reset to a fresh value at the start of each IO.
+///
 /// # Implementation details
 ///
 /// There are three states for a request that the Rust bindings care about:

-- 
2.51.2


