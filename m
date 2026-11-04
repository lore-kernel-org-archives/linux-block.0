Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789360;
	b=E6HOHGUXEE3k780i+1l48TodGQBqVqt9Aq0SbxLAhYe/fgWV0xMszuHugUW27r5gBnUy
	 ZDQesSAVjYDrR+M3/aaJ1hzH2hteBUoAYXdLKXKc4uMDpY6NjpelH1YvSKyZuGlLTIZ98
	 Lvgps78bU+5O+EmkwnF7F9D8yaM4JtdEkVkY21fMNc6eXCAWERjHT3FSCwAYewsiCsRfr
	 30cth4T7IGz85Y0yslDJnsFUYyTYZUahU2bem5aFxzVdF3K68/lpssgjqmHFMkwqNCKw2
	 YvU55jZpxVHSooEL2HjS2MOofVpOOtkVyCnxk3N0BDTxTqsC2VlqkKfXEoAryrtwRsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789360;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=MFA7WkGo+hIbERumFRG59VaVyf5F/3/i6Y52p+XAYVU=;
	b=ieAzHfU6EvYIISXSC+DMhMhA92GHV6jJhxzLo4qL3bE2lZxYF3sDBlLg6c/g0+0q/1Fw
	 qkdPpY/75hQLDBFVPCkFcxwLo0XHZan0iDQFtNPgfPZJ8enycImUsfafhtMIzIE821GEe
	 aGvN04Jw9BNS7xvkLj1+uvBs8eWTM8vERiG7iCuwbCsTQ3SdO3DMCLRDwWV0XWAp74mBb
	 1RGxc3AqVZ+OhtVdJensl0bMlF4+BYIC5myRgTqQX0CvtQgDy1o2glvEo0C1xcIIYkAF0
	 Uc3WLS5YgRls9DHeeUhcP3TSLFjI0NSw4Sect2CkwqYJ83nYKZTxTRlw7d0yg0IKM5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfL+yq+8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F60606A326
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 10:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1F60606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfL+yq+8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793789357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MFA7WkGo+hIbERumFRG59VaVyf5F/3/i6Y52p+XAYVU=;
	b=VfL+yq+8IlWM6hbtB4tgppnfCwEDNvMMrVfbfCPYZxQ62g/IwB8MCOYSkTBvoAwO+m5aXi
	RJQ6n6lMyJNai0EUaF3fa/ityeIeO6zYXwX3n+r3bLtgUyIp+qsoybwR/qU6SosduKzOQH
	XRMOpKjAyDRUpTNCA6zj/aXXQem3A1g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-7_rpUqBSPeWq-YWFmJo4VQ-1; Wed,
 04 Nov 2026 05:49:14 -0500
X-MC-Unique: 7_rpUqBSPeWq-YWFmJo4VQ-1
X-Mimecast-MFC-AGG-ID: 7_rpUqBSPeWq-YWFmJo4VQ_1793789353
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CD851800361;
	Wed,  4 Nov 2026 10:49:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F3ED195608C;
	Wed,  4 Nov 2026 10:49:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ublk: Fix include path for out-of-tree builds
Date: Wed,  4 Nov 2026 11:49:08 +0100
Message-ID: <20261104104909.129656-1-thuth@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When building the seltests out of tree with "make kselftest-all",
the compilation of the ublk tests can currently fail since they
are using the headers from the distro instead the headers from the
kernel source. For example, I'm getting:

 kublk.c: In function ‘ublk_ctrl_dump’:
 kublk.c:190:27: error: ‘UBLK_F_IO_DESC_SIZE’ undeclared (first use in
  this function); did you mean ‘UBLK_F_UPDATE_SIZE’?
   190 |         if (info->flags & UBLK_F_IO_DESC_SIZE)
       |                           ^~~~~~~~~~~~~~~~~~~
       |                           UBLK_F_UPDATE_SIZE
 kublk.c:190:27: note: each undeclared identifier is reported only once
  for each function it appears in
 kublk.c:191:53: error: ‘struct ublksrv_ctrl_dev_info’ has no member
  named ‘io_desc_size’
   191 |             ublk_log("\tio_desc_size %u\n", info->io_desc_size);
       |                                                 ^~
 ... etc ...

Fix it by using the KHDR_INCLUDES from the main selftest Makefile that
should contain the right include path in either case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/ublk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index fc64b8f028332..ba6df7c0b530b 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
+CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 ifneq ($(WERROR),0)
 	CFLAGS += -Werror
 endif
-- 
2.56.0

