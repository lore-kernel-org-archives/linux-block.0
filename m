Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB441862;
	Fri, 15 Aug 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243101; cv=none; b=HZKaveQzXqvcXLi7ky/Rw+KagyfXYdMChG5HLvx/zFcyjOxTi11o+cR8XRKloy9ftInsQrucF1NbsqznslgziBe1IJmL1zVv/VZObnVWqxUWRXvw+JoNIj8qjEs5MXWArwc+fdqK5ulLSFvWQ3+KeBNnNblJxSc/hbKBHSHALVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243101; c=relaxed/simple;
	bh=pzI+PzwBdiJXG7Rnf/MUlf5BoxNaAVR/4KH77t5lHuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5E/lZCmE7lLcrgUNx4+OZ3SkDHCXMW9SMaETg0T0gTqs3CT+rIprJyXYB+0kq1KOlzafQDrj+n82Vu6gyu1rwK48EG4x5CvCk6FFMIVd4zBxPZy9fqRpAJHzgJ27rP91D5JTx/l3aoSsxH/gC8VtWOaAxduQl1M6ZPY4Jq3yWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQWJKGP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQWJKGP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFDEC4CEEB;
	Fri, 15 Aug 2025 07:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243101;
	bh=pzI+PzwBdiJXG7Rnf/MUlf5BoxNaAVR/4KH77t5lHuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oQWJKGP6gtCw1h1qH9RTOdClZX1YTDilo23ktLBDHUigtmARP4mX7tFmeptF0xHS6
	 unKZbkhn3Ey3Mfj9uSR+ssvoXd/7C5hvBLxhhXo04fliJ948lpaFjS1QJHZWocWeBo
	 NxLdjQo7+NyVc934wLn2hJnGcBKSLSElwNk/QBe4c8CxPQgPSCsJl3IeIQB9uocwt6
	 yMGJCS+q7aGsmtvpsYvNIH9dq25oIDcs370kB95QNn+h15nxPC/SWtC512iFgTH+d2
	 Bd5JdcqWL2F9GRfvIW2mkT7986By3+PPD35F9+rTEYsC2765NINY/BAvI0U67xJSOe
	 l3FD4eQbBEDAw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:47 +0200
Subject: [PATCH v5 12/18] rust: block: add block related constants
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-12-581453124c15@kernel.org>
References: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
In-Reply-To: <20250815-rnull-up-v6-16-v5-0-581453124c15@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=pzI+PzwBdiJXG7Rnf/MUlf5BoxNaAVR/4KH77t5lHuM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI+NR1bm5f6cjdHO68QuIpWUgAQN2aK+HG51
 YYTG3A+YBWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iPgAKCRDhuBo+eShj
 d51lEAC7gK4el8MDA3IF/dUMneYYCjOWN/qhhObe1yJ8CTdt16cTDagRa0ww86UJ6KXUvEUBG6J
 9hvJopnLvcVT2uGNLJ8NH5Z15ntMirhKW+dflkmPZM+nRSDk79fvsrGMerrJoK8hcGybBnleenc
 A4jyFOvnq8MDqXAnRdxZ8c3vDplAALdhcBS0Vz0xcnkHxBOTXUyLR0K2jvXxKrqv9RQuKbtFc2l
 VEAe+NCN1+9RtsZ0cWwdGBpLokAUV1u0loXjQSZI+yRyiDnUHt1bg/lMV4p11uLGsdNRKbO+kwW
 usIGxdTCW8VtiNcHgFn3PkUqYWROGxE81iJCGD8IX+iV2zBmjDaOjtQ8U6VIMYaW5Bk/FqBVBzF
 cU1gyr4C49QGJkjmtfIwa+5DTwWR7LrifMIcUgJMBSc5ZUKWAwRevdjQZSemJ/29o2kOSwXkQXU
 NYCmKDMBsztu5EhK0VjtdS6RcovlBO1vJxmwaoCvrJYtcC+vyIh3naGzT39bHav6X9h8HpncIcR
 pBGmABThZD51BgwSNJdlYtTU8+jElIY7IFNXy/lfVOOBFV2i7mg95YdLxt7c6n5FELoSfWYo5C/
 FVoKQWowg7yLS7fT0i36tYi6JsbolEjCrULiO/h3PuIqM7Gun+up5C6vEVoVBIuSjiia7Th5GL9
 if1hvdqt/BzIA3A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a few block subsystem constants to the rust `kernel::block` name space.
This makes it easier to access the constants from rust code.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
index 150f710efe5b..32c8d865afb6 100644
--- a/rust/kernel/block.rs
+++ b/rust/kernel/block.rs
@@ -3,3 +3,16 @@
 //! Types for working with the block layer.
 
 pub mod mq;
+
+/// Bit mask for masking out [`SECTOR_SIZE`].
+pub const SECTOR_MASK: u32 = bindings::SECTOR_MASK;
+
+/// Sectors are size `1 << SECTOR_SHIFT`.
+pub const SECTOR_SHIFT: u32 = bindings::SECTOR_SHIFT;
+
+/// Size of a sector.
+pub const SECTOR_SIZE: u32 = bindings::SECTOR_SIZE;
+
+/// The difference between the size of a page and the size of a sector,
+/// expressed as a power of two.
+pub const PAGE_SECTORS_SHIFT: u32 = bindings::PAGE_SECTORS_SHIFT;

-- 
2.47.2


