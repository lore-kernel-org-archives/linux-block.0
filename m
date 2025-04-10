Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE41D63F8
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297297; cv=none; b=OvvYyW65N/htUt0+a9JyClPvyvCddvUofDQbUo4E2rt8AN9wB9YPhfKssECJdNO8YiCJBaJVTGYLmSAWKBEU0GPSRy3i3lL9ZIdttj7We6bEfi4gThDCm02895aLGfSTLq/c1M3uPQIDElMT2xHloErDgvSJGc4oCZSMhJh3ccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297297; c=relaxed/simple;
	bh=vEHtF3unQGwu3E6J/8I0T593fj7jCATjzkR5znjlP7w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pBVonhXtVy26F8zhQ5thnC9vT9xd4Z+KwL5q6GBDzwtM8mtWrTwf0H/J1QT2YtGVAa6Y5FD44hF7wcNs9hsgiJNKdNxS8LTdESdCWbY45OwTtmf73RR01oyXARRvb2ZNgG5BET1LECpMF3S1mMB0gkPjxBJq0DJa40XzotRMeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N059IrJN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N059IrJN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=P3cul0HMSLwsREqYKeSJyVYe4xfBvK7Oexli1yLCdSA=; b=N059IrJNuGqaC0YJCv/hW2pld9
	MbDpjMqH8jSYlao5+4E0TQW7OBQSImboy9Oi2Zx2qGWa9vHXKujkNeCXfIhQAKAMX8RJs19q4vpZX
	b5WbjbBfbIAFPSUwrC/y0hiLn4xfT7t8KaiV/YGiCq8KNhHmvteL31Ja9zUkX19U6o0AFnfeOwCIq
	KuOrlF5Qon9VDdZZ38upfcmH1seM/tEgRW3nxTPjqR88cSyD/0aNM1Mmrhhd8JLTWJFYsVvXqPm2q
	klGEEZzxycCyeiOnxBp14F9JSfDTu/R05jzhc91ad6w640rwaycGiSKox8SviWZtVRwIilPlXGCSf
	+Vr/rRkQ==;
Received: from 2a02-8389-2341-5b80-393b-6fa1-7c8e-6b3b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:393b:6fa1:7c8e:6b3b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2tPJ-0000000AwRx-26Yv;
	Thu, 10 Apr 2025 15:01:33 +0000
Date: Thu, 10 Apr 2025 17:01:30 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.15
Message-ID: <Z_fdSjFqscMuzxYq@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040:

  selftests: ublk: fix test_stripe_04 (2025-04-03 20:13:38 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10

for you to fetch changes up to 70289ae5cac4d3a39575405aaf63330486cea030:

  nvmet-fc: put ref when assoc->del_work is already scheduled (2025-04-09 13:03:56 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.15

 - nvmet fc/fcloop refcounting fixes (Daniel Wagner)
 - fix missed namespace/ANA scans (Hannes Reinecke)
 - fix a use after free in the new TCP netns support (Kuniyuki Iwashima)
 - fix a NULL instead of false review in multipath (Uday Shankar)

----------------------------------------------------------------
Daniel Wagner (8):
      nvmet-fcloop: swap list_add_tail arguments
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

Hannes Reinecke (2):
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes

Kuniyuki Iwashima (1):
      nvme-tcp: fix use-after-free of netns by kernel TCP socket.

Uday Shankar (1):
      nvme: multipath: fix return value of nvme_available_path

 drivers/nvme/host/core.c      |  9 ++++++
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/tcp.c       |  2 ++
 drivers/nvme/target/fc.c      | 60 ++++++++++++-----------------------
 drivers/nvme/target/fcloop.c  | 74 +++++++++++++++++++++++--------------------
 5 files changed, 72 insertions(+), 75 deletions(-)
