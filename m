Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D732ED27
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110314; cv=none; b=G4MwyZBx2g2Dvx5OG/0UDMBwWCvHtoQyz/OLQ0RZoLULEQTF7BNdD4x7soHVpwC9Wz++c4kGyUzAZhAH+IU+uKqj5W/sp6Ct51NLDdoirZUEsy9EoPVTlWt52jGoqMbBBTpV/Yhi93R/cKLgxANarKT6ULQehvxOf9Gm1hTBQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110314; c=relaxed/simple;
	bh=KpXR3wJB7nb8ni3gv83knyH0enQfz2X5d+5QlhOvoFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHQ/cBgzAay4Am08SMaX5EgExmGYXWMa+MJgYtl5SQY8lCxuJeTNmDuR4bNGRf8y/ORfjPTrOHch57xagxcbM0olYUHOnDHwEZkp1PD7JbkjDUh9u9uKIWjsA+YSYzq39J4f0j3p+KKKUj0DksLXzm4tWmO3/cuB+yTEUmDaThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9p13OXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9p13OXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5Ly5Olj9V8EyeQR5g+YlHMKu7lvW0ciUltY8xX4QQE=;
	b=Y9p13OXRwbQZO7V0e42pQnitGxoBzgSvWr1zecXOo6W+i081zGVgiSDJjXIDRXKHItssDO
	StZiUo0m6WgzEV6jwz6td+sn5n9DkwX4BHdcvZp5FuP85tgXiPrPzq4NVJbG1Q6Css7nms
	SSHdTxcagrPiNrtuVC2mPelLUli1I0Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-v-_SFPQBMaWY5gdAJKjrBg-1; Thu,
 22 Jan 2026 14:31:41 -0500
X-MC-Unique: v-_SFPQBMaWY5gdAJKjrBg-1
X-Mimecast-MFC-AGG-ID: v-_SFPQBMaWY5gdAJKjrBg_1769110300
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27F2219560AA;
	Thu, 22 Jan 2026 19:31:40 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FEFB1956095;
	Thu, 22 Jan 2026 19:31:39 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests v2 1/2] common/rc: support multiple arguments for _require_test_dev_sysfs()
Date: Thu, 22 Jan 2026 14:31:32 -0500
Message-ID: <20260122193133.3087906-2-jpittman@redhat.com>
In-Reply-To: <20260122193133.3087906-1-jpittman@redhat.com>
References: <20260122193133.3087906-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In some cases we may need to check multiple sysfs values for tests.
If this happens, create the ability to pass in multiple arguments to
_require_test_dev_sysfs() instead of having to call the function
multiple times.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 common/rc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index b76a856..f09ba8b 100644
--- a/common/rc
+++ b/common/rc
@@ -326,11 +326,14 @@ _test_dev_is_rotational() {
 }
 
 _require_test_dev_sysfs() {
-	if [[ ! -e "${TEST_DEV_SYSFS}/$1" ]]; then
-		SKIP_REASONS+=("${TEST_DEV} does not have sysfs attribute $1")
-		return 1
-	fi
-	return 0
+	local attr ret=0
+	for attr in "$@"; do
+		if [[ ! -e "${TEST_DEV_SYSFS}/$attr" ]]; then
+			SKIP_REASONS+=("${TEST_DEV} does not have sysfs attribute $attr")
+			ret=1
+		fi
+	done
+	return $ret
 }
 
 _require_test_dev_is_rotational() {
-- 
2.51.1

