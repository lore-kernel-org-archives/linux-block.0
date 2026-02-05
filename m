Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C518871F
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304198; cv=none; b=V+JJJkB4TjJGdFrnCxN87UM19WY1qoY2fZKoLa4Sr3ov40pGQAGZ32kmXIjVlAQ7fGBV/Ih3NpnzjgTsuBm57lEuOUgJiGIDLB3Isg3lB1uJLdk7vxm9iJSgOCU2zpEdEv0sPZYw7A06/QxA0o8ydisMeMW8mJBMCKqxDTe4HOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304198; c=relaxed/simple;
	bh=e9H+1tPWHhMoBU0A58c5qD/LdhC9GAREju4NOD5BrRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9MJL72oei9vxA2g1e2G0xaMznV6WgKRsYxQR8tx+xLRGfnUJJerVH7TVz69mk9cFcRsRJYtZUU4QN1A5JX19JejklPBV4QoxDc4kozFp94QXLTKz0nNWNMmD5n0/tH5tFQpRcApmrq0c+ee0ScVLmlOYXNk5JWIYhSrpiDHfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWchD8Gx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWchD8Gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Vhe3cspgj+wLWuwHkRvA4uR8kHsIOzhuMtjlCVP9U=;
	b=jWchD8Gx3ifzOKBko+LYZ3mneFamfDlzn2RkytRc9FKEBgs2l4GRaqZWJ4uLUMTDktOQrM
	5lETATYr1ibEyVd6qoPijzV+Gx64WH1A6DdvO1kEiUFioC14BfwYUuxeRwKbz576R8SI72
	st11PNQRBz7LiKZancyA7x6glbsVtOg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-BCEI6Aq4P82D9ZsszHni5A-1; Thu,
 05 Feb 2026 10:09:53 -0500
X-MC-Unique: BCEI6Aq4P82D9ZsszHni5A-1
X-Mimecast-MFC-AGG-ID: BCEI6Aq4P82D9ZsszHni5A_1770304192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68FA719560A3;
	Thu,  5 Feb 2026 15:09:52 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9575C180066C;
	Thu,  5 Feb 2026 15:09:50 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 2/9] sed-opal: add RangeStartRangeLengthPolicy parameter.
Date: Thu,  5 Feb 2026 16:09:25 +0100
Message-ID: <20260205150935.238137-3-okozina@redhat.com>
In-Reply-To: <20260130162527.570255-1-okozina@redhat.com>
References: <20260130162527.570255-1-okozina@redhat.com>
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

