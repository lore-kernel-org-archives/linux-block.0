Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C01C84D6
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635970; cv=none; b=Ff0BIoyxL0XofjUW02I6V21Y9vj/qG8NDSwbgre5CQitTjv222qKwd+DeCcIjII0+ip2FTpPIJWAX56wJ0FSOK9fWQ+5xDbsg+ybq+OofkIrHpg++7sG2puOPvp+rzpLivXk4/F1AvHCwzkj32QzAFrmBnUxbiBRdLGcJFwEnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635970; c=relaxed/simple;
	bh=D7lAsLcKYTeULPGNJikuGwdncUkcVQGf8vGJGiIZW64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlfGZqbSf8StfCoE7PkAROkSDWlhLayCbRfZ/j/tRYMyB7EeFY4kkGVI0MoslOzrLL7vsghu/r8e36GDEgx5EXomPEgl6sq9Z+P8nBdQMdHrDM93IpUwttOn0sNHWhG0A+HxpLInqPfIOgzdZkEwKM3XwiJEpFfliOb0lD2y7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7WEyN+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7WEyN+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742635967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRHzUUqW0jQTdoXkiE5MdNbgd1HAkBLRFqY1BFICvDY=;
	b=Y7WEyN+c7U3LoqdLcYsgwDg1TKqVbZ5LGcqtA2oz2N2sjyq2XMqF6dRyXkLGh3ABJAOn7p
	kZY/1BmexnXs+Ow9XbQhh4Mp8rh+oa6nzXomAkd9vLsKsZVxlYa2UFRQ/yjPsxp5Gl8zEd
	YL6xn9AXIV5mk1kI/BiMhji/It1qt8E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-wzSUn4nTPRaDrod3ANaveg-1; Sat,
 22 Mar 2025 05:32:44 -0400
X-MC-Unique: wzSUn4nTPRaDrod3ANaveg-1
X-Mimecast-MFC-AGG-ID: wzSUn4nTPRaDrod3ANaveg_1742635963
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740ED18EBE88;
	Sat, 22 Mar 2025 09:32:43 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4052E19373C4;
	Sat, 22 Mar 2025 09:32:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] selftests: ublk: increase max buffer size to 1MB
Date: Sat, 22 Mar 2025 17:32:11 +0800
Message-ID: <20250322093218.431419-4-ming.lei@redhat.com>
In-Reply-To: <20250322093218.431419-1-ming.lei@redhat.com>
References: <20250322093218.431419-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Increase max buffer size to 1MB, and 64KB is too small to evaluate
performance with builtin ublk server implementation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 9cd7ab62f258..40b89dcf0704 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -40,7 +40,7 @@
 /* queue idle timeout */
 #define UBLKSRV_IO_IDLE_SECS		20
 
-#define UBLK_IO_MAX_BYTES               65536
+#define UBLK_IO_MAX_BYTES               (1 << 20)
 #define UBLK_MAX_QUEUES                 4
 #define UBLK_QUEUE_DEPTH                128
 
-- 
2.47.0

