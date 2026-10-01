Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C7345EB8
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859283; cv=none; b=mXUAEQurVVzrFQRCXViDZ6BREWGUq7lqrJSgl/EoTEzvdvP4JfN+keXQuFOVQtVEZIMWolbbgscUHUuCum6fk0DCEKNbxBZGfWEwOECwjdHJonIAY+F1yqwgWe641H5vN94b1MAKYpQKsY+eJ/hvr2HL79TkTwAcpS/3YBIte80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859283; c=relaxed/simple;
	bh=AgDCNPvbjou/DxofBkJNV+IEFINbRsYoCibr3l9B0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuiQAKPY0uXOjvNQ5sQ0jb4Y0jul8GE7tmXFahaDzD0dD+Uzr/1Jz7tCzT6nr2bKJcH5b1jEJ27TY2wMN3qANwz+VCy3vdPHX9fNC8LD/cpJUvpfwXiX9aAHoEeLc8mMHFmHZ3WO15XchZ2JkLbxEaAmltskrbN5g5uuFhuW0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm2gpfkU; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm2gpfkU"
Received: by mail-oo2-f38.google.com with SMTP id 006d021491bc7-6dc80dcaf91so753431eaf.0
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859280; x=1791464080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxqmP19HU6Ps5AaKVksQJYARcaPC7WzUbGv7h5Ub9Dk=;
        b=Zm2gpfkUyfOomUgF8cSrc55ckpiH1m9VLEWzQHoa58zta+I+rxPhCgcWCe99CWl9ZA
         GrDjWzKyb0eoFtR2+vQfk7CCOY2CYtfj7reM0sgGS59UuRsfoGSH6CwuGcPw7WwIyEq3
         2sTQuSP1yn+hRD2/sLrNHP+2T+qRWytDHEHPJDc0aUQLwUArjYwymKmLyeBld1GuP8gA
         EFBwQeQMYAteQe+duU6DP7NW5V7ThfW8C+HLfrV5/4EktsKmPgH7SkuO80EwzJ+MwvB6
         bM6jUP8dOXyEl9SzMDxakyquGOcZLQ5r8MF1JugqXI8s27bpLyGNc2y7N81DXFJWmH5h
         srYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859280; x=1791464080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XxqmP19HU6Ps5AaKVksQJYARcaPC7WzUbGv7h5Ub9Dk=;
        b=yOwZXRwhFzLyJw33rAh8Q704UbwblG+FEfqEXpw0nt5V5vfrblv0LpGQXl+IpGSPuS
         euGH7LDsP9OAfIAN+dv8Cv+ZvWfVPInXf2C6TXGfnP68mHpoFj+ztYqhwUu2jPkJZlDV
         5rMD/cGnIPvHMMUlSwUV6Rx22Qp5O9THVpGcMBmRH6pfvOuolVXm65MJwmtw5JnErFIe
         mWpTvm6Kq6ibF3cyoTV8/qSdOoEtEQQMKxT3oPt3XqFf76CqURVWtdjdwub7QzuwcDHe
         arT/yHR3yEuzU+d5yyMaXy5Lq5WrHkbykwf48TtM45vYdj6ssywL8K66L46TjUNA/YVZ
         8zrQ==
X-Gm-Message-State: AFuF++mcZclaIo2Ini2SnGAUf4jSXqJT30tCYQM9ruRwlhbtuq8pkJb4
	fuWhpXSrvWKHLTYi+d9X7G7lxzMPcyXBkkaRvRh8Lzu7cWrZsl++DkVcpw+YnQ==
X-Gm-Gg: AYBFou28wyjcTa1MEoiCK38eNXjsDLskOR3oCC8aboCIa5syoWYYI4zuxjW7UaKrYv+
	OEUqmIOc3PPWQF0bm9byHZ8hS11ETcYE92gtcghYp60e9iXlA1qxrnRMpWlLcn9ow3xB0tKahEV
	UPAehyU5taitBS3sumScP2QJRHdOimRIOpu0pbXLOK18H7/xPyAmRnDddLYoANRr6YA8hv6RXje
	RgiwjRl7fYQ89EiN7SFGjJQMDFnU3uRqGJsGautHIZpXLEXbrCyYZL6lc3QBSpD9WIwLqfy9rVw
	c+icLGz0Nof9poH1tfZVKJf8t9S2P/RVESZ8YYGxPcJd37uaWKCb4AsM7F6SMjOXxYSRc8foEh5
	Bo+U6F5pW3FFuHu4vitojuc+vk4ekIPXa+xU+apZqhSQKQ0iNYMUr46F++HDgOJ0wSHBdlnmGzw
	8D1Jtzo7jRzAee9PQzXXcW9cbBjgR/Q8Z3wYVAuNL4poVzxMVTjleObEWNxm/33oNOWhGeA9Ud3
	c5vrz7yE8MuzyA4Jl1hU1MV/+RgfcurFJnQa3rhhKp+Msy5SEwOA2y7vvDcYheleitUxMF0kBD5
	YvFKEmpuORO5Ez3NyeN6XECCoTk=
