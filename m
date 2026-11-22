Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384611;
	b=EK5IaxLE51FwooOo8yxPBCz3NHiIuo2k7HniJJhYvSGuZMFP7ceNONGLQDDWFlPoOmp7
	 6d/CgbV7JIM+gZjpoggaG8UBhX0wT8bLV6krXADO01nDZ8rf4khE/Y+By3xq8uZ2NDNkR
	 WD2qAH9oWshcgfyK4KW1cuj8LuXoe/lOMQnv6JNs6Z60yq161Uu08K5rQEP+J2MI5aW5y
	 SFegQGpnOaOEm1I9kHITAaq2J0SO1BZt80oPQgQy9mblh0n8MrN84d5YytoCnvg6Ps/Ek
	 jrYaWfx5Dk4qYChwxVkoNet6JjgRlkCKyVTresliAiVxTzr8hmpnpFISZLT8VBl+4KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384611;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=RzVUiAa1Zi78olaFHxQ5LfIrbXTA4wMcR/QDA0Z5cBM=;
	b=e1KSRPgWSNhjglwSwt/57gN3+5Dj5j3lwdQlUD4wpfik55eXyMn8HCk2+SOqxmyNSgsc
	 Weao+F5EcnLqZwppMxtGFt9AMZvm1MRPZsH/aWET0JI80brVtd9PoeRofmtbk1k0OcIY8
	 7nOYbUUJgqb/Md13mW+wQ2gWqj7hDKLgog4k8wnxRoKz9p1E0ZZyZ/WOOD3U0VgCWO1jg
	 O00tODe8JYdYb/DCr00yt5DB61XWIvzD4Dq4Qxuax7LGSXbPPTRHTijm7p46jrXLS6Vcg
	 KtaLGkvCBOS1rICzelU5Wj5Nxstg3UUfCDKdRf6UIIZGOoHQ5vPzv9LjuVDHxGzBvSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JWyRMRvM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C522606A31E
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 21:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C522606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JWyRMRvM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795384609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzVUiAa1Zi78olaFHxQ5LfIrbXTA4wMcR/QDA0Z5cBM=;
	b=JWyRMRvMSYu+u1GOH5oOO+pPv8AB/62d+8ev/uCupg9H8+pSXjXv4yJdmZ1Mrt67+ikP8u
	4KhYAxkDFXMak76Xb+goI8aCgXWcWkEFaEXTW+xnbSmhqPTR2WjNeqn+/LeG+LHuIkRdfo
	dKEniLD5w76UD6zv7O1DpNO5oaCGrYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-NgiR78idO2OqH4yJswBNaA-1; Sun,
 22 Nov 2026 21:56:45 +0000
X-MC-Unique: NgiR78idO2OqH4yJswBNaA-1
X-Mimecast-MFC-AGG-ID: NgiR78idO2OqH4yJswBNaA_1795384604
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D90A1956056;
	Sun, 22 Nov 2026 21:56:43 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA170421;
	Sun, 22 Nov 2026 21:56:42 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6AMLufYt2865299
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 16:56:41 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6AMLufZA2865298;
	Sun, 22 Nov 2026 16:56:41 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <mkp@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: stack max_hw_discard_sectors on bottom max_discard_sectors
Date: Sun, 22 Nov 2026 16:56:41 -0500
Message-ID: <20261122215641.2865290-1-bmarzins@redhat.com>
In-Reply-To: <awNF-dV2TacxpUqf@redhat.com>
References: <awNF-dV2TacxpUqf@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

blk_validate_limits() sets a device's max_discard_sectors from the
minimum of max_hw_discard_sectors and max_user_discard_sectors. For a
stacked device to correctly limit max_discard_sectors to a value that
the lower device can handle, max_hw_discard_sectors should be based on
the lower device's max_discard_sectors. Otherwise the stacked device can
pass down discards that are over the size limit of a lower device whose
max_discard_sectors is smaller than its max_hw_discard_sectors.  This is
a particular problem for request-based dm-multipath devices, where the
underlying device does not have a chance to split the discard.

Use the upper device's max_hw_discard_sectors to limit this, instead of
max_user_discard_sectors, to ensure that it respects the lower device's
limits, including their user settings. A user raising the upper device's
max_user_discard_sectors should not be able to make it send larger
discards than the underlying devices can handle.

Device-mapper does stacking in two passes. Each target calculates its
limits from its underlying devices, and applies any target io_hints.
Then the overall device calculates its limits from all its targets. For
the overall limits to be stacked correctly with this change, each target
needs to set its max_discard_sectors to its max_hw_discard_sectors
before being stacked into the overall limit. Otherwise the
max_hw_discard_sectors io_hints values from the targets will be ignored.

Fixes: 4f563a64732d ("block: add a max_user_discard_sectors queue limit")
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---

Changes from v1 (sent as "block: stack max_user_discard_sectors")
- switch from stacking max_user_discard_sectors to
  max_hw_discard_sectors
- Adapt device-mapper to the change.

 block/blk-settings.c  | 6 +++++-
 drivers/md/dm-table.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1f5ee2453269..52ac00c59a0e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -919,8 +919,12 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 		t->max_discard_sectors = min_not_zero(t->max_discard_sectors,
 						      b->max_discard_sectors);
+		/*
+		 * Use bottom device's max_discard_sectors to limit the top
+		 * device by what the bottom device can actually handle.
+		 */
 		t->max_hw_discard_sectors = min_not_zero(t->max_hw_discard_sectors,
-							 b->max_hw_discard_sectors);
+							 b->max_discard_sectors);
 		t->discard_granularity = max(t->discard_granularity,
 					     b->discard_granularity);
 		t->discard_alignment = lcm_not_zero(t->discard_alignment, alignment) %
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 48f25ab6b7fa..4cabe2645094 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1834,8 +1834,11 @@ int dm_calculate_queue_limits(struct dm_table *t,
 combine_limits:
 		/*
 		 * Merge this target's queue limits into the overall limits
-		 * for the table.
+		 * for the table. In blk_stack_limits() the upper device's
+		 * max_hw_discard_sectors is based on the lower device's
+		 * max_discard_sectors, so copy this value over first.
 		 */
+		ti_limits.max_discard_sectors = ti_limits.max_hw_discard_sectors;
 		if (blk_stack_limits(limits, &ti_limits, 0) < 0)
 			DMWARN("%s: adding target device (start sect %llu len %llu) "
 			       "caused an alignment inconsistency",
-- 
2.56.0

