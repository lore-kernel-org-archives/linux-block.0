Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289522;
	b=qYGx5fTIvPY6QUTVHzZNTIdRReqdXV49ZHQa9UG9OLh0VybBj7qZG++frzyzmDBWjHAg
	 rAvzUfTeCe0k8f9NkNEjB2FIvhMM1YhLURef5fNi6jNHxV5iXye5qgKirJJhIer0aO8o4
	 Q7hK5x6Dy7GvLX2Q/91NDB7MIZqLkV5VdXHVRifGodY1Tfhkib4Iti5o85Tz+HEZZKoXL
	 x0dTss/ZZXvSalKag/c9/AHCtlfWhE/tD7N4eXMWm675eYOgeLItTJw/GNbkwc5yv65w+
	 0XfoYIq67+So868yOV16XHSO2+M2AmNmeJVDlMXTM5e4jHXrlLNWW6qLLY84amIVn0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=;
	b=nP//nyJFNMuJQwtliGrWMlLYYTnWspZCGq43D0TqY1ZP5Jz96jdKOCv95T8lsAlZaBUC
	 g2UVCj14aLG0i67qe7hMInrMKRRVbbqVErDMScqLNt9+LWMT8Z9HkhYDVb9crIpbvhisC
	 rN4KaTaCg3DlQ/KPd7k2SrufWp84OGTTb4GNWASuXrr/js9LHNa0rqCes/o7MBWYkSb49
	 CkREQ/Ssg9hKLxHnbq8ZIDYGmt5LlUTbmqjOG/LnX5qCZ4jpAsEZ6mNj6Lj5FdwIR6QVZ
	 BKevqj1OscsiatiWqHM0/UtAebo1+Bof2GPk95CnkDiu44w2onrZLwZCOB9M4vJackw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPIHdURw;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="tS17m/zd";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C4606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RPIHdURw;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tS17m/zd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793289520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=;
	b=RPIHdURwhFQzxXqGxF5QUhfGB5z+bK3Wr0qVBFCdj8DsITI7Zr8IOQ7/wVFyJQZlKh9ova
	gPsTo/2XKnQ+0iq6OxNJq25L8Px3560xLK4pIvvCkLl7URJW2to4MoifKQAQXtXhDVDYnG
	9v2FDu1jgu7Qe3J/kh17jIweBy8eoXM=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-xP_iJWxqOeyvwxGJpbekKA-1; Thu, 29 Oct 2026 11:58:39 -0400
X-MC-Unique: xP_iJWxqOeyvwxGJpbekKA-1
X-Mimecast-MFC-AGG-ID: xP_iJWxqOeyvwxGJpbekKA_1793289518
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35cbea41088so3034982eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793289518; x=1793894318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=;
        b=tS17m/zd7hpZYlf+Myz7mmsRtsxJHHYG71/hoJ+U0TiMItLRiusnTPjlEqeGik8qF8
         wMYDxWU5Yz+QhLjTrqrWxdvWUNwHjFl3Uh2Kz1QWU2hGV0iOpHbAwPULEkd2LYcQWGxb
         b+jJavr5dh4Ly5732jfg6Nso5JBDamjUSob3xULb3ThPJL5ufOwqDexhfsTCOzqnPziH
         XpqipHbNomfcq9OxtcY0SEM91UughpP0pwJ4zkmMcmHYxdChEqnqpmdiWkcfBQ/l+JXB
         AA/+Aizx4jVlK4WwPRcoVoEJheXlWEVQ3tqZvpxibwjqw/TLKFiXbV53VlJGph9LJdnP
         EpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289518; x=1793894318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlvxwwNyQO6n19Y10XHId6qvmxHt/ChSrZalCBx9Qp8=;
        b=MtO31KTdhaPcLBn/Vt1EVodnFt2cEcpqYvlvkhDKlW2K8lTSWjkRGiyLRO9CD8d0vT
         zG1r5qiV/oUlZxomLIeBV4S/DDEz+9sfr9GIFQ31/DA6l7BAZU4dVbYq9l0DTgMPdhwH
         WzOn/hN0HdF/AXijoiWQWw485zafslq3oUuBztyd143yoBdzC9IaJ5rIr6rFog3erOgv
         XAfd95MZkxLrEn3CrzmbTEDW60T2h5KFbSYOVYHhpjEsySIoo3slwOZGoCfyMgaZAt80
         4SZhxAHZER9isl6mzTtzdbrJj8ht3gQ4gy1BQCZUW0UWLgM7EVgS+XNeM1JPNkkvCxk/
         XtXA==