X-Received: by 2002:a05:6820:160b:b0:6d9:c08b:6154 with SMTP id 006d021491bc7-6dcf6a1e643mr4311819eaf.77.1790859280178;
        Thu, 01 Oct 2026 05:54:40 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:39 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 3/8] ublk: mark the batch fetch command cancelable before linking it
Date: Thu,  1 Oct 2026 07:54:17 -0500
Message-ID: <20261001125422.1364260-4-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_U_IO_FETCH_IO_CMDS has the same order problem as the per-io
commands: ublk_batch_attach() links the fetch command into fcmd_head
and marks it cancelable only after dropping evts_lock. A cancel from
the control path (ublk_batch_cancel_queue()) can take it in between and
complete it, and the later mark puts a completed request on io_uring's
cancelable list.

Mark it before linking it. evts_lock orders the mark before the link,
which is where the cancel finds it.

Batch commands are not bounced to task work, so they can run from io-wq
without uring_lock, and io_uring's cancel walk can now find a fetch
command before it is linked. Two things make that safe:

 - initialize fcmd->node: it came from kzalloc(), so list_empty() saw a
   linked node and ublk_batch_cancel_cmd() would list_del_init() NULL
   pointers
 - on the -ENODEV path, complete the command with io_uring_cmd_done()
   before freeing fcmd: that removes it from the cancelable list under
   uring_lock, after which nothing can see fcmd

Also use data->cmd instead of fcmd->cmd after dropping evts_lock: once
fcmd is linked and not the active one, a control-path cancel may
complete and free it.

Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing")
Cc: stable@vger.kernel.org # v7.0+
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6015fb2fb925..5e37b8e9d9ac 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -815,6 +815,8 @@ ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
 	if (fcmd) {
 		fcmd->cmd = cmd;
 		fcmd->buf_group = READ_ONCE(cmd->sqe->buf_index);
+		/* a cancel may look at it before it is linked */
+		INIT_LIST_HEAD(&fcmd->node);
 	}
 	return fcmd;
 }
@@ -3915,6 +3917,15 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	bool free = false;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(data->cmd);
 
+	/*
+	 * Mark it cancelable before linking it into fcmd_head, where a cancel
+	 * from the control path can take and complete it: see
+	 * ublk_prep_cancel(). evts_lock orders the mark before the link.
+	 */
+	pdu->ubq = ubq;
+	pdu->fcmd = fcmd;
+	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
+
 	spin_lock(&ubq->evts_lock);
 	if (unlikely(ubq->force_abort || ubq->canceling)) {
 		free = true;
@@ -3925,14 +3936,12 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	spin_unlock(&ubq->evts_lock);
 
 	if (unlikely(free)) {
+		/* off the cancelable list first, then nothing can see fcmd */
+		io_uring_cmd_done(data->cmd, -ENODEV, data->issue_flags);
 		ublk_batch_free_fcmd(fcmd);
-		return -ENODEV;
+		return -EIOCBQUEUED;
 	}
 
-	pdu->ubq = ubq;
-	pdu->fcmd = fcmd;
-	io_uring_cmd_mark_cancelable(fcmd->cmd, data->issue_flags);
-
 	if (!new_fcmd)
 		goto out;
 
@@ -3940,9 +3949,12 @@ static int ublk_batch_attach(struct ublk_queue *ubq,
 	 * If the two fetch commands are originated from same io_ring_ctx,
 	 * run batch dispatch directly. Otherwise, schedule task work for
 	 * doing it.
+	 *
+	 * Use data->cmd, not fcmd->cmd: once fcmd is linked and not active,
+	 * a cancel from the control path may complete and free it.
 	 */
 	if (io_uring_cmd_ctx_handle(new_fcmd->cmd) ==
-			io_uring_cmd_ctx_handle(fcmd->cmd)) {
+			io_uring_cmd_ctx_handle(data->cmd)) {
 		data->cmd = new_fcmd->cmd;
 		ublk_batch_dispatch(ubq, data, new_fcmd);
 	} else {
-- 
2.55.0

