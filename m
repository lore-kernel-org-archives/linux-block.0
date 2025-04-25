Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5649620
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545081; cv=none; b=fmwEGjxdAzSk7/Y80erarNyKyWXI48nGVJ3XG6BGgMALaAgADaLGp5nK5Ar4jX8Wm6yw32MtMtTgiQkewQQ/LjoZxPW61//aBIwGXiWewBQf3LPv8DM/7HdtnpyGS0TXuWOr7X03ODBqBt0MoFDW6Q8SU/AGZ38SMks6JkPOB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545081; c=relaxed/simple;
	bh=tLzEIFXjANDgXnkRh3uzgP60L+v30ewVyx8OilQj6hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGw2p/lFPOm4giqAGIR34rVhrO6VL2D9Azqx6Vs/SXho2ZEdF9wrvmZGv38Qg5EHCC7PGH7v5r7Uwc3+vIhqX7r0RtILwCgN1oQr/vr0YFVGK6eSAxjLcSL9Q1kFLtsUer4WebGKExjTt+NZlmfD03n5AP8LISh+puW73hycZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KH/Srwh5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH/Srwh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745545078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KP5iLD6bnnXwgZQ0vOD3nb7PtPFdYGCT6qlJV0z2cr8=;
	b=KH/Srwh58VR7RNy6wKkCeRT/8JfsNDV3L+4gJI+ZBVPpYnDcPOY+02vx8W0LAM2Z9XOb0M
	wCzYbTpsoL+DC4kEDfqDQnWFBoEulBmO3uCku4NkTxyG+1ePAWKbGHwzTgu9XJjOoNleIL
	IXAy9/xLyODrXwp6piVL5dVZlYg6tcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-LFlyK1qZNRyENIyxX2VoVQ-1; Thu,
 24 Apr 2025 21:37:52 -0400
X-MC-Unique: LFlyK1qZNRyENIyxX2VoVQ-1
X-Mimecast-MFC-AGG-ID: LFlyK1qZNRyENIyxX2VoVQ_1745545071
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF97E1800373;
	Fri, 25 Apr 2025 01:37:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C671D19560AB;
	Fri, 25 Apr 2025 01:37:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>,
	Ofer Oshri <ofer@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Fri, 25 Apr 2025 09:37:38 +0800
Message-ID: <20250425013742.1079549-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello Jens,

The 2 patches try to fix race between between io_uring_cmd_complete_in_task
and ublk_cancel_cmd.

Thanks,
Ming

V2:
	- improve comment and commit log
	- remove useless memory barrier(Caleb Sander Mateos)
	- add tested-by fixes tag

Ming Lei (2):
  ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
  ublk: fix race between io_uring_cmd_complete_in_task and
    ublk_cancel_cmd

 drivers/block/ublk_drv.c | 41 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

-- 
2.47.0

