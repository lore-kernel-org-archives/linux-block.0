Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BC3FC5D0;
	Mon, 14 Sep 2026 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383786; cv=none; b=ReJJceO+me/Pb5JkHHayNM4DhZR42NxKSZWJguqeQ7VGZkn28yAGn4sGDQhR35z0J8DWck+hQ+EDJYpi7xX5TDabbxJ7hjEA31YCtb9x48Sp91U9zhHMbfbrAAPOBEaVXMdR+5NvzBairVNZ6vPYm7ISjnsP3MBnY9u8ds3dp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383786; c=relaxed/simple;
	bh=feTNeZ21BNrqRGVAvjOwvU/3q6aY66M8cI3IJByjReQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kV1uetR3ven9zZj0Ybraf7Bb68VqGWEN7CLtQTyXeaDvXMypC8gX/5TFq2UiibK76n6e28hS0e4q9SOfA0CEhi0xzUuP9wGI7hizjTYh9kt0h6jOzoHagLX3+i73GfIL7S3I6HV1QnyPhqnx6D35KOywLwrIZDbnTkUUXanQoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=J3QGa7p0; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="J3QGa7p0"
Received: from localhost (ip-109-41-49-60.web.vodafone.de [109.41.49.60])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 68EB2W07265105
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 13:02:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1789383753; bh=feTNeZ21BNrqRGVAvjOwvU/3q6aY66M8cI3IJByjReQ=;
	h=From:To:Cc:Subject:Date;
	b=J3QGa7p0M8osOcYdCQK66ehImQRx1vUWkKZFUHbhfS4iAr4Eso4Lbv1xRhLmao+9r
	 UYYk2+3y6nvkj9KAMtghIFfsbbYNSNcwJAYEhRS4eJUgdNSHfidBmp90BeNdhILynO
	 5jSJm+l4x+1czgiIYGxedy+zmbOOYRHHHHz6KRMs=
From: Dirk Gouders <dirk@gouders.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
        Dirk Gouders <dirk@gouders.net>
Subject: [PATCH] selftests: ublk: fix unused_result error
Date: Mon, 14 Sep 2026 13:01:09 +0200
Message-ID: <20260914110145.41627-2-dirk@gouders.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 166b476b8dee (selftests/ublk: add shared memory zero-copy
support in kublk, 2026-03-31) introduced a write(2), ignoring its
return value and thus causing an error, when building.

Fix this by using the common workaround "(void)!" to trick the
compiler the result is being used.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2400b4615766..5b19bfcfa8d7 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1589,7 +1589,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	/* Signal listener thread to stop and wait for it */
 	if (linfo.stop_efd >= 0) {
-		write(linfo.stop_efd, &stop_val, sizeof(stop_val));
+		(void)!write(linfo.stop_efd, &stop_val, sizeof(stop_val));
 		pthread_join(listener, NULL);
 		close(linfo.stop_efd);
 		ublk_shmem_sock_destroy(dinfo->dev_id, linfo.sock_fd);
-- 
2.55.0

