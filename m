Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80D3F485E
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997257; cv=none; b=OAjpQiwVMqZVaNZg8GKG2KEDaEEx6KC28VbO+RsIvfv+LHAhYvjZw0+aIi6SktAx3uI3RQLmKLRIll93QeMD3F5ECAPliG54t6cq38w6Vf4bPuvmHjj3gKRyp5c5PfKaoh/TTSi8lEUXbDzmwQzOhJr7sJee7seUd7mPbgTXYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997257; c=relaxed/simple;
	bh=b2df2aXNGqCs5jCIHwWB1+oFvAqwoJEyzyCztqI+mL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0IW+Y7GAedjinjEOFsadc5I88TMRErT6X/EKAku8lAi5sBQOGZUD/o3KD31Ahget54igKDce8oKbcZlBbiIVM0iBnHP7jBaJW+B/8ZerSsSOkKNOh72PYQk/Z9aUVZjV0I+UvkTKG1x7MbS7jU3vDXCtESHnw3K87jcmCbO968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtHMnSUI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtHMnSUI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso41178755e9.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997254; x=1792602054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QOBgvIN3PYDY+cIEwUK+qMtv/Bkt+tCopG81B61mV0c=;
        b=NtHMnSUIrejB+0TEyEYzbzaXlRA8ZBc357ih6M8+41Kr1b7juTmoqTHVmie8x90t+p
         rFQohpP/I6kA54QHf/k5mFZ6SHyM4Ax9qJqSw1yHslJvdGZZTRuoLihXZ0PDXBHqK7ey
         E28vIwlgqQ8XS03n5bEbEEiSjuFNWorpBOOo4nNlKiZ8lpvUr4ZmA/lt9l9GDn0ZZ/m/
         ruN4+1uGATSQOPeOFci9DbMfFgO3hlcQGVuxeste42JYRP+JIOg4Nw+IP70u6EkLhb6G
         zqJSfntXWWDsdfYDMYs2bApVh1uJvADhKOp8Ya8QJ0GKR4+7m+EZ1cqWkYgsGPD8HHqB
         nd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997254; x=1792602054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QOBgvIN3PYDY+cIEwUK+qMtv/Bkt+tCopG81B61mV0c=;
        b=ydgauXFcHEgOf1C/F2Q7GUMazI1JEHWw62f4Z1Zh8b3NDY5bWBJ7SX4PaJwDn6FQUN
         HN85VVM41+d8khaIiYNbPudXknTb0OVVSSIIq57WskFpM/TfblrNykHsJNWaHMNDZCj+
         I1k53dl7UtGgvpRY3mO4TINM/YHh3tPMbME9YWYvhNjICdiYv8KbZSYsqvMdG1t982Jk
         Qwp060UHT3Gh9hfMFe/wU1udKxg5+13du7n06zs+RMM1vcf3rlYeOx5m0Lca7qj0IEKh
         /wVxR+seYfjFro5AABYtsY6OedSZeuZuIz8Kpy7UE2taXkZiIbCcjwFkYCiDUjj3YwvW
         ps3w==
X-Forwarded-Encrypted: i=1; AKwUvByYqBvD+nxp/V4zcdGqWPvMv+D4e3G9C4HCQ3GIUS3V0+ycLkl4Jt5oIIUwIVDBo4NqrZzDz78YeABdnw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLSfngjl4qEofh/oyBgJjjmjVJcNT+Eyo4+XhfMQ7C96wvahPi
	VbD/9a+GsOnSxS2maQfHYTdOqmo0amRIa5jyzGeQeQnoVi4A/t1BDiJu
X-Gm-Gg: AYBFou1J5XxonLJtBt/+SJoAN/N6d3chN/WVilx8LcQsPd39GjWBT7eWfWqeBWSB7ya
	0WGDQ9EbVrnF+gbQ+LuKL6JB5it1S9rZxOyKN82lmpbE5ejqhS2xcJaggMgL8UV65VVLODuPbyp
	Qes5AJyclTy7LCBQ13Ef0AjXzZ6x0MJRTmjfTjpysUe8gpQf6si2t9Oh7LvIH4lM1r1av7tzBOl
	gGCQgsDp+1y2vFb+TofU4xiJ4Ki5HGA/Ni9Z47e5KFNAY0k54n9RxeY3daWeoOLX3frzp6Jklfd
	/D2BTKmaUyN91F38Fg5pj/jI7CCfVCCu4gzJK6rGhxfk+YHJJbQAFeeDHku6yKxY0OpNttsJGYN
	2P4nwS+ThVCdwQvDC4fWfvGTiZOU8ofVXiieYJX+Y/BXP5z9g3Vd6prpjYaE3+iYdBHrutAbwhW
	EJkHymi1s3FGEiiN+PWe1tvn5wkWjEu7xFXBCHGijZYND0MBscipwbyNvYXb3eCrWh97ZSTSJwd
	BKJhpQGBRQBvEtd6dL+D6ILPE38WEJy8tVCvOfhqT1qsw==
X-Received: by 2002:a05:600c:609b:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4a18e4ca1dcmr313482265e9.18.1791997253716;
        Wed, 14 Oct 2026 10:00:53 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:00:53 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 0/4] nvme: add nvmet zone report and FC regression tests
Date: Wed, 14 Oct 2026 19:00:37 +0200
Message-ID: <20261014170046.2516-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression tests for three nvmet bugs fixed by the kernel series
"nvmet: fix stale data exposure and ZNS validation" [1]:

  nvme/071  "nvmet-fc: only send read data for successful commands"
  nvme/072  "nvmet: zns: don't leak stale memory in zone management receive"
  nvme/073  "nvmet: zns: reject a NUMD whose byte count wraps"

The nvme/072 fix is already applied to nvme-7.4; the other two are still
under review.

Patch 1 adds the zoned null_blk target setup, cleanup and zone report
status check that nvme/072 and nvme/073 share.  Patches 2-4 add one test
each, with a small C helper for nvme/071 and nvme/072 where nvme-cli
cannot express the check.

All three tests run on every configured transport.  On a kernel without
the fixes, nvme/072 and nvme/073 fail over loop, tcp, rdma and fc, and
nvme/071 fails over fc, the only affected transport.  All three pass
with the fixes applied.

The tests take the next free numbers, nvme/071 to nvme/073.  If other
nvme tests land first, I'm happy to renumber them and resend.

[1] https://lore.kernel.org/r/20261012141239.156408-1-parri.andrea@gmail.com

Andrea Parri (4):
  nvme/rc: add zoned null_blk target helpers
  nvme/071: test that nvmet sends no data for a failed read
  nvme/072: test nvmet zone report initialization and length
  nvme/073: test that nvmet rejects a zone report NUMD that wraps

 src/.gitignore           |   2 +
 src/Makefile             |   2 +
 src/nvme-sentinel-read.c |  89 +++++++++++++++++++++
 src/nvme-zone-report.c   | 165 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/071           |  80 +++++++++++++++++++
 tests/nvme/071.out       |   2 +
 tests/nvme/072           |  68 ++++++++++++++++
 tests/nvme/072.out       |   2 +
 tests/nvme/073           |  46 +++++++++++
 tests/nvme/073.out       |   2 +
 tests/nvme/rc            |  61 +++++++++++++++
 11 files changed, 519 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

-- 
2.53.0

