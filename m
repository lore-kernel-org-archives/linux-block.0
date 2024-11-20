Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26A10A3E
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732071807; cv=none; b=GfVFTa2GTiDwJXxsg+igecDpwahc4Cr3QPoHujfbsC3GLQu8C7YSTPgb9nbliJf5BMR9M7BRPI0+vOtc7fRI5oGXiUGtqPZjPJ6wRWhQ3Lxe4+qXbfPNH5g3C8vYTza9Vgqrz+4bpNBR0s3VhO6vNww6GnWAphowmRoZ3kw3wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732071807; c=relaxed/simple;
	bh=49m9qBu3lATzCLeqb67gSnvAfQPDJxt7vXlt+uD5OVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uup8E7Aiyg2LgYbfok27Rb7rtDSJ1FNi09/OuPTXmTu7GAxB7ynZ7wOK7gYTVxc0hWmSTfhwDCtGgmemHIgvittzA8JMkNxXsuEKn4ZiuDr/3zoBgXkxNV8CbVAULeu0kLm99tx9jR0lN+e/9vp3BYY+jx6DxtIZgIw3chl3B+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2HxUq2K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2HxUq2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732071804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2izUDURaRNSUCsPxbB5/AV6z/0BbH/iA3UrWDhYORS4=;
	b=R2HxUq2KG/wAouAXfbizx9c5MkNDJpazzWTX5H9PdezkDIdGysS3RpiDuy0OAAZggrJG1H
	eeKt9PPnH7Og5dYB8pqfxq2ZK+zYDhgv4HWMjvW2HGfS5fyHc5zcjuabVE7aUHtZiOb2TW
	NshiCsA/84va019TNbEgK7nHCAhuiuc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-ns8c121-OLKO-eGKC5Zeyg-1; Tue,
 19 Nov 2024 22:02:20 -0500
X-MC-Unique: ns8c121-OLKO-eGKC5Zeyg-1
X-Mimecast-MFC-AGG-ID: ns8c121-OLKO-eGKC5Zeyg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 849BE1954B1A;
	Wed, 20 Nov 2024 03:02:14 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A87D19560A3;
	Wed, 20 Nov 2024 03:02:13 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: hare@suse.de,
	shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests] nvme/052: don't remove the def_nsid namespace during the test
Date: Tue, 19 Nov 2024 21:49:25 -0500
Message-ID: <20241120024925.1397864-1-yi.zhang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Skip def_nsid(1) namespace removal during the test as it will be removed
from _remove_nvmet_ns during _nvmet_target_cleanup phase

$ ./check nvme/052
nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
    runtime  3.273s  ...  3.299s
    --- tests/nvme/052.out	2024-11-19 19:29:36.873210200 -0500
    +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-11-19 21:29:26.016088521 -0500
    @@ -1,2 +1,4 @@
     Running nvme/052
    +common/nvme: line 635: /sys/kernel/config/nvmet//subsystems/blktests-subsystem-1/namespaces/1/enable: No such file or directory
    +rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1/namespaces/1': No such file or directory
     Test complete

Fixes: 67e25d7 ("nvme/052: do not create namespace when setting up the target")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/052 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/052 b/tests/nvme/052
index 8443c90..2ff9e53 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -71,6 +71,8 @@ test() {
 			break
 		fi
 
+		[ ${nsid} -eq 1 ] && continue
+
 		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
 
 		# wait until async request is processed and ns is removed
-- 
2.45.1

