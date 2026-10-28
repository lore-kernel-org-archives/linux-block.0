Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205928;
	b=nek1ve66acrUfgUfSThONc3MtmkcaW9merv8EjOjPfTwoD2wEzftq5XMBA5SBAMfiCxJ
	 w8UPXXzcPCsWMGtSrX/Wwbw9HTEuLYGCCWwtdIXx7lp+S2dClsbcXd6BuJh3KlCuo6QdN
	 L5WS6vn+tEX5RGReHPvVMkMboHv+WgnHn4RTh4/Xu/SsNFElTCYPJt0UYHGvR4ahKBNK4
	 Ohsn9at6wtIYox23DwCcEt+W4U50VHd1TajuOWh9sHeAZ3hWqAUtZBMv6KiFX6vChe5IK
	 5CxBW/6wbpRWy7i3Yi1OKTgTlHUWc8MOjarHcg0wDOeMZmQiawRsOkFSMxSXJspDdhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9SVZHFdxkVZAvDR8KtyQ9mon7rHQzeyoCf14TxWDZB0=;
	b=LWF1DMKD7oS/z+KI8a9RR1xx4dhLUuyLIV+7bUz18nH6FDdj6LrU+m5RbcCyPBw2UOv2
	 CefCcVyPb636jJc2vnSqUtND+XRkVOtj2W3drVfSLECmlw99sChlLa2VDZAv36YOlOZy5
	 2Dv4eqtAe3doSi/RRu3cJ86LNdWLsEcY/qInk9eTQcgmUyEChcdNq48BHseZKBzVKfqzM
	 jSACpkyNpypxPotv5jbuRYiqOk0WmFr/88u9vd1oCFAr8S/nEXtQlITbk8O+kQGHSk+yR
	 H4EdX8yNmOI6nYlSs758PWr4mljP7UFJRywnzeiIfP85GU+EvTvOjfLGwxvtU0FAgiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ubYWIFal;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76306606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76306606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ubYWIFal
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8256106635eso661890a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205927; x=1793810727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SVZHFdxkVZAvDR8KtyQ9mon7rHQzeyoCf14TxWDZB0=;
        b=ubYWIFal8OEVh8vvymVvflYlCycZxK6MhOmGJWM2GwRtOX2a8l1IsGSMzl06p5CV63
         kZ1GYD5gcEnlTBhYu+NfizxW0WIGy0uLuHqvfZJNW8EmvmCRaUUcWcoEJx3wY/OlJHfl
         z7HGVXMFot+SUJiVfh0pIEf1lybcblGgAMlHTOzdi2Qzln9zU7BBAq/U/VQXmRLEqou3
         63btQJe8qzRcSBtGNkIYn2pPd7C5Oh96It34zfGryMklR7SzJUl1PUDX0fOOUOw694QI
         RPJCHuAS6oeRZG9NWOETiz97fFKp1HENj9dhU7geK/rrt1Pfk4M5r00tcMDwyPoDLloM
         qtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205927; x=1793810727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SVZHFdxkVZAvDR8KtyQ9mon7rHQzeyoCf14TxWDZB0=;
        b=YxPQqx2YYcXtPnFqgzUPWEDWl/Mv5G8seqBTng/hoYWjKY0xCXIPNa4Y9U4EUpANQq
         TxAQQtzVmBcMd+PjLrxnJjsyk8BfgPH5ufBm8c27r9t/AkqRyJsQesXJCkSKMOsaS3Nz
         dV9g6oUfjXeu/UnnT7Bd+8GEAL5RblD8WDvMxMYyRDs8skd3NU9JBOs4rEEG1h59aI6u
         DtNvexrmQS5og+4OJWDVdR8d1HnaIf4HYzrQh0VG5GDlvZoIADtb1GMcZ2YqJc7GOvNV
         B0MH5NSuBdU7gAp+eJOwTe8rnIRJZZRbyCgamMcw909ojo598DVqZ/o+hHSGDj6HYbux
         lCzw==
X-Gm-Message-State: AFq9FYL0l7/BZ0iXgVXPbZ5tUzo0LQJPIu3uE8q6MKw5KzQs9aJPBZXr
	O1bPu3PMh/PUNQYLoH9+IIbzHkfaEDEAlkQymVVfwTKQyOVCy04qZEY7lf64OekGok0prpux6/4
	0CwqLuzg=
