Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AD1D9A66
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797735; cv=none; b=VZrx1Dn8cdC+mD84FwtTC4Sbw6AuzEA/ryAY+iooce4BPlXQCB588zKhO64CkH8ZhwYQE0iy5+M2e6HKR3p39osA30Ex1OX36gJO150bb0pW66yt1gkZvs7FKmOj8lgUUE52Rib4eMW2e0CEeBz6mCn7oTIRAsDXPGBLXq4Z6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797735; c=relaxed/simple;
	bh=2svO7ANRoavkXX03zVdJ6rQ13oBZ4sElxrn9G2qa3hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4vJzZwHI5dO1mI2eXbrJGWEYLZMyZ1/QWIBe6/NKbnR9spXBFUKq26GZ/OgMrt4lv5VXMa/8ZapSTknpSUmFXaxo5aUHptgxjZD33PpDxtXvys8ywOmwr1H5q5uCALTyCRzmpRzdLppk7lQQjZ/Pl/be32Ce1zB1+udJZB85mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2r5YQBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2r5YQBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773797733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CqFzHcb2df96RmQfDBr72f2by0y/t+p/YTVOoCXpzdE=;
	b=R2r5YQBR7MKscjnBIyyHIDkzMbk4TzjCnPIKXu5JnpzYyXf6g9bRspO4FZCoDol/5/W+z2
	FqtyVQ9K7lOcCa1+AjCY1rUKlwVYtF0vxykrUK2Js5iyGkD4wBsJq6M7gkJpw9rR2aS0Nr
	OrWiFxuVBac9irbMDxw+yMDok9DAmHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-5D8pHsBeMcWUJOkStvAmWg-1; Tue,
 17 Mar 2026 21:35:29 -0400
X-MC-Unique: 5D8pHsBeMcWUJOkStvAmWg-1
X-Mimecast-MFC-AGG-ID: 5D8pHsBeMcWUJOkStvAmWg_1773797728
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2156F180034E;
	Wed, 18 Mar 2026 01:35:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.147])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B42E51800351;
	Wed, 18 Mar 2026 01:35:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Mehul Rao <mehulrao@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18.y] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
Date: Wed, 18 Mar 2026 09:35:17 +0800
Message-ID: <20260318013517.3124637-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Mehul Rao <mehulrao@gmail.com>

commit 25966fc097691e5c925ad080f64a2f19c5fd940a upstream.

ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
set_capacity_and_notify() without checking if it is NULL.

ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
(ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
handler performs no state validation, a user can trigger a NULL pointer
dereference by sending UPDATE_SIZE to a device that has been added but
not yet started, or one that has been stopped.

Fix this by checking ub->ub_disk under ub->mutex before dereferencing
it, and returning -ENODEV if the disk is not available.

Fixes: 98b995660bff ("ublk: Add UBLK_U_CMD_UPDATE_SIZE")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 965460d4fc76..2729b1556e81 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3604,15 +3604,22 @@ static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
 	return 0;
 }
 
-static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
 {
 	struct ublk_param_basic *p = &ub->params.basic;
 	u64 new_size = header->data[0];
+	int ret = 0;
 
 	mutex_lock(&ub->mutex);
+	if (!ub->ub_disk) {
+		ret = -ENODEV;
+		goto out;
+	}
 	p->dev_sectors = new_size;
 	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+out:
 	mutex_unlock(&ub->mutex);
+	return ret;
 }
 
 struct count_busy {
@@ -3902,8 +3909,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_end_recovery(ub, header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, header);
-		ret = 0;
+		ret = ublk_ctrl_set_size(ub, header);
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, header);
-- 
2.47.0

