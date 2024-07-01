Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451622084
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811085; cv=none; b=rRYv6c+hQKqZI4dqrgWvVgGpqv2mV15TUzl0s8bLMV5kMhSARFpyszjQK1B/GJt8taFJJ0xwdayGSjb+IAwMAXbtnrOhimqSn2Me3u4SB026YZshs2UiddnSwo81vaA038hMXde00cW17Ebvi06ayk6iEMYfM4qlRyMKpzDby74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811085; c=relaxed/simple;
	bh=io2GkZiIYUcuRp+B/epQtw1tXdtaGX9dzBOPlrqVRt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxu3TAa1KGG6DgBb9WtqRYTPtE+W8aHUXwUykScrxxj6SOwwS6LsytXNGh4cqR/5/83MzVpoyKicqLd5IjqCqkWk710jRUutiItEixTU24n64DsdWtyYRX6bda+hW4md+572HL7tk7doWnyctRr1OtN/Nm2Y2BCTSy2HTCRry9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wg0+QlQM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wg0+QlQM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LlODSFaN1XpjkzmcZRQPSqxuyDuPQcljPg6BB3l6xz0=; b=Wg0+QlQMKE1TbP0m4NQr0nBY0S
	CfMyNZvdRXWTmn/Rv9e+OUiDlgT2z33QDKNONzNxZi6eJ9h1xQPdOqzC5DnKTpTUZcxxNyHjFZAAr
	NfgJ0eLiG0FJb2Oa7UQ+XGFFUo1jyIG43hK3zMN7e8AcqRDu3Ljg6EeqROlX2eU9Fy1f7i/vmoKSs
	aD/skowRQSTo2F3BGKT7t6xXwzIt2BKLbcjYI6rFRbAqdzdyEDCtE2brTJ+SHXK4xhgqD5Av4v+2t
	bG9jAY3fL9ddMYHm9lMfWj9WcXmGS0u4nwWMR66y5wjgfAvT7kY56gfUcNIMl7k/bFuKw/huHpLE6
	+SdIuXeA==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QQ-00000001ivK-1Og8;
	Mon, 01 Jul 2024 05:18:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: io_opt fixups
Date: Mon,  1 Jul 2024 07:17:49 +0200
Message-ID: <20240701051800.1245240-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I recently noticed that on my test VMs with the Qemu NVMe emulations I
see a zero max_setors_kb limit in sysfs.  It turns out Qemu advertises
a one-LBA optimal write size, which is a bit silly.

This series handles this odd case properly both in the block layer and
the nvme driver as a sort of defense in depth.

Diffstat:
 block/blk-settings.c     |    5 ++---
 drivers/nvme/host/core.c |    3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)
