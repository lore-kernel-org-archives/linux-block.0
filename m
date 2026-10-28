Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205976;
	b=E+C/mtMTAACS1NMFt9J9FEPJCMtXLQw8TgJ8+AlnFP8W4GiXPO4L3hzp+HX77d+Vx4fr
	 v88wgmXd/FqXONM15Odsf6fnu1284leh6Qu0NR1tkXg4tyWxD5vq3RAHkDzwC2rKnmwh3
	 7fbO86NbwZbuINsp7lhbwfdTqR4MT3eC/0X/F+0iVepCNLpdf0/lBvbL0QsyNmNFJpCnd
	 005OzzOQtJqHTAA9kQUe53sq96nJWwQpvP5iCn+JdiAIN5Ku5ICW146Hc1A7pLIKFNIlb
	 wOtxOHSyRIJt9BkHdcJuKt96c50cfSIc/p+SPXAE5iG+yk9VOKhZ6q4sZkZljRw/REw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rTeBkwr4OEjAAF8z50SsMYXiCC7VJ/b9otW64U2j3f4=;
	b=MYP+tdBMqjOwl43DmALlf4PoUE80N1/UzpV2Fzv4EgLAiFTVvSrhV2QNWjXLm5SkEQ8O
	 icpsYfq9idVyLQj01PXz4pD9mVJvL13XyNpHouA/pjiU3vT3l1DefOxzMzT6D/a7bM7wP
	 /4iq+g6AUyeTE0TepEdzValbMX/rbKPwrxGhw1PxCLFb3ksoWI52aBwWESQ+gIMZfWEcz
	 utZ0vl+VuSZ0lZAm715FadtxspKeLsuwWY4kFW7Kci4F3DwXuRDf/Cg2TFf/AGCJEzX78
	 fGsXFT3Abhw5EHnF/xLbM0d4pPCxWlTZqS/9QwVWF3iBQcwBh70smlj30JFZZzrGAng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M+ToNmiI;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5581606A338
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5581606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M+ToNmiI
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-847ac7ccd85so793732a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205975; x=1793810775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTeBkwr4OEjAAF8z50SsMYXiCC7VJ/b9otW64U2j3f4=;
        b=M+ToNmiIRExzWMdNMMrRwh1+O63nvprtbZ7zUrINCL9/6LzMe0z6VPCnLrVsu2a1h0
         rCAEzLr5+3rNRR7SWTh5Vh5qldA1jzUh1QfwI4uKn5hOTjmAOP9y1JXabnZpW6xVkhHc
         NrU0AFR15vSgFWgEcPS6EecTGtB+ruAzxc+MhsQ73gCwEijKaX8Zkg8NE/fl1eo+obNN
         GIlsdhDrthq3+3oXOKUfODnycLKC6sy7FaAS3ym/eaehOmJ7QFJtk3k18KNj17eTFTKG
         SHTfqmEaOXNkpcOxPlYSZ0p4Wioo+lByXHGkX80mBcfqumPm2SyZObVIKYJ3SFqj0h08
         lq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205975; x=1793810775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTeBkwr4OEjAAF8z50SsMYXiCC7VJ/b9otW64U2j3f4=;
        b=HLK9EwaXvYNLiy2pGk+9nlig0COFcLk5SESXgg+rzd4T9N7u9gwvNby5dKpFgYg3C0
         6LmIQsFVu4q/ZvfuhGFgMOzzUHmAfMP72tIJKLdfmyLlA2nX9IJkdJ0jAqfoKR2xWLTq
         BRwrtwTBuZQz94ns1SCsCf3qRDbkRu3LjndyhylM+pi9GVk0Gu97Xjduat5UWhb6tWtU
         bl557OXP/opAHaTJodqZDitZifzUZPo14mCtTbyR46BqDg9ow+dPXEXKcdojCP0t78LA
         FDxnQTWbu4Z3JJ9t6NfAErs7bamVloM8MCRPV1cz1VHIquiKNDAOVZNmZBGbrLsi0qrP
         sLRg==
X-Gm-Message-State: AFq9FYL2778U9pbiPa8hdZLwjrSJ815iZxlcnumGDEGzl3k2zOkt9h5n
	ScOTtokdz7auMnZmW57BOx0hHGAVoKAWI+CkFd7CQIyCGu2eN9Lcg9lKpMQJrljaldbkib64jhA
	+GoLttr8=
