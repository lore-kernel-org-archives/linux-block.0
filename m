Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A59219A71
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305896; cv=none; b=HryaPjTUf71cgYKR/wsu9BRx26FQbe30NOQFn7aD6L1fjUpbxLPj3F1wi3odWsZVOy5Cy6Jeqe0TJxAtxwuLoUjGaWAZk5/bCwuvD/0HjAZzXtfWfCqBFXZUyBQ+kkaca9++yLErz8bDbYw6RRgaDfvGW1XU0ebOQQrJ7Sn/Zu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305896; c=relaxed/simple;
	bh=eKw0GNbhSGb/7NUvqnc3TTcO+szFvMEBMwtXRZijx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P09xRWeo9c6r4i3uIpW7LHvkeqWDPH9VHbkcvASi5AcWCv3kTSSuQ40NGCd0mx6FR9nBQWBr+Zk3snU9SG0ap12SHd9AIlIiSXVX68k/RlvX9Cz0LBfA/vhHPUFAIN/q1m48G5jQtjUOTgqkRs+USaoBun2f9zvDTsOEBPUDUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFZ+hMvO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFZ+hMvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F43C4CEF7;
	Thu,  5 Feb 2026 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770305896;
	bh=eKw0GNbhSGb/7NUvqnc3TTcO+szFvMEBMwtXRZijx5g=;
	h=Date:From:To:Cc:Subject:From;
	b=UFZ+hMvOXmCVZFuq9l08xSEeWSysgRsFJH5ylOjemNgRWllGsvfgQkBxrwunt/2Yd
	 CcnAKJYaNQi4FLcXk3+gOPP5IUIKifQKpz5AduJn4yXWvFSTUVtUHNooaCivfH3AJN
	 rE25yeyky9J0CnxL6A75JszyXJwJW+Bb2wkT07c6Ke7ESEBNvqsulqFlQAhTAjvUhd
	 tC5g8Gxynwk6qOz/eme2gpaqbFI85gU7LcnkmWxFbE0nxNyn7W1g51RqL6VP2FT4i3
	 Q6QUnTfUbD2LgQo/5wke3ahZcMsqi3ScxksV5GAluOHQ4dwNn+uqIrX4EfAdgfb/VQ
	 eXWMJ0XcvD5Uw==
Date: Thu, 5 Feb 2026 08:38:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 6.19, final
Message-ID: <aYS5ZlwruxpNCdTL@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

Some late fixes for nvme that should go in this release. One for a pci
regression that causes a kernel panic during certain dma conditions. The
other fixes a vulnerability in the tcp target.

The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:

  bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05

for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:

  nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.19

 - Fix NULL pointer access setting up dma mappings (Keith)
 - Fix invalid memory access from malformed TCP PDU (YunJe)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: handle changing device dma map requirements

YunJe Shin (1):
      nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec

 drivers/nvme/host/pci.c   | 45 ++++++++++++++++++++++++++++++---------------
 drivers/nvme/target/tcp.c | 17 +++++++++++++++++
 2 files changed, 47 insertions(+), 15 deletions(-)
