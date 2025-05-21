Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E812E5D
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796120; cv=none; b=GiSi0jkKBpNxbeghV49HWWbOAg75G+0/CztZDzxeHGRjDxmk7qNNEyqZZ5d7JOoYYWg+xyafXxH7EBsLT2ejzRH+rFj76wdtssDMff5YWuHRFnCLJU2SYBjLZG6vpdu3sBVID6utXTam6Kx3P4THhxiToZKXqJdQgUKvdAHdxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796120; c=relaxed/simple;
	bh=BADJUgc+7kI9wDjpxW0RCwtbvo7Wwi7vliSMu5ZVDLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EualciJIByOH4ONJ0o/5nHG4nnNWmwDSJ1c95VU2eFGBm9d1lvZKLaccVqvqy8v5DWPJY1SGph93gK6+IWwBMObJ56p0T1i02gTzFZLsI8ZFy2uXpZtI2x7KqoRCX12SvlwgPAEI9M5jeo8raYn0ha6tMarovhoGPLQFz/sXoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMcJUGfb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMcJUGfb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747796118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1LHm3K0afcomk8HzH9S9LREcW1BqUtlYtQIrOG8IPW0=;
	b=MMcJUGfbJ/2CiKeTxJxNCs9IW8QxYiBZTtGvmC4FnSYW1+JpCe4AjB7OeRt/Ro2pdgrSL7
	e0qRkWYYVU/oRgPg91P4ljF7RtgbxkoaCNeB/6Iz00y0jY0WbmhO6TwqGzp42QEsoo6y7Z
	vhraG2Elvue8nVc3amPB+HfKm2DW62A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-7LZDT290PhCqPmZYFFfoXQ-1; Tue,
 20 May 2025 22:55:14 -0400
X-MC-Unique: 7LZDT290PhCqPmZYFFfoXQ-1
X-Mimecast-MFC-AGG-ID: 7LZDT290PhCqPmZYFFfoXQ_1747796113
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A0E61955DAB;
	Wed, 21 May 2025 02:55:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F31C330001AA;
	Wed, 21 May 2025 02:55:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: two fixes on UBLK_F_AUTO_BUF_REG
Date: Wed, 21 May 2025 10:54:58 +0800
Message-ID: <20250521025502.71041-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jens,

The 1st patches fix ublk_fetch() failure path for setting auto-buf-reg
data.

The 2nd patch makes sure that the buffer unregister is done in same
'io_ring_ctx' for issuing FETCH command.


Thanks,


Ming Lei (2):
  ublk: handle ublk_set_auto_buf_reg() failure correctly in ublk_fetch()
  ublk: run auto buf unregisgering in same io_ring_ctx with register

 drivers/block/ublk_drv.c      | 37 ++++++++++++++++++++++++++++++-----
 include/uapi/linux/ublk_cmd.h |  3 ++-
 2 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.47.0

