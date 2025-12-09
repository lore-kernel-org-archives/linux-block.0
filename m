Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46261D27B6
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316325; cv=none; b=r5WodoLGBL3/CbIsppiWyfGPI+p7HbOuK/h+Hd4sJ7ZPdBaE7nZ94NWyOUnnMTCxmhVCD/HBamXjmifmLMksB9pnd9CcVBRWSTQHU726XvSvR4mPgjiBMIFQjYUeQdH7jEUA/d13BeOuUGhPAi9eLn8TDHRyAtz+eiiWNkkJOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316325; c=relaxed/simple;
	bh=iRu5PLlkav70Se5oWF4n86QMlGlcXRhh1oXYO2er76w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9BZxjOGNg6op+P7DZMeC5qrDQ/psjMULEBNwaPBohBBMFgt2trktToEhf4Ej+GeuCWE92al6XenHf+eX8vK+4oakZ3Fe3w1hyr3H5KHV8Vw7kNCQST9Pi0ZhylTNk5bBTaJcZ3Es5+jzGf3HB6XsnRD7Kj1+h6XWYhHUPJZeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3l7efua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3l7efua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765316322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q69PhIL8uoRmBNwIbv5idrfYhwWbnOmaw/+Dj1dvz7w=;
	b=N3l7efuak4eyU84NM2jNaIjpakOXS4Nl9qJOJ96HwcObeiOE4C8uo0+XJz2CragpQDUj1D
	5evJbvhLqrqk2HN5+Y3izwXl4XHKUbgsjxyxxxTIqSTKZmyHhrGH98MNdM7KN0yr6dEc7h
	IXmZauX26A2TDlWSUnjG0lRyD2kRaeo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-A3AZ-SzQPxaBl0rVnnER8Q-1; Tue,
 09 Dec 2025 16:38:41 -0500
X-MC-Unique: A3AZ-SzQPxaBl0rVnnER8Q-1
X-Mimecast-MFC-AGG-ID: A3AZ-SzQPxaBl0rVnnER8Q_1765316320
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 809D2180035A;
	Tue,  9 Dec 2025 21:38:40 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.89.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED811800451;
	Tue,  9 Dec 2025 21:38:39 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests] md/004: md/002: adjust per_host_store to use numeric boolean
Date: Tue,  9 Dec 2025 16:38:35 -0500
Message-ID: <20251209213835.2707268-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In both md/004 and md/002, when loading the scsi_debug module,
"true" is passed as the value for per_host_store. However, on
older kernels, kstrtobool is more limited, so we get the error:
"scsi_debug: `true' invalid for parameter `per_host_store'".
Change the boolean from "true" to "1" to avoid this issue.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 tests/md/002 | 2 +-
 tests/md/004 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index 1af4bfb..1349a18 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -22,7 +22,7 @@ test() {
 		atomic_wr=1
 		num_tgts=1
 		add_host=4
-		per_host_store=true
+		per_host_store=1
 		dev_size_mb=16
 	)
 
diff --git a/tests/md/004 b/tests/md/004
index 9084066..6cae99a 100755
--- a/tests/md/004
+++ b/tests/md/004
@@ -24,7 +24,7 @@ setup_test_device() {
 	local scsi_debug_params=(
 		num_tgts=1
 		add_host=2
-		per_host_store=true
+		per_host_store=1
 		"${@:2}"
 	)
 
-- 
2.51.1

