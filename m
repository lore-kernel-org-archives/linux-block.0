Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0B481B1
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739154; cv=none; b=O9M2Za62CNvYUxebpewCOK9OgYVSftNIuF3ISBPh+9xYaI2lEwoFanPWLotvCgRAyVs1ipSsjLLD0QlM5SypohO4F3z9LiL5dzhyS9qAFrrfVa5kYeL+SWiUW8J0W+wYxh2BQzS1TAHJt8FtWK0AuFzw3uZMVpFJDnttqlSK9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739154; c=relaxed/simple;
	bh=F8yKZIQV+gdODPzHgzDqYospjCHYKr90Bu5fAIrXze8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxujTK0BswPcH9qUKsSVVCV8y5dBxDsWx6kxOGeh32j9vibUKXrgYLIe8+xSvbP6/e2NvY6NW6bpvMthnpxvEgHJfEvXTHQGuZi+xFGLhbwWjp+nTP/YVEsfyC/X9aZl+2pFJPVwa1bQ8ffZjZpCP5vXF6PG8lC21vKawG0yOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDRQapOY; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDRQapOY"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7982c3b7dfcso85664597b3.0
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772739151; x=1773343951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWGzOFn/dLr+0JASN1nlbhCeckpCAXU9j/BcQj2Bi/E=;
        b=lDRQapOYXEvj3gPjQ9I9A+S9dBNNdk/+ddKSWxW5fivQ1N3+0SMDM/jUGWSDJMgdPO
         U9M8OSa9qXT5Z84a99+vimxSvvutWjagYsWk5gVUhBTXud9/U99VDhtuSAilmdi7Utfp
         ls6BDTJonHzZOiNszgM2PSkVaA6z7v+zu2qmZr8uCDMpSa/xOp4RtZaYUtSc4+cp6GLn
         iGPjPhK18JkCI2ebVDD3fnWSNxv298tCDwX7hHO+EjwxeP42dTEF6kB+OI8rDCIDu145
         ohYQuqzQSF6+GyYufxwpyt8YbzY0X3Q+Yb/RwprfsqQEOiZ8Qr7JmnJOftJzg3/pOD+T
         fuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739151; x=1773343951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWGzOFn/dLr+0JASN1nlbhCeckpCAXU9j/BcQj2Bi/E=;
        b=uVbWnmbIVswnPLBSUJvXPHoZM9KtN0OsC3Fh7Ver+pMRxqSHIBC6F9xajYAQcqP9TN
         jwW5zsZSCT8bxossOKZsAxlBR3JwnB75zjt+DFEtrGT0E4gqgQKGFp+e4lJmeWTT6RlG
         ZdEQIqsMcIQ0o+RmYcbi6UjF3FhT1cXPHYfSjyYl1Qvsec231Is5XQnIXL+l87FOPTez
         68V3ec6GDYL+bs4R+8jevavaZywU4p0O0CHfqXK5GUa9ikMMjpktlYgzi7a6LS6R9Gb/
         4rWgnQfPakH2DqCzW6EQqJv7zL+G//thjWusX13fbaqj60dSe0biIrenqd5Kh0AWlU12
         c4ew==
X-Gm-Message-State: AOJu0YxdTIWsBnGP0ibxme3rAITxICCfDTTi9898mfVvr+ePEDtG9bih
	oTVb62iS2VjS32JQcUaF4N++JplUtidnRduxZGKDMCzg6v9dlrib/qa8
X-Gm-Gg: ATEYQzzunJ2k8VbegKHEKX1EdOvtZSUHh0Nd5LyeUBbgvVog13uTpeH98NoHjte9Ptl
	CD3B/LfaiNMipmkH9CQ282+NGAitu2hGn5IxGvPCxYotIZOVx6YF1aG0gValvjh8ISg4D/IyDXB
	eFK0Fgk2rrMVaCYt9gmSLLsMYKtq1nLj8Rx4RJ3549M+/dxvxZFcbJrHcBQRg88RqfZvOo9+yGb
	vjMaYzYG20IBNrUYJ1Sg1f3ao2mqsHYUODP9z8KXSSlIkJPsSmLUXAhaj5RwYN3GrJSV1j/dDbm
	qpAj+H4oJm9ESlRoOU/2SonroayeuijNYpsTK8bJCUCDjkFRfZAgjev+qMpdAxJOGAzBIyBi7Jz
	DHMnYhDRg7faL8J89p05v2Zt6fNl4p1KXuQ2Ey6/C/eqTt6j4Z9ZbGsyQ/gurH/BE1rws76K9u+
	BfEFmKhKcIvAS0k5Qmib5WMWgypIVrLh+UBvDcp+d1tMhfAIBftpxCpkqE
X-Received: by 2002:a05:690c:4446:b0:798:6a34:74bf with SMTP id 00721157ae682-798c6bd9218mr64283397b3.5.1772739150760;
        Thu, 05 Mar 2026 11:32:30 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a9004dsm92357617b3.6.2026.03.05.11.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:32:30 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
Date: Thu,  5 Mar 2026 14:31:46 -0500
Message-ID: <20260305193146.304526-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/block/ublk_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 004f36724..41ed30a18 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5006,15 +5006,22 @@ static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
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
@@ -5335,8 +5342,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_end_recovery(ub, &header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, &header);
-		ret = 0;
+		ret = ublk_ctrl_set_size(ub, &header);
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, &header);
-- 
2.53.0

