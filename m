Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D73D6673;
	Fri,  9 Oct 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539885; cv=none; b=YUk1aHmXoRFhYE5E4WtuGvUTinbSW2OZcsPg8pN0SZ5vuI0Upq5kI1MCuZMDngUnnnEjeGMiXIAbkmODzzNXQfdC1vzEzd6k+AFuCIsX2FkD/zEInmBpVQU2sOu1PSzsMIiHrXge/65vnL7z+JEL0id2jIYF10ik/zQ//CWkYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539885; c=relaxed/simple;
	bh=U3HGUK8lenPcIDRF/4IJtKteI85oOjFHjQmGiPNxeNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuGuL6Hq/S50fEiqdubMwQwmTJWjLbiAWUhNWcvgwHljJPOn3/3QXuQq+jFAX6TnpRw3ovWCKt5jHPM/IzwB+GgBxzcx6HEOXyhOq/b6yxt+jtqxKECPxw32MSwhI8/oZ9m/BMxnPu0wll3CMqVhD0xE+QRIbGzQAjOf2M+znI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B68BA4796F;
	Fri, 09 Oct 2026 11:58:00 +0200 (CEST)
From: Lukas Sichert <l.sichert@proxmox.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Sichert <l.sichert@proxmox.com>
Subject: [RFC PATCH 0/4] block: coalesce bios across buffers and folios in blkdev writeback
Date: Fri,  9 Oct 2026 11:57:47 +0200
Message-ID: <20261009095754.430875-1-l.sichert@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791539879721

Buffered writeback to a block device submits one bio per dirty buffer_head. For
contiguous dirty data this creates many small bios that the block layer then has
to merge again, or does not merge at all. Large folios make this worse, since a
2 MB folio with 4 KiB blocks is up to 512 bios, although the buffers of a folio,
and consecutive folios, are often contiguous on disk.

To aggregate data into a bio, keep one bio open while writing back and
append each dirty buffer to it as long as it directly continues the
data already in the bio and can share its properties. Once a buffer
does not fit, submit the bio and start a new one. The open bio is kept
across the buffers of a folio and across consecutive folios, so
contiguous dirty data ends up in one large bio, which is then also
completed in one pass instead of buffer by buffer.

A similar approach was posted before [1]. Since then folios, and large
folios in particular, make it much more attractive: a single folio can
now carry many buffers, and a run of folios can fill a bio with
hundreds of megabytes. With 2 MB folios I see bios of up to 512 MB
(256 segments).

[1] https://lore.kernel.org/all/20201230000815.3448707-1-ming.lei@redhat.com/

Lukas Sichert (4):
  buffer: writeback: extract shared bio build/complete helpers
  buffer: writeback: batch contiguous async-write buffers per folio
  block: coalesce bios across folios in blkdev_writepages
  selftests: filesystems: add blkdev writeback coalescing test

 block/fops.c                                  |   9 +-
 fs/buffer.c                                   | 236 +++++++++++++---
 include/linux/buffer_head.h                   |   3 +
 .../testing/selftests/filesystems/.gitignore  |   1 +
 tools/testing/selftests/filesystems/Makefile  |   2 +-
 .../filesystems/blkdev_writeback_test.c       | 259 ++++++++++++++++++
 6 files changed, 463 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/blkdev_writeback_test.c


base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08

