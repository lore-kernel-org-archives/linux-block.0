Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DC188017
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420637; cv=none; b=qmYzYV6sK47qbDt+XUAOj+X9A3pPdA9DMijqDm3ek5nykNTuMWcW+xq0GP5UTQEl0dquYPJ258rRqv1hLQVyb2i8ofZUw6EAC/NDo7T1nq0Y+OqsoLEVL3QCTn3Gh8QImFfnLPY33CmXAXwg/LZuUVOai8PvJ7D0o8SiSX4fLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420637; c=relaxed/simple;
	bh=ByTzj5IGZ3g+R1F7RuPyw9nIagWm7b+x+lZ8MBPiGUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZTogALr1JRZEeiuGUdahzl9MddaU4DNppgjC42zf6fwIlgXdCoDdcWCdGSHM+eHGHeM3A9HZL0Y3YM8rbJFHBVwAqsFu3PtSPhczW3wRtSG7wEGP134C1CkLrHSziNF6zLbpXlOjcPvI6L7qBd0BTmblmyWc9H2+QFAV1w+OkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW3nChPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW3nChPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724420634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xTXT+GYr+fqmAfqH03+Vxcjaqi3yqEbIHWDPSw5QGaY=;
	b=DW3nChPkkJcTgWGLFzAHSLU/Y324cv4WmNwTYJpEb09SYO7reBoaQ6J1dESwcpBuPzR8QG
	SLaNU7AMk/gNmE1CPcVWBngJD3KoKfO91F1DKFlf/QhaWsb9dgbqwM3OGPmSn0bdPwnk/c
	2zuoir10TTCtA7JWvdd7tBHm5F5d7Dc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-ix99H8x1OwmW3NP-_L8jtw-1; Fri,
 23 Aug 2024 09:43:50 -0400
X-MC-Unique: ix99H8x1OwmW3NP-_L8jtw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90991955D4B;
	Fri, 23 Aug 2024 13:43:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55A661954B3B;
	Fri, 23 Aug 2024 13:43:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] Documentation: add ublk driver ioctl numbers
Date: Fri, 23 Aug 2024 21:43:39 +0800
Message-ID: <20240823134339.1496916-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

ublk driver takes the following ioctl numbers:

	'u'   00-2F  linux/ublk_cmd.h

So document it in ioctl-number.rst

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e91c0376ee59..5baae6de2861 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -292,6 +292,7 @@ Code  Seq#    Include File                                           Comments
 't'   80-8F  linux/isdn_ppp.h
 't'   90-91  linux/toshiba.h                                         toshiba and toshiba_acpi SMM
 'u'   00-1F  linux/smb_fs.h                                          gone
+'u'   00-2F  linux/ublk_cmd.h                                        conflict!
 'u'   20-3F  linux/uvcvideo.h                                        USB video class host driver
 'u'   40-4f  linux/udmabuf.h                                         userspace dma-buf misc device
 'v'   00-1F  linux/ext2_fs.h                                         conflict!
-- 
2.42.0

