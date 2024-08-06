Received: from lounge.grep.be (lounge.grep.be [144.76.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174F1D1F47;
	Tue,  6 Aug 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951081; cv=none; b=d2FPXbOGGTyXO47UPu2KKUco2LgVhZixMaImgs4pAqdZDEOftLwp+JZTuD+TkmjqHu17S8dSYFMuAw05+Ew72UQ/CnWlYha4Agx9xWhXUk9yHt+ug5blujxpv5crUwwsHlnQPhGuIP2FXZ783oJiOHsUx1wfNWQnTOsVYjsyPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951081; c=relaxed/simple;
	bh=41vzVAVmQoE/b4vTs5dty2x2d2LfL9KAQdxFyLdt8qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDNfPOwXDtvJ6aVIsbS/glgZAEejdk+x41TZDJRS6Y9hqBMZ2IWJVPafOn3vddiGrY4uVAXeBVWVmzhZWyVLdbwFaSB0SbZhR6GLBDvxsoQ7kG/IPqU/CR1P0fxSDfH6lZOcPTikk4PeUFE03R6qi+qENvqtsr+NyL1K7Huw/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be; spf=pass smtp.mailfrom=grep.be; dkim=fail (0-bit key) header.d=grep.be header.i=@grep.be header.b=hSFpjyeS reason="key not found in DNS"; arc=none smtp.client-ip=144.76.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uter.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grep.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=grep.be header.i=@grep.be header.b="hSFpjyeS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grep.be;
	s=2017.latin; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3rHWsnZQI00onpRkU1ccFvqkYqofNkevl1X51tyBwPQ=; b=hSFpjyeSfnk+ZH3lxfFkFu0for
	3sF52lRNjW3fliXat9Ook9xhpayt5iRp3kH0v8nyHRtN2n8syn0C0IAGoYQ8fVLDBNgc/bdYonbYH
	0WEBsouGDYGuFVYPgsvCez/BMhZA6q5Kl5+ZCzagK1Z5I4aP/3VMyV/ySy2n1zkX4qsELnjRoTL/x
	K9SJpB40bQW8j9ltKHamgvwjg+WXii965qkaaMWEX7MIPkha9RZxUL1kweq4zHLCvbQdzp3Mwh5uY
	Ff1Pl75NnjScsG09NKvAdR0Z0njWLN7HAykDOZ1IftByYD9gFCXkNT9yTdK4qxL00y6xj2++xK7/h
	f21thkQA==;
Received: from [196.251.239.242] (helo=pc220518)
	by lounge.grep.be with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <wouter@grep.be>)
	id 1sbKHT-00HZHU-39;
	Tue, 06 Aug 2024 15:31:15 +0200
Received: from wouter by pc220518 with local (Exim 4.98)
	(envelope-from <wouter@grep.be>)
	id 1sbKHP-000000017kg-3K8h;
	Tue, 06 Aug 2024 15:31:11 +0200
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Wouter Verhelst <w@uter.be>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] nbd: nbd_bg_flags_show: add NBD_FLAG_ROTATIONAL
Date: Tue,  6 Aug 2024 15:30:55 +0200
Message-ID: <20240806133058.268058-2-w@uter.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806133058.268058-1-w@uter.be>
References: <20240803130432.5952-1-w@uter.be>
 <20240806133058.268058-1-w@uter.be>
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
index 58221b89965d..20e9f9fdeaae 100644
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