X-Gm-Gg: AYBFou0F4dY2cDxKdWJJvnmPxrJ6zbnyRvB3jsPRLxRT30GOpW1uy9XR9foQMEDv+W4
	tFXSUSsLR/KT90h1bacGJvHHkwNoMcOuVMc7rbdkwSGvYaJmADydMmpGvYDDzyTo9VTIoCjbHkN
	9H2Hk5n3QMYFMkIuM8HqoqC5UB6h3c8mOGXjnj8pYVhbj83m78hr7FUbjzyKvyErboddl8zK1Z6
	LBlYWDsPNLs7SCJ2Gn2l0u5nBavntKqbgvL+SsHyJu6n0CVdW4txkHMStyZvWYl+9Lo+8D0DR5x
	dGa2NeHqpIbblCeUNj0AV912tS6lJLwZ3bBsrf5vM/9Pij15/SYQHfoilX9T3IgDmcQEOcOBplQ
	CzD/eIREXOZpw0T2QYs1OhxXgH/XkwkreHTGZMy3NlE0ueG4JT4s21mJS1qkijN8WEz7vpDPzAr
	L63vxcaN8du/4pclh70d/1kIMIIgJM5+zQqoXKb+010DgkUtFDnRn1Yb7N05zSHUNHAZGqshuoD
	k/sxTI9G2ObPUBRbrW3z8UhehUaxUA+tFR5GQSaZq7chu95/1/FWX16xMxI5xY9/Ayr9L9UyQ/b
	RbjmWfRgFVML0RXxpphnVxV2L1s01irXrah0jMwBVAlQrgMv2rQTHd8Jd5tkqU13/mJpIN12zSY
	=
X-Received: by 2002:a05:6830:630b:b0:81e:abb6:749f with SMTP id 46e09a7af769-85abf770ce1mr3019644a34.8.1793205927464;
        Wed, 28 Oct 2026 09:45:27 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 56/98] nvme-tcp: don't queue the AER while it is being sent
Date: Wed, 28 Oct 2026 10:41:59 -0600
Message-ID: <20261028164415.1262013-57-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

Every AER completion runs nvme_async_event_work(), which has
nvme_tcp_submit_async_event() set up and queue ctrl->async_req again. A
controller that completes the AER twice can do that while the request is
still on req_list or send_list, or being sent. Added to req_list twice
the list becomes a ring and nvme_tcp_process_req_list() never ends:

  WARNING: lib/list_debug.c:35 at __list_add_valid_or_report+0xd8/0xf0
   nvme_tcp_try_send+0x51b/0x600

Leave the AER alone while the send path holds it, there's one on its way
already. Initialize the list nodes at allocation so the check is valid
from the start; nvme_tcp_fetch_request() leaves them that way.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 06c205703cf5..be3938c3cb6f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -766,11 +766,14 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvme_is_aen_req(nvme_tcp_queue_id(queue),
-				     cqe->command_id)))
+				     cqe->command_id))) {
+		if (nvme_tcp_req_busy(queue, &queue->ctrl->async_req))
+			return -EBUSY;
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
-	else
+	} else {
 		ret = nvme_tcp_process_nvme_cqe(queue, cqe);
+	}
 
 	return ret;
 }
@@ -1646,6 +1649,8 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 		return -ENOMEM;
 
 	async->queue = &ctrl->queues[0];
+	init_llist_node(&async->lentry);
+	INIT_LIST_HEAD(&async->entry);
 	return 0;
 }
 
@@ -2884,6 +2889,10 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	struct nvme_command *cmd = &pdu->cmd;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	/* A controller which completes it twice makes us come here twice */
+	if (nvme_tcp_req_busy(queue, &ctrl->async_req))
+		return;
+
 	memset(pdu, 0, sizeof(*pdu));
 	pdu->hdr.type = nvme_tcp_cmd;
 	if (queue->hdr_digest)
@@ -2900,8 +2909,6 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
-	init_llist_node(&ctrl->async_req.lentry);
-	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
-- 
2.56.0

