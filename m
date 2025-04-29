Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD118DB14
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893798; cv=none; b=J6tGxVhdfJr2ecuBEqZwFSnhO5zesXSnu9FVRi1Cai3AHnLHOMf/XmaW0Bzk3i8HoIc7lC223/RDeYhHyG0pb5aU5MSoG/q9d0W8cvXLweVfcVNOl4iF7HFG4hVe9C8tEup9cxv0+wBFLRztror5FqP0mrXd1IXDL7SJQgeBR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893798; c=relaxed/simple;
	bh=dvY7ekfvkQfEUodZrf/Gb8MRZGH6W8I8YVSrdotsjvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcjdQb/BUceR02+T03LfBzccPXpyM9pcx9OHEVH3fFfuBdefLaKToMObAYIMcU3LP+Tnz6cb+tETOS6pqD6QkFMiPkESJe8aRsfpGx6FAyijYrKXrmuVYflTIz4lsMLnL4RFrt272sLOdp0wEZ3E+Tq9DkNXNAHF2C7b9VGHDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPLtWseZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPLtWseZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745893795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ni9e1fTX0UI6xlCutgoYoPnVqsC6yF2ZxYub/3kIJuE=;
	b=ZPLtWseZQLL1Zjgv0xRukU9YUWePMvUDiXVyWeTSd8I/Af1cSTHvODwePAbXZWXp6RpsdX
	OS00hdRdADrj0VxGUO2606vxJ3xKgr7myYrTc1i4vn1dZaoLUnYkJxtrYIZvYqSNJ0oiTn
	gIYj4vxKINAa+kV3XBbBtycOcaRXyAk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-lvKU5sDKMCOuyeetoFH0bQ-1; Mon,
 28 Apr 2025 22:29:51 -0400
X-MC-Unique: lvKU5sDKMCOuyeetoFH0bQ-1
X-Mimecast-MFC-AGG-ID: lvKU5sDKMCOuyeetoFH0bQ_1745893790
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A42531800370;
	Tue, 29 Apr 2025 02:29:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71FD3195608D;
	Tue, 29 Apr 2025 02:29:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6.15 v2 0/4] ublk: one selftest fix and two zero copy fixes
Date: Tue, 29 Apr 2025 10:29:35 +0800
Message-ID: <20250429022941.1718671-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello Jens,

The 1st patch fixes UBLK_F_NEED_GET_DATA support in ublk selftest side.

The other two patches enhances check for zero copy feature.

The final patch removes one unnecessary check.

Thanks,
Ming

V2:
	- add have_program check in new added generic_07 test(Caleb Sander Mateos)
	- fixe usage help of ublk utility(Caleb Sander Mateos)
	- add the 4th patch for removing one unnecessary check(Caleb Sander Mateos)

Ming Lei (4):
  selftests: ublk: fix UBLK_F_NEED_GET_DATA
  ublk: decouple zero copy from user copy
  ublk: enhance check for register/unregister io buffer command
  ublk: remove the check of ublk_need_req_ref() from
    __ublk_check_and_get_req

 drivers/block/ublk_drv.c                      | 62 +++++++++++++------
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 22 ++++---
 tools/testing/selftests/ublk/kublk.h          |  1 +
 .../testing/selftests/ublk/test_generic_07.sh | 28 +++++++++
 .../testing/selftests/ublk/test_stress_05.sh  |  8 +--
 6 files changed, 91 insertions(+), 31 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh

-- 
2.47.0

