Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA021A83EB;
	Sat, 15 Feb 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617189; cv=none; b=e+469Mw90H0JEiUnykvhAgmjFWsugr5N8diOwI+zMJaXwnqNJMxAc+90z9APPfRnxAul9ey0JHm9t4LfhQrokUJR/PWrEEnYHDZX/U06pRahcRgZTb/Nm1Ics98ouR1orxK+TvE3d6LBTf2V8I2nARcOUadU94Z7JBJmUdWspHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617189; c=relaxed/simple;
	bh=v7PXerc38yX4CSSTiNxWoTxizSMopm2JkQfFEFeuHsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FafPhtGwR63+y4xlK41UHhE6DlhSjmZDt7bbljZU5kUvEKuG4WF7Ou29iyaNi4CXZF8qnacnhKlX86DxqhE2xwCXnuF+/4PEMgMiA5tuuc8TTBG5kNInh+kfCFMlECs66/MQKGf4bHzI4HV5thTLqMrha2bUM6MUUSw2XZIFFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUx0A6Zj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUx0A6Zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFBDC4CEDF;
	Sat, 15 Feb 2025 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739617188;
	bh=v7PXerc38yX4CSSTiNxWoTxizSMopm2JkQfFEFeuHsE=;
	h=From:Date:Subject:To:Cc:From;
	b=DUx0A6ZjPb9BoXkHbezSjdfVqHsoUe0OAfrSML3F1k49QZuLomKa2q3odI/nq90cD
	 5ZZRRr7UV541UZXdkxYccEC/oREHDTx/crrd1C4qh6WRl1VS5CU/Z6fhEZFJ92SA3w
	 H6FOa+CssOG4CkzZFeGwFjiBUnO5ghwDgNO7jFIsjZf4IAqGocTsbpFjaU6mVXmw7e
	 b4mUYREs/jTGvlp/oVLhRMHpMJE/WtdrGdlSxHzvw/5gyrmu3sc98jkATUng3nCZnx
	 I9jFC5eBYxpC9RROfH8IeE0nvk3d58oWWuZdILkPjDjxDFBKtMnxBfRKuxXAsiQJU3
	 OkJBYdoeep/Jw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sat, 15 Feb 2025 11:58:15 +0100
Subject: [PATCH] block: set bi_vcnt when cloning bio
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEZzsGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0NT3eSc/LxU3aTM+LLkvBLdNOM0c3MDSwsLC0sTJaCegqLUtMwKsHn
 RsbW1AMAHFYlfAAAA
X-Change-ID: 20250215-clone-bi_vcnt-f3f770988894
To: Jens Axboe <axboe@kernel.dk>
Cc: Oliver Mangold <oliver.mangold@pm.me>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=v7PXerc38yX4CSSTiNxWoTxizSMopm2JkQfFEFeuHsE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnsHNWsWLBMjvJzH4+k0Jo39tw83pgfr1HRvVxM
 I9HkjZD6cqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7BzVgAKCRDhuBo+eShj
 d8m/D/98mFEDqez+HIXSjUNykYa93Js07AnK+4CAp2CL+xvL7IhOuvJm24g6AiqrL6C38f3kKvm
 6+0Kc+R6UFktOIIO09uPII8SLhi6kOtgWGxTanSYwJbZx6wadCQKchEOk5YeEVF2LPDsukWvXI3
 bSg67dX1GTW0iVOG5r6ar0jdKdyvNJcrZhkq0r/Uk9z8yAVv30RXBXm03LAFJj0cn1gv/cHnQS3
 HdIHw+jMlWA6zG7VbyrpQuzURfpldQC58aAT6SalyChHNoIusuKAW6pk5bf9wYxtuIJd11gjQrv
 I5lJQ3yo2RuzSxZanc+f0CyyLSeFB/BNANjR+mHoaXYMMn2dYsXtr9SRGkuBzx+A/M2+F54/Jw7
 RSnWsWx2q/a8IPAH5QLp6DVe4ur/t/FwjW1a8rovOs51JNhGoYuXU30yRwtuewGmjFhAlx3HH7R
 /yB5OKA0PiS7PB9d1dkZ+uZ9r/jcwBhfasRhV7sVXknjGbcUkVr5UvDqSPDEKc1iUJtvdZLFBRS
 krT9NUcc4TidA1a/4pqR452uA738R13joxxsbuj1PEzbyJcU8M1lIjgqnpx1VImu7Vmk0B70Gmw
 /i4JiYTVHKRs5FcXFQZwjmmJMTqweaO+qWnuEaAK6LO9he/hKA+7LojRgaS+SyVqbdjg2MhGCfH
 USYLR/JUZJSKYKw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

When cloning a bio, the `bio.bi_vcnt` field is not cloned. This is a
problem if users want to perform bounds checks on the `bio.bi_io_vec`
field.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index f0c416e5931d9..334eedf312803 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -870,6 +870,7 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		return NULL;
 	}
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_vcnt = bio_src->bi_vcnt;
 
 	return bio;
 }

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250215-clone-bi_vcnt-f3f770988894

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


