Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADFF4D90D7;
	Tue,  9 Jun 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032420; cv=none; b=Zt9Hf8JOsbRamIqQ+6bHN3C5QuYzwx2jh66n3IYd6f1Dc3+QlqZ42k0Ucdxcyuup6l5aH6HfcFCDdCz61vAbvGsx1WssaywUG8LesZjQrhWd+ptIxpjQsnasYtsUTscfe1gnsfY+Skx8DRC4PWvxIzGEjMO2u6M1wFPiRoYOslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032420; c=relaxed/simple;
	bh=QkTc+Yc4D89ONNykWVRFoz8tGJV4akO/AW521uoK1/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTmICzr3W62IpMCuW/8wREWHkB9uzJbzAkkX2dp6D5/uB7dhe5fhGgHW5XYwlM6QUezq61mEmlxR3W0qIE6gOZdmT057Ae6uCVSYKdi9ezhjeb3NlkHzPiN0NH12wq1eKaMIwG4fRQv+o0MsNLkhzBMloAZL9Hw7Rk8TMwOOlhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV4PtLBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV4PtLBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D241F00898;
	Tue,  9 Jun 2026 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032419;
	bh=UznLXv+yDoXlv0q3+7o1af2gG6KRdEpR67pAYXvOmSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eV4PtLBlcmIv0Rs9zY+RH0AQ1KpL1zwypAt5Izt++/RuDL53D/zlqHzbUx3BjTbH4
	 Rwez+JUusnq6LFb1LdHpyHaDhTmIrSSTVvGikutOfjjEzfOP1dPerlzCtMPtBTmxRA
	 Evy2QrFrR7hKO3WPo3IdfJjp8PV6lS6LVgHS3ujbFx5Tpqqt0sALERzM3pGrQdzjrt
	 6oprQDgRaavUxEPY1tVPAPVMc9G6C/+9oeXr8FKTKiqFtmLhRESG55UtwjXTXgvJcd
	 JmgcrTXETRxfnZpM7qU2qItMwIT2F3KGiQjv+5mfAIl6l+pzqY6LcC2cpBEXwgjOmZ
	 SsxmY8pzAd0VA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 09 Jun 2026 21:08:03 +0200
Subject: [PATCH v2 24/83] block: rust: add `NoDefaultScheduler` flag for
 `TagSet`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rnull-v6-19-rc5-send-v2-24-82c7404542e2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=QkTc+Yc4D89ONNykWVRFoz8tGJV4akO/AW521uoK1/4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqKGTK0UzZL4I383mSkVK2Rk14L1Tqwr6Iq1PY8
 mxrWR8hc9yJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaihkygAKCRD6UCkIqsW9
 0KW1D/4zp50ASbhhUmvVy8hfrATcAApjnZ/OtWhyYLIBc0YBryID6W/1ii1xw60AQJCUxU6QH1U
 u+AKjeUPAVylMVse+ivWCG1wwLfFXBir86ERXb7sYtoT6e4ZrX5+2FgtU7If/0jW6PeDE+snU1M
 /Q3XLlMSNDjqNWE+RNDRg8Q+CsI0dJZthUz052XvCHTCV2XU66tblMnZg6Rdd2Gsx4z5hFxQ6qh
 sCjRq21uw0CVTV9/NNaC3r9WOH5c2kfq9l/yurslB3I712ZQjr/Ou9YLI8Dwm78of+YmaKS1/8x
 HF3L9PKpielTT/sp1K1nYGTGv0tIjEQk/SKwJDgGI87P08y5Npo0vBZDcXGAZKqlHwvrcDgXtQl
 Y8Ulc62/bstRDtqz3S6t1471dWYgZf268gPoK/il2sEwIg3xq7x7MC03Czd6WV1yK/UKJ5DbFlo
 Xf/tWC1jUbUQCQOXOqRRDmCHzGjI8lsdfvEvNglhey478SygvWqeshKVPz4KEpVTP2MLPhZrmPD
 twIUqTwCDS3AcW0gXF7i/Ceu/Xq3rPxCc3oO+xVYGzG2ysuJfEzfiVUP5GpgHzd8NfxkZPd/2o3
 22JPrke71+Ss9WHskK1ZzucpQX52QsE0xgCunb6v9fbaTVVxZjVKIQTOameD2U0M9Z9xoxG9XC5
 1zlZ9whoVdLOkiQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a flag that maps to the BLK_MQ_F_NO_SCHED_BY_DEFAULT. This flag selects
the 'none' scheduler during queue registration in case of a single hwq or
shared hwqs instead of 'mq-deadline'.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/tag_set/flags.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/block/mq/tag_set/flags.rs b/rust/kernel/block/mq/tag_set/flags.rs
index b7eaccd200a2..2561d7090c49 100644
--- a/rust/kernel/block/mq/tag_set/flags.rs
+++ b/rust/kernel/block/mq/tag_set/flags.rs
@@ -17,5 +17,9 @@ pub enum Flag {
         /// processing IO. When this flag is not set, IO is processed in atomic
         /// context. When this flag is set, IO is processed in process context.
         Blocking = bindings::BLK_MQ_F_BLOCKING,
+
+        /// Select 'none' during queue registration in case of a single hwq or shared
+        /// hwqs instead of 'mq-deadline'.
+        NoDefaultScheduler = bindings::BLK_MQ_F_NO_SCHED_BY_DEFAULT,
     }
 }

-- 
2.51.2


