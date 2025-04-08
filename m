Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF9261593
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097106; cv=none; b=uaWibpKPU9x/PW/YPkho1fRuVVIVUaRoN331hUmtNVQMzI2DuXSxKMp4OHRbn87ijlm5iS6+a7untmBMdbJwAa3Zt20OC/9Pth9oEBL6QI9XG48i22XTDAAXU/yEwbfNvsnfw1hABov7kcn+bx2n+7/mgj739ItOzhUDzGlr2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097106; c=relaxed/simple;
	bh=YJoOynPVQv6gZWcdp2Ujsv1+t4g5VStLqLsD9qF9+YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfixZwPxBsLTsp2uFrhMLuWM8tQoS393uYjgGXH7xiCXrJSNA7r1VqutMvaJqK57Irk+sedeM5vzCAZ+y+LlK8/GDWK7VbKjBnPUdANSZseXvMG9r3ddIoB3UtdQj/bAL51OeWxQwFeAyN8CPnTch+JmvP6JermCxtczZxwaE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIR6k+L3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIR6k+L3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zuYxaZB3VB46oGLBm8YvDsBINDqpagxJWIf2BOvL6Xs=;
	b=GIR6k+L3T315Ot3kJpO0Fpvn1WRhgJWAmkaEkANgdMu3ebiAABYyeBQ2GJ35+3z4TVAwZ7
	zl/TYNej3bY9jevEqQxrj2Inh+PTTQCZciRrI1I7tBKIVIGuH8sOSVYw3Q+W8CILhtR/hZ
	uOw1tJ0MHvby/rZp7PyT6y62DOmnaow=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-V1u2fmdoNx2tgVYhTOxf2w-1; Tue,
 08 Apr 2025 03:24:59 -0400
X-MC-Unique: V1u2fmdoNx2tgVYhTOxf2w-1
X-Mimecast-MFC-AGG-ID: V1u2fmdoNx2tgVYhTOxf2w_1744097098
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E792E180AB1C;
	Tue,  8 Apr 2025 07:24:57 +0000 (UTC)
Received: from localhost (unknown [10.72.120.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0869195609D;
	Tue,  8 Apr 2025 07:24:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: two fixes
Date: Tue,  8 Apr 2025 15:24:36 +0800
Message-ID: <20250408072440.1977943-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Jens,

The 1st patch fixes one kernel panic issue when running IO vs. remove
devices on ublk zc.

The 2nd one fixes one regression introduced in this cycle.

Thanks,


Ming Lei (2):
  ublk: fix handling recovery & reissue in ublk_abort_queue()
  ublk: don't fail request for recovery & reissue in case of
    ubq->canceling

 drivers/block/ublk_drv.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

-- 
2.47.0

