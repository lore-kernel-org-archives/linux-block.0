Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E461C8605
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707452; cv=none; b=iNAJPR/YnLfD8yfvMS0Lk4FD3wOFEiygAj6sBoAeqGKaYcZ9XQaA1/LKUMA+8gYwy8HFtLSAdbxB9LrILaIOqDeU3VECaFrTcsONIqRfWsgyCLPFc7qqgH7o3CshmQqlZgZ7alqXF98BvLd50Be8Gd4bLlBfRVZHKC55KFXvdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707452; c=relaxed/simple;
	bh=HOqgDNJso1WFX/iXBuHS2bdl9D4hzGsWRFtKrmoCRQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAeZ42pfIUR+xT8bMZ+3lO/mDzC0VKzxGmJ/P0HwGW1C/IUKpmiZ3TOexIMr36l+Rj55D4JQvg73C8ehst6P9rgRwf7I/MGuvUvUGedesafcLIcnEBv5ddrJlOKoK1+b1Dn2aw2tDacUHMX0CzT3nBMLDjVshxSYmvpc8mDIK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3iKFezL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3iKFezL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761707449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TFYAnSpeRT9wPH1v2/3lCtVLC0sJl8NQg9YvDnUrWZA=;
	b=D3iKFezLCzZByXpKrxlJKjcanc5uRVG7NfOiQPATX9tCdS7HT7sImQs9Vr/NeS9/5T/Yf6
	lCzMxzCkHsVIY4QsbZSB23ICd9AJz+1+4ncy05/8YFbQgH1mU9oeB8Ov4ARdbU/esVV/XO
	bUa1EBRt8DtRjW+tU0g0xXegGJu10w8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-YNwO-ROhP36xB7TuRcb0AA-1; Tue,
 28 Oct 2025 23:10:46 -0400
X-MC-Unique: YNwO-ROhP36xB7TuRcb0AA-1
X-Mimecast-MFC-AGG-ID: YNwO-ROhP36xB7TuRcb0AA_1761707444
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8005219540D6;
	Wed, 29 Oct 2025 03:10:44 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10D091955F1B;
	Wed, 29 Oct 2025 03:10:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/5] ublk: NUMA-aware memory allocation
Date: Wed, 29 Oct 2025 11:10:26 +0800
Message-ID: <20251029031035.258766-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Jens,

The 1st two patches implement ublk driver NUMA aware memory allocation.

The last two patches implement it for ublk selftest utility.

`taskset -c 0-31 ~/git/fio/t/io_uring -p0 -n16 -r 40 /dev/ublkb0` shows
5%~10% IOPS improvement on one AMD zen4 dual socket machine when creating
ublk/null with 16 queues and AUTO_BUF_REG(zero copy).

V3:
	- don't use DECLARE_FLEX_ARRAY()
	- annotate flexible array by __counted_by()

V2:
	- use a flexible array member for queues field, save one indirection
	  for retrieving ublk queue
	- rename __queues into queues 
	- remove the queue_size field from struct ublk_device
	- Move queue allocation and deallocation into ublk_init_queue() and
	ublk_deinit_queue() 
	- use flexible array for ublk_queue.ios
	- convert ublk_thread_set_sched_affinity() to use pthread_setaffinity_np()

Ming Lei (5):
  ublk: reorder tag_set initialization before queue allocation
  ublk: implement NUMA-aware memory allocation
  ublk: use struct_size() for allocation
  selftests: ublk: set CPU affinity before thread initialization
  selftests: ublk: make ublk_thread thread-local variable

 drivers/block/ublk_drv.c             | 98 +++++++++++++++++-----------
 tools/testing/selftests/ublk/kublk.c | 70 ++++++++++++--------
 tools/testing/selftests/ublk/kublk.h |  9 +--
 3 files changed, 105 insertions(+), 72 deletions(-)

-- 
2.47.0

