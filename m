Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236511D9350
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981269; cv=none; b=aMfGLrjTQcftjTJdWjaHjGy0s+XzIG+nEY8fLtHbxeysDVYcm915SpU0lL1hCQRMuYTSOcRdesQm2a2Auz5pxBByAmV69L5iEnWiI8KU9upCGDYE0Wc5dK0QiS8ysTXpfawQH1k4Dti5GRF8gm0RBCAkjCGsqmCIMfak1mC4Vb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981269; c=relaxed/simple;
	bh=VxZAq3k1numrivsoeehmfhaUDP/RVl58WLFtd9RVTtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFyj9TtUTyBKe0sfzfJOZqEwb90SALYKIRK1wIKPwAcEPig5CNcF1VwtrUjV6koW7I8zKndss7iGEMgVnc/kCpfqmo0Vkk60V9HgpeKZe/0bjxkAM4tDjpgdIripB73dFYH31Jy/A0XmgPOOGhni+0vBlWLmfcKKhuBRNH5lHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pNqRF+Fd; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pNqRF+Fd"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYLjr4KjWz6CmR5y;
	Wed, 15 Jan 2025 22:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1736981258; x=1739573259; bh=w43fq
	ie8sFeviDvAwAfj/UUjn3xnlWRs5/7ncET4ttM=; b=pNqRF+FdUB11Ke9EMMUwq
	XzaozEUYTAdy9Pr//ErVCBrNINgbdzVqR26DFaV+2wC7QPrTISxfUPRl9nY75fUW
	BGMcT9YhgidPAORZ42vM679JV8z4u3eG27vnLw6k+8ooeLkcRThGeQe5i5Yzg16b
	TXpDJApiS+/j5JMfTFp7czrxiySTZ7913JJOBHRCDc2SdY/e86sIAi5lRFSxfl66
	BJZoq5DGiGKaqEtWjiT3/668glvkVWLgCL27uZJha17rH2f1zk6oNB2F7ljz3oQG
	526jLhddCxoyA52Kxk9YUDgzARba34kjvcp6ZyIZMptBDAGNkzHDVsXTa6r/TU2t
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hTfTkWVimpWe; Wed, 15 Jan 2025 22:47:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYLjg1PQ9z6CmM6d;
	Wed, 15 Jan 2025 22:47:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v17 14/14] scsi: ufs: Inform the block layer about write ordering
Date: Wed, 15 Jan 2025 14:46:48 -0800
Message-ID: <20250115224649.3973718-15-bvanassche@acm.org>
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

From the UFSHCI 4.0 specification, about the legacy (single queue) mode:
"The host controller always process transfer requests in-order according
to the order submitted to the list. In case of multiple commands with
single doorbell register ringing (batch mode), The dispatch order for
these transfer requests by host controller will base on their index in
the List. A transfer request with lower index value will be executed
before a transfer request with higher index value."

From the UFSHCI 4.0 specification, about the MCQ mode:
"Command Submission
1. Host SW writes an Entry to SQ
2. Host SW updates SQ doorbell tail pointer

Command Processing
3. After fetching the Entry, Host Controller updates SQ doorbell head
   pointer
4. Host controller sends COMMAND UPIU to UFS device"

In other words, for both legacy and MCQ mode, UFS controllers are
required to forward commands to the UFS device in the order these
commands have been received from the host.

Notes:
- For legacy mode this is only correct if the host submits one
  command at a time. The UFS driver does this.
- Also in legacy mode, the command order is not preserved if
  auto-hibernation is enabled in the UFS controller.

This patch improves performance as follows on a test setup with UFSHCI
3.0 controller:
- With the mq-deadline scheduler: 2.5x more IOPS for small writes.
- When not using an I/O scheduler compared to using mq-deadline with
  zone locking: 4x more IOPS for small writes.

Cc: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Cc: Can Guo <quic_cang@quicinc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3094f3c89e82..08803ba21668 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5255,6 +5255,13 @@ static int ufshcd_device_configure(struct scsi_dev=
ice *sdev,
 	struct ufs_hba *hba =3D shost_priv(sdev->host);
 	struct request_queue *q =3D sdev->request_queue;
=20
+	/*
+	 * With auto-hibernation disabled, the write order is preserved per
+	 * MCQ. Auto-hibernation may cause write reordering that results in
+	 * unaligned write errors. The SCSI core will retry the failed writes.
+	 */
+	lim->driver_preserves_write_order =3D true;
+
 	lim->dma_pad_mask =3D PRDT_DATA_BYTE_COUNT_PAD - 1;
=20
 	/*
