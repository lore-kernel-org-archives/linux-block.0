Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7234D916;
	Tue,  4 Aug 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847855; cv=none; b=rZykwFfpkeLYjJH6TLC0q+FtVldidlCl/yknS3tBUQ3fDNOYgiz8FUfwif8ZiYlV5BU/H3MgoGrwU+yDv/aJ1bzFoJ6n1yYCD4MuGDeBtIUL+zmNkgvdGcQSh9TKYTPgIPYqCXeCLlbjtS1DROmgsFso/tyMW6fC5WTMep5VpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847855; c=relaxed/simple;
	bh=FBlcuKiYDXicHwb6gwdCzT1PjbJXrJm7M62EgKBxQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYS274lO5ZVWHxfl082MiZcgeHSZrp2nEh8vLnfhKmRWqGoVKHzYwl77cvxpuq0DenYg9LMysq1vglhWaX8PypV1HYR9F5gzBl5S6z0IBoLBJui7yghKIq90FZ+HE+WbsRqV1MhupFwPtGRyr3xkvLrMx0Fvx9HFyJFj+UEAyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hwq4y0y+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hwq4y0y+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DTfyJIotUcHKCZj7ArlAI/w5fN3dUoc2BJbKInSgzxc=; b=Hwq4y0y+o3XuuoYNnvLzHovabx
	AXiE5binEFRiL6bKBFoPy0of3Ld7CuOh3BHA81lGG2yCK0bU0pNP35U5SlTTm9bUpyrVXLbtU7UVk
	LKazYexrw6IDi7IvvDGFWsEkPIykcz+4VsQjc/DE46wFUXU+XQI1ZLK5is4qPQSYqTv9aO1JUhqHn
	OZKDiE9n+mUr7pzGebaSHTRiKoMbXqbqqYC7ZAcmdvIJc/hnPM92qCiWHFTri5LQMrEJMPLfnagdr
	ewMmg7EjQVzho42JgOcr3/PgH9eRA1f1qQgxoJs1JQe9SUnM2D2cHMsAwVoRyGTGFgsTWHPKECdle
	JOK4V0ZA==;
Received: from [93.123.20.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEbV-00000001qzF-3w4Y;
	Tue, 04 Aug 2026 12:50:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: add a ZONE_RESET_ALL uring cmd v2 (resend)
Date: Tue,  4 Aug 2026 05:50:16 -0700
Message-ID: <20260804125038.740388-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series adds a new ZONE_RESET_ALL uring cmd, and cleans up the
io_uring discard support and the block layer zone management code a
little bit in preparation for that.

This command is useful to speed up workloads that need to initialize a
large number (or even a small > 1 number) of disks.

This is just a resent with collected Reviewed-bys to get it back into
the attention window.


Diffstat:
 block/blk-core.c            |    6 +++-
 block/blk-zoned.c           |   30 ----------------------
 block/ioctl.c               |   60 ++++++++++++++++++++++++++++++++++----------
 include/uapi/linux/blkdev.h |    1 
 4 files changed, 53 insertions(+), 44 deletions(-)
