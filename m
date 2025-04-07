Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE7253B53
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031762; cv=none; b=ondC8xAXA6BL0fi7UioUCHysjO4w5ILF8uWsK+/h6mTRSjLVQmqI3BZ1giJ1/aNpvSn/8MpWN21ahJmkdqjR6xkBNOh7qvqyFNYEXpJy72pmUZI87oKdnvUSQXgwhQXNAS/tKw+aBQiNiJSApt8hWv+ss995EFWSfx9u+9QMg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031762; c=relaxed/simple;
	bh=jYi9CR7Q5fj7S7XWe9apQNrYMvQVST/1GVmVWhzhvwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/ZcUGi1MeZG3dUSaGaeJdNAmWGev3vcoWm+dMr+hR3BBSWi7rNqe9SfAZl0j+zzTH1htwBiGDTFTPVqkiyzGvRhzA3wquFNOCMkgf5sQg84BUQdZEVPJgg62Htm812b7/3qRMhYFWe0gxBL4mOJHQ3kssJt6cgZBUXRzAPyVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVMPl3Cw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVMPl3Cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpApatoNxliyCZT9X7yJVRXDYKYsmEhtvUGnbSlge7A=;
	b=BVMPl3Cw30WAEnT1j9haNm2VOOAmC/5rn8fV7Uo9vDJQI5IXPvZRYfsBEppjlwLWuJGAT+
	VQhpXssXv+Cv0pz6xeiA+EIlzOHRvT4n3c6N3q43m47DpcWX6hTpDN5GZAZzqHCSoncYYZ
	2wFlsara68LG5FmeXT2Qg1+8ZKDpcSw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-SZtsnTfDMnKQXusFz7Wxcw-1; Mon,
 07 Apr 2025 09:15:55 -0400
X-MC-Unique: SZtsnTfDMnKQXusFz7Wxcw-1
X-Mimecast-MFC-AGG-ID: SZtsnTfDMnKQXusFz7Wxcw_1744031754
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32C98180AB16;
	Mon,  7 Apr 2025 13:15:54 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5A56192C7C3;
	Mon,  7 Apr 2025 13:15:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/13] selftests: ublk: fix ublk_find_tgt()
Date: Mon,  7 Apr 2025 21:15:13 +0800
Message-ID: <20250407131526.1927073-3-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Bounds check for iterator variable `i` is missed, so add it and fix
ublk_find_tgt().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 91c282bc7674..5c03c776426f 100644
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
+	for (i = 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]); i++)
 		if (strcmp(tgt_ops_list[i]->name, name) == 0)
 			return tgt_ops_list[i];
 	return NULL;
-- 
2.47.0

