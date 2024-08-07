Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C21C9DC8;
	Wed,  7 Aug 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023557; cv=none; b=d/LMn86AqPVrQtQoZOJWatVZiJW2JJgiukz3Xs0B8BLVYky2DBASclDwac1zJfxcwfKI08BDdzVgIxzVn0SXOQZtNVqGxYb4dCLUtat9H1zojWo/ISC8LMjo6uCt7EUPmWGlSKrRolCmLC+V7MF9zTOSudJM/X/KLDRgD4hB3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023557; c=relaxed/simple;
	bh=kzkIMQDu/FjaeeEhvQAUc0rQTFuGh1dfUj81EhvmZ4Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WnHYZOewSjXeSSMixplbKGTAwyxthpQXWr6DP4XP+/ej+N2C4z+hTc+c/NmOnj5virfRTmIYCREQXs6dztbBwpHMxOpc+iJrATZXpfbFRF96JRsN7BnCyTYnv0ptNsL+ih/e6A1ddM2AozaQ3bXZzLdeAZb+GivLidcMOS0hebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LRln4SD2; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LRln4SD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723023249; bh=792d0acaY6kMcp8wa30xhbSdrHsMjPoj9I/JkbjGloI=;
	h=From:To:Cc:Subject:Date;
	b=LRln4SD2bE5CZrX30vffwhORcKdDyqfXK4VAqcPcgTSZm+UtJ8MJKhO7eDvFGouKL
	 jmrFEALcx4v2/7b1HMyz0y2wNGcOauHhLLXzM8BBs3X8LIvWXX2REaXSEZ12i9HDj2
	 /ciofI5uYQzxHpQP8/pFXY5ruYcGl6jd4qE1VwXA=
Received: from localhost.localdomain ([123.150.8.42])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 8801E04C; Wed, 07 Aug 2024 17:34:00 +0800
X-QQ-mid: xmsmtpt1723023240txg6xxsi6
Message-ID: <tencent_F71A15579D1E52ED0B58EF2F3607AA883308@qq.com>
X-QQ-XMAILINFO: M9hFDbrAzKie6qDthG592vbo7UNNZ/Q8ZLzsp+yJBAARnMkeOSliwuwqy36usn
	 z/udIBhrNv30QdnlEB2XlF9LQ0Zau4P/TOwq6dB2e+W0ASTOcALiYDJNMD+fXeisHTfw7HmhuhXb
	 SL2gjN3GwI8uQXamN08OfWRqsyagWPB7B6tx4oIQ7H1iEQqSUWKwIla8occPQf2+/Whqt3WG+2AZ
	 mf+aHlAxOKi7u29vd/WQqDNJAv+kePd4+Qzd8F2uXaBj9RgCARrDFH06JrQpbeVbZzjGNPWuKZUY
	 kvaCW7uyoNAMA+XGDup25KhPsso1Q1l9MpN52XXX1WT8cuE8FR7yHnWwHn6QRIeWiut3rWvZwyJ8
	 gTT6AcqhKVURO8h++GSzLO3Sn1NoLlqJs+/w/prWHZClxcGrrx51feKmsLFHp6ixUnxZquXuKVQG
	 0tYWedXth0AGi96k9/QAvpb/9Y38Ydkdbe9uOPgOFdnBzmoxWYw7ITzDZ+QMtdqvcFFUMG81vWv/
	 VOSKcJCo7MMETyibznbT33DraV20HIJN0j0xMnvsA1dm45MhMMHRh1gN/+xcAlRP89EMXyAUKtGi
	 dqJ/seOG+pJW6ndH8LjytzLdjkRmi63GMy+JkCy0/RQUTugpMut/bHwKDH9vsjYoEQa6kbh0veye
	 dabyrvWoEVlUAaJGEHq2afldziVYCwTUkSGtnzzezZKBurpC4+G97dJOF5tmIz3DhYUMEV8+yGSK
	 cNK2VuDQsnKLD2JD7H45h9bwS0W4v/3+WIofOVjmRTdlqeGz/JgnoxKufmP3kImmfjxQBpdaKZK7
	 VQ+0y4v5mJuIVTHaG8ARYsypJ0VPBG19EgKKClkXy7NdJlNuydBzvKxTX22FF9QWL/x7/mXT5isV
	 ux0HB8ZFUlvD9DdtnJEU5hp7lgFydTFg0xiwhMRvLU0qM/yF7sYULz7mIeBpep6g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: 824731276@qq.com
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	baiguo@kylinos.cn
Subject: [PATCH] block:added printing when bio->bi_status fails
Date: Wed,  7 Aug 2024 17:33:58 +0800
X-OQ-MSGID: <20240807093358.92239-1-824731276@qq.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: baiguo <baiguo@kylinos.cn>

When ftrace is not enabled and bio is not OK,
the system cannot actively record which disk is abnormal.
Add a message record to bio_endio.

Signed-off-by: baiguo <baiguo@kylinos.cn>
---
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c4053d496..29ae86c21 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1617,6 +1617,11 @@ void bio_endio(struct bio *bio)
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 	}
 
+	if (bio->bi_status && bio->bi_disk)
+		printk(KERN_ERR "bio: %s status is %d, disk[%d:%d]\n",\
+				__func__, bio->bi_status, bio->bi_disk->major,\
+				bio->bi_disk->first_minor);
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
-- 
2.33.0

