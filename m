Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F39C5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1863D20857
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT7+wRV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKYHch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbgKYHch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+CRVUJRr10yjo78bfkJPa3QfjhrcfCQgimLtvVFbMo=;
        b=YT7+wRV4fk91lKBadqxMK8CchExc7qQ90MIxK/Bu0KRZHLPwVEdtcgehMVFnQha+0zJGwo
        aZ2wFuEpGke0iuGPrrDX7FPpJ48iPDisJYe/24/VHjahqZQpYBt0t7LjpHsOjHJBnaBQaZ
        ALyY3Fwa1om8XFFIymefSWV8Hdr0sOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-HeAkB7VMP4y6jmHo9LMd0Q-1; Wed, 25 Nov 2020 02:32:31 -0500
X-MC-Unique: HeAkB7VMP4y6jmHo9LMd0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4524107B45A;
        Wed, 25 Nov 2020 07:32:30 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6A2C19C46;
        Wed, 25 Nov 2020 07:32:28 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V2 blktests 1/5] tests/srp/rc: update the ib_srpt module name
Date:   Wed, 25 Nov 2020 15:32:01 +0800
Message-Id: <20201125073205.8788-2-yi.zhang@redhat.com>
In-Reply-To: <20201125073205.8788-1-yi.zhang@redhat.com>
References: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 7fc094b..1f665a2 100755
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
+	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
 		if [ -b "$(readlink -f "$r")" ]; then
-- 
2.21.0

