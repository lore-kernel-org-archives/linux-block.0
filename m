Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51B2C11C2
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460477; cv=none; b=R8G6PI1YrxTtbAH3Gbq5vbtAHeiz2Kecc7jbIgF3EyD1Hljul1WpjHQTlEvCldpTDM4tUaNppfpzJqmvge3GKW43jURIUTWdFnglOu2Pd1qZwUaNFW1tEWirDF85SKYz0q2cHlsiTXc1IPconUtG4eTkKd/td7JvNNBHwkq7f08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460477; c=relaxed/simple;
	bh=UvIYBswDb7OAJBx+aOfTLluxRNbZ5vfhg84S9W89lqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tb1Wmhia7rmwsmv/yKctsy/qOIiKRbGIz64flTX70HpZXW33mrRLdf2aXLDRmcopneeXNAZZpP/cZ9ZMpxiry38Gfp0ha9ouTs9FCQPX6/4G48RM5+ofwnmD7TwFwTZrCKgrz0VT+05IOoz8zEpBBv2wH8wpaX5awD6mXJmZRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erhGbqBS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erhGbqBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766460474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cEtPeuUX9J60EEycGpORZo+SSxAZ7l2BWcakN9qYZ38=;
	b=erhGbqBSAiYzIluXM0ksngeQ4gZOaQ53R0IJjea2lTsGUAVpe652lJF/4rouhIPFSnJoBg
	CfzAgCB+5z/4rw7WRVWgM7941kLSmtHaK3RnUoptS5bNQgDEsSUODZyVU9fJYAzcRwuF+2
	3F01sE5L1IJR5oF0le/Jy7Q4/vTwyjQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-K_05Rn1pOZeSbm4CXniD8Q-1; Mon,
 22 Dec 2025 22:27:52 -0500
X-MC-Unique: K_05Rn1pOZeSbm4CXniD8Q-1
X-Mimecast-MFC-AGG-ID: K_05Rn1pOZeSbm4CXniD8Q_1766460471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B2CF1800378;
	Tue, 23 Dec 2025 03:27:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.97])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98BE530001A2;
	Tue, 23 Dec 2025 03:27:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] ublk: scan partition in async way
Date: Tue, 23 Dec 2025 11:27:39 +0800
Message-ID: <20251223032744.1927434-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Guys,

The 1st patch scans partition in async way, so IO hang during partition
scan can be covered by current error handling code.

The 2nd patch adds one test for verifying if hang from scanning partition
can be avoided.

The last patch fixes one selftest/ublk rebuild depending issue.

V2:
	- fix one comment typo in 1/3(Caleb Sander Mateos)
	- simplify test code: 2/3
	- fix `LOCAL_HDRS` usage in patch 3/3

Ming Lei (3):
  ublk: scan partition in async way
  selftests/ublk: add test for async partition scan
  selftests/ublk: fix Makefile to rebuild on header changes

 drivers/block/ublk_drv.c                      | 35 +++++++++-
 tools/testing/selftests/ublk/Makefile         |  5 +-
 tools/testing/selftests/ublk/test_common.sh   | 16 +++--
 .../testing/selftests/ublk/test_generic_15.sh | 68 +++++++++++++++++++
 4 files changed, 115 insertions(+), 9 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh

-- 
2.47.0

