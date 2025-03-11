Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68ED1DE3B1
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660910; cv=none; b=OzzEyId2JGLjQcECQaTCB4Zg4AMNr5C0oK5Q2/2vUcRRA4qPL6ZI6f51aLyULLyDsRWp8tH6kmB71pw88AjHVhCj1nexU3z00UvBeF8pBAv5omFsdpzPTul3ARDeaAXuLtLKn3DC2a93zfxUQJ4TRf2dyGwXo/X798pbOIKPQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660910; c=relaxed/simple;
	bh=3M1RX7nQUNgedOmI/wuy5kV+UAWXYSfHp90hyMNHCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4UJx1Fh03DCZ1q7LPjkC14tUwQQNJMWdtYDdIFnejR/MnNmwNAS5E5iuVEnWBhFbE16rwVmFquWKOjfcHOqEqft+VxWPg2/8lHOykFNHN1StUHvWfKzstR+B6U98Ngp5DoKOdhfUnxfkY1kXWZjo8Gz681+6OpenWID1ou3d5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=afxOgatr; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="afxOgatr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741660909; x=1773196909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3M1RX7nQUNgedOmI/wuy5kV+UAWXYSfHp90hyMNHCQo=;
  b=afxOgatrQ6lpXqtxNwUTUMVtfTIDgREePLVCExeEI+Lqbh9kozstoBih
   b4L6B+oUHRIXaHPd97MyZFWyE5ozutf9065cQSXLZeENDxz3rJ+uH7bR1
   F+fNx37ksx9Yp1EkuVAEtk0ZjNlL3P44/rWX981NueduOSvrzJKkbwx7k
   bhp/5yphxt25uayT2vnnGapWdwYjstOlVcNEvaEeXKfGEp0ECE1hvawg6
   sBPF7xbxEc5xwmx91qy56jluOwFx31i/1Jye0EoPNeRUkqyLFsg0Cowbc
   zEATCZVh26FdW4BiIWTAFs7HfJTOS8TYTye+AChWxWfJXU0jZtRSHQbkz
   A==;
X-CSE-ConnectionGUID: lXyooUfVS4Gd6F5iw+PsAA==
X-CSE-MsgGUID: JkY3d3jcSDWygHXm7HSCKg==
X-IronPort-AV: E=Sophos;i="6.14,237,1736784000"; 
   d="scan'208";a="45125159"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 10:41:48 +0800
IronPort-SDR: 67cf9517_1PHYr6oMWkwu4xOf4y89m7hBr96c2Q81KTJ0HFjCqyDLwg7
 8PIRI+YidoGkXbSgX+yyTTjc3cOjjtPHTG9JyCw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2025 18:42:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2025 19:41:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/2] block: nvme: fix blktests nvme/039 failure
Date: Tue, 11 Mar 2025 11:41:42 +0900
Message-ID: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
failure [1].

The test case injects errors to the NVMe driver and confirms the errors
are logged. The first half of the test checks it for non-passthrough
requests, and the second half checks for passthrough requests. The
commit made both halves fail.

This series addresses the test case failure. The first patch covers the
passthrough requests, and the second patch covers the non-passthrough
requests.

[1] https://lkml.kernel.org/linux-block/y7m5kyk5r2eboyfsfprdvhmoo27ur46pz3r2kwb4puhxjhbvt6@zgh4dg3ewya3/

Shin'ichiro Kawasaki (2):
  nvme: move error logging from nvme_end_req() to __nvme_end_req()
  block: change blk_mq_add_to_batch() third argument type to
    blk_status_t

 drivers/block/null_blk/main.c |  2 +-
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 15 ++++++++-------
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/pci.c       |  5 +++--
 include/linux/blk-mq.h        |  5 +++--
 7 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.47.0

