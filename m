Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCF332628
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249922; cv=none; b=UW95JU2aPr4PNd5lVLeWdcPIck27kchepqITBvDGw3CfJiKNNaCB2y1P3x6urt5syhZP+iVTcyFuUmZT03UAUd12T/COp4zzd/6/etjxU5ko5x2EHJ9d+JHolgXW9cfyYr6+f1qDcvhtuQpsASbbuz1vqKbkOIb48t/D4E17sSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249922; c=relaxed/simple;
	bh=DfFXs51BZEeAvcxjip7l3pt5+j8Ek5oM+jM5yn+295A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0H+WaZWSgDOb5VvGIPosNDK0bkzkvEn2/877xrQxAkNNsNcMkXWuhd1zL6NfTDfmxCBnHME4oQk3hUmz2SruF3IwEI3FBPx31I9jY17KoM0JD8nx/FsVtSVhAnQ2TPNP/8gn2tE4U+Twg8q6NIuiP36N7jWI3wcnOyYdt4ikLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cAsEb/fN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cAsEb/fN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2SrOIF78dZQATW0HFOJ2SJRj+DI9ea3DFpjVm7ktur0=; b=cAsEb/fNkLI5yQBUyqIF0YGyt9
	2mksYdaOM6QtPaC/L5Nk19P3Dbnnypwwt4e52N1e9h5j+Rrkz7Tt5L3lYOMM7DK7Z8kUHNDezR7O1
	jJk5H8wZIuDUtbOjolxkZalFLIKjX5dksZuOT+fekIb47pLf0tSOWk1pYQWK1xrm15E4ScPd3eyFl
	xyc/V7r+iKPUCPrQWnp/AWeAAdj++u37ShKIp+hOnUm3CR8Dnx0AqQqQ8A7ime3PyM9lFiGB5haBF
	tqIFp4jPh91tQOhYuiH+XAzbXYglSpfejsQQTT+5VobYiG27tq4Th1OE2qg7GTxdaSix4C06Q9bOS
	880lGhsQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZSC-0000000GAZw-1UAr;
	Mon, 23 Mar 2026 07:12:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: add a "discard cache" debug option to zloop v3
Date: Mon, 23 Mar 2026 08:11:48 +0100
Message-ID: <20260323071156.2940772-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series adds a new option to zloop to lose data not committed to
stable storage using a flush operation on device removal.  The idea is
to help testing that file system code does the right thing in face of
volatile write caches.  For conventional devices, this can be tested
using dm-log-writes, but the concepts there don't work for sequential
write required zones.  Instead this adds an option to zloop, which
records the write pointer at the last cache flush for each zone file in
an xattr, and truncates the files down to that value on removal,
simulating losing the contents of the volatile write cache.

Changes since v2:
 - spelling fix

Changes since v1:
 - fix up the documentation

Diffstat:
 Documentation/admin-guide/blockdev/zoned_loop.rst |    5 
 drivers/block/zloop.c                             |  337 ++++++++++++++--------
 2 files changed, 226 insertions(+), 116 deletions(-)
