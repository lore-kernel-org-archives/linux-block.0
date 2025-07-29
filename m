Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F31F8ACA
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800820; cv=none; b=d79VgrFv798ySB+yivqH6zyEjKNnp4y9+NFwQ01MTNbbxBYRGptWJD25aR5AHneJfvt+H1iFVk8QOz9Vw+lNVZTiEzhz5sNTMj2sCR2+vkf7n8CnRkfS8R2U97PDwuMYzsMG1RaH1UOCOE0F2rj73V0iNstz6bJt+AooSyAnbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800820; c=relaxed/simple;
	bh=rs3kRDbQOgdkPSAbdo6DwyOMc3BTI/V1dpmPOl0nyp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mSxhpHCIsihEk6yWeuLrekHEV1I5hymB3z9HeABOqqO4S43IcfNPU+y4tsMzZU+3tOsDU6JtVCAr4rLnvWAFiQDsBg+BvEPFEtodjy4RSEcm1s/630zwdDjT9aZ8d809N2ZVqLkXFcyin+TjWDoogKmkHC044lmNIvTlEi2VYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ewxDBojs; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ewxDBojs"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250729145335epoutp0463ada015f87086e6fa957cf350d8fb12~WwIzAlTvJ2766527665epoutp04U
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:53:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250729145335epoutp0463ada015f87086e6fa957cf350d8fb12~WwIzAlTvJ2766527665epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753800815;
	bh=AGcUyPn1JrrcF4IWgkuGnHCRwlB2EbDc5Q3upuQCVpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewxDBojsdrDxkZorFYm5RUnefPckzjGSdBZBaqQ2IqwhqCgrXissmUV6iqq1yZiCo
	 SLMZbECAIdVuxfeHw0eLvL59Om8WBzwaRbA+e3QYrgxrlhR24UjuRkGQawsS6VSQzY
	 VeSOG4B0787vYj5ASZjkbaoT8JL3xJ5WkLBBXMsc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250729145334epcas5p49ef41a7b7e25b09bd4f703ad72142325~WwIyUiEPs0618006180epcas5p4d;
	Tue, 29 Jul 2025 14:53:34 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bryyk040dz6B9m4; Tue, 29 Jul
	2025 14:53:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250729145333epcas5p49b6374fdedaafc54eb265d38978c1b8c~WwIw78wAe0618006180epcas5p4c;
	Tue, 29 Jul 2025 14:53:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729145331epsmtip2f6541ec770e0f38379b7ecfe8774b361~WwIvi5-ef0270502705epsmtip2z;
	Tue, 29 Jul 2025 14:53:31 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 1/5] fs: add a new user_write_streams() callback
Date: Tue, 29 Jul 2025 20:21:31 +0530
Message-Id: <20250729145135.12463-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729145135.12463-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729145333epcas5p49b6374fdedaafc54eb265d38978c1b8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145333epcas5p49b6374fdedaafc54eb265d38978c1b8c
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145333epcas5p49b6374fdedaafc54eb265d38978c1b8c@epcas5p4.samsung.com>

so that filesystem can control number of write streams for user space.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1948b2c828d3..b1d514901bf8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2376,6 +2376,11 @@ struct super_operations {
 	 */
 	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
 	void (*shutdown)(struct super_block *sb);
+	/*
+	 * Implement this callback if filesystem wants to control the
+	 * number of streams that are available to user space.
+	 */
+	u8 (*user_write_streams)(struct super_block *sb);
 };
 
 /*
-- 
2.25.1

