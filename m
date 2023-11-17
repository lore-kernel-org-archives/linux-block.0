Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZ5+ALIE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A83CE
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 18:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700188536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hV75Y3g6qlRTtL/wsIX/3EKf9lVZZ04U81b4lGV2vSg=;
	b=YZ5+ALIE23zNcqfLMnhilgGOT6rFURl+hLQB4jU6pzIgwH4MTG4hdN527BscHILgcv67Y0
	kJ26wkeOfR8XleAGILeos2EWzaT/zI0F8j8w4g4KWNNvnvpJ7qAWm12xitaz6Sxv4Nyy3a
	eG1dnR7IyrCNy1lr2Poo2/LvHFUJGec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-eQNbKAaoPCu2sdisIGI8lA-1; Thu,
 16 Nov 2023 21:35:35 -0500
X-MC-Unique: eQNbKAaoPCu2sdisIGI8lA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E34203C00206;
	Fri, 17 Nov 2023 02:35:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 073BA40C6EB9;
	Fri, 17 Nov 2023 02:35:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] blk-cgroup: three small fixes
Date: Fri, 17 Nov 2023 10:35:21 +0800
Message-ID: <20231117023527.3188627-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello,

The first 2 fixes lockdep warnings.

The last one tries to deactivate policy after blkgs are destroyed.


Ming Lei (3):
  blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock
    required!"
  blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()
  blk-cgroup: bypass blkcg_deactivate_policy after destroying

 block/blk-cgroup.c   | 13 +++++++++++++
 block/blk-cgroup.h   |  2 --
 block/blk-throttle.c |  2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.41.0

