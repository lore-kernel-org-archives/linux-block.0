Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7D29B76B
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931768; cv=none; b=cAj9Vuh71/26voby17j9Fj2qG9Pkxxt2PLBgtQ8cD0MXyPlW4DnWbO5l97xAnAeyx26SdNda4ATpqay+BQ8O3RN3IHs4D9woqeSnzxtDUy+/K+ZDTHmJ02vAEf8m4L9oUtTi4sCLBUtQgLa7nrJJdmsOHNKrexoLTEVSrffDCaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931768; c=relaxed/simple;
	bh=T7kjf1vLnod7vPSVKmUAP458M3NK7UpbC94VyMvmhuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJrvTspWfkM4fQlIkRGlyStGOOJ8ZS5l3e1g2D2pscn7xjr2H1dkc5njJrNlShYxgcEvuciSQBhOaKWv/RtwaKwpY9ljSO1jU8IOZ/OpTP9X1jNPGzvM5JUdcPfDbORRY0c7qU8AVuT+ITvBNc7oQPok2yzsQ5KA5ud2kdIcRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxGckdP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxGckdP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747931765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJZ/hkaEg3v72sPX2wt7YBuChGiy+rpvdNuXp43t/DU=;
	b=SxGckdP9iJN0U+FyFDbDj7dCd8Parr6Uj3sCSv3gbLrrTAA2tFzUxebgiwncrA4W679VYJ
	aofg6BH5o+I1Wy6d/5N1vjtLspQ5rWJI3y5p9hh/BlD4XyX/VuhLNr19emW7nqq8M+ABZ7
	mGM/XVV5d1nDUkKcbZM5IGDn+pYLNR8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664--WIWerheNUynSo-zC31tQw-1; Thu,
 22 May 2025 12:35:33 -0400
X-MC-Unique: -WIWerheNUynSo-zC31tQw-1
X-Mimecast-MFC-AGG-ID: -WIWerheNUynSo-zC31tQw_1747931732
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05B7219560AA;
	Thu, 22 May 2025 16:35:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E41B91944DFF;
	Thu, 22 May 2025 16:35:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] ublk: add UBLK_F_QUIESCE
Date: Fri, 23 May 2025 00:35:18 +0800
Message-ID: <20250522163523.406289-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Jens,

The 1st patch adds test case for covering UBLK_U_CMD_UPDATE_SIZE which is
added recently.

The 2nd patch adds UBLK_F_QUIESCE for supporting to quiesce device in grace
way, and typical use case is to upgrade ublk server, meantime keep ublk
block device online.

The last patch adds test case for UBLK_F_QUIESCE.

Thanks,
Ming


Ming Lei (3):
  selftests: ublk: add test case for UBLK_U_CMD_UPDATE_SIZE
  ublk: add feature UBLK_F_QUIESCE
  selftests: ublk: add test for UBLK_F_QUIESCE

 drivers/block/ublk_drv.c                      | 124 +++++++++++++++++-
 include/uapi/linux/ublk_cmd.h                 |  19 +++
 tools/testing/selftests/ublk/Makefile         |   2 +
 tools/testing/selftests/ublk/kublk.c          |  94 ++++++++++++-
 tools/testing/selftests/ublk/kublk.h          |   3 +
 tools/testing/selftests/ublk/test_common.sh   |  37 +++++-
 .../testing/selftests/ublk/test_generic_04.sh |   2 +-
 .../testing/selftests/ublk/test_generic_05.sh |   2 +-
 .../testing/selftests/ublk/test_generic_10.sh |  30 +++++
 .../testing/selftests/ublk/test_generic_11.sh |  44 +++++++
 10 files changed, 350 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_10.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_11.sh

-- 
2.47.0

