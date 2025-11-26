Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994F33F381
	for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174979; cv=none; b=KD+7nSm5CTBRVKwp0bP/qwv2nndwNAGGch7JUWfwL7mvGQFHAbglf+Syp/6Vehr1+O26RFmG+RWGOB2oCREuuC462gym16uXNqQIt/TCBpMRzJRhP8mfhOT/47zb1qEzo3+bF/1jBQ3vQEX7adMem4ssfTWMMlvHMZ1aBnVZfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174979; c=relaxed/simple;
	bh=IU4kgx8Wn4nALVRtMfyab5Yub53eM6C01xg0lQHuTo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSV+g37F/6U4SF+f9ktsgR+BXqfMVFcvcW2pGHuEjmdGztpM+aaBsw22X+M7D/qNrrcf3CT8vD2mQWB1Y1wtdZFj3ODhv2CxS/xIzlYg9reZIH+BDGVpgBtE6sqebdxs29JrL/cOGILev7h8d3PlWVWUCPq0Jdcgl/34Keqj0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rr5d+6Kx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rr5d+6Kx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764174977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLbOYH1ZNvDH2OUPDGLBHO7mvrdHvaUK8HEzMWWFf5s=;
	b=Rr5d+6Kx2kF6nySk0U755Mn8gpEiJGoyEK+dA9hvciyN5SAIKMAj3LCCM+hPLZiG1kA2Dz
	jb3Hxskgg28OxKFveYkGxkkxqlqMnMwU5T2Cny6l015TS2R0W5YXWAokfYinypV/VpW9DD
	7VzDYjz0TKkVEa1bSaInt0XfzWOz8u4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-V2gLIDVUMA231heVvoz5qg-1; Wed,
 26 Nov 2025 11:36:11 -0500
X-MC-Unique: V2gLIDVUMA231heVvoz5qg-1
X-Mimecast-MFC-AGG-ID: V2gLIDVUMA231heVvoz5qg_1764174969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9057B1954B06;
	Wed, 26 Nov 2025 16:36:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80B941800878;
	Wed, 26 Nov 2025 16:36:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-scsi@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/4] nvme: reject invalid pr_read_keys() num_keys values
Date: Wed, 26 Nov 2025 11:35:58 -0500
Message-ID: <20251126163600.583036-3-stefanha@redhat.com>
In-Reply-To: <20251126163600.583036-1-stefanha@redhat.com>
References: <20251126163600.583036-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The pr_read_keys() interface has a u32 num_keys parameter. The NVMe
Reservation Report command has a u32 maximum length. Reject num_keys
values that are too large to fit.

This will become important when pr_read_keys() is exposed to untrusted
userspace via an <linux/pr.h> ioctl.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/nvme/host/pr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b139..476a0518a11ca 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -233,6 +233,11 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	int ret, i;
 	bool eds;
 
+	/* Check that keys fit into u32 rse_len */
+	if (num_keys > -(u32)offsetof(typeof(*rse), regctl_eds) /
+	               sizeof(rse->regctl_eds[0]))
+		return -EINVAL;
+
 	/*
 	 * Assume we are using 128-bit host IDs and allocate a buffer large
 	 * enough to get enough keys to fill the return keys buffer.
-- 
2.52.0

