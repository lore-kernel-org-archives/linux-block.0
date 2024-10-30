Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346233E7
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265545; cv=none; b=t+fmjQSJTM9sl0qzsB1LbQKj1Gze01Gbty3w5Ae6Y55E8SnZ8wch9+BcP6tfcO41oHgGhotIkPrrhHcPtcKmlEwaXQjIEVOTz6PT7MMKZHpec4a/zCG/8WmxUa4JN+UDSL8hzn4ffum+pCySHezEqdF/OgbQ8ov6NoJAa7P71Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265545; c=relaxed/simple;
	bh=hSgw1bs8xz9BqmBrl8HG1LIaRp6IzQPTWMd/3SekGEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KESjnWHG3bW0uiwOm3guzxGG86TRXZB3zPujaWbAJq3AFqM8fDUhGirYghhQBRJWlmcxAL3jJzynsyo6BtT9G3fRDPNLHDVIELx5bZQ753DHTKYKzD07Q8rfVB9xxodMizPjcnhILe38NdkE4CBzgWdCVcig9QMIDLp0rlc2C00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=THQPEbLp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="THQPEbLp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LzpB76BiWsVXLdJ11i8+UKzolE0gZ7IIEzrsBt3tkV8=; b=THQPEbLpFDZD90TnzWoGWpBqex
	xKtPtq8W0mFne4GcfYtpuGmxYo4B25FDQwD8uXNRglVYiGb1IpJVKIeSNo4rVQ4/wEXFdMR6qErTd
	wEubWjQgcS3FOlgMIi6kZY7L2m9YIDwnM8Tgu7iWtrXmCAvnwSToq2IvnCgnweZI09luHEy0hYh7Z
	Al2I1+MZo4yt4nIqlGSar1pZVWoD0y1jBX5Lf/HQhPfHkdyCfVcX+xkv0Kd0V5YmF4dW7OAPkfI3b
	UTL645AbtoTYYxh3AxeFsL1M5QkL3ayqzksULQgYePl6nJwyJ+wB8HAN86cWlDCFpFF2u/JKdc2SR
	yTu7Q86w==;
Received: from 2a02-8389-2341-5b80-bb25-9391-28eb-c7ed.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:bb25:9391:28eb:c7ed] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t616k-0000000GlPf-0TFe;
	Wed, 30 Oct 2024 05:19:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Kundan Kumar <kundan.kumar@samsung.com>,
	linux-block@vger.kernel.org
Subject: drop some broken zone append support code
Date: Wed, 30 Oct 2024 06:18:50 +0100
Message-ID: <20241030051859.280923-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

when porting my zoned XFS code I ran into a regression in
__bio_iov_iter_get_pages 6.12, which isn't all that surprising given that
this path isn't used upstream.  After spending some time trying to fix it
I gave up and ported my code to the scheme used in btrfs where the file
system splits bios to the hardware boundaries, which more closely mirror
what we do for the "normal" bio path.

Either way we should not carry dead code, so patch 1 removes that.
Patch 2 also removes our other zone append helper as for the same reason
no one but semi-passthrough interfaces like nvmet should use it, and
those can simply use bio_add_pc_page.
