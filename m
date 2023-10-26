Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D0C25B72
	for <linux-block@archiver.kernel.org>; Thu, 26 Oct 2023 21:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbjJZVs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Oct 2023 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbjJZVs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2061DC
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1TpkxA2WjPiy1cRsPdyl9AKk+VqEjs8I+5jriOwuGuY=;
        b=AYCq1Z2KTUBfU/fWjUG3wkTd/VCJMUwfj10YixOtUv6mqIepE/CdJ+Lb5Jhe9UvRwCQIRa
        mSyGh+FfS+WjAiseLhBJUNndDJRODUu3yUkcBCNFilpLrJklLFW+tdPjdREItunqQGv8LM
        sdAnOWgVlAIzRLhtuEk25SttFj2hIsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-00DnKNgaM9maIMO7qnPBmg-1; Thu, 26 Oct 2023 17:47:28 -0400
X-MC-Unique: 00DnKNgaM9maIMO7qnPBmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09DE1101B436;
        Thu, 26 Oct 2023 21:47:28 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F381840C6F7B;
        Thu, 26 Oct 2023 21:47:27 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id B6CE93003C; Thu, 26 Oct 2023 17:47:27 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH] dm vdo: add MAINTAINERS file entry
Date:   Thu, 26 Oct 2023 17:47:27 -0400
Message-Id: <20231026214727.1067606-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b17e29a75c8..5357fbe1cc90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6001,6 +6001,15 @@ F:	include/linux/device-mapper.h
 F:	include/linux/dm-*.h
 F:	include/uapi/linux/dm-*.h
 
+DEVICE-MAPPER VDO TARGET
+M:	Matthew Sakai <msakai@redhat.com>
+M:	dm-devel@lists.linux.dev
+L:	dm-devel@lists.linux.dev
+S:	Maintained
+F:	Documentation/admin-guide/device-mapper/vdo*.rst
+F:	drivers/md/dm-vdo-target.c
+F:	drivers/md/dm-vdo/
+
 DEVLINK
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.40.0

