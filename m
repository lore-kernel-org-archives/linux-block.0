Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com [209.85.167.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE252E229F
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288619; cv=none; b=XqvyRDu46Q+YpoLAx81+sHcMSsae59b+zdUNHrJoKzsj5QpATWaalxKWW+R/Hl+D40G693AhWzdnSk6U3M6f5UnrqKl7xXs0Aax5dJvZD+NoKSFhBGTJAQp5Bz4CcLFc3JAyLN5kg3aTncdoRYLZdgLV+3Z1petIepbIc45pXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288619; c=relaxed/simple;
	bh=NpcohaBcnv6za/GmbnYrzhV0FADG4UeMPd9+mSNyaLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3EtbTr2I6UrZ/jWvjnTUTvcCKtI1njKRxtdGDxe4aMfgdV18QHAO8UWy8j+rWOEq+Du3yoBfpx1W/Ts9SGw1kjYpozSgmOBSvxkdVe8zLPdoALG5wnSR9SDHcjZ/Qr0Hn6m7qBETPVOuswl6NmoQ2/hB0D+I6lCghR+/xJ6jRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cBmFyDoS; arc=none smtp.client-ip=209.85.167.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cBmFyDoS"
Received: by mail-oi1-f228.google.com with SMTP id 5614622812f47-495e5f0f428so31741b6e.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288605; x=1785893405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bd5xrrTHMzBUsh09hEvUsjiaV1Fjs8/c6t/6k06PFx4=;
        b=cBmFyDoShvA9jUdBMCQ8AATNt9kVOjSyxCo8vlz61kEdnxDZB9uR+LwoqKednBZxg2
         tqBR8QPYrw19xLMe2bcK0mMJ3RxWLcvzA2GriKYdY8z+Y11m1xqod1jPpXFHn60jn2gd
         7bx7y7THB54T+D5W5UntIcGdIeBnFu3snamKuVmD4qP7ND8RDHsflLnwoSK5OLlzyozf
         JWuuN+ihnmEi8bVkS1IpRm9dMedXFSRHdPabIV738OPmGm3ffNeXkJ5dQF3sjJwgjtXb
         iMkK6oRzOin0ncv2xC+PdZRBzNyUWTsegh6zgVUmheL405OaV5DPwggk4A74OR3zaclz
         bJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288605; x=1785893405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bd5xrrTHMzBUsh09hEvUsjiaV1Fjs8/c6t/6k06PFx4=;
        b=X11udh5zWjZzvpGw/nnfEUAYrThrzLqNIlgTpTjiZ+kzGJYxDz4uGCfK3YvIaDwYDB
         ctac79Id2H354yCnRH1LZYgDNrDW42/0kXEyLO3dGh1CYlxg63UO7AeuUm3g0jNbS5Su
         CzGp+gjX3KaQSvb04wd3brdJcfPA9umpZMLOK6/1ri/Sa2e9RR/vUft9okGxSWmnEu9s
         LVaycCvT98JDZOFriSgeLXFUtK3NGk/fg0kjO1jcdEbgnOMlqmIrfYcXTnpo84BEsq3G
         n2CJtY64X/yDQvQusyFGLU5Arsl6lxDr7qj/J3URIDmey1fdaetp6z39zYyqAIQEN7cz
         G9kg==
X-Gm-Message-State: AOJu0YwIs57TWHL0QKuD+wIflSMabbf8xIIoZmajKNHzHL59BJxD7TqF
	y8maB/I5OQ11C6zoE/m+CqC+lDh5jFvzsW9jIn2eVg+HyH9Rsc1Ja9mhZDtJxVkMkRXXSY/3UDb
	ItxG4toWJfTntiZQi2JyF7ENDw3FxejBxuOTTwzr3xCNdlBKQ93sx
X-Gm-Gg: AR+sD10UyUNkZvGp15/bpav+/MOdFhHEGwkUy4ZYiJRxsHIL7rLopKUlNis4C9eqCz4
	Lj5/06cGHcCZlgxnW7ZLeMW/fcOScuf88Rt49sa4QQJ1I0zrQXm2wrf0+czp0eyyMI9k91H1klh
	bBpBv2rj7LId89cbyf9V70VDvjSEpojifDEtNPLDGhIKwbRvkHdyB2BVqStyvKtM7jax02XI8zf
	rnaYWM6OGJXulSGNobaGSD4zEYm1vH12U1RFXU+6WOnKjsC7lZVLoTlAHMEF44YzWjepcLgPGbX
	BgdZRNv+ZABcklftqq45kjA0/1GwZZsSMomZFudP8ue2wRplwtImDyNEtn8x4iRzsY3hKpRsBHg
	kWeG1/5vwQU5/ugm/Ew==
X-Received: by 2002:a05:6820:c2c1:20b0:6a3:6bb0:e58d with SMTP id 006d021491bc7-6ac965bc96amr1300552eaf.0.1785288605436;
        Tue, 28 Jul 2026 18:30:05 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6aca5202389sm63637eaf.6.2026.07.28.18.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id F19DF40443;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ECF73E40442; Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/6] ublk: lift need_map check out of ublk_{,un}map_io()
