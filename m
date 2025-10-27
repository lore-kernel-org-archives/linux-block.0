Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72826281
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530591; cv=none; b=eG5d4CJy8Ys+9AZZe9kfALFcepsJzjOZkGZT2kcjD1YKE786GYDfV9ADJGIujSyxixIBL/2NTX9qWrOFcgJyOBjKi8UCIbGz/G7dtuGxhSV+Hpr7k+akincFkfDp0j/RXCE4VsErEWrreQ2eFo42h5YxpgtD5pkIBTag0sS33l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530591; c=relaxed/simple;
	bh=8EGXy5b1kSFodiuuzawK6wvaYbLLM08GPPPMMQ8zI7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkIIoAAWjYfRG2Qo2dvBRXVfOUhnakYD/nHn9SVRY/GI8aR12scC+wp4opXGcI0Wx2enpHFnC9sVgghi0NJ/yFSTPzguj7cvXMWtw6LT0QGYeJIaJOFPAzWVo6qpjI9l9CwlSztbTzFlu/lQ8dNT1NtnVdWaLQWF3AaoY4VX8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M5rop7MM; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M5rop7MM"
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b6d4e877915so79567066b.0
        for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530587; x=1762135387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=M5rop7MMq5hk2TzNK10RdeSGsBICc4P8G5UR62QY+Go8EUicxYUbV7yKF0Ewknd+3C
         VMkIwFI1srO6yQ4Ecb1XkU2abPONncSeLRtmJT8NcicRp0s6TAqVFGOmmjiI80dxMLvx
         ypX5+L0JchNz6mqkvEnQFM3y7iFrzfC6kLU8lHWge50XHc/Cx/DyHlrT0SYKY/92Crtk
         vNMwJsdtLabuDa29cKqFsQ3e7mWCg9OiYqVG9SbRUMKUp0C1qda9+m1hHKoVy+v1tJmn
         qDkL3sZXTEpf+AM9krAsrF/gZSQplLkX+52qJDh/hHFmMWJrolJMYt+tgOIqGoYwJ/Wy
         n21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530587; x=1762135387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=nk/vDodSjG414GnmyXeYi8nQ/mIdiseA22TUwatS1TpsLEmSjDWjRvW47jrCmHSWHN
         THye0gSsD4qBrkrShZOawPK3d3WWVLsONz2Phyyf/Chg9KCQHe68t29J8+ah+XiY+KtM
         9NrZ1pK34/H0JsAFqAdjo0FdWQBge1mxC+5NqlwGjmgMdkxzWtmTPQJapzxm+SGpXgiH
         YbVcW1sRs3alyCp1ytYwW2iKUAWB9f7CKN4LDWsxfX5E7XvC5pe04DsiDuzoUE0jqMMj
         9JJ2XiIfIQsnDEC1zz/K6GPiugLGXRXDM0NT4fk9a7nWDB6PUpiQFquZvq9MFpf+c0B1
         PlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9VbPApIoy/KC0HzVF2QduSGAzIOpfTpiV3n+9Y4DSTOXGyn9ga/xPMv29VBfpfLx0cz8gK+JvTFC9qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tA9rSgeme0S/UQaUL2wX2Q7ue+rbimKfB218EANuFypn2rik
	OLjKLSBdfQgVldokcUgbru+AS3UiRjPts069jn/QccsmZFY+fqQ+tyL8Vb22YnIL3UFxVoByuZ8
	Msf+fAtWy3MPFUL3PMGxZ6fqBe6KC/dfvyv+V
X-Gm-Gg: ASbGncsmfgkyvqw1NmwFAnIMheyfjs1rXO5bvzbZp3tz1b+l+HsVQw2GQMBXSd79aNS
	WCaqwS8DJtaRlmzJE701aip+E2PVr7LejZAlPcMqswjfxHXiuvKjKgooZ68b6TYoHvENBQ2+tT7
	w6LSTacG8Jm0SmIqlOaIEF5agbQBonk6/fzuYQGAcheso88NQlvOWlSiMwxEzkg/vC0p17a86Vn
	QlpQnaOBWnI/AQxZJynyiShcoXGzh0CL+c+yTm8HxGXRM3IdPqx2mtnxEP3Vz/39uaRhEnc8co8
	sN9T1PPwDBfJw2mk/L4Q9eVvxhP75zResL0QjEbwz5y6oTJGA3EAaHvS6S4nD5lGMX8uEx0UNsC
	C7dhgfFjK9ofXU9OFUUV22fNMEJgEztY=
X-Google-Smtp-Source: AGHT+IE4hiP03f6lofOOS2+HxUXFo5vKINW/jUKRpaO25HyrXJmcC0Z82zfs5/zGzfiuKTm+aQhmKlmbZdW6
X-Received: by 2002:a17:907:c24:b0:b38:7f08:8478 with SMTP id a640c23a62f3a-b6c72716445mr1473292866b.0.1761530586723;
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d85418ef1sm55541366b.47.2025.10.26.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 46DBB3402DD;
	Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3C232E46586; Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/4] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Sun, 26 Oct 2025 20:02:58 -0600
Message-ID: <20251027020302.822544-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd. Additionally avoid the
io_should_terminate_tw() computation in callbacks that don't need it.

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (4):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 29 +++++++++++++++++++----------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 21 ++++++++++++---------
 io_uring/io_uring.h            | 17 ++---------------
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 20 files changed, 116 insertions(+), 93 deletions(-)

-- 
2.45.2

