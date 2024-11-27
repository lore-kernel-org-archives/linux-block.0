Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F311DFDE
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715518; cv=none; b=no5/23o8I7Sr+JyYlAoLHdCwLtNKjV54m99P+QOIGtrbapi9qv8yAffeCyI8+NV74ksI9HkhmxL84aSzZosuar3kQW9RktxKCv/kLdU74M7QBDvXIdRqMj4KtZ7M4puk85ZkkwTW/Qe0XXp+FLSqINHDKalLvx10yHT0drzfGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715518; c=relaxed/simple;
	bh=3fQi4y05Wb8ofIDrYY2TqmC6eFfUh8zczGtjuN2rLO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+AvnfnnW0CzSbJgruVqzkK3J5CTF+Q50mCsnu3l1MjrWFGEbHWNnVuVzuV2rLP6yBHNPhDP73nku84wGb9avPMoLexyGeK/syarrxhM2hvQUiUQYPpqugqs91m/j4IKlnEc34WQ3AoJSc5HVVKtnCcOKftGKhk2OnSkIF6dy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpDgF5dy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpDgF5dy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732715515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSkIReSMDQ4Yq0+UoVEXX2xpnK5H/ZQBFh1+ycy4HrU=;
	b=bpDgF5dyaMlBsfXc+7LFaKkKkYRppe59A0so19o6f1fkuYICeViNtP6NMQ3VMTuNZTQCeY
	m3LBdjr3MRb/Nd4n+WOAJzfuOBYJ9P4x4Zf2hfNHsHgxRE5JNQVyEUccrI72l5MQICPKhn
	g9zIlKDGkVcLjlB5fj9MdLgRIYxAPfw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-jtQQC0rFNICzi4CyABj6Ng-1; Wed,
 27 Nov 2024 08:51:52 -0500
X-MC-Unique: jtQQC0rFNICzi4CyABj6Ng-1
X-Mimecast-MFC-AGG-ID: jtQQC0rFNICzi4CyABj6Ng
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE09E1954128;
	Wed, 27 Nov 2024 13:51:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 236581956056;
	Wed, 27 Nov 2024 13:51:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] block: remove unnecessary check in blk_unfreeze_check_owner()
Date: Wed, 27 Nov 2024 21:51:27 +0800
Message-ID: <20241127135133.3952153-2-ming.lei@redhat.com>
In-Reply-To: <20241127135133.3952153-1-ming.lei@redhat.com>
References: <20241127135133.3952153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The following check of 'q->mq_freeze_owner != current' covers the
previous one, so remove the unnecessary check.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 270cfd9fc6b0..6af56b0e8ffd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -141,8 +141,6 @@ static bool blk_freeze_set_owner(struct request_queue *q,
 /* verify the last unfreeze in owner context */
 static bool blk_unfreeze_check_owner(struct request_queue *q)
 {
-	if (!q->mq_freeze_owner)
-		return false;
 	if (q->mq_freeze_owner != current)
 		return false;
 	if (--q->mq_freeze_owner_depth == 0) {
-- 
2.47.0

