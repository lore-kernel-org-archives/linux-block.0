Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACF529BDB1
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288021; cv=none; b=nA4haqjWZU5ns7g9OLnFjyg5C9+bj/cr0KOC8rm+zCzYN+RPpZEJEvXHtudY4+P6RlbjM+1pvroBiPcwXw5JIFbmnhngESAzSZk9xQslYg+6voHlwmpJBt7D+14TuGnu8bpMwEp8IPykT46NoStQAY8q0sP/mrwtzNOKc0yAq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288021; c=relaxed/simple;
	bh=sRjc/SI038OILsr3bMHdLKKMTziCSvg4xTmOPGlpctA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jk1Lz9Yi25QK5tF2wQZpHzuXUXK3j4x9t7zl873gRs/e2GwYbrc2mZ9/Ria07XJQ9MkjSqG2R/U8PwJexg7/NjnybnB2ORfA87YnWtptP9DxVw9ShwKBIrtSiTvSSirXHPrXNUcthKjEvU12icwQXMnzLyVzbwnkWFPGQ7sJvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UF+OUmOE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UF+OUmOE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K4Q0vf9aPqeDPp1cvmtn7tgo72Dms0Oz5aLWVFeg4Mg=; b=UF+OUmOEEPJKRucA93swbVLWvx
	uINyxt876JandYQQ/fZ0KxXtNOIJeWWfFl+07tINgiCWBFOFBs8X6uCwGBi6bJJoG6FW/JR+9kVlA
	mfraXxkp/flKa0IgfoEMxQOmcIJrnvS9am8qNyznB0JI9tmsWiZ/bWdaDMqte9I8GDi6t6UljfC5Z
	tPGL6tMtjkOBjYl+j74sI9hrlnsyhFpNzFrfrJUyEsSGjyEc5pG3xWoPlTZW737OMeyxKhZx+YEEE
	C1PAbAG7gValKAa00o+xT/46cOi/zqQeoaKMU1uY3J0f+vmSKhHeOdDIYwSVG1pp7sG+4VHXfDZVM
	Ypuq4HeQ==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIWw-00000007Mdc-0dMe;
	Wed, 24 Jun 2026 08:00:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: PI fixes v2
Date: Wed, 24 Jun 2026 10:00:01 +0200
Message-ID: <20260624080014.1998650-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series has two unrelated PI/metadata fixes that came up
during a little testing surge.

Changes since v1:
 - take operator precedence into account so that zeroing doesn't disable
   other GFP_ flags.
 - add a commit log blurb on why Zone Append does not require remapping

Diffstat:
 block/bio-integrity-auto.c    |    2 +-
 block/bio-integrity-fs.c      |    4 ++--
 block/bio-integrity.c         |    9 ++++-----
 include/linux/bio-integrity.h |    2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)
