Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF8192D68
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012385; cv=none; b=YeVTWDS0CZnTf1s7PJGioYQvpx8S43zJzdNs70s973SgCBjNDA0TPZgfQBcyAaD5oCCePYz0NC8B9Z9ecakEgKhwA3HfhyWZQHrtj0QSaYoKabhHGwApLwJLt6dJABsbmocqsBxrySIxuMklTBzC7/+bp7I6ymci9L5qJWqcKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012385; c=relaxed/simple;
	bh=mNc5jpyBf/arF1tPb3vDgaSWa0+vztYhYk2kI6Tumcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjMNx7WXf8ZJv6KWvGdz/7fZfVAhANf22og9RBEE/vzAgWRTtARvbHDsTLIYasBDggUtmgkeR/swjktY/pbmtN15zWQoZtWDLaxFukzElMIiVfkaro/irTEXj6+MRmd7qpw/A6PJ9ZYn6fyLNvTsHrS+ujT1jwTkqUebH20sT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFZI6dXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFZI6dXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35EEC4CEDD;
	Mon,  7 Apr 2025 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744012384;
	bh=mNc5jpyBf/arF1tPb3vDgaSWa0+vztYhYk2kI6Tumcc=;
	h=From:To:Cc:Subject:Date:From;
	b=mFZI6dXjw27ThBi3d7CcaOnXZV5wkWWCD5qYmwuZsZWUxuiltmDS55SI48nNncBi4
	 RCzxDaLHlvaw8n925wExyl0h0vMoQosbvbtb9j4KNf8Wod6IujcxdNX4Jfa6iD5UWj
	 /4ks8aHaotNu83Bk+ZkMnNuYrhyI8NIyG8RWXflbNXMHYNYHPCeA/eUxkvnS9y4ejF
	 Ns3iv0iVyD9lWBIPvgrnkij9Y4IkIkBVv8R1FA+h1NrvowHhzGhTA0/tqU2/inbY1F
	 FnsdAUHrNP+0OUjrebbi99s4k8ZuARQZv+FdPfNTw+WmqnZiDSjMRe+FOTknvG6AEo
	 TuDbkCMNyHnTw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 0/2] New zoned loop block device driver
Date: Mon,  7 Apr 2025 16:52:20 +0900
Message-ID: <20250407075222.170336-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements the new "zloop" zoned block device driver
which allows creating zoned block devices using one regular file per
zone as backing storage. This driver is an alternative to the RUST
rublk driver which provide a similar functionality using ublk
(See https://github.com/ublk-org/rublk.git). However, zloop is far
simpler to use (a single shell command to setup and teardown a device)
and does not have any user space dependencies. These characteristics
make zloop a better solution for integration in test environments (such
as xfstests) using small VMs.

zloop and rublk performance is generally comparable. zloop is a bit
faster for large sequential write operations than rublk, while rublk is
faster for small zone-random write IOs.

The first patch implements the "zloop" zoned block device driver under
drivers/block. The second patch adds documentation for this driver
(overview and usage examples).

About half of the code of the first patch is from Christoph Hellwig.

Damien Le Moal (2):
  block: new zoned loop block device driver
  Documentation: Document the new zoned loop block device driver

Changes from v2:
 - Rebased on 6.15-rc1
 - Some corrections of the documentation

Changes from v1:
 - Corrected Kconfig description in patch 1 (outdated example was shown)
 - Added missing request sector update on completion of zone append
   request (I had not pushed that...)
 - Added reference to the documentation in the kconfig entry in patch 2

Damien Le Moal (2):
  block: new zoned loop block device driver
  Documentation: Document the new zoned loop block device driver

 Documentation/admin-guide/blockdev/index.rst  |    1 +
 .../admin-guide/blockdev/zoned_loop.rst       |  169 ++
 MAINTAINERS                                   |    8 +
 drivers/block/Kconfig                         |   19 +
 drivers/block/Makefile                        |    1 +
 drivers/block/zloop.c                         | 1385 +++++++++++++++++
 6 files changed, 1583 insertions(+)
 create mode 100644 Documentation/admin-guide/blockdev/zoned_loop.rst
 create mode 100644 drivers/block/zloop.c

-- 
2.49.0

