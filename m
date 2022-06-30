Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A723C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 09:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiF3J4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiF3J4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 05:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1620366AC
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656583005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9P5s6J6M9dZUv6A2sm3ewX+NdhaZ9Znte9gZ3ncjQIU=;
        b=icaKFqNZL0gej1FfNG3jEHu5i6yEb8RNWCQs2z0bVXxkya4hpIhUkXNT/a6v1uM3v996uk
        EbvrCwxVQ9xpFcYvW6MhgHt3mMJqJ8JUc6QOLNMb5dgeaz3M7VN/Td7Vh14Pll9nHMFcyR
        exKH2uS+QmLCKSHb7fQlRf/hYU+97tM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-oAoqMYFhP9KOPVN3jDZndw-1; Thu, 30 Jun 2022 05:56:41 -0400
X-MC-Unique: oAoqMYFhP9KOPVN3jDZndw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9865C811E75;
        Thu, 30 Jun 2022 09:56:40 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED972492C3B;
        Thu, 30 Jun 2022 09:56:38 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     shinichiro.kawasaki@wdc.com, yangx.jy@fujitsu.com
Subject: [PATCH blktests] common/multipath-over-rdma: skip NO-CARRIER NIC when start_soft_rdma
Date:   Thu, 30 Jun 2022 17:56:25 +0800
Message-Id: <20220630095625.2705173-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The rxe/siw driver will be bind to NO-CARRIER interface which lead
nvmeof-mp/001 failed.
For example, nvmeof-mp/001 with two NICs, if will output
count_devices(): 1 <> 2 when the second NIC has NO-CARRIER

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 8edcf39..8ab3da1 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -409,6 +409,7 @@ start_soft_rdma() {
 				[ -e "$i" ] || continue
 				[ "$i" = "lo" ] && continue
 				[ "$(<"$i/addr_len")" = 6 ] || continue
+				[ "$(<"$i/carrier")" = 1 ] || continue
 				has_soft_rdma "$i" && continue
 				rdma link add "${i}_$type" type $type netdev "$i" ||
 				echo "Failed to bind the $type driver to $i"
-- 
2.34.1

