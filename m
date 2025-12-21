Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325A137C52
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766335321; cv=none; b=CGp/AkZnVojrUZW8fCMYL+PKFozPF36UaJ6kF+F12UAg7FygW5QKvjB22T7UvNpnPFCbyQOfrxSOetMifqL05w7lpEniQw6fSJABB/t2Og6PFatrVkeefsChreHo/I6XgnbA/B3ANJxZkpLcw5b/6M4D+rDnJAXvrrsanq/EmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766335321; c=relaxed/simple;
	bh=SNm3tRFPU9QMTtrWiYt45GENZENv0Ci7ZnBKx9lKN/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLxeXMgC/G3GS/wRcCbkmpsZEQtwavq2aazYG/dIYLrVlLds2Xb9hQhHdheceznHWcnHNuVE1vm3ebqjOh7wMoBb/9AIleJCi2EcXG8OucWF/UGg3L0ahuJOIMBVjZf6WjqdKK/RN88O6iJAvslBl9irty4hJiM6jCQt/FWBpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSZXiq9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSZXiq9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766335318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zIH9PNwIEsvHivSEkhOPdlVvnIRKLF/etWHvaUoXq5o=;
	b=TSZXiq9yHUy7TwQTWgvVjje2aL+wZGG6uGmEL211UxjyLrh6O/Tf5H29w0M/6mEfzqDdKk
	tLgXJZfj9cettTvOBtKGwcZQLvAYSvRppJpQ/c0/IBJ0t9S37lDQ5HtXNfrNnJ/wVckT1F
	RUTI4BGIGdZ79OVlMCZ2kASfxYWOq38=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-si8EtwU5NReGG5tvTm2eJQ-1; Sun,
 21 Dec 2025 11:41:54 -0500
X-MC-Unique: si8EtwU5NReGG5tvTm2eJQ-1
X-Mimecast-MFC-AGG-ID: si8EtwU5NReGG5tvTm2eJQ_1766335313
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 311551956088;
	Sun, 21 Dec 2025 16:41:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24F68180049F;
	Sun, 21 Dec 2025 16:41:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] ublk: scan partition in async way
Date: Mon, 22 Dec 2025 00:41:40 +0800
Message-ID: <20251221164145.1703448-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Guys,

The 1st patch scans partition in async way, so IO hang during partition
scan can be covered by current error handling code.

The 2nd patch adds one test for verifying if hang from scanning partition
can be avoided.

The last patch fixes one selftest/ublk rebuild depending issue.

Ming Lei (3):
  ublk: scan partition in async way
  selftests/ublk: add test for async partition scan
  selftests/ublk: fix Makefile to rebuild on header changes

 drivers/block/ublk_drv.c                      | 32 +++++++-
 tools/testing/selftests/ublk/Makefile         |  7 +-
 tools/testing/selftests/ublk/test_common.sh   | 16 +++-
 .../testing/selftests/ublk/test_generic_15.sh | 80 +++++++++++++++++++
 4 files changed, 126 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh

-- 
2.47.0

