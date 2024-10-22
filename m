Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67C811EB
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579285; cv=none; b=loOHJ0nYwUgl9AGhX2o4GtB8em9+2zY2HRxhE++sDlP0vNz17R96paoCV+wrcB9afdUlHpz5PHb1t+yN1cgIOqT+xrF3ok4r3eCGfAUaq+HFdl9ooS1eGSdK+D6m2r/mX4laA6I3kN+3UKItVGbgv8l1GidL3/bpcvchtW2LycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579285; c=relaxed/simple;
	bh=8rWXsXQq6NdVS1F1zehZTK67NKYq+21PQOFC+qOjWPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1yFk9HeBC5W6LrO0KHJFnrP4Kcs5p21c9cEhvSaG1PXnAZo8mMUo7aDBRT6desU92jJWTLeKvTh/An0dB/m+e8IaShUj9ZwEKer2/5HiOaGKiNGbm91O64PniF8EnJEREhgudoectUtuHJltojrD4l4BSoLJ+rY5jqiGVY3jQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fx8g9crT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fx8g9crT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729579282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IjW0hc48Gk3fKCcS4ufRCuOIE7OPIiyHBp7mhfF7o/s=;
	b=Fx8g9crTucJvCt0p5s9FffBbXK1L1qNn2Y0uNcTJwIhlLvmiQ/VURLIwKvfgTR8Xq9ztOd
	FJrqFAmd0OM1eY6z7hmABNcm4hVO7CXqHEu9doCcI7FClFge94iaDV7tJfeErZG7oxoTHD
	nxb1ClSy7AJfHKiTPgdGQzRMvQzj3EY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-_eTnGFqxOEOx_gWgft9ulg-1; Tue,
 22 Oct 2024 02:41:18 -0400
X-MC-Unique: _eTnGFqxOEOx_gWgft9ulg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99647195608B;
	Tue, 22 Oct 2024 06:41:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 460C919560A2;
	Tue, 22 Oct 2024 06:41:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block/027: setup scsi_debug with MQ
Date: Tue, 22 Oct 2024 14:41:09 +0800
Message-ID: <20241022064109.3303704-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

block/027 focuses on race condition between blkg association and
request_queue shutdown. Unfortunately it is a bit easy to trigger
lockup by setting scsi_debug in the following way:

- single queue
- 21 LUNs
- small queue depth(110)
- 10us completion delay
- fio: 4 jobs, with iodepth 2048

The above setting creates big contention on tag allocation of blk-mq
code path, especially scsi_debug takes memcpy to simulate IO, which
doesn't match device in reality.

So setup scsi_debug with MQ and avoid to trigger lockup which doesn't
exist in real storage device usually.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/027 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/027 b/tests/block/027
index a79a115..cf4ff16 100755
--- a/tests/block/027
+++ b/tests/block/027
@@ -84,7 +84,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	scsi_debug_stress_remove virtual_gb=128 max_luns=21 ndelay=10000 \
-		max_queue=110
+		max_queue=110 submit_queues=$(nproc)
 
 	echo "Test complete"
 }
-- 
2.46.0

