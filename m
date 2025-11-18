Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC4309F1F;
	Tue, 18 Nov 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453764; cv=none; b=hUL1JYtJd6FZP35zlzI7izzxAevje/S3ven4FZUDT1d0nnA0e9R2NICWBKkFAYdHIFqT35WRBdGzcEHWUfA2UgVz6tinAI8GV3rZCE6Omps8ZuESVyXT9SdWJbR7GxLEAV/czJKVSrpU4aQIvyF7pDPt9GTloIWVzkdiwhKfp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453764; c=relaxed/simple;
	bh=IB9XynbAqeRmsZxpXYSxny1PWyZ4VZELdGdsmNKC90E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=E6XZNSxq07D1xdsyg1S9fJfTIWb7Tcrfi4RBqJwykXvMJTglAI5haQ0XcaIXpwuHjqAXVKbCTaHDj1WuPACHzFvpJBB0gaIvFD0wBNlHQN9s3KEeq71hlwaeAmzwNXrmCo5EhZG0zesWXK51ugKmfnzFV5d1dgShLn3VVuaxPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KvWvv9U6; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KvWvv9U6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763453754;
	bh=Dgq9GdB+TDgt9ubpi2QIxJvPWQziPEpk10JhrXaywjo=;
	h=From:To:Cc:Subject:Date;
	b=KvWvv9U60g+tkussAJeFBfvD7+XPO5vl62rOZVcRlriPXH8fHcZJUomoNvbbW+BUq
	 STcZc2pin+eTwotA6EBBscVTKEIvoJ02dFBEGpszT1RK9SXAITEeNEMyi5GshPeZ0N
	 DXuLaItG7x2WAQr0+AZQUi6VTO7iRNMNcEjkBwbk=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 3F3904AA; Tue, 18 Nov 2025 16:15:51 +0800
X-QQ-mid: xmsmtpt1763453751tb4jwdjo9
Message-ID: <tencent_2FEBA8888C5B7C3CC495E17C29EFE76BA805@qq.com>
X-QQ-XMAILINFO: M43YobM9g9iNuzsmc412q5ZBUR8Jmyt41yWOZ/ah1ScleaQUkJu1WSNxFIpu2+
	 zEQI2tbP2zDTM1Koz8aN0zMJIUcMBpN/da3Vm0RbepEb04IqVomtMs8+FQGNDbwXevM3V4RWZ7+m
	 BfY0Zsy1X2jEquQ67BGYDPFgxYKAEIWHslbEli9DpC8xdWi532MsiDWyV417xXRb8hYzKvaIv0ya
	 3QT5nlw+NdUUaNA7ZPDUQhn8NcZtx6SQSEsoVXo4A1jGhojFTBaw+zXqf2HqZD4Iczd4NQNkhibD
	 Oos7L7iJHA8tTIJFmlhTAOybxe9l87Uh48QCCQt0sR34lKvN/cg3oiyzS17lvlMQPYtm2oNc+IGI
	 T7pvwqzzKzMuWBMpvK8LyKUD5vyELNP6RdcCwCt3JihUdsdkogJBa/MPE5jR4VuTIEXHw0TBtQ4J
	 mFpEBCfynWxIbSvxUmIyxBQu9ZC8WPesCa7slZcKiD7V0vQdfMRFqLQTd1kw/aDifEEkAUoB0/HW
	 QqhdZdmhZ+N1uam2kQuJpQ9Xjswq6Qhf2iCNe6OCrhQj8PoWoRAQH13Fhw2jB/VvbkVR61lliky1
	 OMKE5drLNg5OJwE0pnoPmYzV5ZkUJPLX4SCpXwWcY67nKNR1RtCjkXlRMo7c0imFlgfVzMY9Xy/4
	 N18Rwlg/F9ep5kR/tGMM3pGXT2t9lqmSYJw5UBj1j/vdSjGjqFczoP1dvoSoK1dN40ETtKW1FHzg
	 frLgMC6bMvTLKvjwHXyBh9rHWzFnhuVFuoxZhL5Eg38PTu1thro1rIA2112D6xc1Y+VStaLtb8X9
	 agZxlT5KIWWvi2hofarshXtwf5FR0lzO6yGyFhtiD6lG3eeV7J4CS+CGBKb7e/SL7Z+uL0q97qWb
	 VHZwDGxklpE4L8vtm6rLHW1Qil2vO39Z5ddURnWAfHNihxrtUzlWc2lCtQJMN6+vHMH/fi4bdg4b
	 yUWUT+IWQBr0bW59qamzPkz9+UJXC6auQnqFIbEWgrReFa0NPNfn9bBIo13YbGKT2DlHyOD6LW71
	 Aw8er9tEoDNjbdBJFZh8nU+y79mKmUoyN3hdPCn0oTWq2pqzFEhdUxqexwIeAds/SvzPc9H2SMhc
	 NbArsQG59he7ZKwmZ0aityYwMFfBwJrY2RnFBHMsxaO8Dq180xUcDckx7rrnKFEwMfrolz0+/fkz
	 4Ow8V8dbsUrFH3Uhmajm2X85vN
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: [PATCH v2] zram: Fix the issue that the write - back limits might overflow
Date: Tue, 18 Nov 2025 16:15:50 +0800
X-OQ-MSGID: <20251118081550.2809090-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the value of bd_wb_limit is an unsigned number, when the
page size is larger than 4 KB, it may cause an out-of-bounds situation.

This patch fixes the issue by limiting bd_wb_limit to be an
integer multiple of PAGE_SIZE / 4096.

Fixes: 1d69a3f8ae77e ("zram: idle writeback fixes and cleanup")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
Changes in v2:
  - Rebase the patch to adapt to the latest version.

 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8a13729..5780604 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -579,6 +579,7 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	val = val & (~((1UL << (PAGE_SHIFT - 12)) - 1));
 	down_write(&zram->init_lock);
 	zram->bd_wb_limit = val;
 	up_write(&zram->init_lock);
-- 
2.34.1

