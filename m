Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE6C433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57913610FC
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhDOXME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhDOXMD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618528299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YTeO2NMu0rbgVuVknP5/yqeO0riYia7vLpmniKoNERA=;
        b=bIbh+zWBf/EUTWBNCQYSIar9ygwusk1gh1FnwdrVvEtzhShrVvTIfoScv7Tox1ojKIm4zK
        Z/mV8iE9bUspgMcfXhiml4e1pP+H1ME8vwUkXGrXKp1MSh6HZ42z3OT3u+fDIYNd0sG4cK
        zwEm65a6VNOGs5/Z03eeUgcSk4cZ4kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-SjkolUZkPfGit6j8e6AnLg-1; Thu, 15 Apr 2021 19:11:36 -0400
X-MC-Unique: SjkolUZkPfGit6j8e6AnLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB56F107ACE3;
        Thu, 15 Apr 2021 23:11:33 +0000 (UTC)
Received: from localhost (thegoat.4a2m.lab.eng.bos.redhat.com [10.16.209.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3112760BE5;
        Thu, 15 Apr 2021 23:11:27 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: nvme: Return BLK_STS_TARGET if the DNR bit is set
Date:   Thu, 15 Apr 2021 19:11:23 -0400
Message-Id: <20210415231126.8746-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BZ: 1948690
Upstream Status: RHEL-only

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

rhel-8.git commit ef4ab90c12db5e0e50800ec323736b95be7a6ff5
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Tue Aug 25 21:52:45 2020 -0400

    [nvme] nvme: Return BLK_STS_TARGET if the DNR bit is set
    
    Message-id: <20200825215248.2291-8-snitzer@redhat.com>
    Patchwork-id: 325178
    Patchwork-instance: patchwork
    O-Subject: [RHEL8.3 PATCH 07/10] nvme: Return BLK_STS_TARGET if the DNR bit is set
    Bugzilla: 1843515
    RH-Acked-by: David Milburn <dmilburn@redhat.com>
    RH-Acked-by: Gopal Tiwari <gtiwari@redhat.com>
    RH-Acked-by: Ewan Milne <emilne@redhat.com>
    
    BZ: 1843515
    Upstream Status: RHEL-only
    
    If the DNR bit is set we should not retry the command, even if
    the standard status evaluation indicates so.
    
    SUSE is carrying this patch in their kernel:
    https://lwn.net/Articles/800370/
    
    Based on patch posted for upstream inclusion but rejected:
    v1: https://lore.kernel.org/linux-nvme/20190806111036.113233-1-hare@suse.de/
    v2: https://lore.kernel.org/linux-nvme/20190807071208.101882-1-hare@suse.de/
    v2-keith: https://lore.kernel.org/linux-nvme/20190807144725.GB25621@localhost.localdomain/
    v3: https://lore.kernel.org/linux-nvme/20190812075147.79598-1-hare@suse.de/
    v3-keith: https://lore.kernel.org/linux-nvme/20190813141510.GB32686@localhost.localdomain/
    
    This commit's change is basically "v3-keith".
    
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>

---
 drivers/nvme/host/core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-rhel9/drivers/nvme/host/core.c
===================================================================
--- linux-rhel9.orig/drivers/nvme/host/core.c
+++ linux-rhel9/drivers/nvme/host/core.c
@@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct
 
 static blk_status_t nvme_error_status(u16 status)
 {
+	if (unlikely(status & NVME_SC_DNR))
+		return BLK_STS_TARGET;
+
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;

