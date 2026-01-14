Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EA221F0C
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415934; cv=none; b=Qgq0S4X3+mcMPOlp5VppIM/TmIvuCjsStIliWIJyLsLtg14j9SAwTNS6VFsNJP6dnjYBhyrexhiG9wVpTyGvnmVIEn5dIH4oDpWM2YM1CZGxum8u8VaxVZNFlg109kOW13VMDvTQXxgJ0QFe8QYeLKzQOQ6SHeCdALDEGRVy5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415934; c=relaxed/simple;
	bh=x7DbmQJQV7QHt+t2udRvHDk681dZQUYX/n92c2XtDxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMefBF4XO3XPlo5Zi0GLEzvVVsY91bMRI9wnv7P9TpSVWsRWN32OpiWRKlCwXBpAbGim5zQLHs96FLPUGVS9dbj61zJYfnHrlVMbU3EnSr8usV5aOFys0tkA9mvnCqiRXwWA05XY3KWAzNgtxWec7txnjEaaO+3fbKb6Ram98kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttXrT5Ex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttXrT5Ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8969AC4CEF7;
	Wed, 14 Jan 2026 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768415933;
	bh=x7DbmQJQV7QHt+t2udRvHDk681dZQUYX/n92c2XtDxI=;
	h=Date:From:To:Cc:Subject:From;
	b=ttXrT5Ex7QuBQ/8y9k7pghMUriZwp2xrculrfP6ZeLxZ4w5PowgpVTAX3S1hWtk2t
	 nyYR26UfxR1zsEanoCKc6XWVK33uRBx6r0xFvYB8x+YSo8YINCBHRLUG4f+E/zXqeM
	 GIZg1QvmaE2gWdsEgX/7PqWJ5KsWbxfKicfUZHN1dwfYOglWYZHd94CUj0XYK5vmgE
	 9CJ2fEljVz54lOYblbHWrYSzij+iE6FVJCtApVnypjz+YlhsBVWRRqEocM0OHXEn5l
	 zBOAhItyIECl0DpsCu3wDEacZhq6DZHlWhOredTuJ+UHboU+Ra9RRbTp063z3iRLrN
	 RVe4HvqLGQuZw==
Date: Wed, 14 Jan 2026 11:38:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.19
Message-ID: <aWfiu2Twr5_lT9zq@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9869d3a6fed381f3b98404e26e1afc75d680cbf9:

  block: fix race between wbt_enable_default and IO submission (2025-12-12 12:51:11 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.19-2026-01-14

for you to fetch changes up to 0edb475ac0a7d153318a24d4dca175a270a5cc4f:

  nvme: fix PCIe subsystem reset controller state transition (2026-01-14 07:21:31 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.19

 - Device quirk to disable faulty temperature (Ilikara)
 - TCP target null pointer fix from bad host protocol usage (Shivam)
 - Add compatible apple controller (Janne)
 - FC tagset leak fix (Chaitanya)
 - TCP socket deadlock fix (Hannes)
 - Target name buffer overrun fix (Shin'ichiro)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-fc: release admin tagset if init fails

Hannes Reinecke (1):
      nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()

Ilikara Zheng (1):
      nvme-pci: disable secondary temp for Wodposit WPBSNM8

Janne Grunau (1):
      nvme-apple: add "apple,t8103-nvme-ans2" as compatible

Nilay Shroff (1):
      nvme: fix PCIe subsystem reset controller state transition

Shin'ichiro Kawasaki (1):
      nvmet: do not copy beyond sybsysnqn string length

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

 drivers/nvme/host/apple.c      |  1 +
 drivers/nvme/host/fc.c         |  2 ++
 drivers/nvme/host/pci.c        |  7 ++++++-
 drivers/nvme/target/passthru.c |  2 +-
 drivers/nvme/target/tcp.c      | 21 ++++++++++++++++-----
 5 files changed, 26 insertions(+), 7 deletions(-)
