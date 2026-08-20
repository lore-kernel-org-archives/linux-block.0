Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04740B107
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255888; cv=none; b=cB0IfaeHNexgY9CcQxNpEqQPfWjEkjrdC61dyrQgm9sDY2/M7cvZV3/J4ShG57uGkBxc86M57IMMXY9LtXHbBfP/m38qMVj6Z7q+libi+cuV+JmUbbHtIyDiVd6z0fKHimgFWR6AjLiAOe4ZRi9sW+XE0z/TYvCIxFi95j1naDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255888; c=relaxed/simple;
	bh=nrrjtQwh0O36pPeeC6+8mQAbG5SBL9/4D387nQyR664=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8Xu3rEd4HohdozHGAyPaE8MnB1+5pVC+uYJcyd8eUby1zMFYytKSI9duzo3/5oikFKEWJJrXfp3XdQ3+vx8ilAbRlEMsaPynC8LiYv+sOgnVAVvt2qw3DKUl4Qvz/FYeTza1SBGuLZBp1kL9pTMz9fEEr8eCRnY45KcAOjiXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YRPFaD/U; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YRPFaD/U"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPV1hXjzlfsTm;
	Thu, 20 Aug 2026 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255883; x=1789847884; bh=x/GTT
	XMas7aLrp++KdRAvI1nlG0fSiY2N6z69XdNIrk=; b=YRPFaD/U3bL+Mz5mLBzCy
	deenvaoXL4o1onoE2ToaUVtbSbeiHGCYv+EUYhtq3M6WFykhFo9lP499hIinHkfM
	rC0PqIOxckjtC8KOTwRIjUtcgNvh3vqd2tFiSRujShb7ys1KXhAjqydbo4jiJMIq
	Gdb8KYF5GTg8S/zyzUIbihZkQ9h9FtairlXcdro/izKCNhWh297l3i/Ywsx30Pf/
	yf4wUhL5Gh1JToLD0KlsVH7eIV890GnCNhWNzq+82shg3v29gO0dILg+k+kXs+X0
	hEh72V8yTwBqEN0rreYiKtTln8z80ptKiABJ7jl1gV7tYdjrRBwN4MTgfyuXvKgl
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id T3kU7Y1tJ9-t; Thu, 20 Aug 2026 19:58:03 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPQ1pCFzlfsVF;
	Thu, 20 Aug 2026 19:58:01 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 12/13] loop: Modify the loop_process_work() calling convention
Date: Thu, 20 Aug 2026 12:57:20 -0700
Message-ID: <637d7618f1111e2447b8b1f219eef2ad40d88a29.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for annotating the rootcg_cmd_list member with __guarded_by().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8fde5f2d3473..637212af70d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2037,13 +2037,15 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 }
=20
 static void loop_process_work(struct loop_worker *worker,
-			struct list_head *cmd_list, struct loop_device *lo)
+			      struct loop_device *lo, bool rootcg)
 {
 	int orig_flags =3D current->flags;
+	struct list_head *cmd_list;
 	struct loop_cmd *cmd;
=20
 	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	spin_lock_irq(&lo->lo_work_lock);
+	cmd_list =3D rootcg ? &lo->rootcg_cmd_list : &worker->cmd_list;
 	while (!list_empty(cmd_list)) {
 		cmd =3D container_of(
 			cmd_list->next, struct loop_cmd, list_entry);
@@ -2074,14 +2076,14 @@ static void loop_workfn(struct work_struct *work)
 {
 	struct loop_worker *worker =3D
 		container_of(work, struct loop_worker, work);
-	loop_process_work(worker, &worker->cmd_list, worker->lo);
+	loop_process_work(worker, worker->lo, false);
 }
=20
 static void loop_rootcg_workfn(struct work_struct *work)
 {
 	struct loop_device *lo =3D
 		container_of(work, struct loop_device, rootcg_work);
-	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
+	loop_process_work(NULL, lo, true);
 }
=20
 static const struct blk_mq_ops loop_mq_ops =3D {
