Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0F481658
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556718; cv=none; b=mGdTKlxY7SyK4TW015iB+Wb9f/swSp3hE5bH2sLuCHN2HmHO/3eLqGcC4uEJlQAg5AFAPs9Xzoa67m1J2kKo9Gn/yfz0fT0CII63m3RCQiFdOLIdBDt/ovp0DmYzlDfRUDwwr1LKt+fRv8O4kZZsH5lrOP8Sei3GhGZUNavzJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556718; c=relaxed/simple;
	bh=vBVDxabF0fYe7uGeadTgSZMnd6NJftBLwhRzerfduHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUhNpIksujkgUrmR9QyeV8Fucl7pRy7B9cRVOYR2YTmJhohexOpLod+iVsroGKerYlFLb9YxJ8wXWnSqxlRHi4DNKslxTGIOxYSKMB9rshmt4Lnaxfo2boZwfEf1wjVJ2PhNQQsUQ5mimHOJnnEAOqRyWFcviuoD7rRsPPC5Jc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2QFiBZc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2QFiBZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786556715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lm41zW9D1y3E4PwZafbwiXqMQCx3MNP6JwnBey25G+k=;
	b=a2QFiBZc548Na9ab0Spq9nMVEqjUl39Rcv7/rjSKl96St+OjsThpWp4j2x8b/mAp/dpchr
	3Ln0Fw7GYnRTJMHGq5NsF2/9uarREY/3a6O/y9Iz2h6oFDtNqtyGoK4RpYBDZxOltau6zO
	uYYXRcDlXTjy1DIBC//jp4HEBWY4nAc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-6E8z-0dTMc2bHr-BnevhVw-1; Wed,
 12 Aug 2026 13:45:10 -0400
X-MC-Unique: 6E8z-0dTMc2bHr-BnevhVw-1
X-Mimecast-MFC-AGG-ID: 6E8z-0dTMc2bHr-BnevhVw_1786556709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E19418009C8;
	Wed, 12 Aug 2026 17:45:08 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 469FB195DF98;
	Wed, 12 Aug 2026 17:45:06 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH blktests 0/2] Test multipath and marginal ports
Date: Wed, 12 Aug 2026 13:45:01 -0400
Message-ID: <20260812174503.3705830-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Tests for the upcoming nvme-fc: FPIN link integrity handling set.
It tests for various multipath and marginal port
scenarios, while confirming the port usage and state. The test is
intended to emulate receiving an FPIN event in a multipath environment.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
Link: https://github.com/linux-blktests/blktests/pull/264

Jesse Taube (2):
  nvme: Add _setup_nvmet_port_marginal
  nvme/070: Test multipath and marginal ports

 common/nvme        |  30 +++
 tests/nvme/070     | 521 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  43 ++++
 3 files changed, 594 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.54.0

