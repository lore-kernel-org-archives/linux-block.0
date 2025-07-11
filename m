Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF812BD016;
	Fri, 11 Jul 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234231; cv=none; b=r28wFbyhK+L+qdoRigJz6NC/Nqw7ouD8DjqF+IHSvT8IleYA7aVQGtXDdWwaPgH5r/5tf4JT6eI/2yzU52uddRK9f6qLW95cGR9pT5IMHVYsWnPKu+mS6R8j5a/AgSO+GpJeNNuZyA4xdYEBFEQiu9F38AqpnI1H4NjHExk1WHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234231; c=relaxed/simple;
	bh=MFRvhK8iPDT6FMh7J1nCDqXSyE+ZNVaoKHHwymSCd0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0KpcWbpEgzmyljB4P991Jx3cX4yRgAFIwFt8pD/dEslprlB3U7XAfm7g7aHll6TzhjxbRdIuhRQoUE1yb1ZGtWVVa26Oswe5AEKOmfY1LADS47zIEv+bc4q4mmgIPfNyma4fOJalN7bUVcrhcITG5ZYdH5amKBWcbnc471NUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSddd0uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSddd0uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831FEC4CEED;
	Fri, 11 Jul 2025 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234231;
	bh=MFRvhK8iPDT6FMh7J1nCDqXSyE+ZNVaoKHHwymSCd0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rSddd0uhFozLcQMSccVl6VLJ0v47c+rk+t3WSZmYw40Dnuz4jNeZTiPRGuZrSu81X
	 cUMX+konBdDDLe18Jt5X94wXz+nvMS/30gxXmen42ZkJ2CBJUg4fpu2aFhCxQHbA32
	 yt1JEhgrNqb/K2PxnaPPt6LtYOVSDfErUHzo69FGtkNqy8l2aHQlbEcBFmudP3pe/5
	 F6Kn98ZW+EWbsoFTGg+k+nqhnRPjvgrJGhiy9o+zPtjfwD03giyO21DFd7M7e39SmB
	 J0O3jjKSfT2UileQ6a8WPY9Y4DNlgXG8/67DoIuCgJ1HvX1/lqbc/LkZfydSSujxcZ
	 UKawDEzXYUVSw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 11 Jul 2025 13:43:04 +0200
Subject: [PATCH v3 03/16] rust: str: expose `str::Formatter::new` publicly.
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-rnull-up-v6-16-v3-3-3a262b4e2921@kernel.org>
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
In-Reply-To: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=MFRvhK8iPDT6FMh7J1nCDqXSyE+ZNVaoKHHwymSCd0o=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBocPjMNEVGX2NFrpauvhDJbDfkW+/YUeSQRb1U1
 ZAKq6h7gtmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaHD4zAAKCRDhuBo+eShj
 d9ypD/4pjC5iRSq9F2EevIp+MEPWVyVynL5WashYO2zdZbOfpmyz0ViYVUz2SCGonKwCMasAU2b
 kn1n0/2C263SP56sUGgEnwswG8sBTmlrs5xsKL4FFWO7e+I+ft49cNginJajEGnfSAejUdEMl+Y
 z45RS5S91O0UUfNjs1fQzJ6rODtMivxdDIbRBWTGw6eyNOVvJ872Xt2JBcTWJuVUhJ7i3r1dwck
 kOK7vMWvuBOuMWE1S5GQT3+VBnl/gvDOA3btcVbhnTb0jpTPy8wWjJeuH8yztqOwgu0gNu/Cvnv
 whWMdzt2LKr3ZyM5ioiq9gdXO/lUG4Ti1WHx1BDe7WOTSCu/IlccVAyfsj6Fh5RYHzcEVQhAJrx
 K1kw7Olrdp27Fs22O2Kk7R428SAuL8E+eqXtObaItAVGtUgYZiyMXm5tV7TW+44YfPZY4jSpzc9
 jWIbUC7JTuSOB3j2X5ATbi5TMpfDHnXWyfX7tJjvESVJrYNWHRIymqehYwlpmKGllxZBSaLZ/1P
 UnKizTajESklGykT5YuBAFzm33doKKMgrmkHLmmIAgMusT+sizCHYvbruPltebllqTuGjc6q0wU
 f9dBEGoW1y95iqPJD+asFongyQKuKe04JepWOtJAvMQfcvj8GiyONsu1Eto06PhNamdPcelz5ri
 8kUWrQI5oNBrjHQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

rnull is going to make use of `str::Formatter`, so expose it with public
visibility.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 41af456a46c8..28a6179385fc 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -703,7 +703,7 @@ fn test_bstr_debug() -> Result {
 ///
 /// The memory region between `pos` (inclusive) and `end` (exclusive) is valid for writes if `pos`
 /// is less than `end`.
-pub(crate) struct RawFormatter {
+pub struct RawFormatter {
     // Use `usize` to use `saturating_*` functions.
     beg: usize,
     pos: usize,
@@ -795,7 +795,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// Allows formatting of [`fmt::Arguments`] into a raw buffer.
 ///
 /// Fails if callers attempt to write more than will fit in the buffer.
-pub(crate) struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
+pub struct Formatter<'a>(RawFormatter, PhantomData<&'a mut ()>);
 
 impl Formatter<'_> {
     /// Creates a new instance of [`Formatter`] with the given buffer.
@@ -810,8 +810,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
     }
 
     /// Create a new [`Self`] instance.
-    #[expect(dead_code)]
-    pub(crate) fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
+    pub fn new<'a>(buffer: &'a mut [u8]) -> Formatter<'a> {
         // SAFETY: `buffer` is valid for writes for the entire length for
         // the lifetime of `Self`.
         unsafe { Formatter::from_buffer(buffer.as_mut_ptr(), buffer.len()) }

-- 
2.47.2


