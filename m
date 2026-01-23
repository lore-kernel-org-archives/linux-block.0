Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500A26F2A8
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159761; cv=none; b=nqnUv3Ipz7stRc6Dc3NKX5tzEYQI94TLKcBssNOuudvsQrdk33TYVeumE0/WOtnQe1ULuUWRraA8vCqqpmoK1niTPj2nH1ZvWmR+EEFRXUYAsQ3PJ200lrSDPtNtGNjX3hBOLEbV3JsdpNJNItytmVV8+d3DaZ9KQzxq3V17jxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159761; c=relaxed/simple;
	bh=0dQzOHY2Zb2sfNU10r2tfBsq6xcFcWeqDGUAzGfAgmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIzrACEGFZX1fH2eyHry9VTCPD3W5ZqgMlGjBdqiPyvP87OB0iKwESBQxHuXMcWmWqwI3Hr5f1NvLCyuoKKKb4nxCirrnCZ72sCwJLozLXOFcAuXUyez1p+xc4BdEp3jWkMS8tf8D2OKFOzGFn4iFEp4/clYDy+ALJ7FnGWRbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbzzanK0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbzzanK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769159759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjzOHKl+CXyiXEc6bgMjg6XndycT+DPLqlZ7hI4MfXQ=;
	b=ZbzzanK0Fn+5koJW5L5QVRBiTntGiCN2QtyilOBBryY+SoUvQyhdhz1MkETVvxX+SL8YWE
	Yw6m6etv2cV8rqiDk9BTVi/1vidZbkR4aAgIqak2eWMIZrB2K2Ag30OAdWbbU12Fh08rls
	Ocg83r1pGpl67Fs3FWUd14elShU0WfQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-LiGQ9xK1NEqQ6QMY_8ofPA-1; Fri,
 23 Jan 2026 04:15:54 -0500
X-MC-Unique: LiGQ9xK1NEqQ6QMY_8ofPA-1
X-Mimecast-MFC-AGG-ID: LiGQ9xK1NEqQ6QMY_8ofPA_1769159752
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E5A218002CC;
	Fri, 23 Jan 2026 09:15:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F9291956095;
	Fri, 23 Jan 2026 09:15:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] ublk: BATCH_IO fixes
Date: Fri, 23 Jan 2026 17:15:41 +0800
Message-ID: <20260123091547.2164984-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Jens,

The 1st two patches fix two issues found by Claude.

The 3rd patch fixes test name in test_stress_08.sh and test_stress_09.sh.

Thanks,
Ming


Ming Lei (3):
  ublk: move ublk_mark_io_ready() out of __ublk_fetch()
  ublk: fix canceling flag handling in batch I/O recovery
  selftests: ublk: fix test name

 drivers/block/ublk_drv.c                       | 17 +++++++++++++----
 tools/testing/selftests/ublk/test_stress_08.sh |  2 +-
 tools/testing/selftests/ublk/test_stress_09.sh |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.47.0

