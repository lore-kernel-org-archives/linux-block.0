Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7295DC43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 22:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiFUWsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiFUWsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 18:48:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF81EED5
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 15:48:45 -0700 (PDT)
Received: from localhost (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 580EC66017A2;
        Tue, 21 Jun 2022 23:48:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655851723;
        bh=Rt6IkFmJAfHtPrCGOe/by6P/Wefj36GKxB6XD9MdLIY=;
        h=From:To:Cc:Subject:Date:From;
        b=AZxMBB7Qi7NkaJhu0gVjF+E/t0bGLFprOXm3sPETfN2A4z+5d+3hMh5ilLgVJLbrP
         ZqxzLkI8A/ZD12+gJMfh/YJPgC8Xp5rBwTmCc+9k+ZYsQhhjQ7j9FiIv3SKDpxZi+R
         Ih5Rb8oUM0WnLRRvZpCpbPb7QkRjqHQhU0JwWS9rQqK9Gac4G2iaQ82sjAXfb5snmy
         1gR4hfVwh2zLcMcxhTUYww/wLESe1ZpQtH4hzPfwunXyPQFTAzAtC774JI8sB0ixou
         jXfUOjMzl4VmsxZN19JlNfWnoZcu1oToxvnp7UlpvV0BhXLit3bvvZVPoplg7fMzE8
         OteHA8grv91MA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH ubdsrv] tgt_null: Return number of sectors read/written
Date:   Tue, 21 Jun 2022 18:48:39 -0400
Message-Id: <20220621224839.76007-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I wrote this against your devel-v3 branch.  I'm wondering if you plan to
send a new version of the kernel patch soon? From the latest
discussions, I don't think there were major issues found on review. :)

I hope people don't mind I cc'd linux-block about this userspace code.
Please, let me know if I shouldn't do that.

-- >8 --

The number of sectors read/written is used to verify forward progress of
the request inside the kernel.  If we return 0 here, the kernel
understands that as an IO failure (see first check in ubd_complete_rq),
and will reissue the request, causing an infinite loop of unfullfilled
requests.  This can be reproduced with:

  ubdsrv/ubd add -t null -n0 -q1 -d1
  dd if=/dev/vda of=/dev/ubdb0 count=1 bs=4k

The approach minics nullblk, which returns the total IO size.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 tgt_null.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tgt_null.c b/tgt_null.c
index 85636c405f0c..61850a2cd046 100644
--- a/tgt_null.c
+++ b/tgt_null.c
@@ -20,7 +20,9 @@ static int null_init_tgt(struct ubdsrv_tgt_info *tgt, int type, int argc,
 static int null_handle_io_async(struct ubdsrv_queue *q, struct ubd_io *io,
 		int tag)
 {
-	ubdsrv_mark_io_done(io, 0);
+	const struct ubdsrv_io_desc *iod = ubdsrv_get_iod(q, tag);
+
+	ubdsrv_mark_io_done(io, iod->nr_sectors << 9);
 
 	return 0;
 }
-- 
2.36.1

