Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1CB33A9D9
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387533; cv=none; b=oDzPymMYzqrkVWlBzh2uSlXdWPR9H3eK0z9LQCoNqxTPwn29hSV2zjnXOO1CR8xwIFNXO0Umx1Z7nEMxzZywtKqrPvksF/BdImSvwpDI3xRi9Z874gXvaGMUd/fyWisy0GOnIQ8cWEjq1xlcz7nrv91rAyDJCNqIYkVsE9gRbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387533; c=relaxed/simple;
	bh=e9H+1tPWHhMoBU0A58c5qD/LdhC9GAREju4NOD5BrRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHBNBiZYn6nSuUiLXxhLS59pWPj3SDUwzaA88BEHXDVrsVN3/8wuXCxe7Em6I+8qnbLy2OL06EIa99yQAYGhTOaWwxyUtU95Zn3fqKBzL2N1UuFK/9Fz6czH3rjIbEfvu6M58ne7tXshY+StdrVxgaRaQ8NP/MYUtv3SRG6tnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmpXaPIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmpXaPIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Vhe3cspgj+wLWuwHkRvA4uR8kHsIOzhuMtjlCVP9U=;
	b=OmpXaPIbgBr1vd5G9HSB0MCGQmKbqqfEgyEKHt3XPu0VIy6BBnj4zsZ+WglDM/1CWYZjMg
	DtFrmFxMr6ZM4f9DiVkLvD6KG7JUs1I9g8oQC3ZF3xr/MuO9kHWzqWlaCqoTEK41+aPDBM
	7E7LHEUK15jWr8apuuR71igrQ3wOSiU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-y3Pv8XifOhiZa029kHqOTg-1; Fri,
 06 Feb 2026 09:18:48 -0500
X-MC-Unique: y3Pv8XifOhiZa029kHqOTg-1
X-Mimecast-MFC-AGG-ID: y3Pv8XifOhiZa029kHqOTg_1770387527
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 168EF1944E45;
	Fri,  6 Feb 2026 14:18:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 241B018003F6;
	Fri,  6 Feb 2026 14:18:38 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 2/9] sed-opal: add RangeStartRangeLengthPolicy parameter.
Date: Fri,  6 Feb 2026 15:17:56 +0100
Message-ID: <20260206141804.278721-3-okozina@redhat.com>
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

As desribed in ch. 3.1.1.1.1.2 of TCG Storage Opal SSC Feature Set:
Single User Mode document.

To be used later in Reactivate method implementation and in function
for retrieving SUM device status.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
---
 block/opal_proto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 3dfba3de7be1..b9877eacfe91 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -225,6 +225,7 @@ enum opal_lockingstate {
 
 enum opal_parameter {
 	OPAL_SUM_SET_LIST = 0x060000,
+	OPAL_SUM_RANGE_POLICY = 0x060001,
 };
 
 enum opal_revertlsp {
-- 
2.52.0

