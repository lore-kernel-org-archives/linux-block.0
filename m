Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C73C282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697942171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690932;
	bh=OlsiW8zHmCCN5goS58S0YW87RtfjyOChk7jWdaj6rfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2wwH9fBqQ2BJK4s/xIWR7fjhqVyEu24c0Dz2oQgTkwsugYvYfxgnZfrvSQgMtnof
	 N2qW4zA7VN1+6V2YbmNoRDaxo7NgRNstr2HfRlTh/E/0ob8CN++DVrHUU3ZlS6DGxD
	 ifFZ2ENCl36bHh19K8GCLUxulL+5pshGsnr3H8Nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfA1Pzb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbfA1Pzb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C1620855;
        Mon, 28 Jan 2019 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690930;
        bh=OlsiW8zHmCCN5goS58S0YW87RtfjyOChk7jWdaj6rfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSB6swBpiKCpKDw37DYfe4cZbgOm+VHovYJfPiIjx+Lest13RcK3ZpVxpIKsD0qbX
         ySBlD7t/8sgb11iF8zywWb7OavU4dhiAP7AQHF0aB22j2h806gxJEnVXHVVZwl3/D5
         hpToealI0ZwWQ/JSkeGddbq2/c0V+g1ABeyN1BNw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roland Kammerer <roland.kammerer@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 237/304] drbd: narrow rcu_read_lock in drbd_sync_handshake
Date:   Mon, 28 Jan 2019 10:42:34 -0500
Message-Id: <20190128154341.47195-237-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Roland Kammerer <roland.kammerer@linbit.com>

[ Upstream commit d29e89e34952a9ad02c77109c71a80043544296e ]

So far there was the possibility that we called
genlmsg_new(GFP_NOIO)/mutex_lock() while holding an rcu_read_lock().

This included cases like:

drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      drbd_bcast_event
        genlmsg_new(GFP_NOIO) --> may sleep

drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      notify_helper
        genlmsg_new(GFP_NOIO) --> may sleep

drbd_sync_handshake (acquire the RCU lock)
  drbd_asb_recover_1p
    drbd_khelper
      notify_helper
        mutex_lock --> may sleep

While using GFP_ATOMIC whould have been possible in the first two cases,
the real fix is to narrow the rcu_read_lock.

Reported-by: Jia-Ju Bai <baijiaju1990@163.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 61c392752fe4..1b9822f264d2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3364,7 +3364,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	enum drbd_conns rv = C_MASK;
 	enum drbd_disk_state mydisk;
 	struct net_conf *nc;
-	int hg, rule_nr, rr_conflict, tentative;
+	int hg, rule_nr, rr_conflict, tentative, always_asbp;
 
 	mydisk = device->state.disk;
 	if (mydisk == D_NEGOTIATING)
@@ -3415,8 +3415,12 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 
 	rcu_read_lock();
 	nc = rcu_dereference(peer_device->connection->net_conf);
+	always_asbp = nc->always_asbp;
+	rr_conflict = nc->rr_conflict;
+	tentative = nc->tentative;
+	rcu_read_unlock();
 
-	if (hg == 100 || (hg == -100 && nc->always_asbp)) {
+	if (hg == 100 || (hg == -100 && always_asbp)) {
 		int pcount = (device->state.role == R_PRIMARY)
 			   + (peer_role == R_PRIMARY);
 		int forced = (hg == -100);
@@ -3455,9 +3459,6 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 			     "Sync from %s node\n",
 			     (hg < 0) ? "peer" : "this");
 	}
-	rr_conflict = nc->rr_conflict;
-	tentative = nc->tentative;
-	rcu_read_unlock();
 
 	if (hg == -100) {
 		/* FIXME this log message is not correct if we end up here
-- 
2.19.1

