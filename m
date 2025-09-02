Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916638F49;
	Tue,  2 Sep 2025 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806964; cv=none; b=I0cZ8WHccAjx8giIp+MTgxX9TM6AwcmT20yHNSFZpc3Fp3/4zL3cy8xfhUBJEwJxcclEtyLJn4OBb3DUNynj61JH79G8nxMFhqfwfqAiu0tuBc5sFtuiHcu1UOL3gWAzU0zD+oFBEQCunBCZ4SSlE/5Egts1W+gAZcL5DG6nNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806964; c=relaxed/simple;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJXDbMQ2sDOqPrRcBjYepj7MA4V/fH1+v2M1E9aKZOh2byHrqQspGkQ/fMpVy3BFvBsyqC27YTDZ14lkq0iBATo7UzLdPgGpz6PTosTGO40A1+LRcmtJ6ETTFMxRV6KXHpOU/0fzcRbAwrp60Zrv8t/qrkIJ2OVWlnw/oasYBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLe8MisJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLe8MisJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA03C4CEED;
	Tue,  2 Sep 2025 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756806964;
	bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cLe8MisJD8zMRHnHg0kTCgwq+inur4tADPn9jUz4uleXC/7kYiQFEhJYTan82dM28
	 5lp4r3SZzfaRJllHvKyrF7QztKKvvIyxJvlQ/n8yK6ajd+ZGzLeAr9DS7InKx5CY7t
	 U8F4MQsQQyhNQIcmg6z/gcgKCR8+bOMX0qP1daOv+8NIK/2AduxJCmQGYjEBbSVTgs
	 8eQnymFmi63PvaNDqcLkrSp0h5btbAI1sw88SkcIc7BT7ztCjeb939tkQjkR1pyUA7
	 MtQ7+1qWVOHetpBbsVibqSmvMoOFXIOY0oHrc3RDkCNGlx3BhMijC3jJ63GiVLWZtD
	 4hOdL+x5E9ITw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 02 Sep 2025 11:55:04 +0200
Subject: [PATCH v7 10/17] rust: block: remove trait bound from
 `mq::Request` definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-rnull-up-v6-16-v7-10-b5212cc89b98@kernel.org>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=OfpvNSrrUeZHTWGA2qHRRXa1nwQ1xGGBIsoZwm6M11A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBotr8ClyPWiVj9Ma+0aLYhbK9Pr+52/bIFG1Krr
 h9wNMmQXU+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaLa/AgAKCRDhuBo+eShj
 d4zmD/9u5rY85pIQ+Oq7IeAYvUfbvsK0GBMpf+Aw0lSFWdzJyMNkALE2XOfBtzn9nwVyZhgg6U6
 J0aSG35zlQhUToi0EpovoQGjAhO4WLedWpVno66bWi4gWaaamlhDR/zf9vf/cuUCqXk4FpK/9Wi
 XL3kEV8kg0UnPxzdAnmxV8CeyYZUgMUeqNiEjFWpF0F51zzkrt6bezj4M3OSz762WzOxBrYLuqg
 tPRkAgkUIIoGiLPe1DG1RtPgmd9qY1yWJZ6oRv2F6uwN4f3h8BhXoGoU7r9oFjnwaH8Z031JkNn
 9Xo5jUzi6NrSk6oLxg0v4iMtGHRwfTDi6ZORu93Ow3XDhAlxgKWV/nabIRN2CpOrt7WfJs/uJ7W
 6KQ6QTvXJgC4vTwL5HC78Pip+5njaLpu8JvgVJvPOw4ZJEmxop/MZIbuCTr4jcw/TyT9VrbgtWx
 eHUyHfuhfqjrR7tT6xmbk+ePv+7twwgqP85AkBuHfKvxdrA8arFFZi3rYUelkVyv32TMonNtnZG
 VQcoad3IqE5hkzKgdbFfPG6gv4SwYY3DStWlRj+Mxktan34Qahqw+DbTiU3tRYoH/kgk5WNKPoB
 wl9PcNxJFHZjJnYrJlsuVUdGmhyfNKObTmP6leacYVFaPH+hkM2nHAazQNlF/IGji+V4HXhbTUR
 YOxNdSc3AbbBlyA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
required, so remove it to reduce complexity.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index fefd394f064a..f723d74091c1 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -53,7 +53,7 @@
 /// [`struct request`]: srctree/include/linux/blk-mq.h
 ///
 #[repr(transparent)]
-pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
+pub struct Request<T>(Opaque<bindings::request>, PhantomData<T>);
 
 impl<T: Operations> Request<T> {
     /// Create an [`ARef<Request>`] from a [`struct request`] pointer.

-- 
2.47.2


