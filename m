Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354052153EA;
	Wed, 14 May 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254619; cv=none; b=QT/rjspQuqPFE+bi81umpaFaQFaOlWXdPemrDT2affq8zvLZLV7eon24/cECoB3zWeokffkXQVLbPzD21YVw/M420Gyzam8gud5BzWPvgt3arZfaXtwckEyv4MyITlcsM6/lUk5UKEbrz1Sre1JmqgNjw9nXJEyFzs/ctslHd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254619; c=relaxed/simple;
	bh=wlRcbTGS9QnyRFoJpBFth2Mq4bdCk6zQurUyKr6+Hwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDywNWKRemjqHEbHS8Upx/9FXX0y6sy+kvCwL/dBeAMMnoteZsUrzcGfJHKDm187Obhba7MRJC7NNj0hHaDEvXtjhZw1bNSzJxozlcY5i6aSEwnGx9k5rNxJPFcW+yGcAXdnJh6qTbP5X44NLunYOQAH4QO10DgldtSzFiufN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=y+VbGfbc; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="y+VbGfbc"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZyQ2J0JJ6zlpkbZ;
	Wed, 14 May 2025 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1747254614; x=1749846615; bh=S0wEv
	t6SuoJtzXLDCujJHcKAE+TLB4SLlQd0DV+PY4A=; b=y+VbGfbcFW+PCJ2WkqdQX
	mrSKT9cJNnkNNvfwIHh0LCO6cKeKbXp+3IoFZCJdTSHGYqCpM5WRC9uIwHaYD/i5
	VmE3IKL9u3Ac4mU8cvQ80dkkEKEWtYifGRCetReIaf7bhv12OEMe9Cr6D/1MbfGf
	yZ5g/wm7GKJew+hupVHDAlTKgPBy+eHcvuKaYIVG0+4FTChofCGCTIPjUCfS149z
	KkW3qYi2JxYOMLK2L196/tB59w/VmHetDeLXUrFTcHqWG9pgffdo5crXKkrArlkW
	7vFx+gL/excabHqODP2dnynSwx9wZkxzrb6BE8nD3Q072J7AGjkRe9BDv28DmTEn
	g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lKjIjl0AUb-1; Wed, 14 May 2025 20:30:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZyQ276PGkzlgqW1;
	Wed, 14 May 2025 20:30:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio submission order
Date: Wed, 14 May 2025 13:29:36 -0700
Message-ID: <20250514202937.2058598-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250514202937.2058598-1-bvanassche@acm.org>
References: <20250514202937.2058598-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

submit_bio() may be called recursively. To limit the stack depth, recursi=
ve
calls result in bios being added to a list (current->bio_list).
__submit_bio_noacct() sets up that list and maintains two lists with
requests:
* bio_list_on_stack[0] is the list with bios submitted by recursive
  submit_bio() calls from inside the latest __submit_bio() call.
* bio_list_on_stack[1] is the list with bios submitted by recursive
  submit_bio() calls from inside previous __submit_bio() calls.

Make sure that bios are submitted to lower devices in the order these
have been submitted by submit_bio() by adding new bios at the end of the
list instead of at the front.

This patch fixes unaligned write errors that I encountered with F2FS
submitting zoned writes to a dm driver stacked on top of a zoned UFS
device.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f2..4b728fa1c138 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -704,9 +704,9 @@ static void __submit_bio_noacct(struct bio *bio)
 		/*
 		 * Now assemble so we handle the lowest level first.
 		 */
+		bio_list_on_stack[0] =3D bio_list_on_stack[1];
 		bio_list_merge(&bio_list_on_stack[0], &lower);
 		bio_list_merge(&bio_list_on_stack[0], &same);
-		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
 	} while ((bio =3D bio_list_pop(&bio_list_on_stack[0])));
=20
 	current->bio_list =3D NULL;