X-Forwarded-Encrypted: i=1; AKwUvBy3Z1KDqKmJcS0KQZxqRAjg6mQriKllSdYWc4lancWLj9cXPdQWF+ycGJt3ybaWLqoGqCWJlkbZFLTfRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIUqOFNhzaVIEDcP8Wtj0kPCHzHTMgiztMCW23ltA8+gRrsO+Pn
	+h7B48EliteqON0MdOFXaMHaTtR7KrzIn/OXxz12oFhWbthbzSSdkLgFYcJLbfCdltfd0+6ZCih
	uEJr4oyA7Zmng9TZy8/eLn1asty7Olb+NuinvqZH+QKNWIbLumcboMrKiEXjR1B7E
X-Gm-Gg: AYBFou3T7RHq1Ws02n9zqHmYpq/yGyjp5b2bYX4UDU99BrOFksSKXp9D+yASmxmii5/
	qyyCqwIP5Tma0MOuRoYvfenvAVSwGKdYUyaPi6NcTLGgwB27NZHnVvxhVvUXRP7fixwci46gZWT
	Y7j8wsqsoRvc/dC0o4tA6e4WMRIzliIFOzEyZy5QYMUKa7Fb9gjKzQaRACtEAjFRzB61XrdQ2+x
	Avh42bIRCDzlDxJRjBOhCuiATjq6nz8/qUzn/uSifEnEp6dOUvX+dB56/9w3qeu75C1WXfz6O/O
	C/Z0FH9iNd2OF9UjXEeDJhiBsXZp56S23x7TvSnOSekxGgsH+CHkYDEunedJ68N23XW13XnGsU6
	S6qog0ig0DbbGLwExLcsY6ue8rbWOk1UvACw3
X-Received: by 2002:a05:7022:ed06:b0:182:9071:3249 with SMTP id a92af1059eb24-1a6ced8ec45mr7441622c88.30.1793289518110;
        Thu, 29 Oct 2026 08:58:38 -0700 (PDT)
X-Received: by 2002:a05:7022:ed06:b0:182:9071:3249 with SMTP id a92af1059eb24-1a6ced8ec45mr7441587c88.30.1793289517483;
        Thu, 29 Oct 2026 08:58:37 -0700 (PDT)
Received: from alpha ([76.166.245.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1abea527afesm23753c88.15.2026.10.29.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:58:36 -0700 (PDT)
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
Subject: [PATCH v2] block: only fail dma-buf bios that need block layer PI
Date: Thu, 29 Oct 2026 15:58:21 +0000
Message-ID: <20261029155821.2983229-1-kbader@redhat.com>
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

All dma-buf (P2P) I/O to a device with integrity data is rejected
today, at registration and in blk_mq_submit_bio(). Only a bio for which
the block layer generates or verifies PI needs that. The block layer
then walks the bio_vecs, and a dma-buf bio has none.

Reject only those bios, and remove the check at registration. Then a
submitter that attaches its own PI, for example with
IORING_RW_ATTR_FLAG_PI, can do dma-buf I/O to such a device.

Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
Assisted-by: LLM
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kyle Bader <kbader@ibm.com>
---
v2: a shorter commit message (Christoph), and Anuj's Reviewed-by. The
code is the same as in v1, so the tests of v1 still apply.

v1: https://lore.kernel.org/all/20261028181412.1919506-1-kbader@redhat.com/

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
2.56.0

