Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271736C596;
	Mon, 23 Feb 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883505; cv=none; b=SPNadUCaC0knE4eCJ4NTfE5+uMRcxgB7voIIJpd6Z9IuJ737Ki9OFagOLTwRSUGa+ZTUtPfE2KTKjXz6frGo4+LajJJIyM9jDWJjrzkhNbPQFaW9VX7ThLMVJrBt1VPHrU1rOm/xOFSHq7x0eCf3DLrmcI1gSCELdi4M6B8I4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883505; c=relaxed/simple;
	bh=RmTxviYeFD+kxaP37UaKhNpja7wr7nUMBYTDoejJfWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWiBv4YtTxhkubqvcf5/ZyA0VkT8Pqmvb34vFZDiIFYFq5aEhEW63VBoFtuxWAgpyTIA4/YlJNdZLIWt2ndlZ06BkCOwEVzrjg/JKDfcdCG1OvlyIRrvzk89cw7LBORtE7y89KoSdjZoDovipaZa6+OJ3T3bUMmFdw/ZN2bucBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qAoetkz7; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qAoetkz7"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZLm4P25zlfc9G;
	Mon, 23 Feb 2026 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883501; x=1774475502; bh=AZ3sG
	Qj4YIz4DJk6WdxfGfC5ktdFyZ0XPqv+VnHtmLU=; b=qAoetkz70r/yOQMfgOWBy
	HoXcGws+z8bIK2Ie1yL9uY3zbcwIYBCeufiJCq+ZsqE9t8CWOBZZWvRCvp27PuPb
	wwxIcewRvVMSsJ8KfQMk8ul8MRUh8APwtmByPXGc85NZEmlYgpdp5G6WU9LIky26
	9begIV+Bj4Ia1oAy9qbaZj2RlfB6nnC4nYh8i5HIt8jTBbCTYmHFnWfTi2AHakgo
	lDaGBnul4mc/6F/6ouBf6QW3chZ2k74aTBnT4gtgLrwt2J3VoiEWKP4RRn2Ix7RF
	Qscv/e20J331ArDsOTyeyA5n0jeRG8ig7IrIVbgwG7P2hxht59jxWx+4rpOWKXhx
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 02Rbj0PkP50c; Mon, 23 Feb 2026 21:51:41 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZLd0sYjzlfl6N;
	Mon, 23 Feb 2026 21:51:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai3@huawei.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org
Subject: [PATCH 02/62] blk-ioc: Prepare for enabling thread-safety analysis
Date: Mon, 23 Feb 2026 13:50:17 -0800
Message-ID: <20260223215118.2154194-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Clang thread-safety analyzer does not support testing return values
with "< 0". Hence change the "< 0" test into "!=3D 0". This is fine since
the radix_tree_maybe_preload() return value is <=3D 0.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index d15918d7fabb..0bf78aebc887 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -364,7 +364,7 @@ static struct io_cq *ioc_create_icq(struct request_qu=
eue *q)
 	if (!icq)
 		return NULL;
=20
-	if (radix_tree_maybe_preload(GFP_ATOMIC) < 0) {
+	if (radix_tree_maybe_preload(GFP_ATOMIC) !=3D 0) {
 		kmem_cache_free(et->icq_cache, icq);
 		return NULL;
 	}
