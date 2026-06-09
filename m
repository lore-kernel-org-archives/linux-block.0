Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650E418AC6;
	Tue,  9 Jun 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032594; cv=none; b=lMZWTsNGAtddXRTQFU/U2GXL1gwPjYHltWDnYzUDLUeKO7B0e34alBAk9EwaWVsmmpziBacu/552HkQlxlpFG0d97B3UBvvELV+KIH2mbJAaiJmU9bjGCTTUpG3c247okw2UlAbScFchiP6N901mvebKgoq6awi8I5gXiNrb9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032594; c=relaxed/simple;
	bh=3a7iopDDpVfSb79+JJXmsLPYQF2HcbnYwDnDegNwY+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7MPqyT00ZUmvbWVlN4pdC2ZVGJWB9cztx4hvl0gPEdcZLduUA+seeqJo4pkeWY6utuQZ+9m1W2+hcueEDFnilRBrusgVt4/f3C14RFYXXooWF4ZJxV5kPkKc2F5Jh4Y77KSF4lmY8DnvRrNL3nXgPce9BD7KsvNsVJkKWUWHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA1jDN6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA1jDN6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12CC1F00898;
	Tue,  9 Jun 2026 19:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032593;
	bh=ceBxrKoS+wJKiaFN4cLOiMODjlL/11h7U+S96uTWBDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eA1jDN6YyELOCOa8X5oEIDSxxoh5dC0rltB56ExFbZ7xhWcDACGDg+vg4eMfLW1ET
	 NWoBCbja/8RFTQF+QMnfmLVWDfx3MldlTK4JaZEbBX5aeM10MzN5AYbRpvSC1NCveN
	 DViSi/M/y3DpyqKYQf7Kn4PprdZIDbKCsCfZdufaul72qH6nYaIQAMzNQeohzPmVFE
	 /H2PKBIHT6sci1oEEKP5vYHfAxKY8VmVAqBYVYmc3DNRDkYGXIaxAL51qBa+I9O/2y
	 0+MUdzBiLK/kiZqXF994Qoz+611BRXTEZmZeFxy/cKKQheDoZTvuD4cmaLNfkZNwVH
	 SK72mVDE7jsjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:28 +0200
Subject: [PATCH v2 49/83] block: rust: add a method to set the target
 sector of a request
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-49-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3a7iopDDpVfSb79+JJXmsLPYQF2HcbnYwDnDegNwY+w=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTg+ZmtVXy+AJz3uWxsiQGOSHwamJdP+GKsj
 3jamG5JdFyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihk4AAKCRD6UCkIqsW9
 0OdoD/9PtqqOjDx+7cpfrfEDQvEryz7mcRZz+rSjYP/0BQE+XiVpvXAUCDvPnbakbh4lpNSp0VY
 5TOPyaxt7f0nx6Y5KkuI9jpjdRMzDp7V2DUB71Gx3N7A1CoNfPojHm7qXu82Jgu8LkUGRkYf+vS
 eutgaL12rgKVIr+eD4tH7q/gqnKRhltLWxX+xpQruEQU0VTjEg4EUwMxxBfXp1bKMJr+k2khdsC
 0gMw2N1TN2bxlIwlrhhfg4ev14b+4VFLIqcx2MjGd46RopjOKwEWCnOmbcdH3E3XSWKtaFk009z
 AxH7CgutGjDiXF6MWMNqau2JgWEPSvjh8UHDHhrfy+Ut6KXVbl3nGrO9cBTkR00GX1UzUqHhqz9
 yNTKz58qbnFNbQzdyJp4wxhOu0Kx2g8IW07gVOwMDj30VzUUAYHs9cw/g4TpxX+HElDNqS/wHn/
 APr0iZ2wWuFoGmaC6+q9vEHvU7fuIrGzrzWa/fr6jd4RsnHQxbfoQw4CLFFGqkHyI7ZZCS89ak9
 9mdwJ4B+6sfUwCexGx9msOrWewmkVUvqyol8OvrpYevPG0rvmXCkMZ+2fzZK6zw9QeVDzBq0c/i
 5qKwdLNPIQRC+5Dpy0/hyuG5YHG8PAZLYEZ8vjXYa06A0woFUj+FAVOnL7aoMyVIa0GXk0BH60l
 HEgqudcUfq/MFbQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a `block::mq::Request::set_sector` to allow setting the target sector
of a request.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 63e248970ab1..66ef2493c448 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -336,6 +336,13 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper<T> {
     pub fn data_ref(&self) -> &T::RequestData {
         &self.wrapper_ref().data
     }
+
+    /// Set the target sector for the request.
+    #[inline(always)]
+    pub fn set_sector(self: Pin<&mut Self>, sector: u64) {
+        // SAFETY: By type invariant of `Self`, `self.0` is valid and live.
+        unsafe { (*self.0 .0.get()).__sector = sector }
+    }
 }
 
 /// A wrapper around data stored in the private area of the C [`struct request`].

-- 
2.51.2


