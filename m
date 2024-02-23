Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EE513AED
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674977; cv=none; b=hOo1LcfxbYJLe6lGyywevQ2OpNeea5+BLSO/Wl4rmRpcFdbd2kCLpvM1D1aGGh3Mm67gnOBRM7Y2FQNbqF4hSRkINFY2HriiBbx3cC+yskAXk4Aw2WFHiSAZb2lY1RMCPDAkqpuP4F6eqWQJUrMTBaGdQR7l0IKtkOajWleq5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674977; c=relaxed/simple;
	bh=KwoD9PCRJlE17cQXnVWZiL7GwWSWGAYhTYIRSUWOOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPUnivYQiPNsdkeLZhyS6M6KMvtcy2+zTgQFp5alVFU+VLqtkkxFfzMpU32AJNEd0mo5IQCL+XptE6L8XFFGymfrRaSlz9Fw3zKrxv/tQWwujyPxVJN1oId5CyrRmQO1CUECR+cVsABiBLQsw3ubUo5jUKGEExiAWT+gVMf/Oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agLhBSlD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agLhBSlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708674972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2cnK4S8NxZasYFWFV5SQKDiIri9gQWepYKQr7raDhfs=;
	b=agLhBSlDSbXfFmySadY0yIsyPVzdFpQ5zgN7R8lztKli+zHysIWN3jY0ifMQcsYj5TJh7a
	RPHdI8LvcsRgoEEIPTsDkzM1HhBXaDGQXqVhLy9hwbsO6qyjmW/Whj3bJyDW+C70vRFpHZ
	H3K0pqjfsw6IDEnHl4MlBQ0Ho+YF8WI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-6UMRC2zGOSqu8HkrV0nUvQ-1; Fri,
 23 Feb 2024 02:56:04 -0500
X-MC-Unique: 6UMRC2zGOSqu8HkrV0nUvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85E143806720;
	Fri, 23 Feb 2024 07:56:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.79])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95AE12166AEE;
	Fri, 23 Feb 2024 07:56:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: improve ublk device deletion
Date: Fri, 23 Feb 2024 15:55:37 +0800
Message-ID: <20240223075539.89945-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hello,

The 1st patch cleans up get/put device, and annotate them
via noline for trace purpose.

The 2nd patch adds UBLK_U_CMD_DEL_DEV_ASYNC so userspace device
deletion can be implemented easier.

Ming Lei (2):
  ublk: improve getting & putting ublk device
  ublk: add UBLK_CMD_DEL_DEV_ASYNC

 drivers/block/ublk_drv.c      | 21 +++++++++++++--------
 include/uapi/linux/ublk_cmd.h |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.41.0

