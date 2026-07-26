Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9F3A168E
	for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065563; cv=none; b=Q6UpCC8jSEc8N4SMU1GPhzTOiKzvcFr9rIho/AvGx9yURoZX7RH34YxN59mZ4YJg22zvyEe0H7xLT+VffABG7aMEqNjdWIsH9JhX/FQBxgaGwwxeBoXWBOSPzIMUYyAO+a8Vjadzdzpu9jSUgIeJNG13h6xHvsxr6KHqU/gTETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065563; c=relaxed/simple;
	bh=UmHDQ8Avh88213YFsBTKp7WY9yAPzXpx6PsDprJSvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efjxY8FJ93XJAHDWPStX3NpON6bqGocsg3m7wOZXiX8y7XP7O448PMKeTYgPDcDb6UFqR34h7rxZBdyq37JUh/7vMnEwWknV9y6IzGxw873SY2K8Y0WKecfr3laQbGkto+LgaZKj56TGnu9S4Xae82DyjUsok9wXEfg5t0r04OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=NvQ8//bf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="NvQ8//bf"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so3370375e9.2
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2026 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065559; x=1785670359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=NvQ8//bfQJuzp7j3yL6gGGLYRLnOCIWXp9Tvdo/+924SfpBfJNqUZbLQ/g52q/t3IP
         EIMETlmWs5z4+GPI7G9faNf0w/VzoWTgtPV003H4FOTYAkbA8/VncXQq+0VjYU0fx3EW
         W6k7VMG/U1W00FFP64RodffPkWcQX6C4WrqnPoTE7X48uA5BvZtLcjeyriHB4OvsZTug
         VDWon6KhNPTPrdv5OgErtQAFkMuTKEUU9G6gIIjPCbUKjLUqk0bzCqnnJCz4ScP85sbn
         nr+DIJD/zcANqYHkcoigNe/Jtl+6UY1MQ8B74D3cVc51Y96cXwxVP5uVswIDnDmV4/it
         FF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065559; x=1785670359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=QmEAjgsh1Is1H3wrsha09OExc3MnDErXMsiiKmQ1o3yX3oYclSgMMpIf2F3CNTwKHj
         03aCxGD8W8IBNafPugXgu5U1faAEdZkmh0lC5uc5BO9U97B6OBf3M7uhLK85HfEk4Svg
         U/9qKbBSFhEPOeq5nmyIeBuTOKBmoXYQxwx5k/nckatPh7Vz4XtJkiQSc5p841q7yq6N
         akszbLkwr5GVv6492OZkIiU3OZ8DcIrJmU/sGllF9W/xOZElww2wNzIW3WznY3jQQF8D
         Gs0Q+qrfn4QjjXJoeDk7TX+blZy+pSoS7UR7HGNH+tcxX0wODXocE+N2y6GPAIpkuI/e
         sdGw==
X-Forwarded-Encrypted: i=1; AHgh+RpvHRQpdIHFGyY5P/tLk2x1DqpdfNw2p4T4RMlwmo4Wsl4qStVHB7lYn2zrHdFqO8FJopbNCKZgYfOmew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHX0xkLVUHa/3DwHKzS6xHZYUD++pURCphunshsU0dmg0CvtjC
	yhAFUKat3W7coE/XssKp6b84Bi5fo3ibRIDEtvWDvNa+TV3ULoMIuZfDL4q0das61A==
X-Gm-Gg: AR+sD13qAs5HSGqEIZ7q8Xnp42WFGkgL7Fhf0p4Y2xYx3UOesks6tCZ5sHukeQRyBoq
	315nW4Z+pCHRb9Elhg0SNtoLm44o7ybe2CaBapbR1km0TnUBrbmtEpxjJxqwKQmcWx8ynKfucLc
	c7fLw0lsEHRNRpUcFsR/56yN6sAqAdzqy6Yw0uqwb4r1DMW5WN7+PToWFelgeFApm6Av8a0ypjp
	8orMKrMwK9cL7dKKi4YIahBabXRbot4nY6MKpruPyJP3gZzNU41iMz1daCiqMUU+wi6zROFfMSl
	4lPThh/v8c0HjijdM82rjNcwYc8zhbIbbSyFMp7op5B8SMhKUygDY3zFvILnbJPfRwkVLxOjqmG
	fU2lQ+8qD1zPwbRyrhTbbmhZpQg+nkQiPCcqZMz7AodxPu/iqrs7LJpfEl5I1Em4lUJlozGOdcv
	KNUx/rlSV3ijbkbg0CLuXTdrkOgTDA36E6WujWsKhjlJvdy4gxmYTL2+kMMq2mplMJEvOy0R77n
	hIp0I9tBEOlX3P2u3gu8gBepCFSyu06z6wcRGxKEg==
X-Received: by 2002:a05:600c:1d0d:b0:493:c8c6:4989 with SMTP id 5b1f17b1804b1-496b56bbc65mr64847835e9.6.1785065559344;
        Sun, 26 Jul 2026 04:32:39 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:38 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 02/12] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Sun, 26 Jul 2026 13:32:19 +0200
Message-ID: <20260726113229.2154269-3-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0

