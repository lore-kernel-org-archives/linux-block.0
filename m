Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11A46F4AB
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655974; cv=none; b=KGpkCUkWw3Naz3ywnePInHiUk4rywZTeb1fp5J8Q8eyGoM0B4UjlW1Bi0QVYpc+1XGfLcOBoc2FDpXQ2HrgK6Y3Uceyv/O7de3Uf+NZYzjoWd3ymgD9kKkEx4tgTM7qZWNMq9V7e2JMwjAcMrrPONR6v9grbKuIBhXuPXKtMiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655974; c=relaxed/simple;
	bh=2hXrMq9EcVe8qu/MqiwSrwMrpbLS1aTcErxtzRiVgss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noLTWAWlMt1sVJ0wQ5Gw3licl6RtY/XN/ZbsKCDtDqcGMTpv6rSZBSbMOrABVbVQgmpVYdWawYk/+pXzca7hs07byshuKifJzF7hvNV1JuDQ8QYwHeww2tkvIL3biR+NjL61r5s1Z+cVE6IZXnRx0ZODwHq+UABrJJQhWrSZEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=KhRbw6Mw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="KhRbw6Mw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so23367755e9.2
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655970; x=1785260770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=;
        b=KhRbw6MwzUd7bmMo0hV4z9+afj8sqjGTYv73xy6EeRCBt96GRnE1E6SzHul1x+s1O0
         9DqH8N1S30ibm9hDorMJgvv2sLDeIR4YCrcAGgFkOqCKdyLp43eSt1hsTWKuN4aqMEL+
         0DQ91igtVJipG2Ykkq5dppdt87wMOMHOEirEl6NljGbSqx4HmhMM3cfHbYxDiDgapclo
         RFHXQdxP/QrMCc5itBCIA2wE3yJoFbTs2n6096hPv/4W6BWJVMJM8D8mpaAWelTwqB5B
         8HxCA6PfnK3y+ZCnwSFUGWb/3PpAeIlHDLiiiaer1vtOe2QiYKWPd+bbGp356lvGTjcW
         f+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655970; x=1785260770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=;
        b=dPd+zD0Ehymieexdvvc4FciFWBaehE+neanxE0KGJe0kbkHH3TNCvAuexjcmVzqrfF
         4lABs2Vob/EGVe/Si21Cn1OgmaK1bJz2Ykbv0wkUd0rZN2BAiCvy6MMxCWLomJOJGyEe
         bF13ftuStszrnI5Ujf1VII3g7IjYFjiNY/pMjU3Fuh1PhPWv6/zGwhoyIfWOots6HhlR
         sqUci5gsobmIV8FzSwmSWYJz0Zd2NM0DFsHynWJBrhfNcNlBZb5C8XQpyte52rdM4NS/
         w3BI1G7sy0Gpm/btlvLZhNVLjwXO97Kl4LT9Dvz1W8iVelRsfbs1pFjjZY+bZr9RXWL1
         rv+g==
X-Forwarded-Encrypted: i=1; AHgh+Rpr6NTnq1TGT7cNtS2wIZ0lFprJpCaof61kIyv/A8MQ9SvGRovUpOg5aQvSHy+Etn1ybM5x7fJUXkyd9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBxpgRIMoZRrbULaKzWaYeTAnCjE0ED8zYKu0Q2KDRVkiPqt8
	ga/oB083cp6q1P3TqGlJu1djHuWa6xs7NHMNCFWUcqeO0HfeBXx/DLzbQ68XPKZPwQ==
X-Gm-Gg: AfdE7ckaXlZRpogPqktTGxQXDaoYQ8+Y4+lMamLcSLWqqs0syzN/CecxwCeRazV3ysk
	Mj7BTvCHHs5m9tA0XicEyraAfcpPLWrLl671nfdrLw5ilMwM6MTcqeqHF8/zR9O2qGwUY6cpaLx
	PrBlYDMcaYqzWhqUYzei3ATTamkH1i1DirypamcoudJPNaYnpak3+k9mWsGofZW7kBGqZ57+g7g
	uJlL86+jJo3l4p5DXVd3zrUrYKLRu8/tkR9muHc0UhNxowaz3YXvBOGIUnjB94auGL0GPGVhuPy
	0HQpuHnA/JphTYmii+/vLexokqFK9o0Bimqt0jlb8lRHmwDEyiDvVAOifvAH5BogEW1EYABpXGJ
	BNmY2+DxGQyorbTOeXJeqpx/KBdGvsNw3VL9SMywQQaMAd37x50Rz5cmIHW5xW2yp2eL7HgsAb+
	E9IO3UNdebhZgvUc6EP5UMLYE+08nfeVjyceaGcLHHvd1FE4mJRFI5DR7bdQ==
X-Received: by 2002:a05:600c:2908:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-4954a3dcc67mr172161575e9.13.1784655970189;
        Tue, 21 Jul 2026 10:46:10 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:09 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 5/8] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Tue, 21 Jul 2026 19:44:59 +0200
Message-ID: <20260721174502.111503-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7d769b6460ca..16b7465c233a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2570,6 +2570,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..f7ef903a3d4e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2831,6 +2831,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.52.0

