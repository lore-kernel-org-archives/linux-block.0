Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18A2641CA
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938302; cv=none; b=CW4KpRHa/ozfs0OZg0GPSTazxja1PHuaa4F7pxV7VmJRbZ+uTWh7G1JW1LCLjp/e+1876NUaJy0FOQBxKCdrc58Hhn8YRy7kiDlWDzllq4K0/AGnqrV6TmaZBupIO83dzLcJm4s6yVBtwlR5nHTPcZON530e/GN1RcpcSYz5x5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938302; c=relaxed/simple;
	bh=8PyEGRkcRN3H3Qg+AG9OmNSVW+xgeo66cxYJL94BR4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5rDT1tojY6Aa0Xdfme3ZtcFw9e/hk+Go4EcjNjKaDAeLoCB2QQJTTiE5l3jUTF3c9ob5e2FHCFqvSpe7ZGJM+LMXH4xEQXzuANTlcTg9QeE/cJSMhxnicfo4DjenJmW9HDHBOADZRium3Z1XJEyogBj1LjZSjJkODKTz99BUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6BKAYFq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6BKAYFq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so20955945e9.1
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938298; x=1764543098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZk9sSNTwOxRpwZ/DRrF1dwGfvdtNtexBNm/jAu7ryY=;
        b=l6BKAYFqN+Det8YbgstB6eqhQCK+zE1qvXHle/mj0weBCTEnef8YgpixLJdZkJ65iP
         9p/BSabegsCDKPdS36tISi4H26MiJgGXG9BxBkcTAJVBkrQAUmRtN69eUYZuhsv/D+2k
         lpaPaDH+pTtEkI22e9fcCXPanrMsNzqr5114pkBfSmljaf/xtvFsVwz7m8CiqnhQ8dTm
         WNZX4acCn3nIqfBdbSN+gqRUilyE8ob+Fqf9zjTs9MIHLJlbzND6tThoX9/vlgLLyo0Z
         GiGxpfryUVqJ/5b7Z5UI1Fe9cjAzcSNdiSFnufibnxHCVr32cQ2wTVpJKz7SPSYhxFGK
         7TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938298; x=1764543098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZk9sSNTwOxRpwZ/DRrF1dwGfvdtNtexBNm/jAu7ryY=;
        b=v5YIVsNv/J9vuAR1rTDIXna38SDw1wlThhQBTM7PqEou27Cii7hOLFkcaVzNO+CV+S
         IvukZ/V81GKeDPccZSCxUKA10JOIIiKCuP+mMiB6yQoSjCjDtgi66+NuhFpJfV2xnz62
         NWcDl88YjzCzvFsPEJ9X9xocupPLGjlGe6efHLqLZ5OGo4b4kAjW5cz3RS8HAuy/cGTP
         y5A1mMPw14WDiGdxhlHxZ71E5QNt/7wa6KktbMW7ogGi0FUV14Xh7jcffrGg0uk+um5f
         y/Xy6vvfkv8/q/CrEAJhlzoHgdPpNXKuPe0iDRYRvSpAe8bd1Wx4ivZQAaooDcnlxihe
         Tzlw==
X-Gm-Message-State: AOJu0YzYO5DQzJ+tYjF0fraE23zIV0H9myo6n7msRtaDntJLzI0P/u0f
	s9CYh6ofAfSONAfOXc2ljNdRZD/INb00GnOLHArkHfeR+yi1xAj0qFjtgO8X8g==
X-Gm-Gg: ASbGnct+T7CBzRX/bfWKyjr3+Og9rPlIYIhxxeTHu1HnFNaChDcwFq3gt0ZKIZ07NH4
	kd1wqw+XZLACE9WvQNKUeKEFBaPV+2bcCRNTptwPgxKMxzJF0mhRHS/e0o/nX0/ggOvWsWycipA
	0h+pl6zIISl8D6XW5IPiGcC07EutASdTNvAqm5DYopgdmQdoUhIaAJ/KvJTi8bJoSXcVqgwCZns
	rl+SbkIs2L+FJyOmTb0vhCyhpFTw96odOmdXmyVuQ6IItYkplKvFjEYH2aa4lfnrZUUN7NWPca/
	KAdpofmv6dVx7dCD+ApmPPtRtuqpe/eTSDvmebX5v8tZ99eJqbhg+FhVck5E2gVs1U38F1jI96T
	lOOZ6RQxeALqVG7z+QqcLyiwndWsvNJq+d51RGnY1loUBSt5QAbJq7f42fZLlWaveTOy9BnlIjc
	J/df4eue1/CubBIw==
