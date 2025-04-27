Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947B610D
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745761792; cv=none; b=nugfdU+MWmAItcy69oN5xp7JE73lYaHDYLIktUoL5yPAAUATqtord/kp1lNZ8Lqh9KJVkDE1jKizmn7sMeKf2mNMa42x5JY7MPNsx5LllC1ADCYlG4r/Sx5ErCaqMBNnn8bmNkDA4Z3nwF2JEgFT2K+hxXOzk86J+YUZ3jdrabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745761792; c=relaxed/simple;
	bh=//qfI+Cyg92ldn14HugWDNMHoaTW93oAZdjwD+QZr+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJdJj6ZnT29UZu15XPKE0XdaGH2uRJ1oe11/lE4u2Bs5L9E0URG4iDVEAGTK5VhMDvOIZk7b51AmxVgOavifE+ougRNHdtP6V35V8qBZF4I8qwFKoBEs0H9nxb2Ti0bAYRkGSqZ6DXgN5vJoPQYm6camiIzcX3XlWnmw7dExgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbDWZCUC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbDWZCUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745761790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXpwNj0HNXk+8ouXHZTWmYFD9tUu/wj3rCR0QdWthZQ=;
	b=TbDWZCUCyojfIxkKcjTbcFeZd6hh/aDeGCTODI/4HEjuJdFhMSyQUDiL/VmK/czXxlYRv2
	n/gTj6YFroOSukpVDgDaAYs22eRi93kW6/JqqSi6on/EzWU6b+ENhN9AFFHUjG5Kr3aVvr
	8uoAQN7Sb6DwdAKk6UykPiKIYmYofes=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-GGEEeut0O2aVLoNmttbW-g-1; Sun,
 27 Apr 2025 09:49:46 -0400
X-MC-Unique: GGEEeut0O2aVLoNmttbW-g-1
X-Mimecast-MFC-AGG-ID: GGEEeut0O2aVLoNmttbW-g_1745761785
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D21A818001EA;
	Sun, 27 Apr 2025 13:49:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.119])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A64D19560A3;
	Sun, 27 Apr 2025 13:49:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6.15 0/3] ublk: one selftest fix and two zero copy fixes
Date: Sun, 27 Apr 2025 21:49:26 +0800
Message-ID: <20250427134932.1480893-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

The 1st patch fixes UBLK_F_NEED_GET_DATA support in ublk selftest side.

The other two patches enhances check for zero copy feature.

Thanks,
Ming


Ming Lei (3):
  selftests: ublk: fix UBLK_F_NEED_GET_DATA
  ublk: decouple zero copy from user copy
  ublk: enhance check for register/unregister io buffer command

 drivers/block/ublk_drv.c                      | 59 ++++++++++++++-----
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 20 ++++---
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_07.sh | 24 ++++++++
 .../testing/selftests/ublk/test_stress_05.sh  |  8 +--
 6 files changed, 86 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh

-- 
2.47.0

