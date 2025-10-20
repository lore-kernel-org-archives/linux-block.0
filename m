Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A852F83DE
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964426; cv=none; b=DD8JrQxWeZ+sRDG9SFlX3+oqv//jyEg+BwRLEEs+Fgv/2dyUkbS0sy4vg8SJCsKs4QCCirMB0g40xAO0YeGcpvCsNKQFJpN3t4ZRRaIRV40PbgmfCIpvXuum7NEeOU+yBK4cjpOjvTcLJpwWWf2BAkOKTneqp7YiMc4XC/0G4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964426; c=relaxed/simple;
	bh=XFLQOToBNY+7nOz2f+tpolrIaa0xU7qt4tC6KNATsLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sn+xliymwcchrDus+AllCQ7KTcI2vp3hboDrYHLWL8k214hV0k0qZxwzm9UHKoh15ICizyuGF1w9tPtM/2Q+XwW41bgsv1itQOubPNWSNPXa0t/dZQlHdvvdb7j5mzOVk1Iv13vmhobenqHFRZvQuwjYKkAEEjOJCJ3MDHYKCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExbZJEUQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExbZJEUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760964422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUF+i4AHorT+VALl8fcSqL8T041fxKcuGdTyj83io1o=;
	b=ExbZJEUQRO9ZOLIBMJJU15ODIUWcBDoQFfsYfiXZMjmM5OI0zuIp32NwsQl7WDFwK8UH9e
	K4Cp4oCTS1Bbdwu7wS/sPycDuEQGJD6w4d+Jx62VSyk+3BxZ1QO0Hl95HJEOS7sCTfyt6C
	3P7P1pCcvuvy++MFI0P0SIDnOWZcz/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-X9wRUfuyNyWNOxG67wleYw-1; Mon,
 20 Oct 2025 08:46:58 -0400
X-MC-Unique: X9wRUfuyNyWNOxG67wleYw-1
X-Mimecast-MFC-AGG-ID: X9wRUfuyNyWNOxG67wleYw_1760964417
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B96D818015FA;
	Mon, 20 Oct 2025 12:46:56 +0000 (UTC)
Received: from localhost (unknown [10.72.120.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53DEC180044F;
	Mon, 20 Oct 2025 12:46:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] lib/group_cpus: fix cross-NUMA CPU assignment in group_cpus_evenly
Date: Mon, 20 Oct 2025 20:46:46 +0800
Message-ID: <20251020124646.2050459-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When numgrps > nodes, group_cpus_evenly() can incorrectly assign CPUs
from different NUMA nodes to the same group due to the wrapping logic.
Then poor block IO performance is caused because of remote IO completion.
And it can be avoided completely in case of `numgrps > nodes` because
each numa node may includes more CPUs than group's.

The issue occurs when curgrp reaches last_grp and wraps to 0. This causes
CPUs from later-processed nodes to be added to groups that already contain
CPUs from earlier-processed nodes, violating NUMA locality.

Example with 8 NUMA nodes, 16 groups:
- Each node gets 2 groups allocated
- After processing nodes, curgrp reaches 16
- Wrapping to 0 causes CPUs from node N to be added to group 0 which
  already has CPUs from node 0

Fix this by adding find_next_node_group() helper that searches for the
next group (starting from 0) that already contains CPUs from the same
NUMA node. When wrapping is needed, use this helper instead of blindly
wrapping to 0, ensuring CPUs are only added to groups within the same
NUMA node.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/group_cpus.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 6d08ac05f371..54d70271e2dd 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -246,6 +246,24 @@ static void alloc_nodes_groups(unsigned int numgrps,
 	}
 }
 
+/*
+ * Find next group in round-robin fashion that contains CPUs from the
+ * specified NUMA node. Used for wrapping to avoid cross-NUMA assignment.
+ */
+static unsigned int find_next_node_group(struct cpumask *masks,
+					 unsigned int numgrps,
+					 const struct cpumask *node_cpus)
+{
+	unsigned int i;
+
+	for (i = 0; i < numgrps; i++) {
+		if (cpumask_intersects(&masks[i], node_cpus))
+			return i;
+	}
+
+	return 0;
+}
+
 static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			       cpumask_var_t *node_to_cpumask,
 			       const struct cpumask *cpu_mask,
@@ -315,11 +333,15 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 			}
 
 			/*
-			 * wrapping has to be considered given 'startgrp'
-			 * may start anywhere
+			 * Wrapping has to be considered given 'startgrp'
+			 * may start anywhere. When wrapping, find the next
+			 * group (in round-robin fashion) that already contains
+			 * CPUs from the same NUMA node to avoid mixing CPUs
+			 * from different NUMA nodes in the same group.
 			 */
 			if (curgrp >= last_grp)
-				curgrp = 0;
+				curgrp = find_next_node_group(masks, numgrps,
+							      node_to_cpumask[nv->id]);
 			grp_spread_init_one(&masks[curgrp], nmsk,
 						cpus_per_grp);
 		}
-- 
2.51.0

