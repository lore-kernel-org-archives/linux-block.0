Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA12AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 05:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E2C60234
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 05:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhJ0F7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 01:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236805AbhJ0F7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 01:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635314229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F5vR0xtPD03eW4q0qcuBnEeqcVpyPZWfEGt5+IVGs2Q=;
        b=QaK2CyoCHst8OfdcJ0GE6OrDup213Xbp1/eVXW8QumGQLZCOHj/EFUpE5nXIQcdjIRnR57
        x7+jii+YIoLn0VBIfUjkk2FS4DPV4WA66Gs/dVZyC3LBRMYK92GOrEWlnTwBkoHjg0t5lp
        bnNJ7PBihDwqQLfqisXSKX3s0OSk3YI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-ALyEK5AfOj6y7Oe15FODsg-1; Wed, 27 Oct 2021 01:57:05 -0400
X-MC-Unique: ALyEK5AfOj6y7Oe15FODsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC3C10A8E01;
        Wed, 27 Oct 2021 05:57:04 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 854236418A;
        Wed, 27 Oct 2021 05:57:03 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     bvanassche@acm.org, osandov@osandov.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] tests/block: add the missing _have_fio check for block/029 block/031
Date:   Wed, 27 Oct 2021 13:56:54 +0800
Message-Id: <20211027055654.3591-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/block/029 | 2 +-
 tests/block/031 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/block/029 b/tests/block/029
index dbb582e..0c4fe08 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -11,7 +11,7 @@ DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
 QUICK=1
 
 requires() {
-	_have_null_blk
+	_have_fio && _have_null_blk
 }
 
 modify_nr_hw_queues() {
diff --git a/tests/block/031 b/tests/block/031
index b6927cf..cb4ba67 100755
--- a/tests/block/031
+++ b/tests/block/031
@@ -11,7 +11,7 @@ DESCRIPTION="do IO on null-blk with a host tag set"
 TIMED=1
 
 requires() {
-	_have_null_blk && _have_module_param null_blk shared_tag_bitmap
+	_have_fio && _have_null_blk && _have_module_param null_blk shared_tag_bitmap
 }
 
 test() {
-- 
2.21.3

