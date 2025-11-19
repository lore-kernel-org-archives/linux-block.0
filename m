Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9B33C1A0
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554195; cv=none; b=PxSVNGzVixiQpur8mYQmB7cGQhaKVSPWuxPs51YdandspFT3BFUaSWk8UneACitSVvMJgtqWTRoPRVOY/Ma7h/I0eJLcaat8z8pQ/osGwRXO/2gluAMk0moIctcBYljIEYYkxG1IV5TLPwFf9NXpoO4kRdg5/QRZXUotN4I3hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554195; c=relaxed/simple;
	bh=Md0U8PnYx3hpZSRjVTmfIBRRxHHpEemGpxJgcea3/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9zYuxb3yQaAR+B2IzL5PX4UVpqE58p2eJH2s4X9xDftL/DWPDfnOcVm0ARD46uBn9DDdtRmz8/dYh9WbOi1YYGZWzIs5avQS66UXPBBFBhPKq3KusuwJcDJRndAnMA54zSzWm4jm0OuLf825zG2Y03UOwQVESTrEk+cAWQ/CpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+PQEwgM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+PQEwgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763554193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WUR3hRDWZrQyzE5ZOTPtliWhNphRCp4lcYgm6h8yHP4=;
	b=J+PQEwgMWGOTC4NLvMPLScZxdbF15ST5iFitjdJet5roVUv7BNOKhy3VFIrrnHkvxM6nzB
	u0PuNaIV89j+KYndh4Ovxnxc3oatf+c6kwKgGdayWMq6WBp04QsB5kQhXoMHismPs0ZWW4
	jV9cJnQeXk1T8d7wp605n8w6ONkpExo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-_yqT4mizOLCVNfaujVJ_6A-1; Wed,
 19 Nov 2025 07:09:51 -0500
X-MC-Unique: _yqT4mizOLCVNfaujVJ_6A-1
X-Mimecast-MFC-AGG-ID: _yqT4mizOLCVNfaujVJ_6A_1763554190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35F4919560A3;
	Wed, 19 Nov 2025 12:09:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1263A195608E;
	Wed, 19 Nov 2025 12:09:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] loop: nowait aio bug fixes
Date: Wed, 19 Nov 2025 20:09:32 +0800
Message-ID: <20251119120937.3424475-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Jens,

The 1st two patches fix error handling code paths for nowait aio.

The last patch fixes IO hang issue because of writeback throttle.

V2:
	- use QUEUE_FLAG_DISABLE_WBT_DEF to disable wbt, so that
	  check of QUEUE_FLAG_QOS_ENABLED can work as expected

Ming Lei (3):
  loop: move kiocb_start_write to aio prep phase
  loop: fix error handling in aio functions
  loop: disable writeback throttling and fix nowait support

 drivers/block/loop.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

-- 
2.47.0

