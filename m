Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27953C64E7C
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3CF205F4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOw9uQzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgKZIgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbgKZIgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wEeIHBFqdeT2BNPcW+1wYEqAC+uZW5kXPJtQYxi8fo=;
        b=ZOw9uQzFxMoFzXCjippI02b6pCL81Gweo7CR3W0FTqOmppyp+3MWXYgz7uaT3Bzd2JDP3w
        N39bNn73uHTDP1fvyfMPw9uB8Kf5n9yIgmY4zNHQoyyJgqpUcprEE40L8m9XUeMlSqzQMd
        JHz97qidrsOUVz+Wr/nc40MZyf4jZMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-ez99gfV2PIahdMcY8YG5eA-1; Thu, 26 Nov 2020 03:36:09 -0500
X-MC-Unique: ez99gfV2PIahdMcY8YG5eA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A604E80ED8A;
        Thu, 26 Nov 2020 08:36:08 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA58519C66;
        Thu, 26 Nov 2020 08:36:06 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V3 blktests 5/5] common/multipath-over-rdma: allow to set use_siw
Date:   Thu, 26 Nov 2020 16:35:32 +0800
Message-Id: <20201126083532.27509-6-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
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
index ba6fa0d..b12dec3 100644
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

