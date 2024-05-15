Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2DA2A
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736749; cv=none; b=kIIqURKyTuINZpWa3w8Ngyshrd3vA6AF0xAFrCAfoHCQ2kFjfQQKudEM/vF2Fcyw801rAbRT96WWZ5GHAyWccU3fY6HykiOm+vEZuoHMsyurqqcSups1gm4OPYNQvuNWfVfhvR6We1I1pvMsqGOIpdnrl7Z9qLZEkGL5yPSN5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736749; c=relaxed/simple;
	bh=KQsKaeabrKdboRHfx6hU3HkugUjk2mJbKjID2UQfhJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOT/CaG2+7LH1vczhPp83IiCgBRLBOrh1OdDT3rfWsXtYMetA+ENnlFwKuBG/ZJc6ZzbjhRTvh7RRdvOH4rsIZbH6+Pja9CvCrB2xFb6g03xVjZA/BN1xz+xXlYVszvKWf1AntmGzhTcrPXg2DMBxnz2XhQ/RGNsEGFhOpIrkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6e7D/6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6e7D/6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715736747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A5lc/yJVWR2p2x1Hi5f6Xdfhu5OJrGe1x6bCuD6KXNg=;
	b=E6e7D/6EFvTZNC1F+vyUaWYBI6HaX//V3LPCsWSgLoP+Pcx3e2wUdoslfMmTEZck4EMlhL
	AgXZlTJfb2qPqArDGIhnLRWgKr2V+DJvFfn+6nyruqVn8R79v6MpdRs9m/BY9GX8wLDGrm
	afdkTPTkcvXDeh6V+i5xEMOQ9FQoot8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-TZADKGc2NZWGI6CkFvGA6Q-1; Tue, 14 May 2024 21:32:09 -0400
X-MC-Unique: TZADKGc2NZWGI6CkFvGA6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E463085A58C;
	Wed, 15 May 2024 01:32:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9EF7C15BB9;
	Wed, 15 May 2024 01:32:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-cgroup: two fixes on list corruption
Date: Wed, 15 May 2024 09:31:55 +0800
Message-ID: <20240515013157.443672-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hello,

The 1st patch fixes list corruption when running reset_iostat(cgroup
v1).

The 2nd patch fixes potential list corruption when reordering of
writting to ->lqueued and reading from iostat instance.


Ming Lei (2):
  blk-cgroup: fix list corruption from resetting io stat
  blk-cgroup: fix list corruption from reorder of WRITE ->lqueued

 block/blk-cgroup.c | 68 ++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

-- 
2.44.0

