Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22219C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7320879
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693932;
	bh=4nC/d55yvoV6EJPIWhpgpX1g+jLAEzErrsNeHk839J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyNmdqvudv5T57jFhjLjVpATPAovuO9/6puOf6BgE7XO0fL1znsM36O7jWFyumHtR
	 D3QptbT3Gg50W8SQ9+PLbk5GJaaEHXvYzedOthR4ArS79z/8LUjc6lLGilShrosEZ+
	 ezPJoL/4ZCWzUVFSMijFgIuhaD+UZ68Utcl53u+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbfA1Qpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389282AbfA1QWv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9648C20663;
        Mon, 28 Jan 2019 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692570;
        bh=4nC/d55yvoV6EJPIWhpgpX1g+jLAEzErrsNeHk839J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUGeiJa9BHRsXiLoaBeq4APVZzlp7LJiKng3s9bU9OPxkrMCYkTwcKZZvzG227BcL
         pww3I1oiCgs3Mr0QqtNURL0ztwXisqEOakk7YTtsGMhwQo55jQCSocM5E9SN/Xoobr
         qW74got+FmioYrTZ2gkfu5Q0k6Yc1tuUudTT7/qw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roland Kammerer <roland.kammerer@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 071/107] drbd: narrow rcu_read_lock in drbd_sync_handshake
Date:   Mon, 28 Jan 2019 11:19:11 -0500
Message-Id: <20190128161947.57405-71-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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
index 942384f34e22..77d0f80f62f9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3421,7 +3421,7 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 	enum drbd_conns rv = C_MASK;
 	enum drbd_disk_state mydisk;
 	struct net_conf *nc;
-	int hg, rule_nr, rr_conflict, tentative;
+	int hg, rule_nr, rr_conflict, tentative, always_asbp;
 
 	mydisk = device->state.disk;
 	if (mydisk == D_NEGOTIATING)
@@ -3472,8 +3472,12 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
 
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
@@ -3512,9 +3516,6 @@ static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer_device,
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

