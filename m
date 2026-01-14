Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EA33B6E4
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424903; cv=none; b=Gc40gcJlfJAlasU4o8KRELFZaFmzJLbZP6jYrCu5+ALB5R4k8COaQch8BAIo1Cv4Rv8TT7v2lBHCt59KGZrzNIhFcHhzgJwsx++NLapKtruXPAV32EfOwFppDewrL/iLAJr4vS7p6i8hLHlUg8cQj/4EQoTnOJczn+4Rc6nrCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424903; c=relaxed/simple;
	bh=asf4Z4UQLO9Q9fM2GnaXgjjK4qyXjMeedZ0PrIjmcJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtSeqCGATzgUbnblhc7mfhSO9vewbV/Pzqe5fVyNV9y0zA70fozWeMGWFFlXf9ee7Q3IRLCWfqqbn+KumwuiBs81Rl6kZq5pUpFoeZhzHQmswldyoZAvkXtqXFzEAbv3dthbflAqPYeKPRf6Kv9tV0mcnRWxppKB3V9prYZD4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2uimELN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2uimELN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768424900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CJdwOL2h6r4qb6j8TUiN1uNHRq/XzHoO2Xuh/9uhA4=;
	b=E2uimELNAqPN1LoAav5Metp2CE4vq601WffAJdAUKP1GaVu67I9z9DVmuSC6ajoLym5TYt
	ZzYsqBFCvcbMwZyuPjKBNSiNLDzKXKD7PB5rtbXoJNr54aEBlXq/6WM3eIYoWl2pvDu/dN
	FSIHaH94a7TLUX+ocBTYQ+3kgTxoA58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-h3U9l59EMlq9eLZCp5iUIg-1; Wed,
 14 Jan 2026 16:08:17 -0500
X-MC-Unique: h3U9l59EMlq9eLZCp5iUIg-1
X-Mimecast-MFC-AGG-ID: h3U9l59EMlq9eLZCp5iUIg_1768424896
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA58019560B2;
	Wed, 14 Jan 2026 21:08:16 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.66.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12D4930002D8;
	Wed, 14 Jan 2026 21:08:15 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests 1/2] common/rc: support multiple arguments for _require_test_dev_sysfs()
Date: Wed, 14 Jan 2026 16:08:08 -0500
Message-ID: <20260114210809.2195262-2-jpittman@redhat.com>
In-Reply-To: <20260114210809.2195262-1-jpittman@redhat.com>
References: <20260114210809.2195262-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In some cases we may need to check multiple sysfs values for tests.
If this happens, create the ability to pass in multiple arguments to
_require_test_dev_sysfs() instead of having to call the function
multiple times.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 common/rc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index b76a856..e4b5196 100644
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
+	local ret=0
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

