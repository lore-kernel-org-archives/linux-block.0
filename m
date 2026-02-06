Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3022FCBE5
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387533; cv=none; b=YKWQu2l/3chxyJbbPe5vlH/d7ZTCeJhnq2Q6KVXdzgCljHIRznEADnNnDaEYcVrEfOvqJGwFjjWpZ3LQQu1o2qsTQKH6MLFAcYcFxcJAiTfcjOlDuSoD8QlI9zhFj/GrPD0OyQXCNxSyz+qECHoale+8bgB1UdlXNWITZqNTWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387533; c=relaxed/simple;
	bh=x6C19RHMe93+xU1Xcv7s3oqCwTuTyK52h0lRhS4h+ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTrnb31ZdZ2IGRNWEglItLKTdZJc9e3ln+eMc2W8aFtXiO3M9NvesmOL2XLST2wON2NARObguxrUTm74vCun7tgDxXkSjjOxGKEMpq1kBGGcUaQ86RVDuIrgmy+8DMgTfckYaypiJIPdMWKEuS6PgXcnOtNI91Mgcj7ffkLki2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECMask+n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECMask+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPawCfML16h0jnyFQtsw2kAjKS6b2nyyaeDleyq5jcw=;
	b=ECMask+nDHAYEj5l4EJ2eDOt+xXseo4SrwiOFUo6Q19Td7XZ7ZCrVB0h3Ghll3Phx2Jubu
	fzPaal9awiBD0VNUkLEc0flOoPzwSYKABt/N3TIjBBwkrQbjac41Hos3SYjK21n2URmlPU
	mlr9H4/kMfRywWaP+pi+jgdBh26jdWQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-r_7goPEbPLKWIV-v9pT-4Q-1; Fri,
 06 Feb 2026 09:18:50 -0500
X-MC-Unique: r_7goPEbPLKWIV-v9pT-4Q-1
X-Mimecast-MFC-AGG-ID: r_7goPEbPLKWIV-v9pT-4Q_1770387529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52AAA180AEA5;
	Fri,  6 Feb 2026 14:18:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B7B31800679;
	Fri,  6 Feb 2026 14:18:41 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 3/9] sed-opal: add Admin1PIN parameter.
Date: Fri,  6 Feb 2026 15:17:57 +0100
Message-ID: <20260206141804.278721-4-okozina@redhat.com>
In-Reply-To: <20260205150935.238137-1-okozina@redhat.com>
References: <20260205150935.238137-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

As desribed in ch. 3.1.1.1.1.3 of TCG Storage Opal SSC Feature Set:
Single User Mode document.

To be used later in Reactivate method implementation.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/opal_proto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b9877eacfe91..3ccee5977c10 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -226,6 +226,7 @@ enum opal_lockingstate {
 enum opal_parameter {
 	OPAL_SUM_SET_LIST = 0x060000,
 	OPAL_SUM_RANGE_POLICY = 0x060001,
+	OPAL_SUM_ADMIN1_PIN = 0x060002,
 };
 
 enum opal_revertlsp {
-- 
2.52.0

