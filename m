Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D142E3364
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149110; cv=none; b=C+OoKGv6OXjYXLjZy5tgAe/JxVgA2r3bWA3YoYGM4XKGM8Gd3LFJoNKMjyQLQNL70SM3LE2W26Tw7bsf6uClLZwk3Ea88f2nT/R7uu4mMtkq3NoWp8/Rq/7M800DQ8zMzClU2ZbXDIg9MU/MuW8vAHF0X7FQd6xGEhmfagvxqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149110; c=relaxed/simple;
	bh=L66jDYsH3qckkJe+7aW+MiCVfOqzI42zGz2OJtG8ZLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJjw84PTpKG0LgLm4Oc40B8Wu8AA68fQEEOgUExgMYZuihhnXL247opOi1GwdOFz0VoI12nv7Ogqgrhk4NXEgbd2a5KI0/wYbz6IXsKHlutxMCReC/GGXpZzByC6O6R58MPd/yKQIMtawVBP9eO99yoSyZl3FRWCBSMTLriM/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb6x2agE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb6x2agE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741149107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A7upU84p3VVuRHX4bjMGicd8DATKh8wIt6Dj6Ed/ceg=;
	b=Tb6x2agEAaCiE9o6aUSMapcGPoGuk3v11eZ8VUYLDrIIuyCYaQyqyrRxwLFPJtGzApA6R5
	6kDmVmc1oMuQy9CfVif7pFMTgw+87JB5WiD+bSgfcKA3W/oUC2Y/1lPhpDLBwXnAnB/Cv7
	PlNOCXCLTAPyzPo2l6uZ0SdKurnpO4s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-84JqGe2OPxKV7FjUGLupiw-1; Tue,
 04 Mar 2025 23:31:35 -0500
X-MC-Unique: 84JqGe2OPxKV7FjUGLupiw-1
X-Mimecast-MFC-AGG-ID: 84JqGe2OPxKV7FjUGLupiw_1741149094
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 746E3180AB1B;
	Wed,  5 Mar 2025 04:31:33 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE7C51800266;
	Wed,  5 Mar 2025 04:31:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH 0/3] blk-throttle: remove last_bytes/ios and carryover byte/ios
Date: Wed,  5 Mar 2025 12:31:18 +0800
Message-ID: <20250305043123.3938491-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello,

Remove last_bytes_disp and last_ios_disp which isn't used any more.

Remove carryover bytes/ios because we can carry the compensation bytes/ios
against dispatch bytes/ios directly.

Depends on "[PATCH v2] blk-throttle: fix lower bps rate by throtl_trim_slice()"[1]

[1] https://lore.kernel.org/linux-block/20250227120645.812815-1-yukuai1@huaweicloud.com/raw

Thanks,
Ming

Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Yu Kuai <yukuai3@huawei.com>

Ming Lei (3):
  blk-throttle: remove last_bytes_disp and last_ios_disp
  blk-throttle: don't take carryover for prioritized processing of
    metadata
  blk-throttle: carry over directly

 block/blk-throttle.c | 69 +++++++++++++++++---------------------------
 block/blk-throttle.h |  7 ++---
 2 files changed, 29 insertions(+), 47 deletions(-)

-- 
2.47.0

