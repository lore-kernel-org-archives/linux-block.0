Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814017C61
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810565; cv=none; b=d9Bli7t7QI46DofsxqYxJK1w0DrJ6y2wmxqXM1uJ974zIOcocArua2cutD/P0ib63oma/jwljfRxCVaT2mQf/ulxNhurPDy+mUnj0zmUcgcTJpEomI/hRCQzLQ1u6QY46MFjk0fw1ITJEg4hl3bwcoLHaR6CMyW0Eic6RlKyzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810565; c=relaxed/simple;
	bh=ekuOjRGEzF0LgR1I3BhbSKZxilCXSi3MC+XDu0rL3CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJ2V1dGdIJrF4j3oy38BiBdNKrCuXW4l6mm172ty0P1IgIvHaLYm85W+f3FZv9sKW5QD+Ox6Vc03rBUP/pFCGTH0lZ7F/4U+iuzcBy/JLBQ2OAAfHw63hEdnWOetvAnkOdvRBSHDMNYTyJyYW/ZK5VgfBTlhD6Wo7Fke90H2LT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Li2OJPMA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Li2OJPMA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iPHWKoPzqKWQhS7FEpS3v0I20bqmhBnCIvv7fh6JXkU=; b=Li2OJPMAD71M45adNra1Z7Fkq6
	AigpXz7gm9yeK3AJENiKdpgKoamGfKYCSDE63akOi9W66vv3J75sbsR0IFP6qtSiFeaTvprz/SPJE
	+MHi+1AQLO3UNuZ/3yXJZ6O/rW4wsyOxsYHqbErmg/1vBfjhUXf4E2UDBVCFXYSWgOWaqN81DzFb0
	QGsiqrOQwxxMuKimian3cH/Fy831yubcbN0Pm2YV5LlsNzkgTkBcCSXD9O5DQ/veajY4mzWUjYBUS
	tcG+tYBrrWG0fDggj42EoxifzmuXV31/Iti/wMQccH2CMG3EOPK2THB0bqK4Omo2IQvNhPncGEX0s
	SwvKyc7A==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9I1-00000001iCL-2KnO;
	Mon, 01 Jul 2024 05:09:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: more integrity cleanups v2
Date: Mon,  1 Jul 2024 07:08:56 +0200
Message-ID: <20240701050918.1244264-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens and Martin,

this series has more cleanups to the block layer integrity code.
It splits the bio integrity APIs into their own header as they are
only used by very few source files, cleans up their stubs a little
bit, and then in the last patch change when the bio_integrity_payload
is freed when it is not owned by the block layer.  This avoids having
to know the submitter in the core code and will simplify adding other
consuer of the API like file systems or the io_uring non-passthrough
PI support.

v2 has been rebased to the block for-next branch as there are conflicting
changes in 6.10-rc but not in the for-6.11/block branch.

Diffstat:
 block/bio-integrity.c         |   87 ++++++++---------------
 block/bio.c                   |    2 
 block/blk-map.c               |    3 
 block/blk.h                   |   14 +++
 block/bounce.c                |    2 
 drivers/md/dm.c               |    1 
 drivers/nvme/host/ioctl.c     |   16 +---
 drivers/scsi/sd.c             |    3 
 include/linux/bio-integrity.h |  153 +++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h           |  156 ------------------------------------------
 include/linux/blk-integrity.h |    1 
 11 files changed, 211 insertions(+), 227 deletions(-)
