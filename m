Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58E42EEAA
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204296; cv=none; b=WKT2fghb7RC7eqz+FauO9mhjk+Oogx5qeBBdM4+xW/L7bJKHkm4XLyapp0SmbCQAUeujLOdGjEiUmf3hMIoRPyN6ua8jRyhXnEgyc0hjB3fMg8YXnTrh8iimR1T6F/uVE+1NuPLOyw0Wjf2gSKpmkRCU3zDFJFSOCHlafZexuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204296; c=relaxed/simple;
	bh=eHawWjolnnb4XoIIn3zlbs3myX6M6+hpJdeyBWH1HbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMscPx6Zv5aQK1lDnDSXSuE4ahmFEkKUoDMYEyUO/knlU0Ms5gB85MCMJdu/aGFDuc1KxFwdFx0fPV3HmK+GLs48w7j6T5geLHhDmQta1Bf7SZTkKJmsFCO7LPTn+C6p2Zngkz6nVZ2jHu74u5Jpv2JvdW3SLpuVNI9TT7UpkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=UrI9md/5; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="UrI9md/5"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1772204292; bh=eHawWjolnnb4XoIIn3zlbs3myX6M6+hpJdeyBWH1HbU=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=UrI9md/5v1SfyZ9L0TmVH7Wfss5UJaDG0+Ywg2AG40L8wuTlAdHu78EfwFNQB+i2W
	 Z/64//w5tFtwAOcHNJ8SuEOPTn4GA4Kqs0SNfXmklN1PJrqr9jrcdnyaE1Er4NjTXT
	 TeF7Cb30TJiT/IEn+OFg9e/+58i1WIgeKHoshz3ejUQ9QGlPuVOV1SZd9IQLMmSryC
	 BujloxnilaWKlkG7QCzpfOtW5xl9Fnz0/Ej63/TGsWc6OoB3OZfrc+d3BxjaKGZjzc
	 1YW65Xu6/7QOgdKoAN3OBEGjb30t+XovBiKQub4hJYbC6RAuMnVk7cNrhnWbzamaDN
	 l/RGxYy24VXnyLCucJQ9Uz6BSJnmzRf/4PnAokZs3M9WVJHOs+IF/76EkLo7yhOJRB
	 mIvPkmxTWUKc4AEFILo35RtTwL+03VM/jMv6WQXL7dplpbJ9YGmXoLF4zwNu/8LIdy
	 3MnkIlVtrqpOjOlhfVINgDT884ASuHAHk/Ei61kkmzz54aXicRXx4ce1v6/CfPKbnb
	 0hgOk4Wx5NXuBxvuEMJWPIyAceWiBASnqMdhfVI0JdM0UHUiuXXhzzefHkjnCxUGkx
	 u6/418pxDzl7gzJGVDN0dV7wfN/uSZm2UseymaiJquOQ9ivgIhEfw4vEBLvZ15MANi
	 hEmJxzFIHBRn++hP+c61y0go=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH v2 4/4] selftests: ublk: cleanup kublk.h
Date: Fri, 27 Feb 2026 14:57:56 +0000
Message-ID: <20260227145756.3877069-5-alex@zazolabs.com>
In-Reply-To: <20260227145756.3877069-1-alex@zazolabs.com>
References: <20260227145756.3877069-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arguments are handled via flags so
remove unused no_auto_part_scan bitfield.

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/kublk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 1faeccaaecae..3379e49449b4 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -79,7 +79,6 @@ struct dev_ctx {
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
 	unsigned int	safe_stop:1;
-	unsigned int	no_auto_part_scan:1;
 	__u32 integrity_flags;
 	__u8 metadata_size;
 	__u8 pi_offset;
-- 
2.43.0

