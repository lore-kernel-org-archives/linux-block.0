Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C18C636CD
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA3VN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 16:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjA3VN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 16:13:56 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97D101
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:13:55 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id l4-20020a17090a850400b0023013402671so213402pjn.5
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 13:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EXP/MQjcZ0X3AwaWowhVCnBNYI4a3X3hD54NPfI1tg=;
        b=u7aRBWTmYuij0GVU90BxgnCMr/YmcmggUfigVsUhvBBerXEh/3LiXIm6MNTVU3yMbY
         i9tQ8/qd6dqOm9x2LlKlbBUEX4dKD/Gh4IUe+2EZtFhxAGntNDOF2uYKa4tik3fEWDEn
         umkAf6eKnKV7puBv8EWlwmgCHEMe04PprytYpYZ4aQSEB5cY4AIgg+9kHRtVvhLl5fio
         s4HBhMNEs0eyO3neMVVhex8sRGBD1yU+HTzDwOeXR1MIdfrKdXVOfsHg66UYoHdby+y5
         JjVzxtznXFc9QYtsAVIhUrgPHHhW/l45FDu9nvDmIDhWsTi0kw/ruQAr0pDPrHAnpmxL
         Xn6A==
X-Gm-Message-State: AO0yUKUzr7rZUG/5fULSNGzmKxtqxFiwU4zI3YZ/lsFmalyaJsfh0K5L
        Az5tY+MdgNpHr1VTLTDQZOE=
X-Google-Smtp-Source: AK7set/U+HVmCaGeJkTPhTvo7CYMGfbNp/n6a53KKF43gOkFwkOZAfld3QvNoBnotkkH2y+Me8FZPA==
X-Received: by 2002:a17:902:f2cb:b0:196:5e71:e50 with SMTP id h11-20020a170902f2cb00b001965e710e50mr10072269plc.23.1675113235059;
        Mon, 30 Jan 2023 13:13:55 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5016:3bcd:59fe:334b])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b00194ae12a313sm8223174plo.222.2023.01.30.13.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:13:54 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH] loop: Improve the hw_queue_depth kernel module parameter implementation
Date:   Mon, 30 Jan 2023 13:13:47 -0800
Message-Id: <20230130211347.832110-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the following minor changes which were reported by colleagues
while reviewing this code:
- Remove the parentheses from around the LOOP_DEFAULT_HW_Q_DEPTH
  definition since these are superfluous.
- Accept other number formats than decimal, e.g. hexadecimal.
- Do not set hw_queue_depth to an out-of-range value, even if that value
  won't be used.
- Use the LOOP_DEFAULT_HW_Q_DEPTH macro in the kernel module parameter
  description to prevent that the description gets out of sync.

This patch has been tested as follows:

 # modprobe -r loop
 # modprobe loop hw_queue_depth=-1
 modprobe: ERROR: could not insert 'loop': Invalid argument
 # modprobe loop hw_queue_depth=0
 modprobe: ERROR: could not insert 'loop': Invalid argument
 # modprobe loop hw_queue_depth=1; cat /sys/module/loop/parameters/hw_queue_depth
 1
 # modprobe -r loop; modprobe loop; cat /sys/module/loop/parameters/hw_queue_depth hw_queue_depth=0x10
 16
 # modprobe -r loop; modprobe loop; cat /sys/module/loop/parameters/hw_queue_depth hw_queue_depth=128
 128
 # modprobe -r loop; modprobe loop hw_queue_depth=129; cat /sys/module/loop/parameters/hw_queue_depth
 129
 # modprobe -r loop; modprobe loop hw_queue_depth=$((1<<32))
 modprobe: ERROR: could not insert 'loop': Numerical result out of range

See also commit ef44c50837ab ("loop: allow user to set the queue
depth").

Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1518a6423279..5f04235e4ff7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,7 +90,7 @@ struct loop_cmd {
 };
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
-#define LOOP_DEFAULT_HW_Q_DEPTH (128)
+#define LOOP_DEFAULT_HW_Q_DEPTH 128
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
@@ -1792,9 +1792,15 @@ static int hw_queue_depth = LOOP_DEFAULT_HW_Q_DEPTH;
 
 static int loop_set_hw_queue_depth(const char *s, const struct kernel_param *p)
 {
-	int ret = kstrtoint(s, 10, &hw_queue_depth);
+	int qd, ret;
 
-	return (ret || (hw_queue_depth < 1)) ? -EINVAL : 0;
+	ret = kstrtoint(s, 0, &qd);
+	if (ret < 0)
+		return ret;
+	if (qd < 1)
+		return -EINVAL;
+	hw_queue_depth = qd;
+	return 0;
 }
 
 static const struct kernel_param_ops loop_hw_qdepth_param_ops = {
@@ -1803,7 +1809,7 @@ static const struct kernel_param_ops loop_hw_qdepth_param_ops = {
 };
 
 device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_depth, 0444);
-MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: " __stringify(LOOP_DEFAULT_HW_Q_DEPTH));
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
