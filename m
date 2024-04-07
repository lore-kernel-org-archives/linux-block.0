Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF6A946
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459886; cv=none; b=HUVxpSiStCWQVgNT7vbHlzay1vMvUex5+wsulV1s1TJvkiS5sz6XK3lNd2G0L7N1XqklRahJCOj/JYM5JzY+GCnkLrZxoQ/gDWa1ms6ylaiA+vMdbkKrwEN5LhgBRhXK+c/SB1V4WhhtW4lyApsPJQQg9sfOfCuabpW2y435/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459886; c=relaxed/simple;
	bh=KMQjpdHhO8aqXHMKh3v6cuzTp7d3hKB4ahU6ic+tgJw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mOzYhaMShBrh2bGQnV+/ma4XbGcEQdWEmOkasAV1Kxs4xNQXUiwBVUDGryMaZo+S7qIELWxKBu7d/CuZ6vU3OlAAiYGJS4RKLw+5nL0NyIAIHJELZeBoO9apLxwtYS28a6Fhk4GQ40uSvW/YmJMCwBwmMuKKu5OoD6vWV8ELi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtHDLPkG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtHDLPkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712459883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Naxll35axU9g0UXDYBdTJOyJleGNTia9l3wCWVIVj7w=;
	b=LtHDLPkG0XIbGchMfwzLJZhZWwEG8h7xpKUCx3MAK0AYB/GqaNMR+6dMuZTNBDkJHB1DPj
	G9GaVvLfljHiJljwmhSI/dPkPOfKG/vIR2bB8542J4YYZGogyScM96MugQjKucXdT8sM1Y
	jTTlZRl5uG7c2/xIkp1Nht9JXnFjCxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-V9tRgdT1MhmNVjPTLjB_HQ-1; Sat, 06 Apr 2024 23:18:00 -0400
X-MC-Unique: V9tRgdT1MhmNVjPTLjB_HQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 923FF8570FC;
	Sun,  7 Apr 2024 03:18:00 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0EE18425376;
	Sun,  7 Apr 2024 03:17:58 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com,
	shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests 2/2] nvme/rc: fix shellcheck warning SC2086
Date: Sun,  7 Apr 2024 11:17:52 +0800
Message-Id: <20240407031752.3945715-1-yi.zhang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

tests/nvme/rc:1056:7: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/nvme/rc:1057:7: note: Double quote to prevent globbing and word splitting. [SC2086]

Fixes: 369d310 ("nvme: Add passthru error logging tests to nvme/039")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 203cf0c..1f5ff44 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -1053,8 +1053,8 @@ _nvme_passthru_logging_setup()
 
 _nvme_passthru_logging_cleanup()
 {
-	echo $ctrl_dev_passthru_logging > /sys/class/nvme/"$2"/passthru_err_log_enabled
-	echo $ns_dev_passthru_logging > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
+	echo "$ctrl_dev_passthru_logging" > /sys/class/nvme/"$2"/passthru_err_log_enabled
+	echo "$ns_dev_passthru_logging" > /sys/class/nvme/"$2"/"$1"/passthru_err_log_enabled
 }
 
 _nvme_err_inject_setup()
-- 
2.34.3

