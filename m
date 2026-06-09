Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CB3E44FD;
	Tue,  9 Jun 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032549; cv=none; b=L+HPPuMMmxzaDcA+5oVsClDPfwo3dDHM6+9dBmf6QfyMgVVXN9u2vwfeuOnF4dCpxFbCKInVAzA5f+B4TMirW7l6zhsxfjQCI8Trr7veV2uDt1kemd8bD6BrILremNYSZ9Exd1mpag3C/cYEDw0eiIG/mias1r8HXikFHLdvAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032549; c=relaxed/simple;
	bh=saeAx929MEumoW6R7srpYWt0jl7c4t9NDx7UHc+Auss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHMMu1Iy4Hb5M/83e2Qa7zb/WNiqvRW4D+XOKPJBl5ROMEZLTMMSeUO+9XC7PdcomC9GmwNa8r7iuaSPNPc4Tfrth/qbY/6ZesTPUMv2oeZ+GCoKEm507zMTK+A/7nYPflZiupnZ3kBJev2B4jI0JRDkcx2vt3OAxMxpOeAbA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfEuyFm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfEuyFm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB0A1F00898;
	Tue,  9 Jun 2026 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032548;
	bh=1hPzuRGlGHR6F8zQSGoWCISEe22ewkDpnFmVeBMxzdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jfEuyFm/hAx6MS5urtW/zDAEkpRUKAk4cdbEVABbdlVrV+t5b+q5Qbld29ZT1yWnU
	 lfPpLpHjmMHV/OqnAiK+dvaoXKcbK+L8adV0xvRMa9m3w5GSKvvr7OeAX4dg4IOi8M
	 n1T3enn2PrweRL0/wGuXqXoVdHkPBREFWSnpQCJiIE6W7Q3GA2aZY/HGEcjOIptEyY
	 k024u37TRsmV6aSkYZc/m89BCBfYzNbBckqf56ZK2/4NgaKtMZ3VGGmo+RADdia2/i
	 ynsR4htHT6lBqCY8Za76lYCknx6AWTYz64mv16A1eg6mhOnQk//SII2Ww+bfNILznH
	 NhELfBySmcNNQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:00 +0200
Subject: [PATCH v2 21/83] block: rust: add Request::sectors() method
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-21-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=saeAx929MEumoW6R7srpYWt0jl7c4t9NDx7UHc+Auss=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTH0CYyD0Jxnz7sIleuTxhsvjwvNVqKG9as3
 3F8Reqpp6+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkxwAKCRD6UCkIqsW9
 0DhdEACqiXEmIVrM/wsxmp7AywwJPAcsP9j6NfegAc3bKCA/HCuBa3Y/zaNeXx5o//XHLGK9BJV
 O/naUSzVBIptU36gVfx2L62+wP24jh/mKBc8IFEZWqL+HvVZUKpdiwnG0ZHygZ//gsPrgNd0WEk
 Y3Kg4i7ossqWoy77DyoKcHagMdPztQ79Q1kDy+PioTtteSRFbSKtHkv7JB6wfvSqB1GhfKqQW3V
 ERsPUYYtuhV87vQ0GAGIp3VZwX90RxofIcdZ+3qR93QhhcRdha6p7Jh94AUFLDgyKu+bD/JvRNA
 bkBao4jIQxms245dn2k7sXJVgaufRLa9Qy7GgiOWpN7aUeM/JXNC1MiEQucYYOBQ8uwckuU1bom
 B6+1Y3kQDpi5G8PaTZlVMeuT0fImCQWvldoYZB5xqW7Ctf4yZ1O4/aPWcBO9fu4/cZqqaYQEVg6
 oqwWB+hpBNG2ea8vNo30qSobQN9qfBCLVBsCPd/nskjTP3+k/mbudUkEEsZAvKVcRLiYow791P0
 8QuW0znNVuCnL1T5hPxjtK/7wvEcvqILu09syvrh3FLg7bX7+a4mbGKQg7mdukiBDsErixKBsUm
 Q/myXiwyirEyQMN+IhzeVbUewjW5CN5l+eIUY/sd2rpgkZhdhz95CExMKCjVRTXGrHvfW7GItAG
 N2IkpJWR3O2Imiw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a new method to get the size of a request in number of sectors.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 19bdf17de166..54fe580b7b42 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -183,6 +183,13 @@ pub fn sector(&self) -> usize {
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


