Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A9C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4094B60FD9
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 01:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJYB0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 21:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhJYB0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 21:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635125071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Rl2C3mELUp/D0GHZJ7XateqnRaP8GDfLWuvbGwN4ls=;
        b=UOvYXXyAId0mJn/K9aMpjZLvE53oLSfg7pAtKgPstvjF62tzByYxH8OHVTeFdsA77l5beD
        tHy4BkG1Cz8g2k6FQCYt8qLQF6/nC41D/Uue5n3/qsjJtMQ7Dcrxi4WHBPzSwM4vjD6Nlm
        Wv6Dludcrscwwp/6KxUrNAfWbIkRR1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-1OtiYUEYNqaDZcx1eTVQqQ-1; Sun, 24 Oct 2021 21:24:27 -0400
X-MC-Unique: 1OtiYUEYNqaDZcx1eTVQqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3CE61808302;
        Mon, 25 Oct 2021 01:24:26 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51BCE5D6D5;
        Mon, 25 Oct 2021 01:24:24 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests V4] tests/srp: fix module loading issue during srp tests
Date:   Mon, 25 Oct 2021 09:24:16 +0800
Message-Id: <20211025012416.23432-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ib_isert/ib_srpt modules will be automatically loaded after the first
 time rdma_rxe/siw setup, which will lead srp tests fail.

$ modprobe rdma_rxe
$ echo eno1 >/sys/module/rdma_rxe/parameters/add
$ lsmod | grep -E "ib_srpt|iscsi_target_mod|ib_isert"
ib_srpt               167936  0
ib_isert              139264  0
iscsi_target_mod      843776  1 ib_isert
target_core_mod      1069056  3 iscsi_target_mod,ib_srpt,ib_isert
rdma_cm               315392  5 rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
ib_cm                 344064  2 rdma_cm,ib_srpt
ib_core              1101824  10 rdma_cm,rdma_rxe,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_isert,rdma_ucm,ib_uverbs,ib_cm

$ ./check srp/001
srp/001 (Create and remove LUNs)                             [failed]
    runtime    ...  3.675s
    --- tests/srp/001.out	2021-10-13 01:18:50.846740093 -0400
    +++ /root/blktests/results/nodev/srp/001.out.bad	2021-10-14 03:24:18.593852208 -0400
    @@ -1,3 +1 @@
    -Configured SRP target driver
    -count_luns(): 3 <> 3
    -Passed
    +insmod: ERROR: could not insert module /lib/modules/5.15.0-rc5.fix+/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko: File exists
modprobe: FATAL: Module iscsi_target_mod is in use.

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/srp/rc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 7239d87..d9b7e52 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -497,7 +497,8 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
+	unload_module ib_srpt
+	modprobe ib_srpt "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
 		if [ -b "$(readlink -f "$r")" ]; then
@@ -554,7 +555,7 @@ stop_lio_srpt() {
 	rmdir /sys/kernel/config/target/*/* >&/dev/null
 	rmdir /sys/kernel/config/target/* >&/dev/null
 
-	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
+	for m in ib_srpt ib_isert iscsi_target_mod target_core_pscsi target_core_iblock \
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
 	do
-- 
2.21.3

