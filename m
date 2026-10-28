Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211280;
	b=0bIOvynwYnW4o4Eu0y4d79BO3lJ/6EEV0AXRnQIbwvFvJFxBKdv7f6dMztB2uKd1Fonn
	 OsaoKe3tts5H/xRDHBQ3C8JknLe4KaP8cMkVDteNKo85OlywdwVZx3KiNcku3zdEB0czh
	 +lUR9IewxDeDH1Vh1xTBsXtiAQwDDab+e+8B6+xThFULNezkh+xbWNb935/iXNyMd+zr7
	 HaV0CSKE3gG3jeSrIzgt90odE+w/5oQp2bMDnGf0wLygi6dNaqVfTkamnJWay6h2BJLNQ
	 bDUEUv+UDduVqv3gO7cFxg0fV2zeiFexqt4w7YN94LcnY7OE1SZljaFFHvx9j3eC8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211280;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=;
	b=UjUGSmVsuHZupcwtT4QkqKN07REYjkb02oI4JkYtsEwJUMBoJHrnjtyo+AnOyYeUVpZQ
	 dmlMArcnXp1dpo0G8Oyzcl/yBTtbCWvHTMot1Q8Bu0cCUFSDBRdjTEFM55TbzZuohpU9i
	 N3g+RAXjvat2SufXv5H5pxtSa1PnrWs1xZu7bET0gROCkQDVcTNiTGfJqC+WXN3DLoXia
	 16kiXE6wUzGg4XoXau14RqUs2Vi7RtHd1W9bu2nl1wAyTKsQSvrAqvI1KLB6kxOuy5x/A
	 E7HhL2tM5EybwrfFxctetaFxzCCWvRNDueH/hqcnc/+r3rSi0lzpiNJpIf8NLIrZphA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WmO/tqEL";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WjrjWl3a;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD260A3814
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 18:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FD260A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WmO/tqEL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=WjrjWl3a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793211279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=;
	b=WmO/tqEL/hbMFTY3y2HdcMqZfEGi3+PVQ+wE8PeQ1tHCpHN99I7FTsM6TKeMz9x/xx8Ucg
	1NV4oZjleyNNVILd233mbF0yOcXxQrt8kknX0kT1sKutQrcMMkGd8S32iMz7h+qkgkwJfI
	ZLT8a0yyDAAk4XeyIaVDFkjRm4tvbOs=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-6woPNYn7PF6lNjIjgwVyTQ-1; Wed, 28 Oct 2026 14:14:31 -0400
X-MC-Unique: 6woPNYn7PF6lNjIjgwVyTQ-1
X-Mimecast-MFC-AGG-ID: 6woPNYn7PF6lNjIjgwVyTQ_1793211270
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2636235eec.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793211270; x=1793816070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=;
        b=WjrjWl3aYwUjX0D2cx/jSfQHkockQt0lS6u/y8/Ew0ZMbZxSzrRRmYNdQ8rqPa8+ZK
         jhbmlDr7hzPKY85XZJdFu8r7x72fir3JoS+FdNt6ndEBxgjIGsTfnt/GtzcoEMvogdLt
         2qTQbyNfsNNZsTNTwZpJPSRdKXJYUnSIaU6aN9YnG8r4UfXzVdslaUWnjD1gV/U1hmWk
         N7jgXNToIkb2SgfnhrMIjMGYCYKiUKz/zzuLmqilXKtvy8K6IYNnOUoqBCehEyF3K7CW
         1ZzyaPuOsx9gahDQLwwp/aZ11KkfDKXeqQCJ0tGf9CjxNJpy8RrYDdaFkHYPXA5xxWWI
         RhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211270; x=1793816070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZ1n97WIaS0quFafvxQMGHq1ybtUxrApBPjDUdcn/Xg=;
        b=rc/KsCpw8w7JHqjWl175cMW5K4JPYfY82EnaRNUt5ldumevF5DKySXjYxy2ZyvuDh8
         vzbeWENClLxg3jG+lgbI27wWegfxHziESKFAwqTyYgJbn875hVU1w5ki6CBEtaDZ2E5M
         goyzkZsaxlrBKQpKmOUXbNBkbX27KMwuUjl+jYQpsjtmUKzxT00wZpqHPO20ZChaJ4jK
         bXoqSHgc9AeSUvDqP4Mzdq8nxTGdkD5ceCWqUJq6wR3D950MtLDgd6LLYtvUvACIM9cn
         toi1tLaUkIMQKOian1bCeMxlal9hXqT1Q+Sl8SVGdeQp6M6tpklwN5F8eKOPntzWSAmD
         Zt1A==
