Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BE2F37
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280012; cv=none; b=mYbMicsn1pcoGZAOWkWtc5F81O4+Yq3ODl6CZumfC52i6i3B8KyR0Tk5EaSapry8//h9umOhf/iVRGCgQ5t+lBeqip/QhjGRGiGS8eajncggyhlkQW2qs3rJ3Iy1rbEMGISf0cg0lf2daE/Ct/X7SfEsWxNnqS0I6MQKrlNtDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280012; c=relaxed/simple;
	bh=iZTPbKRein+PcltXsYO5W8U41NGg6hwfYOdeEuSHYnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze4Mzr1qNFRIrYAuzwXhpgxVofbBPaJyTF9IPs3y8fxZm7aBGnKOZMYPy6SxVRwslA5VFe1+r5/CYQidc1ld4HEePLJUXeoJIG3CLAn2el5LsPEDkXXurD4oWr6Huu418a9t+T7V6/J9DOBRUoLJaAVb/zIE5j2WtLdIODQ7ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Se/oBui/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se/oBui/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745280009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gz76iBKutOF8F47jyC2968rhtncaCxH7MlC8e+SZn04=;
	b=Se/oBui/LK0XHCqEEjsVi5KqVeTD/NKRfqrn/zFk4KRlUpers2Eo4hxR1oxr8Fbe0V1QRo
	/r5fCkMVxYt/ZIPfOOVGYWImhQtQGK0LwOWmWNklN9vklOvvO6E0Ab4RODReXczi+xbTVV
	zeVd8SmDBtpV+RNMthF+RBz8CM/3nrY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-i9AokSu4PrmjKMKentVWEQ-1; Mon,
 21 Apr 2025 20:00:06 -0400
X-MC-Unique: i9AokSu4PrmjKMKentVWEQ-1
X-Mimecast-MFC-AGG-ID: i9AokSu4PrmjKMKentVWEQ_1745280005
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0723619560A5;
	Tue, 22 Apr 2025 00:00:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEBD01956095;
	Tue, 22 Apr 2025 00:00:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6.15 2/2] selftests: ublk: remove useless 'delay_us' from 'struct dev_ctx'
Date: Tue, 22 Apr 2025 07:59:42 +0800
Message-ID: <20250421235947.715272-3-ming.lei@redhat.com>
In-Reply-To: <20250421235947.715272-1-ming.lei@redhat.com>
References: <20250421235947.715272-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

'delay_us' shouldn't be added to 'struct dev_ctx' since now it is
handled by per-target command line & 'struct fault_inject_ctx'.

So remove it.

Fixes: 81586652bb1f ("selftests: ublk: add generic_06 for covering fault inject")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 29571eb296f1..918db5cd633f 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -86,9 +86,6 @@ struct dev_ctx {
 	unsigned int	fg:1;
 	unsigned int	recovery:1;
 
-	/* fault_inject */
-	long long	delay_us;
-
 	int _evtfd;
 	int _shmid;
 
-- 
2.47.0

