Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0F1DBB19
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981251; cv=none; b=ePS1Tds89vDq7/opHwfMkOxiCJLS4l+KYWpeBj5+q4g9g4XGoIaCSG9HgpQQJctFAawrPFtfiuNw/qgq7KRgyk+Ex6JsRwJLQA7ETVqSnbh6BpzSzfw23bhbnGb6O4Cbuhdf6Ln6p4QLT7Kf4oG0zoXRIAlvzsIc8yP3SfSp51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981251; c=relaxed/simple;
	bh=AIhneZsKBZZdIP4cBp5Qt9w5GESafUfEVnq7f85c5R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it1CMOXePgKjOGuFlUxyY7N1rUqNhHlTA7E6ucnGBGedmnF6dV0pX2Ws3RQ32mfwSqwajynuVPz70JMrYYxX5IjcqVoCO+Ceh0hCgb2oXV8GjBkb82jM84fzgdhhyxUAxRwS7kMxVhT5BCX7fomVGrWzMsmrnbS0VyqkCwHquvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZosbXVD7; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZosbXVD7"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjY0qTbz6CmM6M;
	Wed, 15 Jan 2025 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981244; x=1739573245; bh=xQ7Ve
	aZq6rWbKoI4S5dg8YZWrUXht2fshQkVyJPRC+s=; b=ZosbXVD7vis/nNfVoHSMi
	c/IHIwL/WbEsBy5mPsU5wImSHlV9P8DETQxA6PWeeQzhmgHkaVk6wagbgm7a+EN0
	2l2JqaQx24L/l2na7Y59+pGfhyscTcj0+WEGCLQFkVmpmyoWFA3eAK7W5gpEzaKB
	g8y3cqaBDRTqnsCP5SVhNseW3NJQbjtj3/5vzxFoiXX9uKREQm1G4IcrajQEQcHS
	KobnTIAcWQgDZE9KqoLCdCxVyORCpm+JljCtw/WcSr4HpmfA4vAzt+4lw9bPZUjY
	4bYKu4/+YbOxfBFh/tEtInXhxw3VeDA7qGrVZTlgh/X0h+4j7mOJvOYRJbf0w2l+
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6GCBoAuRyfIl; Wed, 15 Jan 2025 22:47:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjQ27NCz6CmR5y;
	Wed, 15 Jan 2025 22:47:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v17 10/14] scsi: core: Retry unaligned zoned writes
Date: Wed, 15 Jan 2025 14:46:44 -0800
Message-ID: <20250115224649.3973718-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115224649.3973718-1-bvanassche@acm.org>
References: <20250115224649.3973718-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If zoned writes (REQ_OP_WRITE) for a sequential write required zone have
a starting LBA that differs from the write pointer, e.g. because a prior
write triggered a unit attention condition, then the storage device will
respond with an UNALIGNED WRITE COMMAND error. Retry commands that failed
with an unaligned write error. The block layer core will sort the SCSI
commands per LBA before these are resubmitted.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_error.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 10154d78e336..24cd8e8538e5 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -700,6 +700,22 @@ enum scsi_disposition scsi_check_sense(struct scsi_c=
mnd *scmd)
 		fallthrough;
=20
 	case ILLEGAL_REQUEST:
+		/*
+		 * Unaligned write command. This may indicate that zoned writes
+		 * have been received by the device in the wrong order. If write
+		 * pipelining is enabled, retry.
+		 */
+		if (sshdr.asc =3D=3D 0x21 && sshdr.ascq =3D=3D 0x04 &&
+		    req->q->limits.driver_preserves_write_order &&
+		    blk_rq_is_seq_zoned_write(req) &&
+		    scsi_cmd_retry_allowed(scmd)) {
+			SCSI_LOG_ERROR_RECOVERY(1,
+				sdev_printk(KERN_WARNING, scmd->device,
+				"Retrying unaligned write at LBA %#llx.\n",
+				scsi_get_lba(scmd)));
+			return NEEDS_RETRY;
+		}
+
 		if (sshdr.asc =3D=3D 0x20 || /* Invalid command operation code */
 		    sshdr.asc =3D=3D 0x21 || /* Logical block address out of range */
 		    sshdr.asc =3D=3D 0x22 || /* Invalid function */
