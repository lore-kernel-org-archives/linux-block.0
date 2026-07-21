Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4E3BFE31;
	Tue, 21 Jul 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.215.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624056; cv=none; b=Q5psoWLtsek7BxcxFRk25TkfKZZ40Y2ldyNTmWUzG7muipp1PNQpN5HVEZPKbScAH5/lqj2Aefz6kGNg36S7AEBxzKEpGfU4K0Mglh01WMki/21ygOpS5hrf/Gia54sBmkGgAsn4hfywtXRcy32MOfmf0846BMPOrMvjJIwlJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624056; c=relaxed/simple;
	bh=UfDGCbiX0iAJOSMAkY5LEAHzp4NV1iM8kA0aHeWsudc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YINTveFpA0A2zkLVJ+L3UNI20sZChUTyqs3bIQifCi+V5ACBbRv9q5nYlMhQrtHCjBdGBP1dvDTWlKuWNGQicmtDm6Qz9S7aH+yw1K5Zzvy59WKySbSLbgl0D+Pl+RQ0tPA5BrVeIB1XpTeVyGi5836KFm01EW11lGIOog7Hpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org; spf=pass smtp.mailfrom=xenproject.org; dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b=aLNwX/kO; arc=none smtp.client-ip=104.130.215.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xenproject.org header.i=@xenproject.org header.b="aLNwX/kO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=xenproject.org; s=20200302mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	bh=bdDsiykPjBUfe0KEnYj9Ac5iuCAr2t/tb9Le1tNVtgI=; b=aLNwX/kO4LiiKWi6BZaKN2k6nD
	+CTAUMF96K1Nkr0/X79m/hTpsVP5XM51YlRysDfwUm+OIlB9RiO0VfpktPRsh4Q80xbVbTsIpcV4V
	eib2CY27quvWPIxel5nMWw5QNZQLrFsMt+Y9aK7xInJg8i12gtpjW2Bg4Oc8TYctP05U=;
Received: from xenbits.xenproject.org ([104.239.192.120])
	by mail.xenproject.org with esmtp (Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1wm5lZ-000Ydm-0w;
	Tue, 21 Jul 2026 08:23:53 +0000
Received: from 224.pool85-54-217.dynamic.orange.es ([85.54.217.224] helo=localhost)
	by xenbits.xenproject.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <roger@xenproject.org>)
	id 1wm5lY-00D0uS-2J;
	Tue, 21 Jul 2026 08:23:52 +0000
From: Roger Pau Monne <roger@xenproject.org>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Roger Pau Monne <roger@xenproject.org>
Subject: [PATCH] MAINTAINERS: update my email address
Date: Tue, 21 Jul 2026 10:23:21 +0200
Message-ID: <20260721082321.81212-1-roger@xenproject.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Roger Pau Monné <roger@xenproject.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab8736850ea..0dadcaffab31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29399,7 +29399,7 @@ F:	net/xdp/
 F:	tools/testing/selftests/bpf/*xsk*
 
 XEN BLOCK SUBSYSTEM
-M:	Roger Pau Monné <roger.pau@citrix.com>
+M:	Roger Pau Monné <roger@xenproject.org>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/block/xen*
-- 
2.53.0

