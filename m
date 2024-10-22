Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC07E0E4;
	Tue, 22 Oct 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621007; cv=none; b=kWew0skP+U9TYz3gUM7YP7EzZfpbHFxXYEi+vYAdZmvcliH6hJ5grlzXvuXkdaoQ6en9V87DtEi6nSDafFWeRhGpsPEA+G2FRRqYwwv9ZZNZRVPLY2ly2A0+o33DtUgbu1wUyI4Y2ZkuPxx1PN5URTWSgTUWlEkYtZpjw+bURkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621007; c=relaxed/simple;
	bh=UZqgYCmGKMLoPX6x45jwleLfwKc2WBwRV6SssUQHBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5GD1tNdUL6PMuIqT9zBrzz1LyxsK6upgS6aW0Eg5xJ5gfDJkD0XbH04OJPouaK5c1AHWyAkzK1PDyiHoHb/1q2+aptkWRhI/6A344JRN9YNsmShUaNJhcoPAqU0xCPcOWeQmjY0RL2HSUlKxleDzwi/iHv50lXxlpVtPuN/2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GYmhqKWi; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GYmhqKWi"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XY0kH2RNKz6ClY9C;
	Tue, 22 Oct 2024 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1729620996; x=1732212997; bh=lsF95ZAMKXS4nPzun/TBSeUR4KI4RRlcTUe
	on854CPA=; b=GYmhqKWiPRNZ7boT3oKFHkSK24TQ3JGeHFMdq+hS2EzS99mejpg
	uEu6ifotQaphZt5Zs50DEts1seDZJyNiDt2NzpVg7t+BgCMfMy07TzPhlTuet0pL
	dnDtv3dLrP7mM/MsD5s4VSGq9obL3CaXo1iDquk9TnaW7WfCGJ988a36BpwUvT7M
	kG6cfEPQo2EV4Qo+t0pB6qFjgkKW89tO0rIigwkaKIGnvlltVHvStZU/XdE1lXUf
	w7fmGguOSN94qN6UiPCaNcLEAHoxEqMhEzUylhVoePl/pHelENgMTEl/ZBTJn0sa
	GHz94o0VpMU0WWylTP201M7Lts8ujwsY6bA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Z0rZcDsQIz26; Tue, 22 Oct 2024 18:16:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XY0kC4YXMz6CmLxj;
	Tue, 22 Oct 2024 18:16:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long
Date: Tue, 22 Oct 2024 11:16:17 -0700
Message-ID: <20241022181617.2716173-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure that the tag_list_lock mutex is no longer held than necessary.
This change reduces latency if e.g. blk_mq_quiesce_tagset() is called
concurrently from more than one thread. This function is used by the
NVMe core and also by the UFS driver.

Reported-by: Peter Wang <peter.wang@mediatek.com>
Cc: Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
Fixes: commit 414dd48e882c ("blk-mq: add tagset quiesce interface")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..1ef227dfb9ba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -283,8 +283,9 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set=
)
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
-	blk_mq_wait_quiesce_done(set);
 	mutex_unlock(&set->tag_list_lock);
+
+	blk_mq_wait_quiesce_done(set);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
=20
