Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85393128AE
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294704; cv=none; b=kljo+4HopYtWUfzk3jq1ymktTT0r8+IVuntkTb6a4XcmDbNdltgE1ABuQTNMuRFqgORcoGSiFtiI+A4pFLvcf0ksH0Yw15zRVR76s1MOXu8S5n+2W68whrn691XTXyWCc7/rbjZAGySikOU7ERw5GYfqvU5XtGVuRajoivDaOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294704; c=relaxed/simple;
	bh=wt4BqnF2+4xo5v3+qgiYBG9S4ZjqV8coEqnYibalv3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNaaUEBKXxSf2y0VBtvwyb+dAkdKwMDDUJWtNfN9LtBxmKYVRAWW6TheA2mTEzjaEwz3uITPZ2bWIoukL2CgoSIqYBN2q5+hFQ5ZO1FpOMGXi3f/8NT0G0UcZfRBM1OKOEaYIcn45o4g1NN1lTC7lTh8W/bViOl2Rh4RO8eAtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJDeXL96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJDeXL96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768294702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDnf4rGkR3wMvr1t/EYG1z1MkIHy1IjqNcG8YzQkDRY=;
	b=NJDeXL96XXAOvVCDKpxumEdKi9qmVSBrzqjadMuk03DfiVcyhw4DPBAfuOp5Pb+Amw6h1A
	l8B8wHLMwJ6aQP3FO04tc7iDUAajAvvua4S+VFq29/UABU8hmk8hP7AgluBioOOcdmJbnz
	Sjj3ELIDNrJVD1XnnBSWVwVYEd+zvpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-k3NHCpVNNf-xZc1kQXiGZg-1; Tue,
 13 Jan 2026 03:58:19 -0500
X-MC-Unique: k3NHCpVNNf-xZc1kQXiGZg-1
X-Mimecast-MFC-AGG-ID: k3NHCpVNNf-xZc1kQXiGZg_1768294698
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2060319560B5;
	Tue, 13 Jan 2026 08:58:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E74A30001A2;
	Tue, 13 Jan 2026 08:58:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] selftests/ublk: fix IO thread idle check
Date: Tue, 13 Jan 2026 16:58:00 +0800
Message-ID: <20260113085805.233214-2-ming.lei@redhat.com>
In-Reply-To: <20260113085805.233214-1-ming.lei@redhat.com>
References: <20260113085805.233214-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Include cmd_inflight in ublk_thread_is_done() check. Without this,
the thread may exit before all FETCH commands are completed, which
may cause device deletion to hang.

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..f52431fe9b6c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -753,7 +753,7 @@ static int ublk_thread_is_idle(struct ublk_thread *t)
 
 static int ublk_thread_is_done(struct ublk_thread *t)
 {
-	return (t->state & UBLKS_T_STOPPING) && ublk_thread_is_idle(t);
+	return (t->state & UBLKS_T_STOPPING) && ublk_thread_is_idle(t) && !t->cmd_inflight;
 }
 
 static inline void ublksrv_handle_tgt_cqe(struct ublk_thread *t,
-- 
2.47.0

