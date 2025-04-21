Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D927139D
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280003; cv=none; b=EPf9kUNMg2YUorzZ7SZUyrDBn119SrW5Q3ceUuYA5RHle6deGPUx5JdW3xa3xDV3WqVmaYyGmSSJtM4k5NaHgLIeT5CGUX7eWd6IrPLduAUL2onAfudUHJJx3dfKnHULqBCyO0hKHtwcep1dfWTPpH9S8SYEmEvIfeOOqNKlIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280003; c=relaxed/simple;
	bh=ERQr4h9JHECXQg9Qx+AdDxjhPkmj9l+qjz8mHA631o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWSm0ZkM1c0T2LmtBn9oK5apYflryEHFuTE94xXKGePeV1eSYm81YObvrZPfgdiXOsiFRleoS3B5wv8RN0CiS6mm2srtPrx2oWRfEU3bnhzYDOK5/bwTzHmHwP1z4g+eWRO+DLEA5U8esgi+olcBZuRWni7Pbf2rGEZKEmqbEfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8E+U49u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8E+U49u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745279999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OGZ59D5xSbt4+QuxkQmnqmaWIrsABMYX/8X7u0TqSH4=;
	b=W8E+U49u4/5Aov3cknTVyOg3uKvtXUuldmrTAyc5gGGY8GlvWMH4C2xCuWfEJmzUJ+P+lj
	QeaX0Lg+YyovgtHYu318zGCssHsWzrkZQZgyMN/R09KcviDMbdtSeGlxGnsw48wxcJZ/+w
	d2piZalhq/+tHtngoSDAFcw4UQSSX6o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-6vwHZdyEP0O3rw-q6rxt6A-1; Mon,
 21 Apr 2025 19:59:57 -0400
X-MC-Unique: 6vwHZdyEP0O3rw-q6rxt6A-1
X-Mimecast-MFC-AGG-ID: 6vwHZdyEP0O3rw-q6rxt6A_1745279996
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D7AA180034E;
	Mon, 21 Apr 2025 23:59:56 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64714180045C;
	Mon, 21 Apr 2025 23:59:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6.15 0/2] selftests: ublk: two fixes
Date: Tue, 22 Apr 2025 07:59:40 +0800
Message-ID: <20250421235947.715272-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Jens,

The 1st patch fixes recover test & ublk utility, and the 2nd patch removes
one useless variable from 'struct dev_ctx', both are introduced recently.

Thanks,

Ming Lei (2):
  selftests: ublk: fix recover test
  selftests: ublk: remove useless 'delay_us' from 'struct dev_ctx'

 tools/testing/selftests/ublk/kublk.c            | 1 +
 tools/testing/selftests/ublk/kublk.h            | 3 ---
 tools/testing/selftests/ublk/test_generic_05.sh | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.47.0

