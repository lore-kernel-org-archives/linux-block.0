Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D376026
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876650; cv=none; b=X6wz0YoZ+/GO/9D9/NUyYDFmA45k2iux8Urf8MyJyyQdUvuOmE+gVbuj4bT1pZzyRqmjA8SYAiE3ZLrXgl1akBFnRSUFd5LaTFw2WmbrjhMmILf42MldATp2JnJAJb4wL1cLDN7rdYpAbnJDgOmoZtzrTkQ3c+D7M0sJO+EkRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876650; c=relaxed/simple;
	bh=N59pbrkrtDqQ8Kt1y5xPyH9IE3QKxPGin2Uodd1KNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS6DRPop/TYjuM/Bk/oo+7vkzo84hjvy4aK5QfytKNGw0m2a1nqxhA3s5yufgP9hMIuNrh4noIV9gyvFlLjumabbt8eidSYw9xrtq/06ldcd5xsMDdeenHYw9RyHcufDmFZu9SH64o6fNvguq32PW+WaopTwBs40VyiGSrWa8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/1dzKNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/1dzKNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XTTF2DtOXsGJBNh4PlFufkZBOZSRQIB2LFt8wZ+AyY=;
	b=C/1dzKNqEtQENGcZavvRK6gPhlOJegtB1oSy6wXKJgvVv+EVx06CCATAOK4kMocvEs0tYj
	bC2RuK2t0XvXZI3v/tn4icS9cQ1HnV+N8mrymPkNHH0CSuvc/OxCUtJENoxmHGbwXeV4Re
	L9s5lbpYz8EHiCl3u8TAEoAAYinZ+eQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-uykcQF6LOPGTy5rjVy82mw-1; Sat,
 31 Jan 2026 11:24:04 -0500
X-MC-Unique: uykcQF6LOPGTy5rjVy82mw-1
X-Mimecast-MFC-AGG-ID: uykcQF6LOPGTy5rjVy82mw_1769876643
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23CF61956096;
	Sat, 31 Jan 2026 16:24:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EC841956056;
	Sat, 31 Jan 2026 16:24:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/9] selftests: ublk: simplify UBLK_TEST_DIR handling
Date: Sun,  1 Feb 2026 00:23:32 +0800
Message-ID: <20260131162342.13872-2-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove intermediate TDIR variable and set UBLK_TEST_DIR directly
in _prep_test(). Remove default initialization since the directory
is created dynamically when tests run.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 21ba51fcc7d7..8d298a7ee7b1 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -124,8 +124,7 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv > /dev/null 2>&1
-	TDIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
-	export UBLK_TEST_DIR=${TDIR}
+	UBLK_TEST_DIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
 	UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
@@ -408,8 +407,6 @@ UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
 UBLK_BACKFILES=()
-UBLK_TEST_DIR=${TMPDIR:-.}
 export UBLK_PROG
 export UBLK_TEST_QUIET
 export UBLK_TEST_SHOW_RESULT
-export UBLK_TEST_DIR
-- 
2.47.0

