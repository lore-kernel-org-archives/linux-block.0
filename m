Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C027E049
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780765460; cv=none; b=iAS6H6aTguhQ5CkVtnGKSoIO0kaQl+adJlWrEzubrh0R6rqLjKjqyieBhHqY7jJz2nEBp+atLR1rft4m4ToDnchQ2Z2hQxcPnUof+LvRfOxnVaQGRGDQcFeyr8p+zJm9+0ku+een+vORz2yNl+GE6f6z5CMP5fGtGrHvXaL+tqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780765460; c=relaxed/simple;
	bh=q2NQZY+epqVHr2W7oOJcKG76cTiGmU8+/2BHRpz2gI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7dgpPCy60rfmmDEYLKQZAp4kQhWxsKw94Gs22/MOoE3CCdrwhjYQRgK/DZAwboDWBilOTj/b7zk57EMI3p1QI/oMj1t5KH2Qnw+iiQlflLP0ln2V6WKpU4dtBB/l+/0QNIjBPSmyjhMowceFwmlEZqjN2oiebOwYULFYO0uDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHO3P2AQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHO3P2AQ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ce9d444173so36645236d6.2
        for <linux-block@vger.kernel.org>; Sat, 06 Jun 2026 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780765458; x=1781370258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByUZh0lFBgTCiciJpjsG9ZXS068Tz2mmn6cEtLPjSXA=;
        b=fHO3P2AQWwXQt7pnhvIBf7F4LozVmvF8zHul+47XYUemaHbEReph1mDRFC82mya1wn
         pH+FXJar6/OtJO/MKnDLafHXxJoYRUkiBmxAMhP3L0QSZUIpTd45i8KzsjwfC1BV9Kmz
         J2lOrgbo5tCZszqjd0q5Q72z8wTed30ow/sDS7bYb7ZwVXcXieoH67FWPBiEV83dtax6
         L9gG4Z/ZnXriIVSeHrdRBOaDW9bxrTnHRT7wohsfNecXMlsAU518zLELmXMHzwdhSNtL
         LHDMlktxMYZCZ0ajFkEl8mAAhWVf/hCviZHoZak1JV6pfTbmp+O1u2QuV3lmK4L41LeJ
         yRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780765458; x=1781370258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByUZh0lFBgTCiciJpjsG9ZXS068Tz2mmn6cEtLPjSXA=;
        b=qnNhUsUld/ZRSPR+MX3fodg/bwC4NhUA/Liyqwq0cjoUYO2m3kmrbl+E2YqrTV6WWb
         crgTQnr9GFAp/qnPWdMRh0YghMN76bsKPaSLZFs8LmBxX6oF9Pd5xNYnwLRhyK1OdVAs
         XnWndzmWUqeclWdLmcpR0kP/2rKNLtvaKlAZ8K8B31t5TJIpRtojMhKCvRde0Hc85N5r
         qQK+VrSmz7EWO0MrUItPl2TJVkZtgSZuEHNRX8cugPHsmFLCDJa6Fam/hVomTAjxZZo5
         QPo13U5WUjph7LeNPcV8UtWCd5y95xfObEwX7SrYBzrdgQB3wBGDzoHDMEff0sOutVBm
         K2AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XVGcMSOc6fIbm558WRuDRggKJqGPue866jOsCQn8qb/HqlfvpVvzh/du8vXUSFxdd6xPk//daPiyHdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3CwPOFOvyvLhkbPE+80otlo6BKr0rPF5Jjd32QJvxI1TfSYq
	glhfi1RSpGXIU2grv9lChEO5Jiu55jgZduCnossxODtRu70zR7PHvQvn
X-Gm-Gg: Acq92OFlZMaeRmuaVfyEwPudP1v7JGw+YSyMwrdn1TS9CyYEDWbFUxG3FJCxEwRyaIX
	F2fS7RW1XTjHYPkpTV4jIGL+mipMsPAA8SqSkYW/o4nnn1gjii/0X/ojZgDj4IfWhW3EGzIT8VH
	U/4VgigNzMoJgwnIjSiMPW9LV3BOP0XeI/TLBw78e78IDKT9X+fqG7e291QBpvcNavvGErnAYTy
	lJUG9XlLcZTANyqubbXlb8Eidi2lChcBB9es/FcDyx7gFzvIFlLEWm/pp2ZBnVwRO5K1rkkuGID
	fZUTXneOhJkcU31zkah+hMum/XqeKim4T9iRvEs52BvzepOOVGDX5/FbbuXYt+16OEyblrHfPx/
	KrzsWxnP5eVKwfsGyi+v+feCE5PvmfXWEbYVJMJhrT2taVVGa+C/YUuuK4Vxl3v9fMDnRH2x3/z
	PYsPydLr/ogKrvi8+xfs0uI4fQUJhwVR5FRWQF6cssrM7vckO/4zBJIvFo+znDCvdFQ1YI0Eh6C
	V60uZIMoqDGtqJ9Sun9s8GqHnBItBA=
X-Received: by 2002:a0c:f10c:0:b0:8cc:ee52:3e60 with SMTP id 6a1803df08f44-8cee5f99418mr119842996d6.3.1780765458414;
        Sat, 06 Jun 2026 10:04:18 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm112977966d6.5.2026.06.06.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 10:04:17 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-blk: clamp zone report to the report buffer capacity
Date: Sat,  6 Jun 2026 13:04:15 -0400
Message-ID: <20260606170415.1523660-1-michael.bommarito@gmail.com>
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
 drivers/block/virtio_blk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b1c9a27fe00f3..d50aaf956d558 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -689,6 +689,14 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
 
 		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
 			   nr_zones);
+		/*
+		 * The device-reported nr_zones is untrusted; clamp it to the
+		 * number of descriptors that actually fit in the report buffer
+		 * so a malicious or buggy device cannot drive the parse loop
+		 * past the allocation.
+		 */
+		nz = min_t(u64, nz,
+			   (buflen - sizeof(*report)) / sizeof(report->zones[0]));
 		if (!nz)
 			break;
 

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