X-Google-Smtp-Source: AGHT+IEIzt6XAqBENWHKeltpmV3b1E5pfBhghZPeIUxjN0aB1YgGqF8Sp/+lNyxIs5uZ/0aP6PM4yA==
X-Received: by 2002:a05:600c:5491:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-477c016e60cmr94038575e9.2.1763938298240;
        Sun, 23 Nov 2025 14:51:38 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:36 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 00/11] Add dmabuf read/write via io_uring
Date: Sun, 23 Nov 2025 22:51:20 +0000
Message-ID: <cover.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Picking up the work on supporting dmabuf in the read/write path. There
are two main changes. First, it doesn't pass a dma addresss directly by
rather wraps it into an opaque structure, which is extended and
understood by the target driver.

The second big change is support for dynamic attachments, which added a
good part of complexity (see Patch 5). I kept the main machinery in nvme
at first, but move_notify can ask to kill the dma mapping asynchronously,
and any new IO would need to wait during submission, thus it was moved
to blk-mq. That also introduced an extra callback layer b/w driver and
blk-mq.

There are some rough corners, and I'm not perfectly happy about the
complexity and layering. For v3 I'll try to move the waiting up in the
stack to io_uring wrapped into library helpers.

For now, I'm interested what is the best way to test move_notify? And
how dma_resv_reserve_fences() errors should be handled in move_notify?

The uapi didn't change, after registration it looks like a normal
io_uring registered buffer and can be used as such. Only non-vectored
fixed reads/writes are allowed. Pseudo code:

// registration
reg_buf_idx = 0;
io_uring_update_buffer(ring, reg_buf_idx, { dma_buf_fd, file_fd });

// request creation
io_uring_prep_read_fixed(sqe, file_fd, buffer_offset,
                         buffer_size, file_offset, reg_buf_idx);

And as previously, a good bunch of code was taken from Keith's series [1].

liburing based example:

git: https://github.com/isilence/liburing.git dmabuf-rw
link: https://github.com/isilence/liburing/tree/dmabuf-rw

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

Pavel Begunkov (11):
  file: add callback for pre-mapping dmabuf
  iov_iter: introduce iter type for pre-registered dma
  block: move around bio flagging helpers
  block: introduce dma token backed bio type
  block: add infra to handle dmabuf tokens
  nvme-pci: add support for dmabuf reggistration
  nvme-pci: implement dma_token backed requests
  io_uring/rsrc: add imu flags
  io_uring/rsrc: extended reg buffer registration
  io_uring/rsrc: add dmabuf-backed buffer registeration
  io_uring/rsrc: implement dmabuf regbuf import

 block/Makefile                   |   1 +
 block/bdev.c                     |  14 ++
 block/bio.c                      |  21 +++
 block/blk-merge.c                |  23 +++
 block/blk-mq-dma-token.c         | 236 +++++++++++++++++++++++++++++++
 block/blk-mq.c                   |  20 +++
 block/blk.h                      |   3 +-
 block/fops.c                     |   3 +
 drivers/nvme/host/pci.c          | 217 ++++++++++++++++++++++++++++
 include/linux/bio.h              |  49 ++++---
 include/linux/blk-mq-dma-token.h |  60 ++++++++
 include/linux/blk-mq.h           |  21 +++
 include/linux/blk_types.h        |   8 +-
 include/linux/blkdev.h           |   3 +
 include/linux/dma_token.h        |  35 +++++
 include/linux/fs.h               |   4 +
 include/linux/uio.h              |  10 ++
 include/uapi/linux/io_uring.h    |  13 +-
 io_uring/rsrc.c                  | 201 +++++++++++++++++++++++---
 io_uring/rsrc.h                  |  23 ++-
 io_uring/rw.c                    |   7 +-
 lib/iov_iter.c                   |  30 +++-
 22 files changed, 948 insertions(+), 54 deletions(-)
 create mode 100644 block/blk-mq-dma-token.c
 create mode 100644 include/linux/blk-mq-dma-token.h
 create mode 100644 include/linux/dma_token.h

-- 
2.52.0

