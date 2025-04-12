Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CA33EC
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425059; cv=none; b=HtTS7oPGEOaOwn8G4olgF6VbgTzdHT6sRbfU6DyoN1ZGIITTTg5QsfLj5IkSXoU1FKaU65laIIAsDcbnEJfLNxKm4T+ZompUvGGGIC1i0lLUhDJI/KJcupImvAunIQFkb89qByAoUt8P9I2PpxIpfEQNNeWrBk1cInB2fRDIM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425059; c=relaxed/simple;
	bh=V/Emxn2F93Xx7CkMNFxOFvDEheYG/DDwDGci4K/ZNZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS10xYJW/NtjZRxxMzU0hplj6LFAUxsrGP9jkKvlNVmpJmeA/1qEVdGF3E7Da+BH8lVO4zUZlI07k7mPCWqC7tH39BW/GPPu2PCFZ8C4vN/wFlZvluW5y6X4/5R+dFhHqR6aCR31cStwF+wGaSV0uR6t0RyYCtD/BdXOvr5diM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQIRVbri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQIRVbri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8js/cmjwFtSOFjVEbPxtbck2tkZXBXh/oAoO72fAIEI=;
	b=PQIRVbriy9ApHPRo4ouKlI2xz9SSRc25sqHZP3MUlItW5dkHd9kQbIdHqNgdQVBnpfjFGQ
	j1xrtUaHA6rGnrRV/tFFlZKoZdCrV9cHtH7G2868Mjp2Kt65vYoP7eyVIajxjCT4YOOgMJ
	lHfjdZh+ZidGfA/YEToQ/Iy4EnKR5KU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-t4dTn_L3Nbm2vdeybGTJuw-1; Fri,
 11 Apr 2025 22:30:53 -0400
X-MC-Unique: t4dTn_L3Nbm2vdeybGTJuw-1
X-Mimecast-MFC-AGG-ID: t4dTn_L3Nbm2vdeybGTJuw_1744425051
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ABBE19560BB;
	Sat, 12 Apr 2025 02:30:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4F8D19560AD;
	Sat, 12 Apr 2025 02:30:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH V2 01/13] selftests: ublk: fix ublk_find_tgt()
Date: Sat, 12 Apr 2025 10:30:17 +0800
Message-ID: <20250412023035.2649275-2-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Bounds check for iterator variable `i` is missed, so add it and fix
ublk_find_tgt().

Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 3 +--
 tools/testing/selftests/ublk/kublk.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 91c282bc7674..74cf70b2f28e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -14,13 +14,12 @@ static const struct ublk_tgt_ops *tgt_ops_list[] = {
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
 {
-	const struct ublk_tgt_ops *ops;
 	int i;
 
 	if (name == NULL)
 		return NULL;
 
-	for (i = 0; sizeof(tgt_ops_list) / sizeof(ops); i++)
+	for (i = 0; i < ARRAY_SIZE(tgt_ops_list); i++)
 		if (strcmp(tgt_ops_list[i]->name, name) == 0)
 			return tgt_ops_list[i];
 	return NULL;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 760ff8ffb810..73294f6e3e49 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -30,6 +30,8 @@
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
 /****************** part 1: libublk ********************/
 
 #define CTRL_DEV		"/dev/ublk-control"
-- 
2.47.0

