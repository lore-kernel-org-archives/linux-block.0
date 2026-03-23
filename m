Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860543E022A
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296333; cv=none; b=lnNF5iUzWp92U79+DI0oMsi+SMhJPbd5dYM85AmvOe7IxIXLP7lJ7Tf2KM1f5Fx8UryTWbAkEWHFLYmSP2qe5EQdgKOZI9f7GTjfkSYGcEg2n7dm8VlxM8W7u7uC0UwxLqcXhz+qEWgHZWNXcYbNGNI1mzXQPmyE7P1SCJeJJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296333; c=relaxed/simple;
	bh=GbhFsNDZoyB4yrkIkOGK+1xzi57RR+0NuN5xBCss35U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XliNWVojOIEH1ubhq464/HfmaPkLWd5KpRKTW/4ZuVyfCBCN72ZxaaDt3wPHEPE4Dyo13nSW6j1/JQNkRlbj4J1YPI134qjnr/jdqdMpVKG0ycVlWl04lovtZnmtzJza3yZFkGh3xnOG+GuC5Z7xR0Wlg7gewrAcMGF0kSOG3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2pVJShFX; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2pVJShFX"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4ffkgC4kw5zlfdfc;
	Mon, 23 Mar 2026 20:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774296325; x=1776888326; bh=aLxSWCL1ZR3s1PVacdEF8Kq5TNUAnFF4q2r
	gx2vlkoA=; b=2pVJShFXIm2TJIoZtKtv8kgWnFb6iksxz2ip3dx25+uA0o6CVtS
	4inqTyZvWQE8vhwhWOROrIk0r2qegriO3+GJG+/hzvvhx0ISewynTZ699vc5tfMk
	m1uBm39cWVbjO+HE4KRGWg7p1YnQNoJUXqLqIs1iOPkYAxn+umV2Zr8luwfXEWzP
	18YRuByLLJm9cBntsTLTXTIhgtvqqp/eQtP+B1uKOkq09xas4KoP55q9drXI5BJg
	cuRTdkSDcdK2/91AfrEeb5hw+SZq5dyZ5JUyVuxhPePFFQuRWHwY9TVLAEUmpaAy
	oFAcGo/vJSQtsWdteJA6DJp0Xwrc5om3CPA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fi7tas201gHX; Mon, 23 Mar 2026 20:05:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4ffkg85Z4Wzlgy1v;
	Mon, 23 Mar 2026 20:05:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests] check: Suppress kmemleak scanning failures
Date: Mon, 23 Mar 2026 13:05:12 -0700
Message-ID: <20260323200512.1237426-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kmemleak disables itself if an internal error has been encountered. If
this happens, any attempt to write into /sys/kernel/debug/kmemleak
triggers the error "Operation not permitted". Suppress this error
message instead of displaying it on stdout.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index f170458fdb69..d2232828a9e3 100755
--- a/check
+++ b/check
@@ -233,7 +233,7 @@ _check_kmemleak() {
=20
 	((KMEMLEAK)) || return 0
=20
-	echo scan > "$KMEMLEAK_FILE"
+	{ echo scan > "$KMEMLEAK_FILE"; } 2>/dev/null || return 0
 	sleep 1
 	kmemleak=3D$(cat "$KMEMLEAK_FILE")
=20
