Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B9318B96
	for <linux-block@vger.kernel.org>; Sun,  7 Jun 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836536; cv=none; b=US/DgJVjlJC+q6aRBd0QTA3V/CCiX3gY0bWLf4IxS6ssd5O6+0jTD67GDzb1pUJ0ZLl7VWycfRoUF9O3Dk26q9SX0tSTq4QuMIuoNt3Um7WpW6YCdJdXGahzf/m6qDCbIkYc5tsWA4uZdPjYxrJac1rdy8k7aU+ORYTPZVeLfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836536; c=relaxed/simple;
	bh=BV6AJGuw/xsMgOxl9SY8FG8RrXLJqtI4CTPX962LxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7GzGu27gWSFofC5sERHT812ZxK3h2pE3Rg8T3us6Rmatq2C7Cj0Uz8wntfqAST+2SWcu3t+H5QG5oO/Jv+mmqMH0nagNRrQ9BNPpHr2RszPmYapN93UnaT0XHyP0Pkc5E3tmE9tVv6812Cx5TfVkoqc0eR5pIuRfZy+ZP1TCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+Rm8057; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+Rm8057"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9159da9bba5so243619585a.1
        for <linux-block@vger.kernel.org>; Sun, 07 Jun 2026 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780836534; x=1781441334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/ItvRwkdkhyOcV5EUqgABZkU2mcEZg+Gfh/gQJ+RwE=;
        b=H+Rm80577V2mT7liD/GW7V4S4nALbuDogXu1A3Z+7tEY8cz+zKzCRa/Rn6n7Vu8dHI
         16o5y52rbkuwE+96g7ouii5oVrD9KgufeysqXGbtagbJZS3ASOWlbqfea4Rf/78iFrGN
         ViE+zJcNETsUcto/d956/e/SIfYt6lVLiayxD+qiJ8iz5iJXBBRgoWu2mePMV3XaU4S5
         D9zZfNYDEA+TXmKezkK0cRhoiPtc57LZnQoJfBFs+XETot/d7V2I0SlkrwvuTbM36vCY
         vxOjOEwsqXlFqk5xhTFB5R0nWsvM1BAOLu4WqCo0YOcWjmeZLzPxTIVjsCiw5Sth5CnA
         FaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780836534; x=1781441334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/ItvRwkdkhyOcV5EUqgABZkU2mcEZg+Gfh/gQJ+RwE=;
        b=kWPleaorDvf3b6O/fEC8hv1aYSLqN815KzmT1MwOaRJdtWDAzdUuRIQuOPMUUkmhtE
         puyq52TaEN0XY8OOHFBRoWk44L9EsR0+Qgc02wWqXGvkdNAuxVI/5M99lf2Xt6DMnFI6
         e/4/A4gRo2IeMrgov+2RHlAYh5V4OY9BfCMpKJRUY5aczw4J+iQR64LpYTtsXi/S6bCU
         Fksa7oVwnyFKLAJNhM3gLoDDFUbxfO7MHAJl55PiL4heY+XTsN5KAOWYKVj6lpZMxrFW
         L8GlQh6SKrfPk0BF9vh3JkcNBCN5Xk6He8e2WxMtAAzr+EyMzuWMPj94LL7amGYg0+YC
         M65w==
X-Forwarded-Encrypted: i=1; AFNElJ+6L867AhanZxHKHDjbIbfFK0urLWErCHU5xISYTTcFWjAtE+CTopUs633pn2DEIJIqpuFCYUWSlBRrzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeG2Hl9R4xDPuAp/46+406qe2Dns+McbQ9A2TJCHmvAhIcbTEc
	ZYi3KvTR9+KnOPUN0Ar7E+JGULcGlFLvr6Beb021jZbtnT39YlEnV2tkUCdZYldqoGw=
X-Gm-Gg: Acq92OHmnTcbSPWtjLzne77Wb7C599vUu2UfCN4cLk7442D3jCvJNRwMDsNSQtLmlkC
	692a3x0vL4qggWDbjPkzGQpoDF3iZrTEJcZjfRWug2CQKNlxmTCKRzH1RRqANfCpEVyIG/kKIs7
	AxTmRJMfATqlwyBqy774Wk/VnS9dwLQsh8qbmuyaypXtYdMqKFSz+w0U+Fudx8XynKiNuYgbvj5
	5ipobfbSSUwJTfO0KS0GgK7JUFt6P+T2g8jFrnfSw+vq+s3S+7gT1CIYv5KUuLDvq7YtZ5B3z3D
	+Y0E2TzNoNw6JehXbUQXSyUs052grJ2YPBaaeTB7doc8eTdqg1ABcrfZyBngZ8nqYkqwzY58WUb
	olNMRVuHmZcojc2cfJiMXGuklgImPmiB27NkQHog+ayCF+1OsXRVN54WKdaSob42mky/83GWjMP
	ZZFlP9hD7X+40mQPnqZLnGWTzlFnrV9sFhU8sH6Qr54e1mQIs8XjIIKHL/tCt+WhHRbsvge9Rws
	LsaPqgHfh9QkLmjpvBIUM2lYrZcCEE=
X-Received: by 2002:a05:620a:1d01:b0:914:bb8e:915c with SMTP id af79cd13be357-915a9cac9afmr1892160485a.22.1780836534090;
        Sun, 07 Jun 2026 05:48:54 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cae4sm1419467485a.29.2026.06.07.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 05:48:53 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio-blk: clamp zone report to the report buffer capacity
Date: Sun,  7 Jun 2026 08:48:34 -0400
Message-ID: <20260607124834.3059944-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

virtblk_report_zones() trusts the device-reported number of zones when
walking the report buffer:

	nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
		   nr_zones);
	...
	for (i = 0; i < nz && zone_idx < nr_zones; i++) {
		ret = virtblk_parse_zone(vblk, &report->zones[i], ...);

The buffer is allocated by virtblk_alloc_report_buffer(), whose size is
capped by the queue's max hardware sectors and max segments and can
therefore hold fewer descriptors than nr_zones. nz is bounded only by
the device-supplied report->nr_zones and the requested nr_zones, never
by the buffer's descriptor capacity. At probe time the request count is
unbounded (blk_revalidate_disk_zones() calls report_zones() with
nr_zones == UINT_MAX), so the device-supplied report->nr_zones is the
sole gate: a device that reports more zones than fit in the buffer
drives the loop to read report->zones[i] past the end of the allocation.

A malicious or buggy virtio-blk device that reports an inflated nr_zones
triggers this during zone revalidation at probe. KASAN reports a
vmalloc-out-of-bounds read in virtblk_report_zones() against the report
buffer allocated a few lines earlier.

Clamp nz to the number of descriptors that actually fit in the report
buffer.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: drop the explanatory comment per Michael S. Tsirkin's review; the
    clamp itself is unchanged.

 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27..32bf3ba 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -689,6 +689,8 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 
 		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
 			   nr_zones);
+		nz = min_t(u64, nz,
+			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
 		if (!nz)
 			break;
 

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0
