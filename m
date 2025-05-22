Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5F241AAC
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923434; cv=none; b=IJtQdxKD60c43+sUsXUeYobPx4mRt0Etpyki8uVNmmM1UpHZGSb6tnfG548L6flLZkUBfd17N5PbXkalAzEtw/Vs2T4mj6EP6nfKKX4UVIOmeNPSTXz89FtwvNWOOcUCUq5Q53Zz6lnPiwZFlQRKKodTpnFGcD/rSmZQyOMalYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923434; c=relaxed/simple;
	bh=nGJUi2RsXmC+6T2st88igcbI/zT31b8zCDnadjn/PHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YS7bE+9MYcadSfZ/tNXIB5cYVy0kHwfkOl5EOy1C8Dr/43/sVHq0JTvWt1+xCls8HA1LkuE+Ygm1oablKrv9wMRFY0T7e09+/vAFwJjdGeGcJCrXTTOVNATXU+krQjm0vby/TdiFWPM2ZWfBpGErjaDBBUlewNKgdvJwFCsHTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VD0uk5Uv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VD0uk5Uv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=a/9bmY9uuBZ2JTPTJZG3B8bEcW6rLATfuK3J67UY7dg=; b=VD0uk5UvMAs4S80h3Z/qCBBZ4W
	cA9FCeYB06+SIO7yJne0Qf/Cn0xzfffPNMUGKXCmRaM13ryTEYAfMIDLlKuxvyiK9pcFJj/+YGCfx
	x81m4+eeDkxv+rfNI5rkea5x00goVT6NxdbRMstaCEg9NX64tpN42n1v018sq3JaEiDAZFp7L16wF
	zG91yMCDKQZbrn/cklj66eCogc+31hSElFLK5YeZQrBmvL1bpqapZiyqMhO4CjQRm6NzdyGpJlIMq
	hMpRiFuXrQlONo64oXRtJWI3DfhrcGwBd4qd83kSDRaFKKWEhGDbky3cGC9EmCimW8kiat4tPmL4h
	QXu6OnNA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uI6jP-00000001EBM-17lR;
	Thu, 22 May 2025 14:17:11 +0000
Date: Thu, 22 May 2025 16:17:08 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme =?utf-8?B?ZtGW?= =?utf-8?Q?x?= for Linux 6.15
Message-ID: <aC8x5G4RUjgbAoAc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 355341e4359b2d5edf0ed5e117f7e9e7a0a5dac0:

  loop: don't require ->write_iter for writable files in loop_configure (2025-05-20 09:16:23 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-22

for you to fetch changes up to 49b9f86a594a5403641e6e60508788a7310fd293:

  nvme: avoid creating multipath sysfs group under namespace path devices (2025-05-21 14:55:46 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - do not create the newly added multipath sysfs group for
   non-multipath nodes (Nilay Shroff)

----------------------------------------------------------------
Nilay Shroff (1):
      nvme: avoid creating multipath sysfs group under namespace path devices

 drivers/nvme/host/sysfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
