Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357EC83011
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302E722210
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UBdvyebJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgK3DbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:31:03 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54598 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgK3DbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707062; x=1638243062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZvesihZxqvpooUM98Q5I5u1Gk/h9BuWE3/slZ8Ndhs=;
  b=UBdvyebJc2SOdg+ELh6SZqEifbF43g++iuH7JxGv0x22eiv2p+8sR5Qd
   sGki3AXkfHh+FCzYlFzuIIcj3OczxrnnvI1cp4SI6I9PR+5fGtb1u+cUa
   x7G/fGYBKuVimSDbQpU5lOiZvIjJ5Pqj1NwGQYgLYGT4emb984Ug5eOfv
   hoxWfHN/yH/BkZmz11iQfh6oFCg2GYbJbBOyDrsROkVEfzHzXgIMZ4VIj
   8k4pbnZXgZxuiQyxAbgXS1fX3MsC2QF8HLNtdwOuSJKJLRYSMZMIXJQY3
   CCzw3vhfVNNB8hM9XD17jxbjIuwY1S7gme7f9Q6a/2PNVvNFI3g3QGyHI
   g==;
IronPort-SDR: q6auArkCvMXP5GfT3QlRBRR58YIruQbcldjguEJSSSJiHez2vQNrADn1bhlyykvg0dxmh031Yk
 WpC0x1QUZmbSVEXni8Ooj+Q/MipyhcI92oN++h8vLtYXpi2du802rw0f3sBH9G828196mtGhkD
 SLWgvPAEIjvRCILSGUONNfPQi0GcMYnOyMe3ptJ++w0vAj5EjyOJgv7AwGZQoboHMIzhfiIObz
 O9OCSCCIuJbFQisJPl7pjgMQSRMBhqydDwUuoRLM3k6q9HT+n3LawobKyg2k+rAtDA+dUCq2zK
 uQk=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="263892556"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:30:17 +0800
IronPort-SDR: M+kG19BmbL9kxF4oLhZ9+t5FHLIr+Qr3z4smG03AWjK9WbMY5zB2OCe9BZ1RDT2Eum2ojx8d+L
 uYGnG3fBfzEofho2Q8+1D8+wg+IikCilU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:15:54 -0800
IronPort-SDR: D/BUOXWv2eTkbgoe7jKf7dg39j2KiXkWrENICF9TxUT2qMl1QE4vc8zXddcDHx96f86j97JzMx
 xRrVlGunzBPQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:30:17 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 9/9] nvmet: add ZNS based I/O cmds handlers
Date:   Sun, 29 Nov 2020 19:29:09 -0800
Message-Id: <20201130032909.40638-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e1f6d59dd341..25dcd0544d5d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
-- 
2.22.1

