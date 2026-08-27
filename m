Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD64D8DBD
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857067; cv=none; b=chqZixGhq5F6McmCHqgecPzeF/Fd+ZvhokwRJO0HumIIm/YCunRA6kz+p9cOLD2VKXOnvocHG5GWz9EC/om/m4YmwB3ufrKZ1dVChpeZ8wCaKCpM4OQ0AYB2kiYhbcZUmP51UsloTfjeBDRVQQCyd24BfRIH9Jfp3t/as6fPp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857067; c=relaxed/simple;
	bh=LC382L91Fjmkvg3DzrJyfTe6xYWA++BUDclrQpsPZnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEmH+wtEjfwiSLJT051ep6dw6OdbKZOCJiUU7xatyy4UrcA3iBi1OlRpABAEbk43aeeSn+VoOL3rQAoGNQOXSKxVJg5NIjRaz/XYX8CAdgnV619/wu7sXoqzaWiHlV8oy0hHzl3D8XirOXrFKqwQk9uEEj0wU/KfO1QkH14Z18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aosQXsxG; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aosQXsxG"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5c63c4af822so12339e0c.1
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787857051; x=1788461851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i10FjmX67zefyeXKozkB0Kmfyho0gXqWl4rPPjjJZ9s=;
        b=aosQXsxGzXAlVch2OV7h96Ps25/3SQ5OcOfmOjiAnoQPNuimPx4xO+VqRcS7UjhTCv
         yp6oKwGtfw+Kp8COsFuceOxA1VNLj0YqS+zVDRX/J5SlNGkUezoPgoqV0imVXUwS6lmp
         Zk3AiSipFgKtCkTCzF8NszkcjOwJlY5SMcbmjQ/sWxCLdBzjXb+ZqMxHj9PCoa/sA0v9
         syQLejkZj2JoUKRtYkczz9dnbSdeb8UqCrSI9xm4TXWs0uBPOO/80ctDd1h/EtUm372q
         A5KD7XSHQRmQLSPp1d+O6jSmgLU6dNmAFO9V6gEARJ4/YVUkqMusr4yW/sIQiulkX1YI
         ih8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857051; x=1788461851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i10FjmX67zefyeXKozkB0Kmfyho0gXqWl4rPPjjJZ9s=;
        b=Gfh+h7KSTAnkvKytW4CcnTIOUUiXLpDc/4vSkRycEm7hXpIG9oN7h44OY+QLp4u6Fa
         EPIlhhSpNWdA+ybdh0NwSKnphkcOAG9xmTga3GFi73EZKmWAAqF6AH2viGPb9BncLypl
         uAyDTHq+VGk7mzCEhjYUvjR5btC83DnMUB0Vx0iFTGzX5knEDL/au8YNCAdrw23Me4Xf
         yTREDMxF7Q237s86/D3qRiEGv46A0Swqw5Yk3P3BT+RSwtsWNvZGXxjh00HlscjIZj3+
         k3mwZ/Bs1LcUTWaC98ENc561G5CtoOvFXH/mxrQaNdepUa6Trh0WP6dihCW9R4uLNxG+
         TvYQ==
X-Gm-Message-State: AFuF++ky+rX6/A+Cm6t9xD0he+dEyk55sQIS1g+Mw6MfQorJ5UQopzm+
	d0eq1yBAnsxCbgRL0Hh9qM17rZmpcF4y4t4EHwfzcKsN68Nx00jDE3SfgygplOJOPvieG4RY3fH
	WHGBZh1F0z9NhYnGmc8f01ujbYjjkuarYoZxMefj01Qe0ggmc2hHO
X-Gm-Gg: AR+sD13Ebxd6vkj/K33NXKlm/inpH0MpH4MpJRcY+wGV7YfinOsMTrm8jkStMLuiM0a
	aI1/55slCqpOrwZQkw5uDkUut1iKaFCy9WvwvHfJVkKH+25wTAY+xs1tE3krVR4KQEfsE6TaJd1
	KN3nKJJwLF/OCm/gdaGcquk+ifNZB88ZTM0QcMx1/f1g2+YohQt5orIK03YpLp5Wl3aeNxjuUeq
	2lp6+7ZnuCIXs1WIVH5zFP8YgxcbfoJarsq14ugPYXGPtNvdeBxNfvie/n0SbUZHqt+4pakyo07
	h6JQfeW47hmDeIv4X4T+a9+BAHIK7PfndWfbtD63/WdjWa7pLCvPpGDX+l4azQSnaKucIvAr4Lm
	D4Utg3hf6mzuQL22A
X-Received: by 2002:a05:6123:593:20b0:5c3:a1f5:7569 with SMTP id 71dfb90a1353d-5c680feb0f7mr218849e0c.1.1787857051036;
        Thu, 27 Aug 2026 11:57:31 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c6600147edsm1730496e0c.8.2026.08.27.11.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:57:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 64D774013B;
	Thu, 27 Aug 2026 12:57:30 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5A653E404C2; Thu, 27 Aug 2026 12:57:30 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] io_uring passthru: set result on blk-mq request completion
Date: Thu, 27 Aug 2026 12:57:19 -0600
Message-ID: <20260827185722.3234622-1-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring NVMe passthru currently receives the NVMe status and result in
the blk-mq request completion callback nvme_uring_cmd_end_io() but
doesn't post the io_uring CQE until the io_uring task work callback
nvme_uring_task_cb(). The status and result must be plumbed through
struct nvme_uring_cmd_pdu, taking up 16 bytes of the 32 available.

Store the status and result on the io_uring request in
nvme_uring_cmd_end_io() instead of nvme_uring_task_cb() so it doesn't
need to be passed through struct nvme_uring_cmd_pdu.

Caleb Sander Mateos (2):
  io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
  nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()

 block/ioctl.c                | 10 ++++++----
 drivers/block/ublk_drv.c     | 26 ++++++++++++++++++--------
 drivers/nvme/host/ioctl.c    | 19 +++++++++----------
 drivers/scsi/scsi_bsg.c      |  4 ++--
 fs/btrfs/ioctl.c             |  3 ++-
 fs/fuse/dev_uring.c          | 15 ++++++++++-----
 include/linux/io_uring/cmd.h | 29 +++++++++++++----------------
 io_uring/uring_cmd.c         | 34 ++++++++++++++++++++++------------
 8 files changed, 82 insertions(+), 58 deletions(-)

-- 
2.55.0