X-Forwarded-Encrypted: i=1; AKwUvBxd4OSJ5O9A5tvUVsx3cl97oeZqv/NmfgCG4hcGu7aHlzYOPuS9201Guvkau6mjIlrYSb46tWGAg4WJZw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLo/TE8pIFv88hxQdF5nUoqPLRmAsbAJI9arTS8rHwDVknSdAVP
	xRvIsPA2DlJrEHPvXrhwDVMWwPC+Gy6eQR2fkNmPWDCKJ0pHdeo+VwRVHs+S+KgqxpQ/eHj7yz1
	ugjhKEstkLT4nz3BKdNVn0PrCkr+EN5ZYBOB+RWyV3WrHJ1faU87JzvLMAEbj3Vld
X-Gm-Gg: AYBFou3VOaaYsI1liDNcbSH2iE9Un5uXLaNOIYwT8pA+2CoYGicYfCYpEhYJnTqHJqI
	NcWW4tO9OQIMPxK1iy6hbcIkiA/wBq92oISt76ZVd1KejBQADAsj8K/ucE+QE5xp+vAUc6i8Lpz
	Z3UnygP6tHBVIg8agRlFsnvK1O22kfpHqDg6uJbrGMzNRLzIwFbqfep7ke6exwUGWwLjKjGZLF1
	etF+a9Tvt7DsqauxvNn7WKBEjP+D5Vi0RBYNPCP1h+dP+ZkkcNJ+py26FsTw80jzcbhP1ykTmEt
	DnObxVFb0iLhj2XetYI8ChLUQgO3msPJYDq85MGd9TSgEAOatv0n/Cu+SCsKA+clBxRiDvF1d0M
	0OT8aVJMdZZXcta4/s+qbkUq35xL6eDEmw3R2
X-Received: by 2002:a05:701b:2414:b0:19d:81db:1ec6 with SMTP id a92af1059eb24-1a6cbf75087mr3886291c88.14.1793211269649;
        Wed, 28 Oct 2026 11:14:29 -0700 (PDT)
X-Received: by 2002:a05:701b:2414:b0:19d:81db:1ec6 with SMTP id a92af1059eb24-1a6cbf75087mr3886246c88.14.1793211269001;
        Wed, 28 Oct 2026 11:14:29 -0700 (PDT)
