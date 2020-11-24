Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE49C6379D
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B10420721
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEHu8jeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKXBFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:05:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgKXBFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 20:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606179899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yEv/vluezzvVLg37JJarSnMNGqxRyFsGSXl71cskrY=;
        b=HEHu8jeLYASf4TnB1/2JS05euTo0LJo1X87mr82HBnbciGvHgZIc9A/Md83uIUNxdvf3ea
        XNQZl7dWCx1qSPbqRzUcb9dTrStaR24tFB07llkOjTth3DAMz+Hc+Q3WFczIDGISNrReXF
        VF7+ITVAzGlFR6gQPUkRcWcCkl8cMS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-wp5qsJBXNFSx6EqkVGPoOA-1; Mon, 23 Nov 2020 20:04:55 -0500
X-MC-Unique: wp5qsJBXNFSx6EqkVGPoOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A8A3E74A;
        Tue, 24 Nov 2020 01:04:54 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BD366062F;
        Tue, 24 Nov 2020 01:04:52 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
Date:   Tue, 24 Nov 2020 09:04:23 +0800
Message-Id: <20201124010427.18595-2-yi.zhang@redhat.com>
In-Reply-To: <20201124010427.18595-1-yi.zhang@redhat.com>
References: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the ib_srpt module insmod failure as the module in some distros are
end with .xz, like bellow on fedora:
/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko.xz

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/srp/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 7fc094b..74053ba 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -465,7 +465,7 @@ configure_target_ports() {
 
 # Load LIO and configure the SRP target driver and LUNs.
 start_lio_srpt() {
-	local b d gid i ini_ids=() opts p target_ids=() vdev
+	local b d gid i ini_ids=() opts p target_ids=()
 
 	for gid in $(all_primary_gids); do
 		if [ "${gid#fe8}" != "$gid" ]; then
@@ -500,7 +500,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
+	insmod "$(ls /lib/modules/"$(uname -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
 		if [ -b "$(readlink -f "$r")" ]; then
-- 
2.21.0

