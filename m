Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4C186294;
	Thu,  8 Aug 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100811; cv=none; b=PSWXAxL6fZtLROTRCL8cftbgCHAZ8JiMz5bbZa30rzBQpJxxB6CmOpFmLmmk0X0CjMbVXkMXIF6quMJYpV2eaS6T11JiIJxaBUCGtWiSql7Vaav8x9rgru6nMJ6vlJtQtAzN3dNdMn6Anmvc81vtoaJp66Z3sRvSBmfrCWQEJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100811; c=relaxed/simple;
	bh=VigLCVAtM/vdFdtKQSvIXI1UgQNrQ+gWtW23dGtCxos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q56kFM7rJ7MlJOQMEU/UAhQq9lm0g0/0NJp1XVS9FxScrSrj33/hwj2JXTrdTFA9i2o/N+rnBlHd0UFJhVue9/9vEBIRokXF2gQ0v50Uo0tdVKruw51l4cwdfM8j4F3aO3Qojreuj0QskwdasZ8hDtGzEyAFZWdr2gmlJtrTftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=ee20310w reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="ee20310w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=z7k44l1DajN8fRFkdDwg1QvnT6YZqQMsOZi6y2LqcD8=; b=ee20310wnoGTYje0UcRd1tjR5Y
	pJ66o3Xk5Q3RuA4iTQvmfYY39XUI+/7L/FhYzxj/qpvZQ5Vdbj0w3GLgngG1hu97e5tj6tdZsZLbu
	0zs7cEZszUJ9/6NyCn6YHaARZA7WyWnTuA/TaJIpHvzNvNiYGE8hdqu/ga5jRZ0vcIzSKWYNP+Yx4
	9gVHunUNXh4VP9AVGQxISrS3B71HFJM+Cd3J6FLnHfb43zg9A0eNxvAvxZ1niNqtfL85Okq2+M2u4
	FEokhZjsjwGSU+ANgaSv3x0D1jzO5R1DkhHEr2za0H3wPczLF2/04vHfE2BU6wBN1MiCbfC0bk76i
	QxiNYBIw==;
Received: from [102.39.154.62] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sbxEQ-002YHk-2n;
	Thu, 08 Aug 2024 09:06:42 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sbxEJ-00000000knr-23GE;
	Thu, 08 Aug 2024 09:06:35 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] nbd: nbd_bg_flags_show: add NBD_FLAG_ROTATIONAL
Date: Thu,  8 Aug 2024 09:06:02 +0200
Message-ID: <20240808070604.179799-2-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808070604.179799-1-w@uter.be>
References: <20240803130432.5952-1-w@uter.be>
 <20240808070604.179799-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also handle NBD_FLAG_ROTATIONAL in our debug helper function

Signed-off-by: Wouter Verhelst <w@uter.be>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b2b69cc5ca23..fdcf0bbedf3b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1714,6 +1714,8 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 		seq_puts(s, "NBD_FLAG_SEND_TRIM\n");
 	if (flags & NBD_FLAG_SEND_WRITE_ZEROES)
 		seq_puts(s, "NBD_FLAG_SEND_WRITE_ZEROES\n");
+	if (flags & NBD_FLAG_ROTATIONAL)
+		seq_puts(s, "NBD_FLAG_ROTATIONAL\n");
 
 	return 0;
 }
-- 
2.43.0

