Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E8FC433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 00:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4782523770
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 00:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAUA2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403877AbhATXU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 18:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611184741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GyA8Fb7NZVs06A+zg2hgsEXSW4n/4/Wf2Sq9Yp4judE=;
        b=bLup3fV/ejkjzY4qVpnjKV+moDYWU/bcr92kRLLU00MtPRJIE0y+7qrfZ91gV+zUHHkVhw
        4P2VA479+McJEswvRUwoC0m9PKgTQoPuLBrVI7bZVYXUUkDRnPe6WzPzdEveAWXjxgZuP3
        veU47vry+NtZkwWXbOTzcU3dmoaKyJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-vXYHMSIMNYiPbYjYEWSViQ-1; Wed, 20 Jan 2021 18:18:59 -0500
X-MC-Unique: vXYHMSIMNYiPbYjYEWSViQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84C56802B40;
        Wed, 20 Jan 2021 23:18:58 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20D6760C6D;
        Wed, 20 Jan 2021 23:18:56 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     bvanassche@acm.org, osandov@osandov.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] common/multipath-over-rdma: update is_rdma_device
Date:   Thu, 21 Jan 2021 07:18:39 +0800
Message-Id: <20210120231839.10267-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Below patch make the siw/rxe device virtual in the device tree, update
is_rdma_device to match it.
a9d2e9ae953f RDMA/siw,rxe: Make emulated devices virtual in the device tree

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 355b169..e4269f6 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -79,17 +79,24 @@ is_number() {
 # Check whether a device is an RDMA device. An example argument:
 # /sys/devices/pci0000:00/0000:00:03.0/0000:04:00.0
 is_rdma_device() {
-	local d i inode1 inode2
+	local d i f inode1 inode2
 
-	inode1=$(stat -c %i "$1")
-	# echo "inode1 = $inode1"
+	f=$1
+	inode1=$(stat -c %i "$f")
 	for i in /sys/class/infiniband/*; do
 		d=/sys/class/infiniband/"$(readlink "$i")"
-		d=$(dirname "$(dirname "$d")")
-		inode2=$(stat -c %i "$d")
-		# echo "inode2 = $inode2"
-		if [ "$inode1" = "$inode2" ]; then
-			return
+		if [[ "$d" == *"virtual"* ]]; then
+			if [[ -e "$d/parent" && "${f%%/*}" == "$(<"$d"/parent)" ]] || \
+				   [[ "${f%%/*}_siw" == "$(basename "$d")" ]]; then
+				return
+			fi
+		else
+			d1=$(dirname "$(dirname "$d")")
+			inode2=$(stat -c %i "$d1")
+			# echo "inode2 = $inode2"
+			if [ "$inode1" = "$inode2" ]; then
+				return
+			fi
 		fi
 	done
 	false
-- 
2.21.0

