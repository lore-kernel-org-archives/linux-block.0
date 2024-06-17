Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E8E554
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609619; cv=none; b=Tm6sQ2U1WQBCxNuJAdXlK4Hu2W1c5Jq7JlnHmzYtkNk0+KnRtwrWgVs68B9ghT33Zyeb/ydiCEFpwU/AKeXKZBkGS9Ank6at6JKtDTVAH2FmhxelXzaYAPL/x99sxARR5XAZC5nd5xTiYQpyXIHW3w4LOi2c9ZnzAM03DvmM5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609619; c=relaxed/simple;
	bh=6Be1VBuJBuQx5WhlORRWbQbz/9PnkOafd1jCoOL3EyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn5MOXKFJMhTXTvQyS29gNkKmXNaoPc7i9F68bS8toDrjk5Gt3YonfSCQ7bTDC/FvTpKECTTmBFsT6RmnTPwrsxx3Lq04v7dYtbrvQjdcqUXFewn+812P0Sg7VZffhn2xgHcrfrk2n5OilKHyDgyw9VdIo/Bw2pvOUCvNALfvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=In/UU8Zo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="In/UU8Zo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718609617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VGyu5AtFOjrYW0RzXt8zeng+1SKzDJmAJ+4VL1VE6fw=;
	b=In/UU8ZoYrzLGjaK0la4+qc3CU7DZmRbXccDk9fMxkE2x6i0J6X5nrpeXlKMOvQuThhT1C
	Nz5aOrYgFy+Z9lY3WdXAisG3b7TImb4+WQosudRcShmWmvRKc2xvXDfjdFCuSZSLq7QKTo
	+QiPXdYDF0L5JBu9tD8C/ji9wd/tJBI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-uM0S3oo2On6hmLCXvq3YQA-1; Mon,
 17 Jun 2024 03:33:30 -0400
X-MC-Unique: uM0S3oo2On6hmLCXvq3YQA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D64B819560B3;
	Mon, 17 Jun 2024 07:33:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.120])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 068F31956087;
	Mon, 17 Jun 2024 07:33:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Adrian Bunk <bunk@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org
Subject: [PATCH] Documentation: Remove the unused "tp720" from kernel-parameters.txt
Date: Mon, 17 Jun 2024 09:33:22 +0200
Message-ID: <20240617073322.40679-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The "tp720" switch once belonged to the ps2esdi driver, but this
driver has been removed a long time ago in 2008 in the commit
2af3e6017e53 ("The ps2esdi driver was marked as BROKEN more than two years ago due to being no longer working for some time.")
already, so let's remove it from the documentation now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b75852f1a789..89b784ec5ab1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6619,8 +6619,6 @@
 	torture.verbose_sleep_duration= [KNL]
 			Duration of each verbose-printk() sleep in jiffies.
 
-	tp720=		[HW,PS2]
-
 	tpm_suspend_pcr=[HW,TPM]
 			Format: integer pcr id
 			Specify that at suspend time, the tpm driver
-- 
2.45.2

