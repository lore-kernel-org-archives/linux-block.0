Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFEEEC0;
	Sun, 15 Feb 2026 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198879; cv=none; b=nrYLdKaWUXGiQFIfbvfX8O0YT3qI0+6CyJ9SJN9WerD63gXSKqymrK7HR1OzpFqkYtQa54qfczbh0AualQ9lUfHDRMU62fGBUyUYRQ23p3EUem3tYjyBOBcEiKLrUkj6wrZ4DLcUcPhfmNCzx5lcPCbNu/Aba/wYZGQ53YtXYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198879; c=relaxed/simple;
	bh=ishZSvvB3Z9zb8FDhnjXHtGNUf+npQzs8cRfHAQ8f/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHbwNcikliocQAguR635+0I8LEE0O6uwsbqT+ZxUQBsnJYdcGKQlBX7HVOvLrPfPNj122OcoQFWPunt965irl1eGyQ5j9+rs6f0yQPHz0rwB9wCcv4IQ54aPSgCVuRVuLPaXjCTwgsS1oUtJAcQ59Rnz1Tz5cJDuzvTMl+YYXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSaFrKiF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSaFrKiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAFAC4CEF7;
	Sun, 15 Feb 2026 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198879;
	bh=ishZSvvB3Z9zb8FDhnjXHtGNUf+npQzs8cRfHAQ8f/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DSaFrKiFGB6/amTCrWtVtDcKfgshDfMj5idpSAyBQc4yEmAPlpMjiRG9o7/hxoA+M
	 WTCYeCZIM4P6YzdnFkyfKuLz3UPN9hqAqyYC+wcMYr9Yi0yYLgD0VPRqB+sx5aXIOs
	 C/E6Z8NUcStd5iRUdv9VJcw+ehamkLxBVU38EOSl6xuW56SWqgD83VlJbd/YcFurEx
	 7LYrG9sJkDwKUScLvbLY+nKP699y2FMURC1capUA2px4hyZG85LvIiqVOA6zvXv4f4
	 D/DZ1hfai2J4PRkFEsULcN8QKKNp/+gCp27DCBc17FPEwYqWQ9Qsk8dnvf/tlTco8c
	 DVe0LQHWytQlw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:26 +0100
Subject: [PATCH 39/79] block: rust: add `GenDisk::queue_data`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-39-de9a7af4b469@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ishZSvvB3Z9zb8FDhnjXHtGNUf+npQzs8cRfHAQ8f/g=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklg+2aHPwWeYSKM1xwW1IHpYHkn2PT29EkZ7q
 RTzFzyPMfuJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYPgAKCRDhuBo+eShj
 d8Z7D/9CVhX2J92c1AOi2x4M0wJNziPWeHyPAG1ev/9oJdujHCMyMp49WszuFgmYujNhRiF4/4c
 tAHeQSTiybLHs+yKXAnrC+KhwvhsCWCYtQBgBiHRQ3fZpNV9of/AN6cCx8Xzs2nnAvWfHnzjkJx
 QhMdRd0cykNNVSPrx1CrOqryOPKGdq1KDuacQhb3pKkaAW8sQoE2YZJMLPSftYv1lSm6BSEtBGW
 vQ4keKzdQ7e5ueIC7V+Ej2aIMn0UmLJ9nEt89YVSVESTsEjh1/5m2dBLns5sOpcwdaBBrzU4TEK
 ObvgiTy/7knmletLmc3TLdmFa+yzzwQCeG5sZNucLKSPB3QbxFGNMgfXkNvVpH6Vwy62TbQXewA
 HnyYyaTtno1Dfy0yiWJD6n4TvZEXo1F4ipk7n39r1Blt1O+yqe3Kw5Eo1UCmApquRGRGnqMhwah
 T165zGyKMU1sQDfDUqP9kOouPyBPxtr8izJ6IHmP4eV/4RWmv8qUtQbO5tsy+HpeITKktMtVVfo
 vf3U1q9tcqvCGojacdc30nqWkUqso9gnXRqEqX6FcufnzT/nSa3hAojU1ubkKDCZUFabyG9lPSM
 wGQd0G7QkYQm1rELpA12e1wh5z7GlXx8ePguS5fIAJObeSYnrn2k16JAXQDe7asZ8vwfM+UyBWg
 iQ/8jHAkGqbPItw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to borrow the private queue data of the queue a `GenDisk` is
associated with.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 8a22767f1b916..fbda2f572e17f 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -246,6 +246,12 @@ pub fn queue(&self) -> &RequestQueue<T> {
         // SAFETY: By type invariant, self is a valid gendisk.
         unsafe { RequestQueue::from_raw((*self.gendisk).queue) }
     }
+
+    /// Get the queue data associated with this [`GenDisk`].
+    pub fn queue_data(&self) -> <T::QueueData as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: By type invariant, self is a valid gendisk.
+        unsafe { T::QueueData::borrow((*(*self.gendisk).queue).queuedata) }
+    }
 }
 
 // SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a

-- 
2.51.2


