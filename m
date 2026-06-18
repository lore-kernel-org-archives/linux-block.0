Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175527FD4B
	for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793721; cv=none; b=dP1IOnnsLRv/vyssIQaf7wJ8MXYK1lmQD0E75dReaeT+vGMr/MHc/ojwILBEMqb0Rtc4Ger26vGiWoiw+gHrm6EzXfPSfS30VRpDCqIk8gRThV8WEiD57cXXxfEbaRg4WavwOqEa+M91fTdjSMUipxeAMqdzDp8HIq7//T7wc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793721; c=relaxed/simple;
	bh=lHzq0DRrYwRYHmIFHjAV+cI6P2brgnGcPL/w7E8S3A8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHrdTmhzQuo2gXq8tX5hEu0izFIlg5jTz0+vB7/R4P6FWsUWffDwh+TILjtEkbqA55FsUGV2bQQS/ANWFEe35ta87tMrTuDDUA+JAcCHM7TWENcI9rwPOtpg8j98IZRlKqHBPgRRO3Uncr9EziD8SQCxqPjEfflVy2mxPsZ4ucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEX7P91q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEX7P91q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781793718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=EtLvooHJQB1vaODxe8v5ss5cpKQH+f8lCqKqLMMpiyg=;
	b=GEX7P91qe46pqT01VR0MwQGWpatRk5S2CeHGuJPnSQyTzD4ZZjER8BDNN6VvDZcCk1kQIF
	w9dcwcK1afChoT8XR3jKwZL+hA/L/eTAPJp0aKB6q9jcuUPAQTfI/DVxpPmJP07xFOEucP
	x55r+hcmPasBEpj3NKaliNbIXWU/DwU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-P1se2M5-N_ar7Ug-okthjw-1; Thu,
 18 Jun 2026 10:41:55 -0400
X-MC-Unique: P1se2M5-N_ar7Ug-okthjw-1
X-Mimecast-MFC-AGG-ID: P1se2M5-N_ar7Ug-okthjw_1781793714
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52E421956041;
	Thu, 18 Jun 2026 14:41:54 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 864C61956089;
	Thu, 18 Jun 2026 14:41:53 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] Fix _get_page_size()
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 18 Jun 2026 10:41:51 -0400
Message-ID: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There is no CONFIG_PAGE_SHIFT stored in /boot/config-`uname -r` on RHEL
systems (maybe all systems?).  As a result, tests that make use of
_get_page_size() were doing the wrong thing.  For example, throtl/002
used it to calculate I/O sizes for direct IO.  Those sizes ended up not
being a multiple of the logical block size, and hence throtl/002 was
failing.

Fixes: 8eca9fa ("common/rc, scsi/011, zbd/010: introduce _page_size_equals() helper")
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/common/rc b/common/rc
index 20f7c7a..d60a125 100644
--- a/common/rc
+++ b/common/rc
@@ -562,13 +562,8 @@ _have_systemctl_unit() {
 	return 0
 }
 
-# Get system page size from kernel conguration
 _get_page_size() {
-	local page_shift
-
-	page_shift=$(_get_kernel_option PAGE_SHIFT)
-
-	echo $((1<< page_shift))
+	getconf PAGE_SIZE
 }
 
 # Check if the system page size matches the required size (in bytes).

