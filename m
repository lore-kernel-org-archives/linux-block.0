Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AE41A791;
	Tue, 28 Jul 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229569; cv=none; b=mNBf9AzaM84j4la2hBLdRbU4f5h66PiWWDPm1tDY3Gx8++e1rUFBLMJ5hFPv1CQXZFJwzIbwiuDSE0/AB/FcBzNRXCHYLMH8Rs91vdpL7GbS5GQRv76lYT6Eua4ioa/POBw5Z5EezV2riDIwVksIASU7eP6bhvIO8SY2NRewLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229569; c=relaxed/simple;
	bh=ggX439FIkKMIQ3Sm4mS/AwbAG77hWlv46f4GkwynSPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqF5tZybeoNZw3ITbIBiqdH68lWzS5FZImXeQx06ChZCZpQy30APofK7qxGEuF28xac92uqlJX5KW4+AZbCpRGWiZ+Abt342KKzI0jzcFWKgLFiqqCs3VhaEijQQ4w4ja6wYRgNk/R1JOTI75lXMCUd1c0cVrbHG6sJfr43/2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xfhzk9fT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xfhzk9fT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OO
	PV6L7HY5yVcZiBAtsBlbq3jqF8pQf+S4wrz3I/d08=; b=Xfhzk9fT7OeGtYRb2S
	/OfJwR+/jTLWRLBc6KYrezFat4ZVBveRrPwFRSTTwEOqdrtnEeMsV1aAtc3tIIr+
	fjjipki36nctOHvQEYW2nVL7+rDOSQ0Kuvm9HbBxiAA5fQC+o3BvnyeZr8Ctv3ci
	SA9unXx6zxy0vGfBA32yvcFQw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXhfzLcGhqt6JbKA--.64755S3;
	Tue, 28 Jul 2026 17:05:31 +0800 (CST)
From: Guo Tenglong <micronull@163.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Tenglong <micronull@163.com>
Subject: [PATCH] drm/radeon: fix typo in comments
Date: Tue, 28 Jul 2026 17:05:07 +0800
Message-Id: <20260728090507.16847-2-micronull@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260728090507.16847-1-micronull@163.com>
References: <20260728090507.16847-1-micronull@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXhfzLcGhqt6JbKA--.64755S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyktw1DGFyxtF4UGF1UGFg_yoW8Xw13pF
	srWFy3Kr90kw4UKw13Zay2yFy5C3Z7ta1jgr4UKw43W345A348XFyfZr1UJr4kJ3y8u3WY
	yFyv934UCF10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJxhJUUUUU=
X-CM-SenderInfo: xplf20hqxozqqrwthudrp/xtbC3BsHPmpocNsyrQAA3I

Correct "sucess" to "success" in function comments.

Signed-off-by: Guo Tenglong <micronull@163.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fc..fb79c990a 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -777,7 +777,7 @@ bool radeon_boot_test_post_card(struct radeon_device *rdev)
  * Allocate the dummy page used by the driver (all asics).
  * This dummy page is used by the driver as a filler for gart entries
  * when pages are taken out of the GART
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  */
 int radeon_dummy_page_init(struct radeon_device *rdev)
 {
@@ -969,7 +969,7 @@ static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
  *
  * Initializes the driver info and register access callbacks for the
  * ATOM interpreter (r4xx+).
- * Returns 0 on sucess, -ENOMEM on failure.
+ * Returns 0 on success, -ENOMEM on failure.
  * Called at driver startup.
  */
 int radeon_atombios_init(struct radeon_device *rdev)
@@ -1045,7 +1045,7 @@ void radeon_atombios_fini(struct radeon_device *rdev)
  * @rdev: radeon_device pointer
  *
  * Initializes the driver info for combios (r1xx-r3xx).
- * Returns 0 on sucess.
+ * Returns 0 on success.
  * Called at driver startup.
  */
 int radeon_combios_init(struct radeon_device *rdev)
-- 
2.25.1

