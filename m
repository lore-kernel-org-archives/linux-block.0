Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FB824A3;
	Fri, 27 Jun 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026547; cv=none; b=lxuenAttMGVDcfXP66Cdu2EWSQov7sje/TqoaKNmyY7Mu4MFC2I9vu8+zwTXaEsr39blrDZOIbBXYPAbK3KSXZup19ydzYQWh6gJj1jm7r+7H/7htwLQfIaZ+atxKN6SrgalGxQlUuwVMhUA4k3QBO5JfzklNMNet/n6eLA0Bbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026547; c=relaxed/simple;
	bh=vWaPSK7tFprZvlKk6cNOOT8GxuKU+3MFNSmpz8uN3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYcEA5A6Uwb9UJg80nQlNM+YcGjsaMAI/ZnNZf5p73dZOTA5c4KCC8p0zOpFP8nnTm4Y/2N295dYN5RpulNtOA8g65nvLh1Z7zlI6ZnErwGHNAx0rlThvZFwYR6LADOnYfZf4MIsGWA5yyEltCye1lR2w5kDVmiT8NK5C/R+nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTgs6Q5e; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTgs6Q5e"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so292768f8f.3;
        Fri, 27 Jun 2025 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751026544; x=1751631344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSNzCAhQULxNCOGe2nHXtwBZiRA02UYH1olLfxSNu64=;
        b=YTgs6Q5etdzGhRpo+uvSOuAn1wryk/tXTNxqeAgwAubtxurllJPDZiaBJ/VyAwOwf2
         UP09uJj5wKr61TAhzYapoGfqNNGWla5Xq0G24G3WhDTxbJCoLPXUmxLZb3czl6CPiQVj
         Gu3VvUCqMBlqaBOkgABk0Q6YxNYBopYGHPgt1+sJuyG1SGrREZds/NLrIJ8eoHUSwsmB
         hawkOcZ1YUREeBkEoQRBJx7tfL0TwGWKIf3EqkM7oEfKpV87XYYnzIxizpmk7gdRJXj5
         6hS/OmRfMe3eENASgK0MODsjuL4sJGPAAOxBZXDqAKhtN6K+vlfw7WHRcG6hxUlhKUNC
         ITbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026544; x=1751631344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSNzCAhQULxNCOGe2nHXtwBZiRA02UYH1olLfxSNu64=;
        b=CO6fLzqc8OxWMlXUYBj2RugcH2qafkLmBVzAlLJ0IY7d6h4tLxJcYqp40+fh0KeFvY
         dKp6jJuUpVN8DTgJ4gOjGvl+MZy9p4wl36Oh4Was+3C6GK9C0BTam5L6x9lr44HyEAxk
         lZpkjtyZo+0hEMJo9IWxIbZI3Sc5+zyhksgbHymTHzje+Mdsw/d++7hDxCk/0+QkaM6u
         7pXwu18QRhjc1JPcinpsouBFky5yV5iPdScRDknh6vT//lCuw2W34ygi5NeXrWibZMmE
         MtHBhWH3EFs8xP0N0+5PWc3PPTgrjv2SSd+3+ixtvPoW5Yru5FoneVlj3DgfLPp/oKFg
         mafw==
X-Forwarded-Encrypted: i=1; AJvYcCUiV1qHissiW/AfD5IKOLwqaQ7r1QaDXgBsygPQLE7KR9lYOpSNJsNOJTqcfGy4TCAGG4AP9rgTqtn/lA==@vger.kernel.org, AJvYcCWLawctQf2CxIgmzhuEK8KeljZlOHNiaJkaLr652EgYsdHYzftKrn6Hk/DPOWaueh6egYqJNFlZPwKk4TGk@vger.kernel.org
X-Gm-Message-State: AOJu0Yybwl5Oqe4+0JNjgPowyIaseRJGZ+7IVqq4pjHOYx86J9ca4A3x
	JZn+OZFXBhhQk1fM8lUPryRpAq0bohsJ0G1lJOEiTHDeE6MyzXMfiaWy
