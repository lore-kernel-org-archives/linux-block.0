Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A463009F2
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169878; cv=none; b=mqZWhnTnwgmGutVGljPhuF/JZcZagyHPytDaVbjoEfu+jo+FyCgArDdFb2E8oF9mmS3uczY3SX1YycPzUdQuf2HRkIoHPFW9SEkouG14ENNccZ5nOuTsnKe0xpoBiz8ZFT1VUJjT+CyO9pnlZWiMwstlDFByp2RNi4Fs2DgILbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169878; c=relaxed/simple;
	bh=qGkqLlDl/zgz0nfl4xdkoO75AW1/TrLia/Swjqef9j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+se5ZWCjFhnz3/9qZ5DcOVPe2YhXOsqqkB2AEMOjHOyBTjWGJhXU/Ro77IaF9xGvhQgaPYetC0fUfwOYos+tCrAm+YR9L5kr6/feW9zuxoVt6y9L31tSwl+dGRw0WuHLIbk98gwswtl3wWKLG8YCYtvrj/T66SdzD6SVPppeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6BUmS0f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6BUmS0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787169876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DVprECuFqi5/25eTasTEjoxbRyEm7VP4LBrO4h9TFwY=;
	b=d6BUmS0fATHYLbZdt606sIlj42ca6zYFAtnDJkdFGIW/ymeGJYXrenO5X8vf4Zf/DX4oZH
	YHeM7ET53/UL4uQeDpVnUgFCG+xUWhVEliPKhCXHTh2EVNNct687adDNmxmtanx3QBjTq7
	2gBxWLS5rRybqNDYwDG4T6KznnoTSac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-K4lxCDZvMwiK5YpEUdT2bw-1; Wed,
 19 Aug 2026 16:04:32 -0400
X-MC-Unique: K4lxCDZvMwiK5YpEUdT2bw-1
X-Mimecast-MFC-AGG-ID: K4lxCDZvMwiK5YpEUdT2bw_1787169870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5992B180035C;
	Wed, 19 Aug 2026 20:04:29 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.17.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8AF2180049F;
	Wed, 19 Aug 2026 20:04:27 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	shinichiro.kawasaki@wdc.com,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH v2 0/2] Test multipath and marginal ports
Date: Wed, 19 Aug 2026 16:04:23 -0400
Message-ID: <20260819200425.194743-1-jtaubepe@redhat.com>
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220329
Link: https://github.com/linux-blktests/blktests/pull/264

Jesse Taube (2):
  nvme: Add _setup_nvmet_port_marginal
  nvme/070: Test multipath and marginal ports

 common/nvme        |  31 +++
 tests/nvme/070     | 613 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  43 ++++
 3 files changed, 687 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

-- 
2.54.0

