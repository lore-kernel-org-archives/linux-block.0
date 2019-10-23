Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8768BCA9EB6
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2622086D
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 17:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXGgZckW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfJWR5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:57:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfJWR5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 13:57:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so23061130wrl.11
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KW4c36Kk3fpc2/8fRozdFYe6cS4S+4MdmPE2d0+GcRw=;
        b=jXGgZckWv3kjvDSHig3iV31/zjMN/gvLgRcCJ3Rpfk0YGMJE8koZdx2CMjioor5qdy
         /9XFHwKSVZDBkR+sPgloP/P1Ldyu0wLETVkWslgEgrzEO06dNPfPokI76/rF1ci6/TM1
         DO4XhL4c/g3v/fePqmcI1+5uxsoMaFQt5TVcBgWGFdkA6wJ2ZE6o+7317gumWInJW2iF
         zwjzIHi4x053RKlNchwYSeg/R2od1qFakZidUaAAyzlj6Ro7KK+abs15qCEYKo7hH7r3
         BawjRisBBfncmQwNpS9DEjREoLmD4rNoiOCZe4tBiMbATD5xsivQD00BwCkGv40+Q7Zi
         twAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KW4c36Kk3fpc2/8fRozdFYe6cS4S+4MdmPE2d0+GcRw=;
        b=lD8d9cKdkGqJQLXOEXLWn72PnhwP8ecTHrE0GveP1oqmIX5FgyxncpdhIM4PJSHnVO
         Oh/9TolDnQVmhPyASEdeFHf8doOEMIMuwHiCXmZnsuF4GmVFgPpnHXt4O4PhOt2I/PgQ
         wC963gbWN8qqcbr3JBYe0admKYmJwUVf08IdXf/fIECb7EA1O9Fvb8Wbjlobfkib6U+D
         nr4lp6DCR69Db7IZHy2Vhn3KX0yNWu9ArmY3PD++hPBkt71/FOUZX0II+qvIp7Cg4B9t
         +7Te/nI9iF2MJdz1frG84958LrgaUbVhZFLpPFG2b8RuU4IcDdiYzX27lFlg3Rak3VTQ
         wFxA==
X-Gm-Message-State: APjAAAVJJ/AlblHx1sCYzu8+z3Ik9qo1YcPIK8GN+33enztDdDbwX/zi
        34tqraaGRfFJQB+nfQFkWrnIdx7F
X-Google-Smtp-Source: APXvYqxhCgG5+iV11wjXU+cNVRPWPGherE87QsO2qrjKUt6v7mQOhrgTjSQkJTKsVE7MG0Ni2wtMQA==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr16172wrv.168.1571853430292;
        Wed, 23 Oct 2019 10:57:10 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w22sm7722789wmi.7.2019.10.23.10.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 10:57:09 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Shagun Agrawal <shagun.agrawal@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: Fix cpu indexing error in blk_mq_alloc_request_hctx()
Date:   Wed, 23 Oct 2019 10:57:00 -0700
Message-Id: <20191023175700.18615-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During the following test scenario:
- Offline a cpu
- load lpfc driver, which auto-discovers NVMe devices. For a new
  nvme device, the lpfc/nvme_fc transport can request up to
  num_online_cpus() worth of nr_hw_queues. The target in
  this case allowed at least that many of nvme queues.
The system encountered the following crash:

 BUG: unable to handle kernel paging request at 00003659d33953a8
 ...
 Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvme_fc]
 RIP: 0010:blk_mq_get_request+0x21d/0x3c0
 ...
 Blk_mq_alloc_request_hctx+0xef/0x140
 Nvme_alloc_request+0x32/0x80 [nvme_core]
 __nvme_submit_sync_cmd+0x4a/0x1c0 [nvme_core]
 Nvmf_connect_io_queue+0x130/0x1a0 [nvme_fabrics]
 Nvme_fc_connect_io_queues+0x285/0x2b0 [nvme_fc]
 Nvme_fc_create_association+0x0x8ea/0x9c0 [nvme_fc]
 Nvme_fc_connect_ctrl_work+0x19/0x50 [nvme_fc]
 ...

There was a commit a while ago to simplify queue mapping which
replaced the use of cpumask_first() by cpumask_first_and().
The issue is if cpumask_first_and() does not find any _intersecting_ cpus,
it return's nr_cpu_id. nr_cpu_id isn't valid for the per_cpu_ptr index
which is done in __blk_mq_get_ctx().

Considered reverting back to cpumask_first(), but instead followed
logic in blk_mq_first_mapped_cpu() to check for nr_cpu_id before
calling cpumask_first().

Fixes: 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Signed-off-by: Shagun Agrawal <shagun.agrawal@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8538dc415499..0b06b4ea57f1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -461,6 +461,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		return ERR_PTR(-EXDEV);
 	}
 	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(alloc_data.hctx->cpumask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-- 
2.13.7

