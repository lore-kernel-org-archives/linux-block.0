Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E47C64E7B
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E3320721
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T42L/HNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgKXBFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:05:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgKXBFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 20:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606179909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Meb8VBRdNpLl6eh22OMMs7hFvb4+eceBdMv99rKjoOI=;
        b=T42L/HNdU4fITktVBAR53X1AK31mtNyLO7m99yQ++0vO199saKS9+nGwJFAn292q1NxbyQ
        P9gQkgvuzUo/Fv5C0lzMHMZWwmVZ/0i8uGEDurPMcXyxN4kYEp/dDqoIR49X59s7wa9xjS
        VuEzxXSH9y3cctjpV33N7Mlrm5FdLxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-D75VfgFXM_a0uzWhw-xDLQ-1; Mon, 23 Nov 2020 20:05:04 -0500
X-MC-Unique: D75VfgFXM_a0uzWhw-xDLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF7B718C43C7;
        Tue, 24 Nov 2020 01:05:03 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8AF81346D;
        Tue, 24 Nov 2020 01:05:01 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH blktests 5/5] common/multipath-over-rdma: allow to set use_siw
Date:   Tue, 24 Nov 2020 09:04:27 +0800
Message-Id: <20201124010427.18595-6-yi.zhang@redhat.com>
In-Reply-To: <20201124010427.18595-1-yi.zhang@redhat.com>
References: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With this change, we can change to use siw for nvme-rdma/nvmeof-mp 
testing from cmdline:

$ use_siw=1 nvme-trtype=rdma ./check nvme/
$ use_siw=1 ./check nvmeof-mp/

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ebc5939..d0fec6f 100644
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

