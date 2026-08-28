Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AC226D18
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931046; cv=none; b=llfizRQFrsvRQhzmW20BcOvD9H9ZZ7lcJfN4n2loI+pmirYrRB0NMbhxMqz1ebosZTvWeNLuSJi79GxN4Ngi2FIjRs9Fv/VQPMy0sVvQwaRlHH3QRPYRNZgIRNJXuw0b22+nXjn9rFzjeoGey49oFRGtoDVVvC4s9WbJEjgWXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931046; c=relaxed/simple;
	bh=yusfmBL9svyY6nOvvHTlQAwXGClT7b8szoSn4klTyPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EG1DlQo67ltzLGTUrtDbJtjBhzWnpRThLuN+Z2UToiS7Sik7DN20GFJ9VwJQb1Bd9W8gXxq1Q7Gi29gGTpgz9CL2j67bArVaEYB/1cDJExKDsoo1/Rq3L/n7V1iUsprnzIkd0DFTpFyR0q5e0X8vP0XLGNnOJO2wuSQh2LtKvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euV9O8IW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euV9O8IW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787931042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdjCvINA0cwlE2/4yuBDf8b7Wm2saPmhAU2BAVB86Ek=;
	b=euV9O8IWYSlzqM0HJJMv1t21+dNobK4nsgBmbVxXq/PduQvbhiZAu/sippkF+ozq1CYrTa
	7y7iM8FOBgNemcocd8Nz6LdZxd8TXeaLUVuvlSHjee27D7zXR0H657voR37zzTq7phDyhU
	+p/bO2+J2GSLejj7EpkPp3ciSWQSveI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Cnz8mARjOdKTPva7-lntBA-1; Fri,
 28 Aug 2026 11:30:35 -0400
X-MC-Unique: Cnz8mARjOdKTPva7-lntBA-1
X-Mimecast-MFC-AGG-ID: Cnz8mARjOdKTPva7-lntBA_1787931034
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1EE219540CD;
	Fri, 28 Aug 2026 15:30:33 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.80.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 472DC18005B1;
	Fri, 28 Aug 2026 15:30:32 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [blktests v3 0/2] Test multipath and marginal ports
Date: Fri, 28 Aug 2026 11:30:27 -0400
Message-ID: <20260828153029.853768-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Tests for the upcoming nvme-fc: FPIN link integrity handling set.
It tests for various multipath and marginal port
scenarios, while confirming the port usage and state. The test is
intended to emulate receiving an FPIN event in a multipath environment.

In V3 various generic link checking code was move to common/nvme.
This is so that it can be used by other tests to check if multipath
working correctly, even on kernels that dont support marginal paths.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
Link: https://github.com/linux-blktests/blktests/pull/264

V1 -> V2:
 - Fix timeout issue
 - Skip test if /sys/class/fcloop/ctl/set_marginal_rport does not exist
 - Wrap lines at 80col
 - Add John's tags
 - Fix various change requests from mailing list
V2 -> V3:
 - Add tests for inaccessable paths
 - Fix fio not exiting
 - Move generic code to common/nvme

Jesse Taube (2):
  nvme: Add _setup_nvmet_port_marginal
  nvme/070: Test multipath and marginal ports

 common/nvme        | 278 +++++++++++++++++++++++++++
 tests/nvme/070     | 454 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  49 +++++
 3 files changed, 781 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.54.0

