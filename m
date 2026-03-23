Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9C36922D
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297765; cv=none; b=USovXU3JsNzcX2uGWvHZqru0EK4kPVmimEvsz5Thavaw5CmxvMij+niDp524Q4h3xFiOWWEhcm+JmHWomoIUupyHtioRWIX3e4tR/NW3YazeDyZ/72cabi/eramdfabD7A1Gk6PNyS65xsQ6ep8vDE6bvdGGoIFr+3kAkOe7s0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297765; c=relaxed/simple;
	bh=d54RFIFd1VEIjF8sqlRKiB8kS1iA4lHKNbBXyR/CJmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9dZtfMjaoOnNHf+HRkNYz9RtPmoKCC5itW4lLXkRgpj+sEcYtExcex/FMEMqWu4fdfrWgNefSYRp11UgHqX6WepFzuEmfbTKsnBWdt9st3H/Rq9XC4dUOyxzirXRQndn4aYQxX18sWj/LSMJv+UrN3a0Qd+Pi97cFYokaBcpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SkBsDfwj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SkBsDfwj"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fflBp4xCrzlfgPq;
	Mon, 23 Mar 2026 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774297759; x=1776889760; bh=KhRKI
	oDWH9yqO5sYrwspWeVQ1ZooaBaPJyStEb2NTao=; b=SkBsDfwjaAhEv9ta0yWe9
	YVfKgj1/nIlOdsCqjpRp5Xo7wEiDv6uY4T+7+yzQA1lpJHsu75ufXfK5R9UKKCtm
	7Q5vXOGRvEHyJMlV6NgfxtACBJBIKLqYdlrIsjIyKNnariPmARfFKBDBdmCmONZZ
	ypQq7O1zhRA0NfMW0zIRL7aOGgKexwAEQo05ccLwfJlhK85XSGo6YkswTBQgo0Ry
	cHnIXOo3nlr6pMPVOtrDnupKgbt2ddn1guJNK3f0x00AQcINcP9UPxXdi6xsP/Rf
	vs4J7IiAWBotFSJXGfkhtItMO3/VvfCHn5Qt20jaHljACRUs39bGbJgUm2kqT+Cu
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rxi-uf1VlKxG; Mon, 23 Mar 2026 20:29:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fflBk4NW5zlfl6N;
	Mon, 23 Mar 2026 20:29:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: Reduce BLK_MIN_SEGMENT_SIZE
Date: Mon, 23 Mar 2026 13:29:01 -0700
Message-ID: <20260323202904.1248169-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260323202904.1248169-1-bvanassche@acm.org>
References: <20260323202904.1248169-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current value of BLK_MIN_SEGMENT_SIZE, 4096 bytes, makes it
impossible to test small DMA segment size support on systems with a
virtual memory page size of 4096 bytes. Hence reduce
BLK_MIN_SEGMENT_SIZE to 512. There is nothing special about this value -
any other value that is a divisor of 4096 and that doesn't cause
lim->max_segments to be exceeded would also work.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 7082dd5a87f9..7c792c012b0d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -23,7 +23,7 @@ struct elv_change_ctx;
 #define BLK_DEF_MAX_SECTORS_CAP	(SZ_4M >> SECTOR_SHIFT)
=20
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
-#define	BLK_MIN_SEGMENT_SIZE	4096
+#define	BLK_MIN_SEGMENT_SIZE	512
=20
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
