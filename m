Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8623207DFE;
	Fri, 15 Aug 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243141; cv=none; b=BRIOx75ERKhKx4RfDtr0kj3NxcR0heiPuWG3qbSUUrqZ73vB62z/L07ZGIUKgX929wCggV7ltEmv3tXMJgKfXFvT03AZ5rEr0o6wcT++oyazyjvZ0039NxsvSLUH/FLVaF8O+Ox4CEFH4gmnt8N61Tk2ex0NoKyVegduLo911CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243141; c=relaxed/simple;
	bh=OtQddS6ZPwb9NsJVIHicx+JPypcp8+9DXNsP2q69rJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prPbvGhYIzQgACbwtCmCwcpHLh0B4aH+tB2t6OzarLRsygyAvVQTn35AcBwLYBVPNzDtmdoYjSYgiSrfi4JN3iUDH2l1g+xjey10k8bbnc9GjIuGxqMLTa+WvIBoGUkBBH5p/TApWltZ17QzXmDF9zlbX9csv89FrUOWvlg4FTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZgO7ZcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZgO7ZcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707BEC4CEEB;
	Fri, 15 Aug 2025 07:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755243138;
	bh=OtQddS6ZPwb9NsJVIHicx+JPypcp8+9DXNsP2q69rJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qZgO7ZcUOShEL20wjOzsryQ3ygdF6qfuUgCBur6zonytmSQqSHSmZNJRpJE+x2o7N
	 d1vf4dD0B0a7LSawyqY01xyvjUKWDwBViiYpmgEIHJRr1oFtrOMa6eWQcuAuJfxSIj
	 t8mhcM7NgFyRp+vLnyTb1VPhqVOtcq+e9t6KFa/a0wpkQffo1cQrJIJ3ASim/j/flP
	 nWXFYxcxXqf44VTYLr5rP6+ZqvVxBa83y5sbswBzK+y/TfOTpDK3lHa7zE0zGDbgaM
	 fSvjZgJtiaSGYPY0nDgcSKiusHXy8ksE3KHgfsZXD6l90w1oF/Ck3/4VnWL4aaT69G
	 PG5KbNoGygRsA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 15 Aug 2025 09:30:41 +0200
Subject: [PATCH v5 06/18] rust: str: add `bytes_to_bool` helper function
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-rnull-up-v6-16-v5-6-581453124c15@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OtQddS6ZPwb9NsJVIHicx+JPypcp8+9DXNsP2q69rJk=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBonuI590lR6f8ZJYdslPPTOmFmX4I5TThmacgAR
 9fFdCr4UpqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaJ7iOQAKCRDhuBo+eShj
 d5ooD/98J4AUaj99036/IMhZ092yldDZQGM/wznNZmm64EQPuMLGwx9BYaMMckEb8qLzr7v2/WM
 zUSJpfKOpbOEDU78DHDNm2JZiEVUUB3WvlhhuYZlqauAae5MxSfxQgOXp2y78cFVoPeLCTG3txe
 c64LtWAoAFPY5R7TEvOiDA/iYAE7CK52XFpWbbSLbrbVWw4EBo5f/sOS8RoRlRFaviYvCyvN2Ee
 rptSENyTyRdOsUVl5f/81a7eqEfbMNbav+ionpwgetYQVvOtGHv6uoxFIQGT+bPdxaFyk2dp1M1
 qJaoPphFU9AgiHYuadktVpUd9quYqSdHqv6pmoE/wm5+APT3f0QpCm6FtNxtPFVtIe/o/fG+q6i
 AvF0d459YC0YtZeMRxee0YFEc5xBAiotlrmHSAbd5xkLqZ3cll5BwYoj/SIkf2RSu91pOVcigta
 DohSVD5GznhqG49BHko43ShmJqrr1rAsBvqVlcrwqho0dEB6/giuuzOiqu+fx0LQRtQUaCPgEAU
 ofwqBzb853b2u8W2nVfpvpExzUR9ANYYD9lo4geKCvjTXphaO9jPV/mq/xTH1EBuQ8vp62UtV1t
 C8RciBdoFQY51jxRuqlrjDgSOiOaV0Ob1hAZ1wCc8AQS1jhl+O7RPCzkJ4Rj8kUAofAEf/lRZDA
 bV3QkPnGsV0DoCQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a convenience function to convert byte slices to boolean values by
wrapping them in a null-terminated C string and delegating to the
existing `kstrtobool` function. Only considers the first two bytes of
the input slice, following the kernel's boolean parsing semantics.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/str.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 5611f7846dc0..ced1cb639efc 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -978,6 +978,16 @@ pub fn kstrtobool(string: &CStr) -> Result<bool> {
     kernel::error::to_result(ret).map(|()| result)
 }
 
+/// Convert `&[u8]` to `bool` by deferring to [`kernel::str::kstrtobool`].
+///
+/// Only considers at most the first two bytes of `bytes`.
+pub fn bytes_to_bool(bytes: &[u8]) -> Result<bool> {
+    // `ktostrbool` only considers the first two bytes of the input.
+    let nbuffer = [*bytes.first().unwrap_or(&0), *bytes.get(1).unwrap_or(&0), 0];
+    let c_str = CStr::from_bytes_with_nul(nbuffer.split_inclusive(|c| *c == 0).next().unwrap())?;
+    kstrtobool(c_str)
+}
+
 /// An owned string that is guaranteed to have exactly one `NUL` byte, which is at the end.
 ///
 /// Used for interoperability with kernel APIs that take C strings.

-- 
2.47.2


