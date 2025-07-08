Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC1423C507;
	Tue,  8 Jul 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003941; cv=none; b=l4sBJsmqQImLS6rX2sjmQFdK06yilggkrMIVNeZXVyWZrAHsRxBzUdyTkb41y1Sc2AWi2rKwKhgqky0xbMcJch0rP/DO5fydCfV7O4m3g+Lp/Asqa1mky3oOQO++9piLzzCKjmi9uaCZjHgpk7iIovvoQ2dn1bEgtHVAVbJVYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003941; c=relaxed/simple;
	bh=z0+jOSZzCCJUSyUkPI8s+JDMHgPTdqPWG6ejwrYP3mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5my0Bola2vtdCGoHtK2gnCPG2WY2VZfwSgpcrczB080xn8rPrsstRgTd5iyVuwIaZAePcrpjwt922jgknl+VCZ3aDMQRSAx4YFTBTqOkO3oz8tlbbbFHiVI2bZ23OWF+yZpfEKF70x0Rxg5RA6wUymJOaXXV8B21/7Y52aTKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW4fjsve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW4fjsve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07650C4CEF0;
	Tue,  8 Jul 2025 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003940;
	bh=z0+jOSZzCCJUSyUkPI8s+JDMHgPTdqPWG6ejwrYP3mo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KW4fjsverz1sLkNuZuhm+M1UyyaFr38t6Tn/wRUdn5D6gEHeN0TZ2oMneVlaKRpv8
	 CHcqBUHvrsxRE6D9RntP5yCJ0fAfv9Y16DLd60WzRFl0qnes35VRzVKMp/o/+YPyc6
	 lxDlBpOU3R1yj6qTy8pU0iUXD4xp+dNPNpV0zpA0msQ6FJJIiGSJRJ8tq2M2YVOoQr
	 pFFuydt2uLsW27Ft2GpP7exsQ+oGlRAKlF2/kkuTOPkiHOvZShJjVBCm/vx/ZF4E+T
	 tMVB1BVTd8jJC/nkn3wnhytpOLxanpJ1pQGklSMxR+5ndVbcalU6Al24aRH9p/3lPF
	 BlM5/jd7S0Vnw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:07 +0200
Subject: [PATCH v2 12/14] rust: block: mq: fix spelling in a safety comment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-12-ab93c0ff429b@kernel.org>
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
In-Reply-To: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=z0+jOSZzCCJUSyUkPI8s+JDMHgPTdqPWG6ejwrYP3mo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVL2BNjzLJTazu9p0aBbWi5VxY6sIudKezm9
 U9lZkXR/JCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11SwAKCRDhuBo+eShj
 d4jzD/0Vl+QhDQ9TzC2wDCbB2E0Zswy8wbWlcX9YsLptw6xfv2xcV4TNB5D8CCXf5wEOVmMspiV
 dqeaUplFJcZftgDCKTWsST5Pnag6PhRoBI/DMTprQle1kH2TwnIp1BXZ/GWkgV9UXi6/3DVp1XX
 29fYB/pkmBQcmA80JBfVyR8EV+JCzEmqHJqHNj2nWXAU2Fy8/FK28ZXnmMJzvathTR9UKqJvSno
 cn2h/Ctn+MPGwTf+Syo4gIJQxauZ9adFI1Ll7fHkRaXgRcRJteJV9USL1oT/EnF9QAT2XFkCUs0
 rN3BkrKBmxYTNK6Z85+cAL6nmmwymeelCuBdKkHNQMwA/2zkcFJOAkQsf8dYbWNMa/ERNjlnqNS
 hDDmNHLPqge0bHF0p/h4RpeObCDiBB3c1REtWhPmqA14hYjxa/x8uEv87DVGLJGR+tmhpXVJ1jn
 joc14CFRj65S7jPyL8uQrfKRnBG0ZY4DcFL87vj9399MhAhsg8It2vdIy62LaLHcm6LFPdPL6dV
 oojFpnlh7052HED5KKB/qL51rv+1vB88A79ksd8uUDhB71Om9MPFtOr+3kzB3+He6H01EWU+RmL
 bop21V7zo2MynDrykz2s6rrFakFZrLdRVljfziehp721rP7sKysvWBL9lF0ZhPvafSZm9YLr6mz
 Aaz9wZXLFPJc1hQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add code block quotes to a safety comment.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 2d14a6261a313..873d00db74dd5 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -143,7 +143,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
         // valid allocation.
         let wrapper_ptr =
             unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
-        // SAFETY: By C API contract, wrapper_ptr points to a valid allocation
+        // SAFETY: By C API contract, `wrapper_ptr` points to a valid allocation
         // and is not null.
         unsafe { NonNull::new_unchecked(wrapper_ptr) }
     }

-- 
2.47.2


