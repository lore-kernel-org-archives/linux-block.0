Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BECC433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BDF222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzI3liLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgJTIQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388340AbgJTIQg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603181794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=baGYhwVH7iVs3xKtBJMV3q5cpBS0iMBTLWqbMpArqI4=;
        b=XzI3liLCGONUeEYDlck1QZQINwQFcMauAPfFxubObbOnmRTwFotMtDfq4Da6M2ZkaizZWT
        WO/VvBKu78Tx/Lheo+8187MLNvyYrW7RSyiUtReBN6XUmm4ELXyUSd8fPCUv+0LhIwtGqL
        L7cW8JzfUcmCop3XMRAqIyhnKD5alJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-KBGc1kEtN3y8uvCuR6iecQ-1; Tue, 20 Oct 2020 04:16:32 -0400
X-MC-Unique: KBGc1kEtN3y8uvCuR6iecQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 535D68030BD;
        Tue, 20 Oct 2020 08:16:31 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9C2B5D9D2;
        Tue, 20 Oct 2020 08:16:28 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 1/2] nbd: fix use-after-freed crash for nbd->recv_workq
Date:   Tue, 20 Oct 2020 04:16:14 -0400
Message-Id: <20201020081615.240305-2-xiubli@redhat.com>
In-Reply-To: <20201020081615.240305-1-xiubli@redhat.com>
References: <20201020081615.240305-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The crash call trace:

<6>[ 1012.319386] block nbd1: NBD_DISCONNECT
<1>[ 1012.319437] BUG: kernel NULL pointer dereference, address: 0000000000000020
<1>[ 1012.319439] #PF: supervisor write access in kernel mode
<1>[ 1012.319441] #PF: error_code(0x0002) - not-present page
<6>[ 1012.319442] PGD 0 P4D 0
<4>[ 1012.319448] Oops: 0002 [#1] SMP NOPTI
<4>[ 1012.319454] CPU: 9 PID: 25111 Comm: rbd-nbd Tainted: G            E     5.9.0+ #6
   [...]
<4>[ 1012.319505] PKRU: 55555554
<4>[ 1012.319506] Call Trace:
<4>[ 1012.319560]  flush_workqueue+0x81/0x440
<4>[ 1012.319598]  nbd_disconnect_and_put+0x50/0x70 [nbd]
<4>[ 1012.319607]  nbd_genl_disconnect+0xc7/0x170 [nbd]
<4>[ 1012.319627]  genl_rcv_msg+0x1dd/0x2f9
<4>[ 1012.319642]  ? genl_start+0x140/0x140
<4>[ 1012.319644]  netlink_rcv_skb+0x49/0x110
<4>[ 1012.319649]  genl_rcv+0x24/0x40
<4>[ 1012.319651]  netlink_unicast+0x1a5/0x280
<4>[ 1012.319653]  netlink_sendmsg+0x23d/0x470
<4>[ 1012.319667]  sock_sendmsg+0x5b/0x60
<4>[ 1012.319676]  ____sys_sendmsg+0x1ef/0x260
<4>[ 1012.319679]  ? copy_msghdr_from_user+0x5c/0x90
<4>[ 1012.319680]  ? ____sys_recvmsg+0xa5/0x180
<4>[ 1012.319682]  ___sys_sendmsg+0x7c/0xc0
<4>[ 1012.319683]  ? copy_msghdr_from_user+0x5c/0x90
<4>[ 1012.319685]  ? ___sys_recvmsg+0x89/0xc0
<4>[ 1012.319692]  ? __wake_up_common_lock+0x87/0xc0
<4>[ 1012.319715]  ? __check_object_size+0x46/0x173
<4>[ 1012.319727]  ? _copy_to_user+0x22/0x30
<4>[ 1012.319729]  ? move_addr_to_user+0xc3/0x100
<4>[ 1012.319731]  __sys_sendmsg+0x57/0xa0
<4>[ 1012.319744]  do_syscall_64+0x33/0x40
<4>[ 1012.319760]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[ 1012.319780] RIP: 0033:0x7f5baa8e3ad5

In case the reference of nbd->config reached zero and trying to
free the related resource, including the nbd->recv_workq, if another
process send one DISCONENCT cmd by using the netlink, it will be
potentially crash like this.

This will the nbd->recv_workq under the nbd->config_lock.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index edf8b632e3d2..3d3f4255e495 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1327,9 +1327,10 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 					 atomic_read(&config->recv_threads) == 0);
 	if (ret)
 		sock_shutdown(nbd);
-	flush_workqueue(nbd->recv_workq);
 
 	mutex_lock(&nbd->config_lock);
+	flush_workqueue(nbd->recv_workq);
+
 	nbd_bdev_reset(bdev);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
@@ -1339,6 +1340,18 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	return ret;
 }
 
+static void nbd_config_clear_rt_ref_and_put(struct nbd_device *nbd)
+{
+	lockdep_assert_held(&nbd->config_lock);
+
+	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
+			       &nbd->config->runtime_flags)) {
+		mutex_unlock(&nbd->config_lock);
+		nbd_config_put(nbd);
+		mutex_lock(&nbd->config_lock);
+	}
+}
+
 static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
 				 struct block_device *bdev)
 {
@@ -2006,16 +2019,15 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
 	nbd_clear_sock(nbd);
-	mutex_unlock(&nbd->config_lock);
+
 	/*
 	 * Make sure recv thread has finished, so it does not drop the last
 	 * config ref and try to destroy the workqueue from inside the work
 	 * queue.
 	 */
 	flush_workqueue(nbd->recv_workq);
-	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
-			       &nbd->config->runtime_flags))
-		nbd_config_put(nbd);
+	nbd_config_clear_rt_ref_and_put(nbd);
+	mutex_unlock(&nbd->config_lock);
 }
 
 static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
-- 
2.18.4