Received: from alpha ([76.166.245.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c9fd2b4sm7438411c88.6.2026.10.28.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:14:28 -0700 (PDT)
From: Kyle Bader <kbader@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Kyle Bader <kbader@ibm.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: only fail dma-buf bios that need block layer PI
Date: Wed, 28 Oct 2026 18:14:12 +0000
Message-ID: <20261028181412.1919506-1-kbader@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Bader <kbader@ibm.com>

Any dma-buf I/O to a device with a PI checksum fails today.
blkdev_init_dma_buf_io_ctx() returns -EOPNOTSUPP at registration, and
blk_mq_submit_bio() fails each dma-buf bio with BLK_STS_NOTSUPP. The
checks prevent a crash: bi_dmabuf_map shares a union with bi_io_vec,
and bio_integrity_generate() and bio_integrity_verify() walk bi_io_vec
to compute the guards over the data.

Only the BI_ACT_CHECK action walks the data, and a dma-buf bio does not
need it in two cases. In the first case, the submitter attaches its own
integrity payload, for example with the io_uring PI attribute
(IORING_RW_ATTR_FLAG_PI). Then bio_integrity_action() returns 0, and
the device checks the PI as the submitter asked. The block layer only
touches the integrity buffer, to remap the ref tags. In the second
case, read_verify or write_generate is off. Then the device inserts and
strips the PI, or the block layer allocates an integrity buffer without
PI in it. This is the same as for any other bio.

The first case lets an application read data into device memory, for
example a GPU buffer or an NVMe CMB. The device checks each block and
puts the guards in host memory. The application can then check the
data, or combine the guards into a checksum of the whole buffer. The
CPU does not read the data.

If bio_integrity_action() asks for BI_ACT_CHECK, fail the dma-buf bio,
and otherwise let it through. Remove the check at registration, because
the integrity payload comes with each I/O. With the default integrity
settings, a dma-buf I/O without an integrity payload still fails with
-EOPNOTSUPP.

Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
Assisted-by: LLM
Signed-off-by: Kyle Bader <kbader@ibm.com>
---
This applies to for-7.4/io_uring-dmabuf (45b716456dd9).

Anuj's check in v10 fixed the crash in blk_integrity_iterate(). This
patch keeps that check for the bios that need block layer PI, and lets
the other dma-buf bios through.

The sysfs knobs change the integrity flags only with the queue frozen,
and blk_mq_submit_bio() holds a queue reference from the new check to
bio_integrity_prep(). So the two calls to bio_integrity_action() give
the same result for a bio.

I tested in a QEMU 10.2.2 guest, with udmabuf and with an NVMe CMB
that a small module exports as a dma-buf. The namespaces have 4 KiB
blocks with these metadata formats:

 - 16 bytes, PI type 1 with the 64b guard
 - 64 bytes, PI type 1 with the 64b guard in the last 16 bytes
 - 8 bytes, PI type 1 with the 16b guard
 - no metadata

With a user PI buffer, reads and writes pass on all three PI formats,
and the data and the PI match. This is also true for a 2 MiB I/O that
the block layer splits, and for four commands with one PI slice each.
A write with one bad guard fails with -EILSEQ from the device. Without
a PI buffer, a dma-buf I/O fails with -EOPNOTSUPP. If read_verify or
write_generate is off, that I/O passes. Pavel's rw-dmabuf test from
liburing rw-dmabuf-tests-v8 passes on the namespace without metadata.
On the PI namespaces it passes with read_verify=0 and write_generate=0,
and with the defaults it fails with -EOPNOTSUPP on the first read.
The tree builds with CONFIG_BLK_DEV_INTEGRITY=n.

Without this patch, every PI case fails at registration with
-EOPNOTSUPP, also with read_verify and write_generate off.

If a liburing test helps, I can turn the test program into one.

 block/blk-mq.c | 9 ++++++++-
 block/fops.c   | 2 --
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7fff1305b..3fc9fdeb3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3138,8 +3138,15 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
+	/*
+	 * The block layer cannot generate or verify PI for a dma-buf bio, as
+	 * that walks the data pages.  Only fail the bio if it needs that, not
+	 * if the submitter attached its own integrity payload or if PI
+	 * generation or verification is turned off for the device.
+	 */
 	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
-		     bdev_has_integrity_csum(bio->bi_bdev))) {
+		     bdev_has_integrity_csum(bio->bi_bdev) &&
+		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
diff --git a/block/fops.c b/block/fops.c
index 01bc8afe3..5c8024011 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -947,8 +947,6 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
 		return -EINVAL;
 	if (!disk->fops->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
-	if (bdev_has_integrity_csum(bdev))
-		return -EOPNOTSUPP;
 	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
 }
 

base-commit: 45b716456dd99488a0cef58482120dc0474aa696
-- 
2.54.0

