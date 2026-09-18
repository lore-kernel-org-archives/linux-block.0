Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0E342CB2;
	Fri, 18 Sep 2026 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740413; cv=none; b=rgzwkCvD7drkOdgMUGnNN2cDf8vVwJ3TbgL75CKZ0f2F7IMT+4KwrcGsBGVCJvjvibdmbU/krs4yWQpyGqZjN4KdBDQWlQB2Fy6O1YXkqK6wJdYtLJxZetHfSQlrXimkm5d/Ysjg4eRt3umb95eYz0NhVBja3KUq71kwQMQVXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740413; c=relaxed/simple;
	bh=XH01LQDrSeTYNcZ34jKuemgPhhisqKELCndQNzF6Qo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puEhR65SMIhQmJ2wsd9X1676VlP/qovg2FSoHrABCgKmaIGA2MKRfk2bXSL33NoSI6GsZvPIHKw9N7wIvDhYVsgWVCFQfV5yRZQZ9ikTiidwFf+Z+oQZLhJeYCYQpSEr29nK5gZ0AHS1BwP1vC0Svz/CVTdG9Ad1Qw+di7jmVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLJN78un; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLJN78un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F51F000FF;
	Fri, 18 Sep 2026 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789740412;
	bh=GTKWs0qfHLo3fEKtqsDO7a7gqF+SW8Fr3qS1h0YFepU=;
	h=From:To:Cc:Subject:Date;
	b=aLJN78unDeK4qGhWNw9uHIR1EihNGzOoyf5vUZeUpbVaVUo6Dz8tsf+Yf+29eafjF
	 zRTzU/KJCXmTfhYJ2X0WXhp996aEVxyGWLf+/u48ifoemHDJQ9DbXdKYaA5YkxTko+
	 mhFZ//OCRHv7Jkk47mpnXj8bUMT2CCBFua31p9VfYqemSBnt7DzGRyWD/4oPzE84a2
	 0OX76mri7aJuJ8MfRWK4ZZYI90jNcPonCJItBAmQFWazmdQlbS1za8YM15Pczl8WuX
	 aNKgS1kLq67iY0NAHIorRNg3HfSxy438AsPhb/dhoJYoUyvWLSSfev1RiRiAEAPmAp
	 69yWWSY0Sd4nQ==
From: Niklas Cassel <cassel@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: set the zone write granularity
Date: Fri, 18 Sep 2026 16:06:42 +0200
Message-ID: <20260918140641.2031075-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288; i=cassel@kernel.org; h=from:subject; bh=XH01LQDrSeTYNcZ34jKuemgPhhisqKELCndQNzF6Qo4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLWuhZeOHgiZ+a5/yvMz3/K7jUMDIzbrVPQIqLzym3ft /OP+zOiOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRt7KMDE9P3pi0YpbALMa/ s5wzpz7vXJ489+4EJ9U9ahOZJ0/m5+xmZNgc+nYzP9sJe+6fC2c5h65QcZ7+Xv3LwZtrHzfc8jp 34zUvAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

virtblk_read_zoned_limits() reads the write granularity that the device
reports in virtio_blk_zoned_characteristics and assigns it to the
physical block size and to io_min, but never to the limit that is named
after it. queue_limits.zone_write_granularity is left at zero, so
blk_validate_zoned_limits() raises it to the logical block size:

	if (lim->zone_write_granularity < lim->logical_block_size)
		lim->zone_write_granularity = lim->logical_block_size;

A device that reports a granularity coarser than its logical block size,
which is what the field exists to express, therefore has it silently
reduced. A 512e host managed disk passed through to a guest reports a
logical block size of 512 and a write granularity of 4096, and the guest
ends up with a zone write granularity of 512.

bio_split_alignment() returns lim->zone_write_granularity if it is non-zero
and bio_split_io_at() may split a bio with as per bio_split_alignment().
This can real to the write getting rejected by the host drive, as the write
is not aligned to the physical block size.

zonefs also takes its block size from bdev_zone_write_granularity(), so it
would incorrectly use 512 on a disk that requires 4096.

sd_zbc_read_zones() sets the limit from the physical block size for the
same reason. NVMe ZNS and null_blk leave it unset, but the fallback
gives the right answer for them, as their write granularity is the
logical block size. virtio carries a separate value that may exceed it.

Set the zone write granularity from the value that the device reports.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..c8bfbf8435ac 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -743,6 +743,7 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 		dev_warn(&vdev->dev, "zero write granularity reported\n");
 		return -ENODEV;
 	}
+	lim->zone_write_granularity = wg;
 	lim->physical_block_size = wg;
 	lim->io_min = wg;
 

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.55.0

