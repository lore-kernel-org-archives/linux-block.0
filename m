Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E86BC433E1
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B85820885
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 15:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTUoQYU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHSPQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:16:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728611AbgHSPQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 11:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597850198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dtDVWY8XOKhIQ4U3Ma2pRAa4BiO6PQTODa+d3hIB028=;
        b=eTUoQYU4w0PqxebyjdZzMRKFNsm+RFbo0GeMURwvXAX8SLNNBx34cLHnUuJP5UccO80DYJ
        2oKwt13HCLT6oHOlBsyPybW4VkRuRE7nQtXra84l+6VSJ76iwMRRlq+uccdGnrsfOfAnNf
        RsJQbV3xqe6QN/TEh/OD9oqwRHxO1U8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515--sbZrEW0OP6v7eM-itDyxQ-1; Wed, 19 Aug 2020 11:16:36 -0400
X-MC-Unique: -sbZrEW0OP6v7eM-itDyxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D061DDFB;
        Wed, 19 Aug 2020 15:16:35 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com [10.66.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E837E304;
        Wed, 19 Aug 2020 15:16:32 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     sagi@grimberg.me, osandov@osandov.com, bvanassche@acm.org
Subject: [PATCH blktests] common/multipath-over-rdma: fix warning ignored null byte in input
Date:   Wed, 19 Aug 2020 23:16:01 +0800
Message-Id: <20200819151601.18526-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[blktests]# nvme_trtype=rdma ./check nvme/004
nvme/004 (test nvme and nvmet UUID NS descriptors)
    runtime  1.238s  ...
nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]ignored null byte in input
    runtime  1.238s  ...  1.237s 410: warning: command substitution: ignored null byte in input
    --- tests/nvme/004.out	2020-08-18 08:11:08.496809985 -0400
    +++ /root/blktests/results/nodev/nvme/004.out.bad	2020-08-19 10:43:02.193885685 -0400
    @@ -1,4 +1,5 @@
     Running nvme/004
    +common/multipath-over-rdma: line 409: warning: command substitution: ignored null byte in input
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
     NQN:blktests-subsystem-1 disconnected 1 controller(s)

manually to reproduce:
Update one network interface with 15 chars:
[blktests]# ip a s enp0s29u1u7u3c2
5: enp0s29u1u7u3c2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether f0:d4:e2:e6:e1:e3 brd ff:ff:ff:ff:ff:ff
[blktests]# modprobe rdma_rxe
[blktests]# echo enp0s29u1u7u3c2 >/sys/module/rdma_rxe/parameters/add
[blktests]# cat /sys/class/infiniband/rxe0/parent
enp0s29u1u7u3c2[blktests]# f="/sys/class/infiniband/rxe0/parent"
[blktests]# echo $(<"$f")
-bash: warning: command substitution: ignored null byte in input
enp0s29u1u7u3c2
[blktests]# echo $(tr -d '\0' <"$f")
enp0s29u1u7u3c2

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 355b169..86e7d86 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -406,7 +406,7 @@ has_rdma_rxe() {
 	local f
 
 	for f in /sys/class/infiniband/*/parent; do
-		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
+		if [ -e "$f" ] && [ "$(tr -d '\0' <"$f")" = "$1" ]; then
 			return 0
 		fi
 	done
-- 
2.21.0

