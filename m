Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5B332EB9
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573257; cv=none; b=OJiyWhZL8YpMJTmm/jnHL24gjgAdvK4EbaVx3549VThXTYCIo4fFpLvBPeQnp3cRiJHJZn53JMrW9tUaMv+hbfdFP8K4rE5eQug2LyLNbuImvfGiDrM2D5cAZEVr99WnZcJYYAgW1GhPbnRbI4l0e73m3Ffzy1nJYJAvLo5cyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573257; c=relaxed/simple;
	bh=NrEXo68yPwa3hxUP62ZY6nIfv3gLCefav8O7QAhAaDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia2K+Y4L71cf92FHEYwt2EplKyoMY9P74duWFv7Mt8rz9q29uerbKJ94saMNAuQqpYWGfuzGzWgmgrBoy4/ufnr3E3Uurbd0tafLLD01IYqTttvuvdypGSlxr/YX+RAKtClw/Ewgf5SKSmpBa+qWLzvMKb1H7OidUAuv98TxFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz+91U80; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz+91U80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768573252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCNdV9Ez9YXQFCIELWx1HpdNzEX/g9J/sK+a6tyislo=;
	b=Sz+91U80/QmKezlUQU6dFCcvijRIpUOkgjpukj8UvZodv+4bILr951Q99bgt9zybdUVcL8
	yaaUJJoNDTgwkRd54fFbpZciTYoyF8dNhMFYGDdfAkZuOQbqKpsWrQ9UEBOFDOe73r3k2b
	LhSiyng2lh9FVYxAk5U49VP7SdfprRw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-puK3Z_fzPCWUHa25UCyRdA-1; Fri,
 16 Jan 2026 09:20:50 -0500
X-MC-Unique: puK3Z_fzPCWUHa25UCyRdA-1
X-Mimecast-MFC-AGG-ID: puK3Z_fzPCWUHa25UCyRdA_1768573249
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DDB918005B7;
	Fri, 16 Jan 2026 14:20:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A833B30002D6;
	Fri, 16 Jan 2026 14:20:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 22/24] selftests: ublk: increase timeout to 150 seconds
Date: Fri, 16 Jan 2026 22:18:55 +0800
Message-ID: <20260116141859.719929-23-ming.lei@redhat.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

More tests need to be covered in existing generic tests, and default
45sec isn't enough, and timeout is often triggered, increase timeout
by adding setting file.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile | 2 ++
 tools/testing/selftests/ublk/settings | 1 +
 2 files changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/ublk/settings

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 3a2498089b15..f2da8b403537 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -52,6 +52,8 @@ TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
 
+TEST_FILES := settings
+
 TEST_GEN_PROGS_EXTENDED = kublk metadata_size
 STANDALONE_UTILS := metadata_size.c
 
diff --git a/tools/testing/selftests/ublk/settings b/tools/testing/selftests/ublk/settings
new file mode 100644
index 000000000000..682a40f1c8e6
--- /dev/null
+++ b/tools/testing/selftests/ublk/settings
@@ -0,0 +1 @@
+timeout=150
-- 
2.47.0

