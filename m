Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B70C64E7D
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805BD2415B
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSGFVJL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgKTS2C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgKTS2B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:01 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6772224C;
        Fri, 20 Nov 2020 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896881;
        bh=kZP/yJ0fC48nk2mQjLHjxqe4jwNkrL9OlMX67rrCfeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSGFVJL9JogUdypN/ZQyffCYDFsJCGJixU+LHOGoE5LJZ6ez1a/tr/mVSC6YJKauR
         3BPVhKZKtScgBwYWR4sYpZ3ohALDf8WFjDkB7GVCOROu/g9eu2wkT2hn2knGy8pEvX
         lCGdldmuh5vBvBDOmfhVQjMMdSd7z1YzrlgMaMUo=
Date:   Fri, 20 Nov 2020 12:28:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 027/141] drbd: Fix fall-through warnings for Clang
Message-ID: <44663f18fb12e39c53b0e69039c98505b7c6d5da.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a break statement instead of just
letting the code fall through to the next, and by adding a fallthrough
pseudo-keyword in places whre the code is intended to fall through.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 1 +
 drivers/block/drbd/drbd_req.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index dc333dbe5232..c19bb74ac935 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -5863,6 +5863,7 @@ static int got_NegRSDReply(struct drbd_connection *connection, struct packet_inf
 		switch (pi->cmd) {
 		case P_NEG_RS_DREPLY:
 			drbd_rs_failed_io(device, sector, size);
+			break;
 		case P_RS_CANCEL:
 			break;
 		default:
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 330f851cb8f0..9f212a923a3c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -750,6 +750,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 
 	case WRITE_ACKED_BY_PEER_AND_SIS:
 		req->rq_state |= RQ_NET_SIS;
+		fallthrough;
 	case WRITE_ACKED_BY_PEER:
 		/* Normal operation protocol C: successfully written on peer.
 		 * During resync, even in protocol != C,
-- 
2.27.0

