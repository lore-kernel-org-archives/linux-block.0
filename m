Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2230C63B;
	Wed, 10 Jun 2026 05:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068222; cv=none; b=gBpoa1DFBWwZWMe8CPTS6xaaGa1kpQ8XDwiR9oKDWZ5mLA0NBkWCMDb+YVbWjOZCKvasDt5PzgFDqXtmnxqTtMJGj1nMFDXwsV+8jwOybT3gfPReguLYfhQb/V5Ybh1Xg8lP1bJUTm9kE6xRtOz76NZeh1unaD/6o1CyvF0TFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068222; c=relaxed/simple;
	bh=Ga0w4mOhyRAMdzhIK/IO32MHLe/xDoVb4wCIZopi4Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAVTX6Oq4DpY9X1oaB5BMPDcdxMOZLWBWXHO0sUFHUc3LYDbuuoyfOQG2fBwQRzoPXUS9RLGxqUoIVxkjE4LB2Iv+pX3bh1JNq66AgyTIgOxlQl67pKJU0UDNlO8XMQpXUaTxqrRousUPy3SKYsFRD8mVvh4BMjWiDT0CQL5AYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R8bMuCzE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8bMuCzE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yz7YFWWMxtYCyliJrw7JdN2FfQ3bkv92qdzFJZi+9TM=; b=R8bMuCzEYUVx232lY3wAyGvoT/
	+cXJXayJWRXI4+IH5d0CPwMWIXhgfJwlBgzH7wZJji3ZYMNUegKHwgV2dPh8z3/BieswMBzssB5DJ
	zvuNpV8hOcYLmXp6UJiuFszhm3o9x6Bt4tdNCHHY/sWQohA3w2ilFJHHwiA/mchLKoQ57xSJV5MKM
	fQ+viDwhw6ME4EIOklezLTwSqtuejN09XQfCXU7umAp31+SY4ZTIRTmKweaV9BUEGS1PHIaIUoj9e
	60Ej+EdLKZf9q5dx14dGFc0s3nqVBamc1VBVh05p0Hy5xpNxwZKn8HRaW7t05BSM4VQkcrabjwJHz
	78edRihw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBCl-00000006oHa-369S;
	Wed, 10 Jun 2026 05:10:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: configurable block error injection v4
Date: Wed, 10 Jun 2026 07:08:01 +0200
Message-ID: <20260610051015.1906799-1-hch@lst.de>
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

this series adds a new configurable block error injection facility.
We already have a few to inject block errors, but unfortunately most
of them are either not very useful or hard to use, or both:

 - The fail_make_request failure injection point can't distinguish
   different commands, different ranges in the file and can only injection
   plain I/O errors.
 - the should_fail_bio 'dynamic' failure injection has all the same issues
   as fail_make_request
 - dm-error can only fail all command in the table using BLK_STS_IOERR
   and requires setting up a new block device
 - dm-flakey and dm-dust allow all kinds of configurability, but still
   don't have good error selection, no good support for non-read/write
   commands and are limited to the dm table alignment requirements,
   which for zoned devices enforces setting them up for an entire zone.
   They also once again require setting up a stacked block device,
   which is really annoying in harnesses like xfstests

This series adds a new debugfs-based block layer error injection
that allows to configure what operations and ranges the injection
applied to, and what status to return.  It also allows to configure a
failure ratio similar to the xfs errortag injection.

Changes since v3:
 - use a static branch to guard the new condition
 - split out a new header so that jump_label.h doesn't get pulled into
   blk.h
 - more checking for impossible conditions in blk_status_to_tag
 - more spelling fixes

Changes since v2:
 - improve the documentation a bit
 - fix a spelling mistake in a comment

Changes since v1:
 - drop the should_fail_bio removal and cleanup depending on it, as it's
   used by eBPF programs and thus a hidden UABI.
 - as a result split the code out to it's own Kconfig symbol
 - various error handling fixed pointed out by Keith
 - documentation spelling fixes pointed out by Randy

Diffstat:
 Documentation/block/error-injection.rst |   59 ++++++
 Documentation/block/index.rst           |    1 
 block/Kconfig                           |    8 
 block/Makefile                          |    1 
 block/blk-core.c                        |   87 ++++++--
 block/blk-sysfs.c                       |    5 
 block/blk.h                             |    3 
 block/error-injection.c                 |  314 ++++++++++++++++++++++++++++++++
 block/error-injection.h                 |   21 ++
 block/genhd.c                           |    4 
 include/linux/blkdev.h                  |    6 
 11 files changed, 489 insertions(+), 20 deletions(-)
