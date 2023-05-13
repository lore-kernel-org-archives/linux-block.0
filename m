Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E12C77B7D
	for <linux-block@archiver.kernel.org>; Sat, 13 May 2023 14:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjEMOMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 May 2023 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbjEMOMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 May 2023 10:12:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA230C0
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 07:12:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f389c21fe8so39453331cf.3
        for <linux-block@vger.kernel.org>; Sat, 13 May 2023 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683987171; x=1686579171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mA6DdBwaCGj/+RZQvUf+gresNy3xMkdlzHnsTxDq2Eo=;
        b=imHyEZ08OxVy4dYc5daSWrtXJYiH3rp5LJyyUk2Li0pdKi6R0fUBIELqpjMFXJvYEk
         tfMMqYiY9+y0CuMhVyLgkEia2rDem1IJ/0/MX9zdNYsWEUbY/1g17QvAlyroS9OWXfOb
         fQUDQZUufjotEubcRYglsNfLYQrgsO2SSzG5E7eQvKHNt2sXLjK8OoTEqcVfeG1ntF+i
         tSIEYjeAw/krSz72d+fqMtqWKJUHEKd8Jnd6cLJirVkcDSvSCqeNghKs6/cxwWw6tYGT
         t/CxCY/gsuvDkS7Hmr985elMTr43i9ZaCU2epDOLPFxMInM+OTp0jvXcYbgzPkYBBcqV
         TVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683987171; x=1686579171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA6DdBwaCGj/+RZQvUf+gresNy3xMkdlzHnsTxDq2Eo=;
        b=O0E3hbZAN47xrWNlgU3n5nQr4SpfZ/xblhcUKOqFtaC9VeK22wUmCvoQjN0lSukU9O
         TreKVSsjQc4FwjsulL1rqCHtJyD7TICG3QMCRhgbLgMJ5LGHpM3srWCaEGNPAfzpdyLL
         jAH/j2TlBNKzkDePMVpyAQZ4ol6W/73WqFxHkQXo4Wokr31lyFJNXpy3OugYn0H1OV7J
         tdinun4R6BM609nZdvl0VJzdS6OaB+x+deI7D9bdgQS0G8BMMKXN6MnyxImhwLmqII5a
         BImZFAgB97j3expnaQD3wwelqaqA/Mfnqc59JilX9rl+p9DlpRghZv1U2KZswPi+xHar
         F1lg==
X-Gm-Message-State: AC+VfDyz5XMxqy+xPV7Ak3VvLRF5iWAnRVNtWSzDvRtF33nF0z+kX/FN
        6mpt3qyCAz3lO86Em+WhQWOaZPKORMU=
X-Google-Smtp-Source: ACHHUZ5/8tEkur9GPqsG8uPhvAv+fDvYzCaqYEOysLvqBcImQKFRmqw7iCQjnDEAWZvPASBOSpDVaA==
X-Received: by 2002:a05:622a:1807:b0:3f4:dc79:1a6e with SMTP id t7-20020a05622a180700b003f4dc791a6emr21553015qtc.19.1683987171028;
        Sat, 13 May 2023 07:12:51 -0700 (PDT)
Received: from tian-Alienware-15-R4.fios-router.home (pool-173-77-254-84.nycmny.fios.verizon.net. [173.77.254.84])
        by smtp.gmail.com with ESMTPSA id pc8-20020a05620a840800b0074de8d07052sm2617qkn.47.2023.05.13.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 07:12:50 -0700 (PDT)
From:   Tian Lan <tilan7663@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Tian Lan <tian.lan@twosigma.com>
Subject: [PATCH 1/1] blk-mq: fix blk_mq_hw_ctx active request accounting
Date:   Sat, 13 May 2023 10:12:34 -0400
Message-Id: <20230513141234.8395-1-tilan7663@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tian Lan <tian.lan@twosigma.com>

The nr_active counter continues to increase over time which causes the
blk_mq_get_tag to hang until the thread is rescheduled to a different
core despite there are still tags available.

kernel-stack

  INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
  Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:inboundIOReacto state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
    Call Trace:
    <TASK>
    __schedule+0x351/0xa20
    scheduler+0x5d/0xe0
    io_schedule+0x42/0x70
    blk_mq_get_tag+0x11a/0x2a0
    ? dequeue_task_stop+0x70/0x70
    __blk_mq_alloc_requests+0x191/0x2e0

kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
__blk_mq_free_request being called.

  320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0 in-flight 1
         b'__blk_mq_free_request+0x1 [kernel]'
         b'bt_iter+0x50 [kernel]'
         b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
         b'blk_mq_timeout_work+0x7c [kernel]'
         b'process_one_work+0x1c4 [kernel]'
         b'worker_thread+0x4d [kernel]'
         b'kthread+0xe6 [kernel]'
         b'ret_from_fork+0x1f [kernel]'

Signed-off-by: Tian Lan <tian.lan@twosigma.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c8dc70020bc..5b374fab169c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1593,6 +1593,9 @@ void blk_mq_put_rq_ref(struct request *rq)
 		if (rq->end_io(rq, 0) == RQ_END_IO_FREE)
 			blk_mq_free_request(rq);
 	} else if (req_ref_put_and_test(rq)) {
+		if (rq->rq_flags & RQF_MQ_INFLIGHT)
+			__blk_mq_dec_active_requests(rq->mq_hctx)
+
 		__blk_mq_free_request(rq);
 	}
 }
-- 
2.34.1