X-Gm-Gg: AYBFou2LnG+d+QCdQW38/f7ysGnfA4q/O24M64BQnSuYo1XePybhtYUqgyk47muL1Q+
	8L42M3fM1hdhI8tOAcRpiaLPV7uk0ypfrAAbIKFgw1u1FEOyLgTWQwXXcxK0rEYZK9yZq+LUnuE
	yDEh9FKlkcXzI/P1l1p68pUApiDFyl+MmOahXxVgPzBIzTKPY/qwXJ1N3XSikGdVYh4v7FCfw8N
	xfC6qo8CP1+X70fE/+H84RGUtpRTEvkto1nUAtwEeUYHn0uI0QP1tJWtwT4y8mJDImBfxVXXEiX
	vJSXmIPqdt2Kqn52evJy8Ts1Ycci+ssx00IVaUneBEwiCLsclig6SH/KH+bMFU6BQdEdTO3Eg5S
	aLPPlxUpk7QimSVJLBQBznYaFOKNW274sTVtqcT+V2QEmjypqE+0VWgH7axVWcUvfPpGsjSNBAf
	YlO80Q900O4BXI6Ifhv6wRYKTvHLux2Je9XdyhISXvqFgTcYQ8wXKM68qDJ+YrcD3t3vkZWuT1t
	23U4GHr9Mr52TZeuNhLIN2EJPpgWE/GpFrw1nULNiaLhG1qfih5t7GvHVOMmWaZXnq2JzMosuR0
	pka7TVn2tIH3nVUhiX5CdkFBLpWAZ7lVE+hkvs5Zv1thzXomzAKF8reo2bR5p5rVLXbYDjMGbCu
	jaTBte63Tx1YBlduPOWo=
X-Received: by 2002:a05:6830:6412:b0:845:8d86:9f88 with SMTP id 46e09a7af769-85abd032c43mr2609859a34.15.1793205974834;
        Wed, 28 Oct 2026 09:46:14 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 91/98] nvmet-rdma: don't run the wait list recursively
Date: Wed, 28 Oct 2026 10:42:34 -0600
Message-ID: <20261028164415.1262013-92-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

nvmet_rdma_release_rsp() returns the send queue slots of a response and
then runs the wait list, passing each waiting command to
nvmet_rdma_execute_command(). Many commands complete inside their
execute callback, and if the response can't be posted,
nvmet_rdma_queue_response() calls nvmet_rdma_release_rsp() right there,
which starts another run of the wait list inside the first:

    nvmet_rdma_process_wr_wait_list()
      nvmet_rdma_execute_command()
        nvmet_execute_admin_connect()
          nvmet_req_complete()
            nvmet_rdma_queue_response()
              ib_post_send() fails
              nvmet_rdma_release_rsp()
                nvmet_rdma_process_wr_wait_list()

Each waiting command adds a level while posts keep failing, and the host
decides how many commands wait: it sizes the receive queue, can fill
the send queue with commands that nvmet_req_init() rejects without
taking a slot, and over siw can make posts fail by holding back an
RDMA READ. 400 waiting Connects overflow the stack of the CQ worker.

Before the loop executes a command, point the response's new
wait_released at a flag on the loop's stack. A release that finds it
set means the loop hasn't returned from that command yet: it returns
the slots and releases the response, but sets the flag and leaves the
list to the loop instead of running it. The flag tells the loop not to
touch the response again.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 7c97a47e305a..b8098ec53d7b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -77,6 +77,8 @@ struct nvmet_rdma_rsp {
 	u32			invalidate_rkey;
 
 	struct list_head	wait_list;
+	/* set under rsp_wr_wait_lock while the wait list's loop executes us */
+	bool			*wait_released;
 	int			tag;
 };
 
@@ -511,23 +513,42 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 	return ret;
 }
 
-static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
+static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue,
+					    struct nvmet_rdma_rsp *done)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
+	if (done->wait_released) {
+		/*
+		 * The loop below has not come back from this command yet. It is
+		 * further up this stack if the command completed in place and
+		 * its response could not be posted. Otherwise it runs in
+		 * another context. It goes on with the list, so leave the list
+		 * to it.
+		 */
+		*done->wait_released = true;
+		WRITE_ONCE(done->wait_released, NULL);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
+		return;
+	}
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
+		bool released = false;
 		bool ret;
 
 		rsp = list_entry(queue->rsp_wr_wait_list.next,
 				struct nvmet_rdma_rsp, wait_list);
 		list_del(&rsp->wait_list);
+		rsp->wait_released = &released;
 
 		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 		ret = nvmet_rdma_execute_command(rsp);
 		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 
+		/* A released response can be freed, or in use again. */
+		if (!released)
+			WRITE_ONCE(rsp->wait_released, NULL);
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
 			break;
@@ -680,8 +701,9 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 
 	nvmet_rdma_free_rsp_resources(rsp);
 
-	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
-		nvmet_rdma_process_wr_wait_list(queue);
+	if (unlikely(READ_ONCE(rsp->wait_released) ||
+		     !list_empty_careful(&queue->rsp_wr_wait_list)))
+		nvmet_rdma_process_wr_wait_list(queue, rsp);
 
 	nvmet_rdma_put_rsp(rsp);
 }
-- 
2.56.0

