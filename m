Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7769463
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715509; cv=none; b=BMFjWIzpjf9P2DuRJcMUPHW/3KOn9x7doKleIX+9sw0hJZppg0GAp6hJ442weYxLloMz49pV1yjPl2nPUWtj2XO4VpBdffXMddstGVcggs7iI5OSLRA3DmuabptLKpvtt18+FbppeigIdMgQ4NMpOR86fcU+nQJXtATaov1ia9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715509; c=relaxed/simple;
	bh=PJ1ZGwH/RYqaFthmml+/Do+RiW8T1pHGrh6bjz5Fipc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvVueyFr2mFWTe48DgGixcIjCVTme8L94SkxCssvfJ+HMp49E211rLH/ILVbvobUEsBEO6rwXql/ckksN+9pldriCiwmr4933lQopghfLPCNIhuaIcgw87kPxQaRJVE9Z/5Br7jAWP0HIhPYhMgUjs4ccWM9UON8zk/cwaKTJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3TvMLSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3TvMLSZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CNMieq7O/uwnerULtTiR2qkvguYFX57ajSlBBE3RlNU=;
	b=X3TvMLSZ650mKpg4/DkcOKD2M+E2JTHEBUB+D0j/jFWjOzIQtEGsmU3QU1vlLUhUxu5vIp
	kwHxhY785XVqRdjeuwBYYyDZpjnKy6cBbcDKMZnT7yZfsqxp/xuiaXoBcfPRtkmRlWlihO
	GqBgxwDtuSR6Yrx5osHwrSBL52XMfxk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-o2JrIydSORKFfUNrCHBarw-1; Wed,
 27 Nov 2024 08:51:45 -0500
X-MC-Unique: o2JrIydSORKFfUNrCHBarw-1
X-Mimecast-MFC-AGG-ID: o2JrIydSORKFfUNrCHBarw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AA981955F68;
	Wed, 27 Nov 2024 13:51:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 734251956054;
	Wed, 27 Nov 2024 13:51:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] block: cleanup queue freeze lockdep
Date: Wed, 27 Nov 2024 21:51:26 +0800
Message-ID: <20241127135133.3952153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello,

The 2nd patch kills false positive caused by removing disk io lock
modeling in blk_mq_freeze_queue().

The other patches cleanup & improve freeze lockdep model.


Ming Lei (4):
  block: remove unnecessary check in blk_unfreeze_check_owner()
  block: track disk DEAD state automatically for modeling queue freeze
    lockdep
  block: don't verify queue freeze manually in elevator_init_mq()
  block: track queue dying state automatically for modeling queue freeze
    lockdep

 block/blk-mq.c         | 10 ++++++----
 block/blk.h            | 23 +++++++++++++++--------
 block/elevator.c       |  7 ++-----
 block/genhd.c          |  7 +++----
 include/linux/blkdev.h |  6 ++++++
 5 files changed, 32 insertions(+), 21 deletions(-)

-- 
2.47.0

