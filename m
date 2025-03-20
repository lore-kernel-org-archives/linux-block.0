Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987881C3C07
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434707; cv=none; b=alATFwkWI7E7Pker0JBTDPAniAcygwcSMOToZzM/feHCPdgCfKhkDnUmVGIyAPuHrGtZIBhMqDRNzonMEBGH83WBGjzB+m659PDfFoouwiITEYZSDZ905R+BFrU0x2SaIUqJmxCEhFm/ex7o6vn9bzH7+ULbRFWaCZ6l54KCw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434707; c=relaxed/simple;
	bh=jpp8ekC4uZtZJob32G0rjVUc1FNKc6CoM2LnoC4Ja8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlcdlM6jkBpi0iRyIjwl+uYI7PNUMwZ1bO76Bq9CuHrFi5krwy8hiyYK4vsJD7uZ07sd8DsFV9HXNi25/1PpbgJ9JITnhYly/e1WYfxWgtYo9IaYXYDJEzoNWxQ6YBPHnhmmg2kJININ/7u7RK856QjENgPhJ3/HzcwoimsNtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKZQYvRz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKZQYvRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQ68UmjOgJ6cYNwlQ8ygU4srmUE02YGm+MSEoDaqFZE=;
	b=OKZQYvRzQdjKbfiuYlO6/jc9ed3FsiKIHQcN0KTSY4EUehr3rRXv988hNNCZ6etFgATnJW
	maGp1n2O4Do/nA2akI296NKiYkSeifaklfWbZwBJZj+HdyS3yVrZ0FBvH6gi2SGtu9HDjf
	rstX7wmTrXkK/dHxxIXlTtM50kxzTTE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-ARhRr5TGNmC3gGUDUQdM4Q-1; Wed,
 19 Mar 2025 21:38:23 -0400
X-MC-Unique: ARhRr5TGNmC3gGUDUQdM4Q-1
X-Mimecast-MFC-AGG-ID: ARhRr5TGNmC3gGUDUQdM4Q_1742434702
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9675180882E;
	Thu, 20 Mar 2025 01:38:21 +0000 (UTC)
Received: from localhost (unknown [10.72.120.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 906211800268;
	Thu, 20 Mar 2025 01:38:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] selftests: ublk: don't show `modprobe` failure
Date: Thu, 20 Mar 2025 09:37:34 +0800
Message-ID: <20250320013743.4167489-3-ming.lei@redhat.com>
In-Reply-To: <20250320013743.4167489-1-ming.lei@redhat.com>
References: <20250320013743.4167489-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

ublk_drv may be built-in, so don't show modprobe failure, and we
do check `/dev/ublk-control` for skipping test if ublk_drv isn't
enabled.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 350380facd9f..c86363c5cc7e 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -64,7 +64,7 @@ _check_root() {
 
 _remove_ublk_devices() {
 	${UBLK_PROG} del -a
-	modprobe -r ublk_drv
+	modprobe -r ublk_drv > /dev/null 2>&1
 }
 
 _get_ublk_dev_state() {
@@ -79,7 +79,7 @@ _prep_test() {
 	_check_root
 	local type=$1
 	shift 1
-	modprobe ublk_drv
+	modprobe ublk_drv > /dev/null 2>&1
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 }
 
-- 
2.47.0

