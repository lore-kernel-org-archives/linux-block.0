Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B64C32771
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 02:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiISC3c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Sep 2022 22:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiISC3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 22:29:30 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2D25B
        for <linux-block@vger.kernel.org>; Sun, 18 Sep 2022 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663554565; x=1695090565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JBOaVn60btra9JeZfOTYUCxR+HJ/e/5C0OPePcOqEU0=;
  b=VFWV+8cmy9+8m8u0zUFtr2o71pOIC+6YsB/FMfyPV2M6MSLf+DHiS4+M
   bKvHpvgaclEPloMuhq9vOM7/gQRe11CJY3XOtmveGmAEGMjIR9ISHbSAX
   UFY/775WJsPkNpndGZp5y3x0YQUo8AH/ZhsXe/kFsJ6qPXLTlY8nR4f+z
   DHaNBnKWKD7SHkED9o8sZ729upzkpfeyXSsDmpU/rqSBbE3LaxNKkS0vO
   QdCFGxcQ7OYpZkr7o6G77DlARBd+2Rbg7oSpWboC9F5Q5IOydjef3L9CL
   cJTk00K8vzQyzRw1ndXIRTi0Ue26NxVt+SEUSEZR0Gru/EMTmfxHwNwz+
   w==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654531200"; 
   d="scan'208";a="211668182"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 10:29:25 +0800
IronPort-SDR: yOyAfgFTR7vfYUA7WY2sNtEBE0mMHvjxEjDd2KbbKcA4SvwL69V0AUhVrnh9ZIIAM18syk0CiG
 RraVidovFKeXslgsMnq7/ZWVrR1+dc9u3y3ljWJiZBJdAAXZy/NaIBa6Y0h/6EUEEnoOYlm4jW
 xFFUkOV1K6De/2D+6tROHW+B0N0VxFbEJh3eQPHjyqTVFbjnTGAwnqD0PdS0vJiA+tAiLB2ByY
 S7LeGuwO0oAV3oKIaP2qgGa1ld5aB5FLv0tN+hlNTHGAb0paMlI2cBnoJZaZGsHOGCiXT9jMT2
 IfYwZJtiJ75P2cDIXhuy6X1i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2022 18:44:03 -0700
IronPort-SDR: 7wUaPiFVrGA3pXrah8lAI1vF4npQMfvyUWeThZStf6t6/QEcvr2tTjGJRsZ6b61JUwKJ58klY9
 7WF2oe3RBo79ongJ4gpClSH6IZitjzcrF4C8n+L2iW5ElqnRgW/wVkAnA896cXJ/x+G8ExoNyp
 SA46s7tsfcVALvfgS+IeJlxJRFtF+7wGdzs0ELU4GVM6fxFKaM2WU+UklPENJpC3RkRz7txEY0
 QZYCy3piPnYYMhiyxNlTzg8p0NOhzUe+HvyFt4+REaGtEh0FHzZHZL8sCLxJjts1p3u+s3jzPP
 g6c=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.110])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Sep 2022 19:29:25 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     linux-block@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH 2/3] virtio-blk: add a placeholder for secure erase config
Date:   Sun, 18 Sep 2022 22:29:20 -0400
Message-Id: <20220919022921.946344-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The configuration space layout in virtio specification defines more
members than are currently present in the kernel virtio_blk_config
structure. Specifically, there are some fields defined in the spec
that are related to secure erase operation support. The newly added
zoned device extension adds even more fields after the secure erase
section.

In order to keep the zoned configuration space data field alignment
consistent with the virtio specification, append a field of the size
that is equal to the total byte size of secure erase-related fields to
virtio_blk_config.
---
 include/uapi/linux/virtio_blk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..d9122674a539 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -121,6 +121,9 @@ struct virtio_blk_config {
 	__u8 write_zeroes_may_unmap;
 
 	__u8 unused1[3];
+
+	/* Secure erase fields that are defined in the virtio spec */
+	__u8 sec_erase[12];
 } __attribute__((packed));
 
 /*
-- 
2.34.1

