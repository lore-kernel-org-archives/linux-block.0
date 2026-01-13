Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960862ECE86
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294699; cv=none; b=E8TdnlbGIuiB9j+rvS//LQ7PEkJ49EWBdbgBx5ZF/bIaG4A4f8nLHuRNJWPP7TsyT25ONF/lsZc68uoi5zDH/B6rlR05xWQ+zt6p6u4Ou00hW12trFsVkieYwAj5CBQBxNmoqmN7gsqcw5t3FYNh8LL6oI/HgFCxwqrgklhp/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294699; c=relaxed/simple;
	bh=FwijC/z1UH7dAhNuQ5Gsq+f6YEGLvFMYR19LGlCEL1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3Iyu1+fKX6cBd/zGWQi029zqdSq9oWzaNDERYAwgluRK+BKWH1SnoP8weJ1srKnz+GPSlVoVReLSNsu2k39IbDqptPMJt8tt4UTHggpmse3qbBxA1KCXusqIo9uOO6/W0Sgbf9KcMPgi+r/F1nthLbJDJMcuBmWXDFrWAC1jZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVJMx7On; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVJMx7On"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768294697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80wFlejrRCumhXGIgSaH/vb2/rM7VtO99uVP1JTSUt8=;
	b=WVJMx7OnjE9T6MuYPE1NJnDUgtZQib5nUCRAjdFyFGmNZdSmJfa+1lzknIMgRvu4G+E/q8
	fd2Xk+u271oepdApOrVGEmkVbGmxo8nCZMXP/2vpdC2bll0afdSiqnqEQ8CZabNNK+b6fe
	kKaUeDNGxTPybQB8w4fAtih+A7vwoEU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-cuOA2VP1O-Gzx3SH_WYAaQ-1; Tue,
 13 Jan 2026 03:58:15 -0500
X-MC-Unique: cuOA2VP1O-Gzx3SH_WYAaQ-1
X-Mimecast-MFC-AGG-ID: cuOA2VP1O-Gzx3SH_WYAaQ_1768294694
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F94519560B2;
	Tue, 13 Jan 2026 08:58:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 155B330001A2;
	Tue, 13 Jan 2026 08:58:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] selftests/ublk: three bug fixes
Date: Tue, 13 Jan 2026 16:57:59 +0800
Message-ID: <20260113085805.233214-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jens,

Fix three misc issues of selftests/ublk:

- make sure all io_uring commands are completed before exiting from ublk
  thread

- cancel in-flight uring_cmd in case of failing to start device

- logging fix for avoiding segment in case of logging & garbage output in
  case of foreground

Thanks,


Ming Lei (3):
  selftests/ublk: fix IO thread idle check
  selftests/ublk: fix error handling for starting device
  selftests/ublk: fix garbage output in foreground mode

 tools/testing/selftests/ublk/kublk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.47.0

