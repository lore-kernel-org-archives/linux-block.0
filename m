Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABB3081AF
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174825; cv=none; b=aKQGdN8doo39LwDGntoKsY6aNwrVoSYX35nZ6osz0nXaAwaX7CQid2P7WvHKiJ08h2V0m29CeGsonI6HUt3RWP/+i7p6w7ZYTFh0pLg6IxRjjqa6gWle0n3ZNHln8TdS5yIhKY7m3lZmXMa8tnz6U05L7WQJAuf738LWhmguWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174825; c=relaxed/simple;
	bh=+8TQGyg0ZV97+kPFYJBnRauC5Q+QxqG5BEUv/mu4y9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebC7TohJQrU3OXGTjXqP8c5CvddaZgQ/QgPjor9JE8pPkdux0CfPhs2ZKIsHfWv9ei5Nw7ExBvzCak9+9eSqIQS8M7Z0V1SXOFBZuYIIIcXpWgxWzNyT0U16gTH79yPccYlIfHifNXtnQU5omKclqq7KjTRU9vfCaZzRCZa/03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BZWmGKO9; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BZWmGKO9"
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-591b99cb0c4so18944e87.2
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174821; x=1761779621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=BZWmGKO95mD2clfYM/PYqVpX7rGOPzXaBNdIxo6ldORmYIU9uBypqtCxh4clf8sg7p
         bbPfaMsN7iLQ3zmHfVqgp0KZOJTmocZJh605cfVR6RZ4eyuZEiryrUz3UjN6sJcbRuLw
         8B+Fd7EYoRGQnTx1q4yLgQoa/iMRapBsKvpc+cu8J5u96XjxcKdReTAR0i3usD+gUIre
         5xBkmT5LrdNzzrK7Ea0M1dpI+W25Hwuhn1oeXWrTL6cRWN18YvIfFRWWY2/QkX2n22G1
         iAWc4OQMve7TJLXWQbXzftDQIj1GtrxTS5Zw+8nVeEACw2dcTAO60Gd6UwnK9A8E7KtU
         3Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174821; x=1761779621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEb7Tz++jPbBE/mHfoATYrwfDk87qKz0eD7ACfLRyGs=;
        b=nBYBoQpU7icUFRyUihSIspxBOgSR1dUf3LNjXyQpBlr4DhODQyT2D1qQZ5/2NTbqCL
         mnllf2pVFPj7unfnlIlamnIUfqaPRAAPFN9nTwQ0nFf8oCK1317cRiwQXFFTbLN29/kw
         WCUhY3oHRlLmH0Z9PTRcqjtPKhtauMttsnJ5qRqMGbxH9ezjdPpt3Lg+w+GElZdBmQ3v
         UC0oBG4kUNn/EBjyUIHMUQFAK9Ca0c4zObqalUwAi1XRbhP7/H3aIJ3Ak778AAyk1M5W
         QjspOKTn42hBAUFE57AVAGKJKo3SjpYG8qB+EXdOVyCmwljZagh0NzmOqYN6rOrayYH/
         Vy1A==
X-Forwarded-Encrypted: i=1; AJvYcCVsZ/VhErgWy6saqD0C6bx2f0qpk+wg/wNoJS534DCzZypcx76t5WIH5nqbj2rZiHswAkAcnpn0QSef7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5Yqu/UYdEezHuT55Owbq9MNbNUibR7J9/yu2oQ2zI2DkXrSe
	YdRKpoYMiha15QxtuLR9Y3bUwOiQxed7a+QYfhK/er22GFUaF5OCNf5BLNj+9dN1mmqKBFpzg07
	dbB+L+JB22QTfufo26j3hldPIiTThjMOQrJnFsb5r8ydrqn0S7zjk
X-Gm-Gg: ASbGncvE2WZkoJR7bIbMURYVLh2eiVp1yYlVIol1t3/gtI02OmVAC1eKznCNtQDenqT
	w4ocxw7A7pGRIcWDcR3+dFpIvT3l4PqfgNkhm9eczVZrD8tP9KNweuUJ4R1uz8moqr6lSYRyI08
	zkFqYF/fiWfmhGPlZD0UaYGYViBXJ2Ava5iBKvVsziGniz+61km+RXuo/bm0je80Dlg/kX0ukTy
	rYebCvAgSwiqwPvNY/qQbiBYeTvF57/q6PM6/NDftzMlCpER6DgkZ0c6Nwh4Lsv5BS++uCIKtPN
	CJIwGO3/tpVp0YBo4UvQrJgSuvM9H5IS8PLUqw1obgTv68vU9oUYHgiNTV+hiVhqPZqCmvDIvrk
	ngBakmKkQfjGL8C9C
X-Google-Smtp-Source: AGHT+IE8YXW1bqh82Pv83CqBL++4EorD9wKI8kSNSxyaHaZobY7QUQj2BR1bXjAEiGky/6dYa+2+odrIWp7W
X-Received: by 2002:a05:6512:131a:b0:57e:ed2d:190f with SMTP id 2adb3069b0e04-591d8598d06mr3612400e87.7.1761174820409;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4aa2259sm40463e87.0.2025.10.22.16.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 86E1B340283;
	Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7A5DAE4181C; Wed, 22 Oct 2025 17:13:37 -0600 (MDT)
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
Subject: [PATCH 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Wed, 22 Oct 2025 17:13:23 -0600
Message-ID: <20251022231326.2527838-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a io_req_tw_func_t wrapper function around each io_uring_cmd_tw_t
function to avoid the additional indirect call and save 8 bytes in
struct io_uring_cmd. Additionally avoid the io_should_terminate_tw()
computation in uring_cmd task work callbacks that don't need it.

Caleb Sander Mateos (3):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  1 +
 drivers/block/ublk_drv.c       |  3 +++
 drivers/nvme/host/ioctl.c      |  1 +
 fs/btrfs/ioctl.c               |  1 +
 fs/fuse/dev_uring.c            |  3 ++-
 include/linux/io_uring.h       | 14 +++++++++++
 include/linux/io_uring/cmd.h   | 46 ++++++++++++++++++++++------------
 include/linux/io_uring_types.h |  1 -
 io_uring/io_uring.h            | 13 ----------
 io_uring/uring_cmd.c           | 17 ++-----------
 10 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.45.2

