Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACC53BE
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641600; cv=none; b=q/b4wig/ZlSy/OxSgB6RbRmKJpi1ocF0v1V9MIM+/VdaG0n6bmkMvQHlU5ZaquO4pFk1dGuWV1pp/sj3iwZsak3A1vijmvBzSf8Gz4vN76D+lAXKnOeLlglMoD0SBLixvBooVsKN19omB3dPyL9wEQnEA9xkVrBO6pftZxMmBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641600; c=relaxed/simple;
	bh=X/GK3JOgz5UELHr/UwK/C5idRT4FlHybqiWQ2zW+u1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mf9m2SrxAsRP+JkllxSXF3S2cxk08004jAP5O3z7XjzRR1dMycCG7hr1yLd4RctozYDQRromnnlkgMHFgHp9kpQEw+W+itrrvuPNcHBEr3Z0lBfUYUfXTPbofPhhfKqF6GZDApD3ET76o+H0Ptzh4/6hU2jZCCOmW4RxNN39J/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NceDYPLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NceDYPLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750641596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0jHEUOCnYJt/is6Hd1OIkl8a1WNCNnxTWgHybKxns4=;
	b=NceDYPLZYBG0HUmzWfckBLIJPf7gMUTIsU5P+7SYyR2Hw7dExzV+hI2/u1rKS5j6NJmThH
	5mCjNg8ieYNbY+epyp3kUZ/DZSdiUVSTRtdaEpYGticWQmFAJkimq82dN4fyFnp0xpj9Ss
	4LjSxTL8c1bgmpxTMZEStvL/J1TVjew=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-5HzkcjSNNdaqg7TjGYYPkg-1; Sun,
 22 Jun 2025 21:19:53 -0400
X-MC-Unique: 5HzkcjSNNdaqg7TjGYYPkg-1
X-Mimecast-MFC-AGG-ID: 5HzkcjSNNdaqg7TjGYYPkg_1750641592
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E372B180028C;
	Mon, 23 Jun 2025 01:19:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A990C19560A3;
	Mon, 23 Jun 2025 01:19:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] selftests: ublk: don't take same backing file for more than one ublk devices
Date: Mon, 23 Jun 2025 09:19:27 +0800
Message-ID: <20250623011934.741788-3-ming.lei@redhat.com>
In-Reply-To: <20250623011934.741788-1-ming.lei@redhat.com>
References: <20250623011934.741788-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Don't use same backing file for more than one ublk devices, and avoid
concurrent write on same file from more ublk disks.

Fixes: 8ccebc19ee3d ("selftests: ublk: support UBLK_F_AUTO_BUF_REG")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_03.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index 6eef282d569f..3ed4c9b2d8c0 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -32,22 +32,23 @@ _create_backfile 2 128M
 ublk_io_and_remove 8G -t null -q 4 -z &
 ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
 ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
 
 if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc &
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
+	wait
 fi
-wait
 
 if _have_feature "PER_IO_DAEMON"; then
 	ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
 	ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
 	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+	wait
 fi
-wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.47.0

