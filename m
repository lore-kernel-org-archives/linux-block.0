Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D5C4708F
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 04:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A37E6100A
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 04:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEaEsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 00:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhEaEsR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 00:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622436398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cy9PRa4HfgHIADVMyrFClaHyXLpziqLSP/u3CDqFdh4=;
        b=UmiAVHoaiqkvlX0jAWQRJjohHB6mrl9XX1qP6R/gD5TZoMnloQvhHOa2Ka1coAkSj4TELJ
        PixjvLVtf5ZmBOhKdalmzTDvwsOfscshzrowGhdUphAfDgGFAdM6luZQLFhg+zgb+m8qVK
        ALad8WjI/uv1MsW+cHX/cM3pXaEOi3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-WYRPDa9jOZ-xor53wfIK4w-1; Mon, 31 May 2021 00:46:36 -0400
X-MC-Unique: WYRPDa9jOZ-xor53wfIK4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8CA7801817;
        Mon, 31 May 2021 04:46:34 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59D465DEAD;
        Mon, 31 May 2021 04:46:33 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@fb.com, linux-block@vger.kernel.org
Cc:     logang@deltatee.com
Subject: [PATCH blktests] tests/nvme/031: add the missing steps for loop_dev clean up
Date:   Mon, 31 May 2021 12:46:21 +0800
Message-Id: <20210531044621.25514-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/031 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/031 b/tests/nvme/031
index 36263ca..7c18a64 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -49,6 +49,8 @@ test() {
 	done
 
 	_remove_nvmet_port "${port}"
+	losetup -d "$loop_dev"
+	rm "$TMPDIR/img"
 
 	echo "Test complete"
 }
-- 
2.21.0

