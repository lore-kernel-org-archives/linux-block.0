Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F721CC71
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191150; cv=none; b=qvEVOzNY9EbHVEZ3XXmy/9ZufynhZSRF50LQqFVCEXsqsjK6UomxvstSfBTTmR2RseNPhpONQjrMg1Os8tfrUYGP10Hf/uFTto2u/gYYaSk6BG2fUuj6EoCTzzDJVS3Xulyv8baJRcu6b1pXPSyQTXh5LCPDfe32PPhr9v8PYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191150; c=relaxed/simple;
	bh=iVm1sc/0yzi6zogeE+RXRsbJuGuK2FR+aC1GXH88LmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2CLuSA3z1UVeYgzdrmjIEezt25CJBCKI5l852eeLbJBk+3zKT1LmEjeWEqKFZFcdUIa90bU02fbb7XEit2O3Eg2w4UcEyElXHdOh+worz+hJAaKUNkV2S0Ud8fpqOITl49A/mtgLwKkC3Sb7YvG8KsZW0olYZyrioKUBE5bm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAOMbzdw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAOMbzdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768191148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F34FiE6NoRfOq6tndxs8iwB4Dc1It/53NI4NOalES3M=;
	b=dAOMbzdwxlhJ3+yUzDohIZzTxZ8Hiyy/aCRIlhcwevC+j5jK/y5NqsQXVe1MKXuGpItG8h
	T4w7KL6r5aOKxD/m10skRqGmOK2FNnUus/0zwB6xRzznf6SAmnWxVl0/XaKqW4kT2RCPeL
	QbuC+FNGZRzrz7x06gJhrR37svM4T/8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-k4_zkIRiN6myC3QeSJGj3w-1; Sun,
 11 Jan 2026 23:12:22 -0500
X-MC-Unique: k4_zkIRiN6myC3QeSJGj3w-1
X-Mimecast-MFC-AGG-ID: k4_zkIRiN6myC3QeSJGj3w_1768191141
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C7DF1954B0C;
	Mon, 12 Jan 2026 04:12:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 358C41956048;
	Mon, 12 Jan 2026 04:12:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: fix error handling if start_dev pid validation failed
Date: Mon, 12 Jan 2026 12:12:04 +0800
Message-ID: <20260112041209.79445-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


Hi Jens,

The 1st patch cancels inflight uring_cmd in case of failing to validate start_dev pid.

The end patch fix builtin kublk utility for handling starting daemon failure. 


Ming Lei (2):
  ublk: cancel device on START_DEV failure
  selftests/ublk: fix garbage output and cleanup on failure

 drivers/block/ublk_drv.c             |  9 +++++++--
 tools/testing/selftests/ublk/kublk.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.47.0