Date: Tue, 28 Jul 2026 19:29:51 -0600
Message-ID: <20260729012951.3744582-7-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729012951.3744582-1-csander@purestorage.com>
References: <20260729012951.3744582-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_map_io() and ublk_unmap_io() are no-ops for ublk devices that
enable user copy or zero copy. However, the implementation is a bit
convoluted, returning the full request data length and relying on the
caller to check the return value against the request length.
UBLK_F_SHMEM_ZC recently added branches to skip the ublk_{,un}map_io()
call for I/Os using a shared-memory buffer. This is a more logical place
for the need_map check, so move it there from ublk_{,un}map_io().

Checking need_map early also avoids the expensive pointer-chasing for
the ublk_iod_is_shmem_zc() check in __ublk_complete_rq() in the common
case of a ublk device using user copy or zero copy.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1da45e382253..d4443a43229e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1464,19 +1464,15 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 {
 	return blk_rq_has_data(req) &&
 	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
-static unsigned int ublk_map_io(const struct ublk_queue *ubq,
-				const struct request *req,
+static unsigned int ublk_map_io(const struct request *req,
 				const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (!ublk_need_map_io(ubq))
-		return rq_bytes;
-
 	/*
 	 * no zero copy, we delay copy WRITE request data into ublksrv
 	 * context and the big benefit is that pinning pages in current
 	 * context is pretty fast, see ublk_pin_user_pages
 	 */
@@ -1488,19 +1484,15 @@ static unsigned int ublk_map_io(const struct ublk_queue *ubq,
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
-static unsigned int ublk_unmap_io(bool need_map,
-		const struct request *req,
+static unsigned int ublk_unmap_io(const struct request *req,
 		const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (!need_map)
-		return rq_bytes;
-
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
 		const int dir = ITER_SOURCE;
 
 		import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, &iter);
@@ -1591,15 +1583,16 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
 	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
 	/* shmem zero copy: no data to unmap, pages already shared */
-	if (ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
+	if (!need_map ||
+	    ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
-	unmapped_bytes = ublk_unmap_io(need_map, req, io);
+	unmapped_bytes = ublk_unmap_io(req, io);
 
 	/*
 	 * Extremely impossible since we got data filled in just before
 	 *
 	 * Re-read simply for this unlikely case.
@@ -1755,14 +1748,14 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
 {
 	unsigned mapped_bytes;
 
 	/* shmem zero copy: skip data copy, pages already shared */
-	if (ublk_iod_is_shmem_zc(ubq, req->tag))
+	if (!ublk_need_map_io(ubq) || ublk_iod_is_shmem_zc(ubq, req->tag))
 		return true;
 
-	mapped_bytes = ublk_map_io(ubq, req, io);
+	mapped_bytes = ublk_map_io(req, io);
 
 	/* partially mapped, update io descriptor */
 	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
 		/*
 		 * Nothing mapped, retry until we succeed.
-- 
2.54.0

