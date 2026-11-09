Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253178;
	b=aLVDEPSICOFzDBwc+CpQ6R4i9GWnNyEL2SCjMaZPboOdVFsV+0j9gpfuRJkcG0Zv3ssm
	 lpZZ923Fm3EsqGIrQEYVUL2tS8TpmgbBIOs64tZYDdySFq+7kmnOWhcCnKfkYdg0sx4/5
	 dEQKEBc+gBspKleEb3zMElfBdAPdNl/SqsR+6RtnCR8mNhyJC16aQJPiHGbVEEWFas27a
	 XqDKxdUdq/TqtjpY57dfQZ9xLi6dcsthHd4UP83Jh2rvPvDdciLOowEn0K6+j2BJLMgDd
	 pcTArDvDyctaTz3hDJVBHMgfnIjlmgBCJfVM1cTWJOrpkcIm7iRT8bu3Y0KPLE7lYdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253178;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=e88sGOaf8naSU5yJw1LRL2JX3D71whzaUkfVTT4pmiU=;
	b=gvxsIX8GRX2BXZbs6KN9ysxq11rhKJAZdLioM5keSwIGQTzQdn4qCpvCrHTudl6hYwBe
	 l48kG9AagXiz2azVKXFWkoz7eLQNtLa557idcWU2vXNxcnfv57MQHb2PLuX8d2rnIpIp6
	 +gE/OJgbQB8AvxyK9vjA1R8OTjG2yt4H56ltzwwM+jG6Bans6PJirhM6v2679Dyg9cdQ3
	 +kdIFt+E5ksE78k1sk+4HMG0LYznb69B7SKZcYij98lqU1hQ5yuq/yyZWLbeLruOTyixD
	 3vDhomHO1PzWHR9sXZXDBTTBekGz02D6qntc71zZxuBAZhsOburh23F5S1Plp7rwzTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOzOnbNq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9B606A331
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 19:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F9B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOzOnbNq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794253176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e88sGOaf8naSU5yJw1LRL2JX3D71whzaUkfVTT4pmiU=;
	b=VOzOnbNqqEh7Cm1pb3E8zF7u5qs2rl6HYpdOtxeiy7yWhU7UZdRS+so4ZsbY5JPFKAG996
	Lxmw9F4hT0KGMkWXKa88nSDbuW9BrgOvqa6Uo5gZdLhS1XN9UQTqb1mREiH+12f9YJWYgc
	42iMJ5DHmk2fuKXQiWnS62tmJBjcc2I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-uW_G6uEGMlOwOJcOACFO0Q-1; Mon,
 09 Nov 2026 14:39:33 -0500
X-MC-Unique: uW_G6uEGMlOwOJcOACFO0Q-1
X-Mimecast-MFC-AGG-ID: uW_G6uEGMlOwOJcOACFO0Q_1794253171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F1FC1977321;
	Mon,  9 Nov 2026 19:39:31 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E05531956089;
	Mon,  9 Nov 2026 19:39:30 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6A9JdT86595121
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Nov 2026 14:39:29 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6A9JdRH7595112;
	Mon, 9 Nov 2026 14:39:27 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: stack max_user_discard_sectors
Date: Mon,  9 Nov 2026 14:39:27 -0500
Message-ID: <20261109193927.595104-1-bmarzins@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

blk_validate_limits() sets a device's max_discard_sectors partially
based on the value of max_user_discard_sectors. For this to be set
correctly on a stacked device, max_user_discard_sectors needs to be set
to the smallest value of its underlying devices. Otherwise the stacked
device can pass down discards that are over the size limit of the
underlying device. This is a particular problem for request-based
dm-multipath devices, where the underlying device does not have a chance
to split the discard.

Fixes: 4f563a64732d ("block: add a max_user_discard_sectors queue limit")
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 block/blk-settings.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1f5ee2453269..1f02a867061e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -919,6 +919,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 		t->max_discard_sectors = min_not_zero(t->max_discard_sectors,
 						      b->max_discard_sectors);
+		t->max_user_discard_sectors = min_not_zero(t->max_user_discard_sectors,
+							   b->max_user_discard_sectors);
 		t->max_hw_discard_sectors = min_not_zero(t->max_hw_discard_sectors,
 							 b->max_hw_discard_sectors);
 		t->discard_granularity = max(t->discard_granularity,
-- 
2.56.0

