Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071EB56B7A
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407180; cv=none; b=kmTAm1959x+zFrXuRpIgU7scJ//AFpmQsG3HJn2po+pEIHuFct7ISngtKM7qPDQ9PKTS9MmlpdYJ3PLyueU0ny1o7VHyeR59kdFkrtf1TV/Bkbtx2syufMFjGqAxUzhWpVRZesGAVd7JOwiYzCthYPhlwEmdlSTUqUxsxAb3jX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407180; c=relaxed/simple;
	bh=yu7ldD7xbyA65qGghAtJRgci7GDWBWrK/Xy2T0Ot5fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O1q+3I5HB/md8SJW88rybzbLYDLTSHy765JaxEjfD7SttTSa+rKfwj7ZsMvETCe1uyNdlzMoFpCIpz5n1gEHR9xX3hyR51vLhSdj9SxfxQFi6+axiiBRmagabZHzHLvx98Y0RIIb0ayP2qfm9KFLtYwk+uZV/Tv7xSr2djFtnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ve9hjCle; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ve9hjCle"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JoucQx+6sHbpb/V1c/RuxM3qQezoY+tj4Ijd3qenvhg=; b=Ve9hjCleKGA9mB+2kkXuEH8fE/
	FkG7doViS+jqMX30J95zsD4h4Q15hOazkhc66h2ddvek/aoMhTwKAAJ6j8xV7070kmRSb8/HtSS0E
	+i/yLfBmA4fapirHIqbpYQtz41BEKp0OO3GyKi963IQ6p0Vn1pyV9PjsqZC2APRkmce3UZb3v61jU
	175HqC7DlgXoro/HQxjIOLYEbrP1MwO1rjbsmp6ugr9URZEMJ0wAnvtcTcgrhuoW0NDzDri7gngn8
	mpWDp+YiiCe2a54s0C4UETGhTmzE6kWqfc3lS5BPFQ+KEiQZPbfgL4LOUUv8517crsSH32PScPcto
	v0xWv0qQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcIkU-0000000DDpf-0JjJ;
	Tue, 20 Feb 2024 05:32:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: drop bio mode from null_blk and convert it to atomic queue limits v3
Date: Tue, 20 Feb 2024 06:32:58 +0100
Message-Id: <20240220053303.3211004-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series drops the obsolete bio mode from the null_blk driver and
then converts the driver to pass the queue limits to blk_mq_alloc_disk.

Changes since v2:
 - rebase on top of the blk_alloc_disk prototype change

Changes since v1:
 - add an incremental from Damien to make sure the zoned tunable are
   properly taken into account

Diffstat:
 main.c     |  503 +++++++++++++++----------------------------------------------
 null_blk.h |   19 --
 trace.h    |    5 
 zoned.c    |   25 +--
 4 files changed, 139 insertions(+), 413 deletions(-)
