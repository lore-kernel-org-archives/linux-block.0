Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E71C3C11
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434721; cv=none; b=Dly/Mvlc1xxX6EsQaB51/ypN3if4YHeH+F/YWrYhzMpaCCJUC/jUFlb7BWkPWt9E6cv7JFo3WSDMKgDSMu77g6vntCVv+ADxuVcl7eCpePs6jfTBxNuqPpaNpdKJpjJzEaeBHWp74gKrD+0635gW+LXt18BtKkyqtTL3Isb5VhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434721; c=relaxed/simple;
	bh=tyNnKzkNlOfQ9y+3zR3SXnqOL9LdhzAqtfGWnqqZo8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDvi70sP4h4NZvLE6fIv2R1lpD/SSBlhClLnb42FItofPeHfTIj0dKTyu6et72spuUXOMyd5mnj+p/NC7V24u0quLBS9UcZcWm46drkMpFP/tLHI4oLIypIAU/5k9VT+D3hLAUzzBwp9oTOZdTX/DuNBJ4lUAkykeVsqzCe9pfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZJxrcWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZJxrcWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuEw7K+Fy36hpVpQalPa2rMI/SNHfnKzi8BTcPkh0rc=;
	b=IZJxrcWEf2HB9stGPrQY2JqdyfW1ewhh3sLATz0cpaEcat5fz+NOXPaoC/8y5p+yTTJEDK
	R01TuGczf5V/bmSlf3OQy0BlO9EkYUm/ryefY8tInLo4e9ghEXqt7PGa4nvT8rT9AzOMdE
	ZNM+bef/4spn2+8rYvW9TsZblw2Tj9E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-V5zr01_POcOE_3bnT5SL8A-1; Wed,
 19 Mar 2025 21:38:30 -0400
X-MC-Unique: V5zr01_POcOE_3bnT5SL8A-1
X-Mimecast-MFC-AGG-ID: V5zr01_POcOE_3bnT5SL8A_1742434706
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722EC180AF4E;
	Thu, 20 Mar 2025 01:38:26 +0000 (UTC)
Received: from localhost (unknown [10.72.120.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50C691800268;
	Thu, 20 Mar 2025 01:38:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] selftests: ublk: add variable for user to not show test result
Date: Thu, 20 Mar 2025 09:37:35 +0800
Message-ID: <20250320013743.4167489-4-ming.lei@redhat.com>
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

Some user decides test result by exit code only, and wouldn't like to be
bothered by the test result.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index c86363c5cc7e..48fca609e741 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -94,12 +94,14 @@ _remove_test_files()
 
 _show_result()
 {
-	if [ "$2" -eq 0 ]; then
-		echo "$1 : [PASS]"
-	elif [ "$2" -eq 4 ]; then
-		echo "$1 : [SKIP]"
-	else
-		echo "$1 : [FAIL]"
+	if [ "$UBLK_TEST_SHOW_RESULT" -ne 0 ]; then
+		if [ "$2" -eq 0 ]; then
+			echo "$1 : [PASS]"
+		elif [ "$2" -eq 4 ]; then
+			echo "$1 : [SKIP]"
+		else
+			echo "$1 : [FAIL]"
+		fi
 	fi
 	[ "$2" -ne 0 ] && exit "$2"
 	return 0
@@ -216,5 +218,7 @@ _ublk_test_top_dir()
 
 UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
+UBLK_TEST_SHOW_RESULT=1
 export UBLK_PROG
 export UBLK_TEST_QUIET
+export UBLK_TEST_SHOW_RESULT
-- 
2.47.0