X-Gm-Gg: ASbGncusJp57xaLjo5K9Uk6met31jZN3rZ5llkX1fHTAeJbmxgXiFiFMl383DeTvsE7
	B1dNou/qDyxpwl7h+KIDG0jXqWuT2fd0JrmcJ9OgMQBUWYK3JCpg/pdjig0Ju47GWquX196vpud
	T6YDUdYSXe/qTGi49kobzZpQjxpDmYSdH6p53sG3MiL+HBVwrAyEjuaE23f4XHaSoBjZTGOVRNq
	J70Af983Yqu4dlmIM/Ibj4SljQMVlLo1BdXt8ajHwDbAcqWjqSG6FGAzGBZ660hN0mM8wk+ZvA9
	wRYY+driVIiyem3ETVpY3luONrm4FBi0A+kYmzeeqxnBdpVZ0sfNP1CWrQulJZCHZB+XnD+ClMb
	0qgq1iI6rioqVHw4=
X-Google-Smtp-Source: AGHT+IFxEau6MybuzhUxkkPYte1ZoUsWvtByYAO8s26pxQdvWzlR86gK9+Q+u9x1KVPd0RJnXeBUig==
X-Received: by 2002:a5d:6384:0:b0:3a6:d191:a834 with SMTP id ffacd0b85a97d-3a90dd535bamr793215f8f.9.1751026543770;
        Fri, 27 Jun 2025 05:15:43 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:c222:941f:da95:c9f3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a892e59628sm2522355f8f.81.2025.06.27.05.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 05:15:43 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Philipp Stanner <phasta@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>,
	Asai Thambi S P <asamymuthupa@micron.com>,
	Sam Bradshaw <sbradshaw@micron.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: mtip32xx: Fix usage of dma_map_sg()
Date: Fri, 27 Jun 2025 14:11:19 +0200
Message-ID: <20250627121123.203731-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_map_sg() can fail and, in case of failure, returns 0.  If it
fails, mtip_hw_submit_io() returns an error.

The dma_unmap_sg() requires the nents parameter to be the same as the
one passed to dma_map_sg(). This patch saves the nents in
command->scatter_ents.

Fixes: 88523a61558a ("block: Add driver for Micron RealSSD pcie flash cards")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 66ce6b81c7d9..8fc7761397bd 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2040,11 +2040,12 @@ static int mtip_hw_ioctl(struct driver_data *dd, unsigned int cmd,
  * @dir      Direction (read or write)
  *
  * return value
- *	None
+ *	0	The IO completed successfully.
+ *	-ENOMEM	The DMA mapping failed.
  */
-static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
-			      struct mtip_cmd *command,
-			      struct blk_mq_hw_ctx *hctx)
+static int mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
+			     struct mtip_cmd *command,
+			     struct blk_mq_hw_ctx *hctx)
 {
 	struct mtip_cmd_hdr *hdr =
 		dd->port->command_list + sizeof(struct mtip_cmd_hdr) * rq->tag;
@@ -2056,12 +2057,14 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
 	unsigned int nents;
 
 	/* Map the scatter list for DMA access */
-	nents = blk_rq_map_sg(rq, command->sg);
-	nents = dma_map_sg(&dd->pdev->dev, command->sg, nents, dma_dir);
+	command->scatter_ents = blk_rq_map_sg(rq, command->sg);
+	nents = dma_map_sg(&dd->pdev->dev, command->sg,
+			   command->scatter_ents, dma_dir);
+	if (!nents)
+		return -ENOMEM;
 
-	prefetch(&port->flags);
 
-	command->scatter_ents = nents;
+	prefetch(&port->flags);
 
 	/*
 	 * The number of retries for this command before it is
@@ -2112,11 +2115,13 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
 	if (unlikely(port->flags & MTIP_PF_PAUSE_IO)) {
 		set_bit(rq->tag, port->cmds_to_issue);
 		set_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags);
-		return;
+		return 0;
 	}
 
 	/* Issue the command to the hardware */
 	mtip_issue_ncq_command(port, rq->tag);
+
+	return 0;
 }
 
 /*
@@ -3315,7 +3320,9 @@ static blk_status_t mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	mtip_hw_submit_io(dd, rq, cmd, hctx);
+	if (mtip_hw_submit_io(dd, rq, cmd, hctx))
+		return BLK_STS_IOERR;
+
 	return BLK_STS_OK;
 }
 
-- 
2.43.0

