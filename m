Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2144E5346;
	Tue, 29 Sep 2026 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674516; cv=none; b=snjQvVl0Fd7wjEMrWc6I1xxK3KbwDtpOx8w76pHx8sCMtOPixwz6x89O6cyE96aJO8+S1mhJslB+dVh80h93GCJRIjw1zPsGiFr+tPaSD7Ke/WsWOlZNhO9L0ESIO8OmY4PRkEFWJ9I4/wOGe4PODcMOPfo4w3odlBnE3Jv9n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674516; c=relaxed/simple;
	bh=bIFn2pjUeTiC5wS05OSRBgu4oCkYLVCeZyDD46iH7Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkJjFKY31t+HNkN3bePWitEvtgy7huK1dtgGzxtIQuLzYxAF20BEe3TvmrbdEDkJYb1+ErEsHqbgm1TZDIWUsEGYGh2aFl7X1zFIu3zjL/McFpAOCyPt7DtsWi6SEA+/YMUBei/udnaKAbxOLbJ1/7ct0u72K3edMOu3Krob7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGz4jahW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGz4jahW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C6C1F00893;
	Tue, 29 Sep 2026 09:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674514;
	bh=BEIJ+7D1mrelpwjpwjzaqOtYEMJ5/UQg4y3dnRHLWIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AGz4jahW+BOEW8YbykCOTN2CvxXj2tbh2tFd22ZpUZCrEPWUnHZTRxM7IlOXHbh8V
	 RARW2nlrrUwzs3dqW3vp4lvqWg8pJ98Le9i5PUMPRvJJvtMI6Igk0DIIHJ+ci4hUQz
	 3+m8sXFv32KLDs3AgOS32kPWOTH/gFrgdnS40xlyfHhF2TyhfK/P5K+tYRw6mNslJN
	 o38tkrUSzBbLkfAdBVPZubJYAqNDiWTYeEjBaue49OIvOM427xeSsfM3sAnZ7JmDi+
	 Pcc6gxmkfIlQOaS5gUEwVUgucIT4CFKyOD3TgvG5Z5hgoiG0EzwCadaDfB8/dFJKh9
	 tLu9J+3/uA/bg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 29 Sep 2026 11:34:06 +0200
Subject: [PATCH GIT PULL 8/9] rnull: configfs: add power to configfs
 features
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-8-642a4c1aebd7@kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
In-Reply-To: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Malte Wechter <maltewechter@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=I+J9Gb8CZHSj922DYHtlwANtCQ1t8QQ9pmX/AKKQdsU=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YaNGw9p2Dan6f3FWKmqsM9RCfWANM8oU5bI
 Oa009UrYoSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGGgAKCRD6UCkIqsW9
 0C56EACxMArX1qzfbGgLWbqiMrWmJpcQovtTVFMKR0y8KnzHJ/RhM280EFPwS5HgoG5OAjWEbSW
 tAunmz2orrSvLlrblTLEfHiF6ZpDQ42Ev3LvU/gCwYEfMvyilTXrn2CBZxUDlSHYjQW1UZ0qtxy
 XimWv9DuycNRsi2y9ufB9i5LfYUvXZDmSfyH6KNEK9ZExX+0eebc88euc2MnWGMKRfRvF7Xn+0I
 dUzyFBEE7Y8XS0iV2R80tp8dAprYQyEOd81QxvdN+mmpn8pWOILxw2IiVG8zMomVGswis12ZNK1
 RTMWE6D27PP8KpePrgAsBxhiAnJNA9wo6tCSjnFkPxLimzRsZSc+UVOL/zw7YwmqN2cFBDbwzP2
 0BLV87Yfeaf9G0CM6EyIjpwQGxKhkoS4XZfYxnHfeMjnMjYKy13lHOFuy42grAv7rLA82+b5lLx
 ZAACtQC3LGwqHB0D3xbBCG5YL2EW8r0TtTsBuQUP4BC6eC3Pzr7Btk7J4c5u7VQApJHkiWPQggl
 XFPI/g4pAVhs5BasSjGFaQ+aQNovNamZdQIuWQDBG3oomNDqkkqiGjrxamkpJGB3X0Qim9QK3wQ
 KQdNWUw66t2SGuHGULLY+uAbXKRkwKgRjHWJkaCFhfc7mGnVcaGkEgE5LkabFlhzJfLbHQkD/IL
 9GkvPHWWZsJo93g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Malte Wechter <maltewechter@gmail.com>

features displayed by configfs for rnull was inconsistent with the
actual features available. This correctly exposes `power` as a feature,
which is also consistent with the C null_blk driver.

Fixes: d969d504bc13 ("rnull: enable configuration via `configfs`")

Signed-off-by: Malte Wechter <maltewechter@gmail.com>
Link: https://msgid.link/20260924-upstream-v7-3-rc3-v2-1-ca56ae7a73e9@gmail.com
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/block/rnull/configfs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index 24b02256b4cd..34ef96fa125f 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -47,7 +47,7 @@ impl AttributeOperations<0> for Config {
 
     fn show(_this: &Config, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
         let mut writer = kernel::str::Formatter::new(page);
-        writer.write_str("blocksize,size,rotational,irqmode\n")?;
+        writer.write_str("blocksize,size,rotational,irqmode,power\n")?;
         Ok(writer.bytes_written())
     }
 }

-- 
2.54.0


