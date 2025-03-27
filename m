Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D720D4E5
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069114; cv=none; b=XKFbHJwHeORM8XbVvO8IUSX7DASh3Y8XCvUKD9WC7CYw3/xN3dt91BiUcTiJfjgu2Edr69EJF812W9m+qstWMmDTchVCaktzuDao1ZxSpGvRH5yyDF5RHqHpcio+ZKvyM6e1xgA1CmNSyTKob2BY9VfX5tvumWcnq902uG4NEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069114; c=relaxed/simple;
	bh=rQmSIxKfr9upSsJzMtgWSJbQYKBpTiul6bHo74Qf4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpOvoWqQm7WwrhwSuM/ta5UKxfS/lB2Oav0yagVDR9+mMDCba5LToipgN1IeieJYJyKvto30DC0US9SP2fPEWcxyuOufV/RS52/43BJxF2n6ZfLZNvRSA2ScmCFa5bwywn2dj9WHKApuX7UNAhw8J4mFPsLOiM9ZRyCVeTfxTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hR54/xj6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hR54/xj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3tn+H0QeS4/nHHC1xsHI0cyEFtAVUc9jYX4ncqYH5o=;
	b=hR54/xj6dlcJnu95+l3pRd1YVagypQa+E5qAMOEBsN3psIlhTkbR0KkjJuxP3KSn6Z1Fwq
	GOEl65zK31+vHdEfdvoCtWnN8jfoRvZdnefqKcrZ9JGElFKAGZU3mQHOy5jyI9maKkDx8t
	SE2VhNr1JlEuR6H0wOCu68tTmrf9OAQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-huEmf7QyOhyXTG0kAFK41w-1; Thu,
 27 Mar 2025 05:51:48 -0400
X-MC-Unique: huEmf7QyOhyXTG0kAFK41w-1
X-Mimecast-MFC-AGG-ID: huEmf7QyOhyXTG0kAFK41w_1743069107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21ED418EBE95;
	Thu, 27 Mar 2025 09:51:47 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E137A180B486;
	Thu, 27 Mar 2025 09:51:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 03/11] ublk: remove two unused fields from 'struct ublk_queue'
Date: Thu, 27 Mar 2025 17:51:12 +0800
Message-ID: <20250327095123.179113-4-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove two unused fields(`io_addr` & `max_io_sz`) from `struct ublk_queue`.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5b0c885dc38f..b60f4bd647a1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -143,8 +143,6 @@ struct ublk_queue {
 	struct task_struct	*ubq_daemon;
 	char *io_cmd_buf;
 
-	unsigned long io_addr;	/* mapped vm address */
-	unsigned int max_io_sz;
 	bool force_abort;
 	bool timeout;
 	bool canceling;
-- 
2.47.0

