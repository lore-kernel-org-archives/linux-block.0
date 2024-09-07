Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB8D51E
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673424; cv=none; b=MKx+nNnNJSugiUNicVZICns2EUj0/O7og8F6MRJHuh/ky+kJ5wBUYe+2jFAG2c1sSuB/HCOCKezdFfSzMGCL/yOMRcuEpijN7djkgPYLBsviwZus8ua4TwCPydgs1+xC2zw7FGBzaUNGGxUw75Y7AdOFLKtCz6CiON3KYdo+k3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673424; c=relaxed/simple;
	bh=6uxixK1scc3K+z0ywE7Kx+a8Uqz1dVp+pcAI4wjlEFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCicTo7MFJKZx0lYoFxfUJqZxJcOgWpXY+rvJlf7RTl+JsguPcI7VHoYOll9x4MeKFSjV7RRvdY0OG0DS474KVYoavY+JxwdGwstF3SqBaog2VMjonGaI1mr40X/bwkLUdpsqy8VZM4+IrDC7KflNBm3KuOkMRjIqamSFTMM7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnHmW3UN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnHmW3UN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725673420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fLxyk5SAcbYAhfF4ou7MIyPctVVOwWxw2qf0CQY8HEA=;
	b=gnHmW3UNQxtjskpj9E8VlNj+iXHJhDuieDkNAiSU0bjF/4BkS7REUD0T3CyaejiLk3YtJL
	p+++UYgGotcfvQuwjt7qdPAy2MHkYQDwtbUpPbdyTtKdcyvphCgEfv1u+iL0euKLQJ9le/
	NTmaaykYJrk04ynLFTKfzjpQ3zYQ6fk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-wFbVyhcJOdugbaxpxGUQ8Q-1; Fri,
 06 Sep 2024 21:43:39 -0400
X-MC-Unique: wFbVyhcJOdugbaxpxGUQ8Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BE6619560AB;
	Sat,  7 Sep 2024 01:43:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1ABC51956056;
	Sat,  7 Sep 2024 01:43:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Richard Jones <rjones@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>
Subject: [PATCH] block: elevator: avoid to load iosched module from this disk
Date: Sat,  7 Sep 2024 09:43:31 +0800
Message-ID: <20240907014331.176152-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When switching io scheduler via sysfs, 'request_module' may be called
if the specified scheduler doesn't exist.

This was has deadlock risk because the module may be stored on FS behind
our disk since request queue is frozen before switching its elevator.

Fix it by returning -EDEADLK in case that the disk is claimed, which
can be thought as one signal that the disk is mounted.

Some distributions(Fedora) simulates the original kernel command line of
'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
hang is triggered.

Cc: Richard Jones <rjones@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Jiri Jaburek <jjaburek@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index f13d552a32c8..2b0432f4ac33 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -676,6 +676,13 @@ void elevator_disable(struct request_queue *q)
 	blk_mq_unfreeze_queue(q);
 }
 
+static bool disk_is_claimed(struct gendisk *disk)
+{
+	if (disk->part0->bd_holder)
+		return true;
+	return false;
+}
+
 /*
  * Switch this queue to the given IO scheduler.
  */
@@ -699,6 +706,13 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 
 	e = elevator_find_get(q, elevator_name);
 	if (!e) {
+		/*
+		 * Try to avoid to load iosched module from FS behind our
+		 * disk, otherwise deadlock may be triggered
+		 */
+		if (disk_is_claimed(q->disk))
+			return -EDEADLK;
+
 		request_module("%s-iosched", elevator_name);
 		e = elevator_find_get(q, elevator_name);
 		if (!e)
-- 
2.46.0

