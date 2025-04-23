Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74115223DCD
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400267; cv=none; b=NMH/7cCAxa2IdSCppm/IMFx2V/qIUdusOyVf/FcToxjXhYKQHtrqXUByCKXCtwyp5PHlkTcY+sAa3xo3Oz7DXsMYlFUjlHLJDH+0YwJJY6oxgq31g/JOB2elYN07wvwCxWtvs/Mza9i8utOdyRYytp3SPiCtw174qMLJ0FXFo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400267; c=relaxed/simple;
	bh=uhxWzwWdk7pH9GY9QqZbvp7tHr7um+B1yunR9MR0AWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5KdbWcrlFdSIGaf9VKTCsDLGbO9URaPSB007855GFfGaC2mmtr7loXbHVVOkn6LWyTtHF8YVpKLhmU5aqojc2+90JKGXkQ9fl/liqww1RfHpHdDvw++jwIAnELGQ36p9loPSYV4afIctECdMUTlfzJXGck9+dzaLkxvc57HGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPZH5y7J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPZH5y7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745400263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B25CbmgCFwZ0O4hl8fWejX1u5z7/b7An7iv3+BzNojk=;
	b=QPZH5y7JfERAPE49TDM0RLRYbNU85bXyeajDWZrihdJ+ZtbkcdHat9JWqCJFV9SppaVl6m
	nGSO2hEjpnKpfaSPTZ5xMMtzaKX9lhHy553VuhmuwCyWvbcckVuBKzSggooYWQ3UIC1FHl
	E8oRSQT7PSZqiH0LG/p7HtgRZjuzKcE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-n9eoAhzhNhW2oCR-oQro3A-1; Wed,
 23 Apr 2025 05:24:17 -0400
X-MC-Unique: n9eoAhzhNhW2oCR-oQro3A-1
X-Mimecast-MFC-AGG-ID: n9eoAhzhNhW2oCR-oQro3A_1745400256
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EB02195609D;
	Wed, 23 Apr 2025 09:24:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AA8D195608D;
	Wed, 23 Apr 2025 09:24:13 +0000 (UTC)
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
Subject: [PATCH 0/2] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Wed, 23 Apr 2025 17:24:01 +0800
Message-ID: <20250423092405.919195-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Jens,

The 2 patches try to fix race between between io_uring_cmd_complete_in_task
and ublk_cancel_cmd, please don't apply until Jared verifies them.

Jared, please test and see if the two can fix your crash issue on v6.15-rc3.

If you can't reproduce it on v6.15-rc3, please backport them to v6.14, and I
can help the backport if you need.

Thanks,
Ming

Ming Lei (2):
  ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
  ublk: fix race between io_uring_cmd_complete_in_task and
    ublk_cancel_cmd

 drivers/block/ublk_drv.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.47.0

