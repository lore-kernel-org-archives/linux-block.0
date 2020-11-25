Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D3C56201
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2C020872
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKP90XEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgKYHcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgKYHcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBETgrtaSHCu/pRI8rEDyKeLrmNqs8eFOS4w1HY/9io=;
        b=LKP90XEzbjMI5DoSI5n9HF9fTQwfvWterHx5DMNC4c9hycIKD8khCOL5mJ9ZFF9eAwuF8i
        07A6nqCWlbxTVnLT800kA9J4WpOhvJkgTUnRTQJjHXRAVNUSiwFaKiP1zQWmcvbogOQc21
        stHjOMMO8IzP6UZ3HQUmr2icgYrMGbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-iEKInZIQObast-VXNwWn7w-1; Wed, 25 Nov 2020 02:32:42 -0500
X-MC-Unique: iEKInZIQObast-VXNwWn7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11CD28030B9;
        Wed, 25 Nov 2020 07:32:41 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B97319C46;
        Wed, 25 Nov 2020 07:32:38 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V2 blktests 5/5] common/multipath-over-rdma: allow to set use_siw
Date:   Wed, 25 Nov 2020 15:32:05 +0800
Message-Id: <20201125073205.8788-6-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With this change, we can change to use siw for nvme-rdma/nvmeof-mp/srp
testing from cmdline:

$ use_siw=1 nvme-trtype=rdma ./check nvme/
$ use_siw=1 ./check nvmeof-mp/
$ use_siw=1 ./check srp/

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 1bbefb7..d156a12 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -12,7 +12,7 @@ filesystem_type=ext4
 fio_aux_path=/tmp/fio-state-files
 memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
 max_ramdisk_size=$((1<<25))
-use_siw=
+use_siw=${use_siw:-""}
 ramdisk_size=$((memtotal*(1024/16)))  # in bytes
 if [ $ramdisk_size -gt $max_ramdisk_size ]; then
 	ramdisk_size=$max_ramdisk_size
-- 
2.21.0

