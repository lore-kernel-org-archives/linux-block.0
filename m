Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79B21CC68;
	Tue,  8 Jul 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003989; cv=none; b=KoXUh0/JLrC3kVVF4vKA9WtVQ+6Iys6rG8fcdomgjy1CRT63ZpLsPrX+54KAU3C9KyzRaxYpXMMnKGx6YGvQgWjgPS9xTrQAw172vcF/JGsy4XutrtUzbkZkDIJwOxkvs26PZYkQ+peo4xJD1hQkwi0f6hc5MPC30pC3LNQcfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003989; c=relaxed/simple;
	bh=Xmgym1IZWOog8WJ4qolzgPA+pX4lELKlYs3ixE38TJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gz+m+zZIJ1tdsPNYk93SSYqHqh9WHPpTxltQg9o1EYH1z+wdzImeTSl/RIh/JvJtfHgWgcSJXiXItHOUQWiyWIJp84B+pQRXAk8kH3PnoFhZSAVyt2XtmeTJRX6LobOxgik1DdRwqPQktoDy5EFp1UOfxwhic9m4ZObxtpbGF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg/vqnTd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg/vqnTd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342AC4CEED;
	Tue,  8 Jul 2025 19:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752003989;
	bh=Xmgym1IZWOog8WJ4qolzgPA+pX4lELKlYs3ixE38TJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bg/vqnTdy7Y+LvC6NrfVYROnqPRhRir35pgC2D3IjF81lAISsldNepcmMm55E2oLl
	 PK8MJxXCK/baABMkK+Pd5vzgtuGNKIzEknmgpN8uGIP8Yi6ABc/o6KresNd+rgSMb3
	 ykIS/9u8/1wQvxZgUnIqFph8dpxpSgmeqQtXzP1diRhUKtLUrO1WETsQRSKD6Y6sd8
	 cqoWmgIU/WAGCh0OarrI4hedEbWDRhAh4xixZn8puzGbPF1B4bu7I31h+3/mGNgtyZ
	 KvbIg7p2qNquUjbIdkxKsJd17w1Zioaan0wqEjyxNhEXjgk2sxuZpsUCLyfstwDgZA
	 5h2C2I7ozjiNg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 08 Jul 2025 21:45:02 +0200
Subject: [PATCH v2 07/14] rust: block: remove trait bound from
 `mq::Request` definition
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rnull-up-v6-16-v2-7-ab93c0ff429b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Xmgym1IZWOog8WJ4qolzgPA+pX4lELKlYs3ixE38TJM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBobXVGIkHZZw1DgQOridEB2hltFA/XOcDJt/ghj
 jdW29w0eUCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaG11RgAKCRDhuBo+eShj
 d36iEACMzi+0C6NInqA+7u2yu194iA5hbVsPygIWn09xlGjVOihjFKdfaA7ugxVNP+BWyRgn9xV
 uEtKUg8fAmHyQYHgnK0t4dJVv27NipgOplLQfzeb397VhLnWSTbJDReFjXs+rRE/uml34DWEry8
 QJOLPJiK/bIpJRZkFKWdezb96UDx+LAoMo8hpydlS4aKavl1C2vinpEZDIycTKG4qDsv1Ia+zu6
 67iXBce8oeGualOMgGgHhj+McojSwc1JpJ/lFfgmQBHAbJIsxtQocjifnDamN8mFEUizpfUVZqd
 b92CpbBWCVYoH9vK9/iUajpw8r3eKDND4Pk0RhzVTNqalxxULJiko850yuc6T3SzZCFJnSrAw4+
 H4Pv6RtPZaZQjCVAqaV2UlheqvBWmZb/uvjg2XWg12ueP9eZzwDrejLbu8LYhtODuOZOVzKy1ly
 uBm/U/gqmyxf7zw96FUGBHpkKV2B8oy/I6LFUC9e8NfTdQtNGjJowJp0eX2BERvWuF4t1ZtEWMx
 B/OCCnHV5+kTUOn5IIp0VQTt5GL8JpgIap9WsZOYfI249nfJ/oXcVrAw3nPlcPFT3PPXQEPAdNY
 qquCs7fdI+jeZyWbfe8GBblH0wseXpRDI60QFXed+N36Eh0yZLVM954OUpIdzDjllbATYhv+ztI
 DuVpeYX1/ZZY/Vw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Remove the trait bound `T:Operations` from `mq::Request`. The bound is not
required, so remove it to reduce complexity.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/block/mq/request.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index 4a5b7ec914efa..2d14a6261a313 100644
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


